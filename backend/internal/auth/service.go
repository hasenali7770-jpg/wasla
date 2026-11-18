package auth

import (
	"context"
	"crypto/hmac"
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"fmt"
	"log/slog"
	"math/big"
	"strconv"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/password"
	"wasla/backend/internal/platform/phone"
	"wasla/backend/internal/platform/ratelimit"
	"wasla/backend/internal/platform/rpc"
	"wasla/backend/internal/users"
)

// IDGen produces Snowflake IDs.
type IDGen interface{ Next() (int64, error) }

// Config holds auth tuning and secrets.
type Config struct {
	CodeSecret      []byte // HMAC key for OTP codes
	PhonePepper     []byte // HMAC key for banned_phones
	CodeLength      int
	CodeTTL         time.Duration
	MaxCodeAttempts int64
	ResendAfter     time.Duration
	// Anti-fraud limits. Callers without a valid attestation get half.
	PerPhoneHourly int64
	PerIPHourly    int64
	PerPrefixDaily int64
	PasswordParams password.Params
	TermsVersion   string
	LoginTokenTTL  time.Duration
	// A session younger than this cannot revoke other sessions (limits the
	// damage of a stolen OTP).
	NewSessionGuard time.Duration
}

// DefaultConfig returns production defaults; secrets must still be set.
func DefaultConfig() Config {
	return Config{
		CodeLength:      5,
		CodeTTL:         5 * time.Minute,
		MaxCodeAttempts: 5,
		ResendAfter:     60 * time.Second,
		PerPhoneHourly:  5,
		PerIPHourly:     20,
		PerPrefixDaily:  5000,
		PasswordParams:  password.Default,
		TermsVersion:    "2026-11",
		LoginTokenTTL:   10 * time.Minute,
		NewSessionGuard: 24 * time.Hour,
	}
}

// Service implements wasla.v1.AuthService.
type Service struct {
	DB       *pgxpool.Pool
	Redis    *redis.Client
	IDs      IDGen
	SMS      Sender
	Attestor Attestor
	Limits   *ratelimit.Limiter
	Cfg      Config
	Log      *slog.Logger
	Now      func() time.Time
}

// Register adds AuthService methods to the router.
func (s *Service) Register(r *rpc.Router) {
	const p = "/wasla.v1.AuthService/"
	rpc.Register(r, p+"SendCode", rpc.Public, s.SendCode)
	rpc.Register(r, p+"ResendCode", rpc.Public, s.ResendCode)
	rpc.Register(r, p+"SignIn", rpc.Public, s.SignIn)
	rpc.Register(r, p+"SignUp", rpc.Public, s.SignUp)
	rpc.Register(r, p+"CheckPassword", rpc.Public, s.CheckPassword)
	rpc.Register(r, p+"LogOut", rpc.Private, s.LogOut)
	rpc.Register(r, p+"ListSessions", rpc.Private, s.ListSessions)
	rpc.Register(r, p+"RevokeSession", rpc.Private, s.RevokeSession)
	rpc.Register(r, p+"RevokeOtherSessions", rpc.Private, s.RevokeOtherSessions)
	rpc.Register(r, p+"RegisterPushToken", rpc.Private, s.RegisterPushToken)
	rpc.Register(r, p+"SetPassword", rpc.Private, s.SetPassword)
	rpc.Register(r, p+"DeleteAccount", rpc.Private, s.DeleteAccount)
}

// ---------------------------------------------------------------------------
// Login codes
// ---------------------------------------------------------------------------

