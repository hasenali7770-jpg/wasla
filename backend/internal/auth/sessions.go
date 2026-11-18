package auth

import (
	"context"
	"crypto/sha256"
	"encoding/base64"
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
	"wasla/backend/internal/platform/rpc"
)

// RevokedChannel carries revoked session IDs; every gateway subscribes and
// closes matching connections with close code 4001.
const RevokedChannel = "wasla:revoked"

// Authenticate resolves a session token from Hello. It returns ok=false for
// unknown, revoked, banned or deleted sessions.
func (s *Service) Authenticate(ctx context.Context, token string) (sessionID, userID int64, ok bool, err error) {
	raw, decErr := base64.RawURLEncoding.DecodeString(token)
	if decErr != nil || len(raw) != 32 {
		return 0, 0, false, nil
	}
	sum := sha256.Sum256(raw)
	err = s.DB.QueryRow(ctx, `
		UPDATE sessions s SET last_active_at = now()
		FROM users u
		WHERE s.token_hash = $1 AND s.revoked_at IS NULL AND u.id = s.user_id
		  AND u.deleted_at IS NULL
		  AND (u.banned_at IS NULL OR (u.ban_expires_at IS NOT NULL AND u.ban_expires_at <= now()))
		RETURNING s.id, s.user_id`, sum[:]).Scan(&sessionID, &userID)
	if db.NoRows(err) {
		return 0, 0, false, nil
	}
	if err != nil {
		return 0, 0, false, err
	}
	return sessionID, userID, true, nil
}

// RevokeSessions marks sessions revoked and kicks their live connections.
// Shared with moderation (bans) via the exported helper.
func RevokeSessions(ctx context.Context, q interface {
	Query(context.Context, string, ...any) (pgx.Rows, error)
}, where string, args ...any) ([]int64, error) {
	rows, err := q.Query(ctx, `UPDATE sessions SET revoked_at = now(), push_token = NULL, push_provider = NULL
		WHERE revoked_at IS NULL AND `+where+` RETURNING id`, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var ids []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		ids = append(ids, id)
	}
	return ids, rows.Err()
}

// Kick publishes revoked session IDs so gateways disconnect them.
func Kick(ctx context.Context, r *redis.Client, sessionIDs []int64) {
	for _, id := range sessionIDs {
		r.Publish(ctx, RevokedChannel, strconv.FormatInt(id, 10))
	}
}

func (s *Service) LogOut(ctx context.Context, c *rpc.Caller, _ *pb.LogOutRequest) (*pb.LogOutResponse, error) {
	ids, err := RevokeSessions(ctx, s.DB, "id = $1", c.SessionID())
	if err != nil {
		return nil, err
	}
	Kick(ctx, s.Redis, ids)
	return &pb.LogOutResponse{}, nil
}

func (s *Service) ListSessions(ctx context.Context, c *rpc.Caller, _ *pb.ListSessionsRequest) (*pb.ListSessionsResponse, error) {
	rows, err := s.DB.Query(ctx, `
		SELECT id, platform, device_model, os_version, app_version, COALESCE(country_code, ''),
		       extract(epoch FROM created_at)::bigint, extract(epoch FROM last_active_at)::bigint
		FROM sessions WHERE user_id = $1 AND revoked_at IS NULL
		ORDER BY last_active_at DESC`, c.UserID())
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	resp := &pb.ListSessionsResponse{}
	for rows.Next() {
		var ss pb.Session
		var platform int16
		if err := rows.Scan(&ss.Id, &platform, &ss.DeviceModel, &ss.OsVersion, &ss.AppVersion,
			&ss.CountryCode, &ss.CreatedAt, &ss.LastActiveAt); err != nil {
			return nil, err
		}
		ss.Platform = pb.Platform(platform)
		ss.Current = ss.Id == c.SessionID()
		resp.Sessions = append(resp.Sessions, &ss)
	}
	return resp, rows.Err()
}