func (s *Service) SendCode(ctx context.Context, c *rpc.Caller, req *pb.SendCodeRequest) (*pb.SendCodeResponse, error) {
	ph := req.GetPhone()
	if !phone.Valid(ph) {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_PHONE_INVALID, "phone must be E.164")
	}
	if err := s.checkPhoneNotBanned(ctx, ph); err != nil {
		return nil, err
	}
	// Cooldown first: a "wait 60 s" answer must not use up the hourly quota.
	if ttl, _ := s.Redis.TTL(ctx, "otp:last:"+ph).Result(); ttl > 0 {
		return nil, errs.RateLimited(int32(ttl.Seconds()) + 1)
	}
	attested := s.Attestor != nil && s.Attestor.Verify(ctx, req.GetDeviceAttestation(), ph)
	if err := s.checkSendLimits(ctx, c, ph, attested); err != nil {
		s.logOTP(ctx, ph, c, pb.CodeDelivery_CODE_DELIVERY_SMS, "", 4)
		return nil, err
	}
	return s.issueCode(ctx, c, ph, pb.CodeDelivery_CODE_DELIVERY_SMS)
}

func (s *Service) ResendCode(ctx context.Context, c *rpc.Caller, req *pb.ResendCodeRequest) (*pb.ResendCodeResponse, error) {
	ph := req.GetPhone()
	key := "otp:" + req.GetCodeHash()
	stored, err := s.Redis.HGet(ctx, key, "phone").Result()
	if err == redis.Nil || stored != ph {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_PHONE_CODE_EXPIRED, "code expired, request a new one")
	} else if err != nil {
		return nil, err
	}
	if ttl, _ := s.Redis.TTL(ctx, "otp:last:"+ph).Result(); ttl > 0 {
		return nil, errs.RateLimited(int32(ttl.Seconds()) + 1)
	}
	if err := s.checkSendLimits(ctx, c, ph, false); err != nil {
		return nil, err
	}
	s.Redis.Del(ctx, key)
	r, err := s.issueCode(ctx, c, ph, pb.CodeDelivery_CODE_DELIVERY_VOICE_CALL)
	if err != nil {
		return nil, err
	}
	return &pb.ResendCodeResponse{CodeHash: r.CodeHash, Delivery: r.Delivery, CodeLength: r.CodeLength,
		ResendAfterSeconds: r.ResendAfterSeconds, ExpiresInSeconds: r.ExpiresInSeconds, NextDelivery: r.NextDelivery}, nil
}

func (s *Service) issueCode(ctx context.Context, c *rpc.Caller, ph string, via pb.CodeDelivery) (*pb.SendCodeResponse, error) {
	code, err := randomDigits(s.Cfg.CodeLength)
	if err != nil {
		return nil, err
	}
	codeHash, err := randomToken(16)
	if err != nil {
		return nil, err
	}
	key := "otp:" + codeHash
	pipe := s.Redis.TxPipeline()
	pipe.HSet(ctx, key, map[string]any{"phone": ph, "mac": s.codeMAC(codeHash, code), "attempts": 0})
	pipe.Expire(ctx, key, s.Cfg.CodeTTL)
	pipe.Set(ctx, "otp:last:"+ph, codeHash, s.Cfg.ResendAfter)
	if _, err := pipe.Exec(ctx); err != nil {
		return nil, err
	}
	provider, err := s.SMS.Send(ctx, ph, code, c.LangCode, via)
	if err != nil {
		s.Log.Error("otp send failed", "prefix", phone.Prefix(ph), "err", err)
		s.logOTP(ctx, ph, c, via, provider, 3)
		s.Redis.Del(ctx, key, "otp:last:"+ph)
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_UNAVAILABLE, "could not send code, try again")
	}
	s.logOTP(ctx, ph, c, via, provider, 1)
	next := pb.CodeDelivery_CODE_DELIVERY_VOICE_CALL
	return &pb.SendCodeResponse{
		CodeHash:           codeHash,
		Delivery:           via,
		CodeLength:         int32(s.Cfg.CodeLength),
		ResendAfterSeconds: int32(s.Cfg.ResendAfter.Seconds()),
		ExpiresInSeconds:   int32(s.Cfg.CodeTTL.Seconds()),
		NextDelivery:       next,
	}, nil
}

func (s *Service) checkSendLimits(ctx context.Context, c *rpc.Caller, ph string, attested bool) error {
	div := int64(1)
	if !attested {
		div = 2
	}
	checks := []struct {
		key    string
		limit  int64
		window time.Duration
	}{
		{"otp:phone:" + ph, max(1, s.Cfg.PerPhoneHourly/div), time.Hour},
		{"otp:ip:" + c.IP.String(), max(1, s.Cfg.PerIPHourly/div), time.Hour},
		{"otp:prefix:" + phone.Prefix(ph), s.Cfg.PerPrefixDaily, 24 * time.Hour},
	}
	for _, ch := range checks {
		ok, retry, err := s.Limits.Allow(ctx, ch.key, ch.limit, ch.window)
		if err != nil {
			return err
		}
		if !ok {
			return errs.RateLimited(int32(retry.Seconds()) + 1)
		}
	}
	return nil
}

func (s *Service) checkPhoneNotBanned(ctx context.Context, ph string) error {
	var banned bool
	err := s.DB.QueryRow(ctx, `
		SELECT EXISTS (SELECT 1 FROM banned_phones WHERE phone_hash = $1 AND (expires_at IS NULL OR expires_at > now()))
		    OR EXISTS (SELECT 1 FROM users WHERE phone = $2 AND banned_at IS NOT NULL
		               AND (ban_expires_at IS NULL OR ban_expires_at > now()))`,
		phone.Hash(s.Cfg.PhonePepper, ph), ph).Scan(&banned)
	if err != nil {
		return err
	}
	if banned {
		return errs.New(pb.ErrorCode_ERROR_CODE_PHONE_BANNED, "this phone number is banned")
	}
	return nil
}

// verifyCode checks a code and, on success, marks the attempt verified so a
// following SignUp can reuse the same code_hash.
func (s *Service) verifyCode(ctx context.Context, ph, codeHash, code string) error {
	key := "otp:" + codeHash
	vals, err := s.Redis.HGetAll(ctx, key).Result()
	if err != nil {
		return err
	}
	if len(vals) == 0 || vals["phone"] != ph {
		return errs.New(pb.ErrorCode_ERROR_CODE_PHONE_CODE_EXPIRED, "code expired, request a new one")
	}
	if vals["verified"] == "1" {
		return nil
	}
	attempts, err := s.Redis.HIncrBy(ctx, key, "attempts", 1).Result()
	if err != nil {
		return err
	}
	if attempts > s.Cfg.MaxCodeAttempts {
		s.Redis.Del(ctx, key)
		return errs.New(pb.ErrorCode_ERROR_CODE_PHONE_CODE_EXPIRED, "too many attempts, request a new code")
	}
	if !hmac.Equal([]byte(vals["mac"]), []byte(s.codeMAC(codeHash, code))) {
		return errs.New(pb.ErrorCode_ERROR_CODE_PHONE_CODE_INVALID, "wrong code")
	}
	s.Redis.HSet(ctx, key, "verified", "1")
	s.Redis.Expire(ctx, key, 10*time.Minute) // time to fill in the sign-up form
	_, _ = s.DB.Exec(ctx, `
		UPDATE otp_requests SET status = 2, verified_at = now()
		WHERE id = (SELECT id FROM otp_requests WHERE phone = $1 AND status = 1 ORDER BY created_at DESC LIMIT 1)`, ph)
	return nil
}

// ---------------------------------------------------------------------------
// Sign in / sign up / two-step password
// ---------------------------------------------------------------------------