// guardNewSession stops a freshly created session from logging out older
// ones, so a stolen login code cannot lock the real owner out.
func (s *Service) guardNewSession(ctx context.Context, c *rpc.Caller) error {
	var created time.Time
	if err := s.DB.QueryRow(ctx, `SELECT created_at FROM sessions WHERE id = $1`, c.SessionID()).Scan(&created); err != nil {
		return err
	}
	if s.now().Sub(created) < s.Cfg.NewSessionGuard {
		return errs.Denied("new sessions cannot end other sessions for the first 24 hours")
	}
	return nil
}

func (s *Service) RevokeSession(ctx context.Context, c *rpc.Caller, req *pb.RevokeSessionRequest) (*pb.RevokeSessionResponse, error) {
	if req.GetSessionId() != c.SessionID() {
		if err := s.guardNewSession(ctx, c); err != nil {
			return nil, err
		}
	}
	ids, err := RevokeSessions(ctx, s.DB, "id = $1 AND user_id = $2", req.GetSessionId(), c.UserID())
	if err != nil {
		return nil, err
	}
	if len(ids) == 0 {
		return nil, errs.NotFound("session not found")
	}
	Kick(ctx, s.Redis, ids)
	return &pb.RevokeSessionResponse{}, nil
}

func (s *Service) RevokeOtherSessions(ctx context.Context, c *rpc.Caller, _ *pb.RevokeOtherSessionsRequest) (*pb.RevokeOtherSessionsResponse, error) {
	if err := s.guardNewSession(ctx, c); err != nil {
		return nil, err
	}
	ids, err := RevokeSessions(ctx, s.DB, "user_id = $1 AND id <> $2", c.UserID(), c.SessionID())
	if err != nil {
		return nil, err
	}
	Kick(ctx, s.Redis, ids)
	return &pb.RevokeOtherSessionsResponse{RevokedCount: int32(len(ids))}, nil
}

func (s *Service) RegisterPushToken(ctx context.Context, c *rpc.Caller, req *pb.RegisterPushTokenRequest) (*pb.RegisterPushTokenResponse, error) {
	if req.GetProvider() == pb.PushProvider_PUSH_PROVIDER_UNSPECIFIED || req.GetToken() == "" || len(req.GetToken()) > 4096 {
		return nil, errs.Invalid("provider and token are required")
	}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `UPDATE sessions SET push_provider = NULL, push_token = NULL
			WHERE push_provider = $1 AND push_token = $2 AND id <> $3`, int16(req.GetProvider()), req.GetToken(), c.SessionID()); err != nil {
			return err
		}
		_, err := tx.Exec(ctx, `UPDATE sessions SET push_provider = $1, push_token = $2, push_token_updated_at = now()
			WHERE id = $3`, int16(req.GetProvider()), req.GetToken(), c.SessionID())
		return err
	})
	if err != nil {
		return nil, err
	}
	return &pb.RegisterPushTokenResponse{}, nil
}

func (s *Service) SetPassword(ctx context.Context, c *rpc.Caller, req *pb.SetPasswordRequest) (*pb.SetPasswordResponse, error) {
	if err := s.checkCurrentPassword(ctx, s.DB, c.UserID(), req.GetCurrentPassword()); err != nil {
		return nil, err
	}
	if req.GetNewPassword() == "" {
		if _, err := s.DB.Exec(ctx, `DELETE FROM account_passwords WHERE user_id = $1`, c.UserID()); err != nil {
			return nil, err
		}
		return &pb.SetPasswordResponse{}, nil
	}
	if n := utf8.RuneCountInString(req.GetNewPassword()); n < 8 || n > 128 {
		return nil, errs.Invalid("password must be 8-128 characters")
	}
	hint := strings.TrimSpace(req.GetHint())
	if utf8.RuneCountInString(hint) > 64 {
		return nil, errs.Invalid("hint must be at most 64 characters")
	}
	if hint != "" && strings.Contains(strings.ToLower(hint), strings.ToLower(req.GetNewPassword())) {
		return nil, errs.Invalid("hint must not contain the password")
	}
	email := strings.TrimSpace(req.GetRecoveryEmail())
	if email != "" && (!strings.Contains(email, "@") || len(email) > 254) {
		return nil, errs.Invalid("invalid recovery email")
	}
	phc, err := password.Hash(req.GetNewPassword(), s.Cfg.PasswordParams)
	if err != nil {
		return nil, err
	}
	var emailArg any
	if email != "" {
		emailArg = email
	}
	_, err = s.DB.Exec(ctx, `
		INSERT INTO account_passwords (user_id, password_hash, hint, recovery_email) VALUES ($1,$2,$3,$4)
		ON CONFLICT (user_id) DO UPDATE SET password_hash = EXCLUDED.password_hash, hint = EXCLUDED.hint,
			recovery_email = EXCLUDED.recovery_email, recovery_email_verified_at = NULL, updated_at = now()`,
		c.UserID(), phc, hint, emailArg)
	if err != nil {
		return nil, err
	}
	return &pb.SetPasswordResponse{}, nil
}