func (s *Service) SignIn(ctx context.Context, c *rpc.Caller, req *pb.SignInRequest) (*pb.SignInResponse, error) {
	if err := s.verifyCode(ctx, req.GetPhone(), req.GetCodeHash(), req.GetCode()); err != nil {
		return nil, err
	}
	if err := s.checkPhoneNotBanned(ctx, req.GetPhone()); err != nil {
		return nil, err
	}
	var userID int64
	var hint *string
	err := s.DB.QueryRow(ctx, `
		SELECT u.id, p.hint FROM users u
		LEFT JOIN account_passwords p ON p.user_id = u.id
		WHERE u.phone = $1 AND u.deleted_at IS NULL`, req.GetPhone()).Scan(&userID, &hint)
	if db.NoRows(err) {
		return &pb.SignInResponse{Result: &pb.SignInResponse_SignUpRequired{
			SignUpRequired: &pb.SignUpRequired{TermsVersion: s.Cfg.TermsVersion}}}, nil
	}
	if err != nil {
		return nil, err
	}
	s.Redis.Del(ctx, "otp:"+req.GetCodeHash())

	if hint != nil {
		token, err := randomToken(24)
		if err != nil {
			return nil, err
		}
		key := "login:" + token
		pipe := s.Redis.TxPipeline()
		pipe.HSet(ctx, key, map[string]any{"user_id": userID, "attempts": 0})
		pipe.Expire(ctx, key, s.Cfg.LoginTokenTTL)
		if _, err := pipe.Exec(ctx); err != nil {
			return nil, err
		}
		return &pb.SignInResponse{Result: &pb.SignInResponse_PasswordRequired{
			PasswordRequired: &pb.PasswordRequired{Hint: *hint, LoginToken: token}}}, nil
	}
	auth, err := s.startSession(ctx, c, userID)
	if err != nil {
		return nil, err
	}
	return &pb.SignInResponse{Result: &pb.SignInResponse_Authorization{Authorization: auth}}, nil
}

func (s *Service) SignUp(ctx context.Context, c *rpc.Caller, req *pb.SignUpRequest) (*pb.SignUpResponse, error) {
	ph := req.GetPhone()
	vals, err := s.Redis.HGetAll(ctx, "otp:"+req.GetCodeHash()).Result()
	if err != nil {
		return nil, err
	}
	if vals["phone"] != ph || vals["verified"] != "1" {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_PHONE_CODE_EXPIRED, "verify the phone number first")
	}
	if req.GetTermsVersion() != s.Cfg.TermsVersion {
		return nil, errs.Invalid("terms of service must be accepted")
	}
	first := strings.TrimSpace(req.GetFirstName())
	last := strings.TrimSpace(req.GetLastName())
	if n := utf8.RuneCountInString(first); n < 1 || n > 64 {
		return nil, errs.Invalid("first name must be 1-64 characters")
	}
	if utf8.RuneCountInString(last) > 64 {
		return nil, errs.Invalid("last name must be at most 64 characters")
	}
	if err := s.checkPhoneNotBanned(ctx, ph); err != nil {
		return nil, err
	}
	userID, err := s.IDs.Next()
	if err != nil {
		return nil, err
	}
	lang := "ar"
	if strings.HasPrefix(c.LangCode, "en") {
		lang = "en"
	}
	err = db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `INSERT INTO users (id, phone, first_name, last_name, lang_code) VALUES ($1,$2,$3,$4,$5)`,
			userID, ph, first, last, lang); err != nil {
			return err
		}
		if _, err := tx.Exec(ctx, `INSERT INTO user_update_state (user_id) VALUES ($1)`, userID); err != nil {
			return err
		}
		// Link existing phone-book entries to the new account.
		_, err := tx.Exec(ctx, `UPDATE contacts SET contact_user_id = $1, updated_at = now() WHERE phone = $2`, userID, ph)
		return err
	})
	if db.IsUniqueViolation(err, "users_phone_uq") {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_ALREADY_EXISTS, "account already exists, sign in instead")
	}
	if err != nil {
		return nil, err
	}
	s.Redis.Del(ctx, "otp:"+req.GetCodeHash())
	auth, err := s.startSession(ctx, c, userID)
	if err != nil {
		return nil, err
	}
	return &pb.SignUpResponse{Authorization: auth}, nil
}

func (s *Service) CheckPassword(ctx context.Context, c *rpc.Caller, req *pb.CheckPasswordRequest) (*pb.CheckPasswordResponse, error) {
	key := "login:" + req.GetLoginToken()
	uid, err := s.Redis.HGet(ctx, key, "user_id").Int64()
	if err == redis.Nil {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_PHONE_CODE_EXPIRED, "login expired, start again")
	} else if err != nil {
		return nil, err
	}
	attempts, err := s.Redis.HIncrBy(ctx, key, "attempts", 1).Result()
	if err != nil {
		return nil, err
	}
	if attempts > 5 {
		s.Redis.Del(ctx, key)
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_PHONE_CODE_EXPIRED, "too many attempts, start again")
	}
	var phc string
	if err := s.DB.QueryRow(ctx, `SELECT password_hash FROM account_passwords WHERE user_id = $1`, uid).Scan(&phc); err != nil {
		return nil, err
	}
	ok, err := password.Verify(req.GetPassword(), phc)
	if err != nil {
		return nil, err
	}
	if !ok {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_PASSWORD_INVALID, "wrong password")
	}
	s.Redis.Del(ctx, key)
	auth, err := s.startSession(ctx, c, uid)
	if err != nil {
		return nil, err
	}
	return &pb.CheckPasswordResponse{Authorization: auth}, nil
}

// ---------------------------------------------------------------------------
// helpers
// ---------------------------------------------------------------------------

func (s *Service) startSession(ctx context.Context, c *rpc.Caller, userID int64) (*pb.Authorization, error) {
	raw := make([]byte, 32)
	if _, err := rand.Read(raw); err != nil {
		return nil, err
	}
	sum := sha256.Sum256(raw)
	sid, err := s.IDs.Next()
	if err != nil {
		return nil, err
	}
	var ip any
	if c.IP.IsValid() {
		ip = c.IP.String()
	}
	_, err = s.DB.Exec(ctx, `
		INSERT INTO sessions (id, user_id, token_hash, platform, device_model, os_version, app_version, ip)
		VALUES ($1,$2,$3,$4,$5,$6,$7,$8)`,
		sid, userID, sum[:], int16(c.Platform), c.DeviceModel, c.OSVersion, c.AppVersion, ip)
	if err != nil {
		return nil, err
	}
	u, err := users.LoadSelf(ctx, s.DB, userID)
	if err != nil {
		return nil, err
	}
	c.Bind(sid, userID)
	return &pb.Authorization{SessionToken: base64.RawURLEncoding.EncodeToString(raw), User: u}, nil
}

func (s *Service) codeMAC(codeHash, code string) string {
	m := hmac.New(sha256.New, s.Cfg.CodeSecret)
	m.Write([]byte(codeHash + ":" + code))
	return base64.RawStdEncoding.EncodeToString(m.Sum(nil))
}

func (s *Service) logOTP(ctx context.Context, ph string, c *rpc.Caller, via pb.CodeDelivery, provider string, status int16) {
	var ip any
	if c.IP.IsValid() {
		ip = c.IP.String()
	}
	if _, err := s.DB.Exec(ctx, `INSERT INTO otp_requests (phone, ip, channel, provider, status) VALUES ($1,$2,$3,$4,$5)`,
		ph, ip, int16(via), provider, status); err != nil {
		s.Log.Warn("otp audit insert failed", "err", err)
	}
}

func (s *Service) now() time.Time {
	if s.Now != nil {
		return s.Now()
	}
	return time.Now()
}

func randomDigits(n int) (string, error) {
	var b strings.Builder
	for i := 0; i < n; i++ {
		d, err := rand.Int(rand.Reader, big.NewInt(10))
		if err != nil {
			return "", err
		}
		b.WriteString(strconv.FormatInt(d.Int64(), 10))
	}
	return b.String(), nil
}

func randomToken(n int) (string, error) {
	b := make([]byte, n)
	if _, err := rand.Read(b); err != nil {
		return "", fmt.Errorf("random: %w", err)
	}
	return base64.RawURLEncoding.EncodeToString(b), nil
}