func (s *Service) checkCurrentPassword(ctx context.Context, q *pgxpool.Pool, userID int64, pw string) error {
	var phc string
	err := q.QueryRow(ctx, `SELECT password_hash FROM account_passwords WHERE user_id = $1`, userID).Scan(&phc)
	if db.NoRows(err) {
		return nil
	}
	if err != nil {
		return err
	}
	ok, err := password.Verify(pw, phc)
	if err != nil {
		return err
	}
	if !ok {
		return errs.New(pb.ErrorCode_ERROR_CODE_PASSWORD_INVALID, "wrong password")
	}
	return nil
}

// DeleteAccount anonymises the account. Messages stay (shown as "Deleted
// Account"). An active ban is carried over to banned_phones so deleting the
// account is not a way around it.
func (s *Service) DeleteAccount(ctx context.Context, c *rpc.Caller, req *pb.DeleteAccountRequest) (*pb.DeleteAccountResponse, error) {
	if err := s.checkCurrentPassword(ctx, s.DB, c.UserID(), req.GetPassword()); err != nil {
		return nil, err
	}
	var revoked []int64
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		var ph *string
		var bannedAt, banExpires *time.Time
		var banReason *string
		if err := tx.QueryRow(ctx, `SELECT phone, banned_at, ban_expires_at, ban_reason FROM users WHERE id = $1 FOR UPDATE`,
			c.UserID()).Scan(&ph, &bannedAt, &banExpires, &banReason); err != nil {
			return err
		}
		if ph != nil && bannedAt != nil && (banExpires == nil || banExpires.After(s.now())) {
			reason := "ban carried over from deleted account"
			if banReason != nil {
				reason += ": " + *banReason
			}
			if _, err := tx.Exec(ctx, `INSERT INTO banned_phones (phone_hash, reason, expires_at) VALUES ($1,$2,$3)
				ON CONFLICT (phone_hash) DO NOTHING`, phone.Hash(s.Cfg.PhonePepper, *ph), reason, banExpires); err != nil {
				return err
			}
		}
		for _, q := range []string{
			`DELETE FROM account_passwords WHERE user_id = $1`,
			`DELETE FROM contacts WHERE owner_id = $1`,
			`DELETE FROM privacy_rules WHERE user_id = $1`,
			`DELETE FROM privacy_exceptions WHERE user_id = $1`,
			`DELETE FROM profile_photos WHERE user_id = $1`,
			`UPDATE users SET deleted_at = now(), phone = NULL, username = NULL, first_name = 'Deleted Account',
				last_name = '', bio = '', photo_id = NULL, updated_at = now() WHERE id = $1`,
		} {
			if _, err := tx.Exec(ctx, q, c.UserID()); err != nil {
				return err
			}
		}
		var err error
		revoked, err = RevokeSessions(ctx, tx, "user_id = $1", c.UserID())
		return err
	})
	if err != nil {
		return nil, err
	}
	s.Log.Info("account deleted", "user_id", c.UserID(), "reason_len", len(req.GetReason()))
	Kick(ctx, s.Redis, revoked)
	return &pb.DeleteAccountResponse{}, nil
}
