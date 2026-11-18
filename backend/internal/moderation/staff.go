package moderation

import (
	"context"
	"crypto/rand"
	"encoding/base64"
	"strings"

	"github.com/jackc/pgx/v5/pgxpool"

	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/password"
	"wasla/backend/internal/platform/totp"
)

// NewStaff is what CreateStaff hands back once, for secure delivery to the
// new moderator. Neither value is retrievable later.
type NewStaff struct {
	ID         int64
	Password   string
	TOTPSecret string // base32, for manual entry
	TOTPURI    string // otpauth://, for a QR code
}

// CreateStaff adds a moderator account with a random password and a TOTP
// secret (two-factor login is mandatory for staff).
func CreateStaff(ctx context.Context, pool *pgxpool.Pool, email, name string, role int16, p password.Params) (*NewStaff, error) {
	email = strings.ToLower(strings.TrimSpace(email))
	if !strings.Contains(email, "@") || strings.TrimSpace(name) == "" {
		return nil, errs.Invalid("email and name are required")
	}
	if role < RoleModerator || role > RoleAdmin {
		return nil, errs.Invalid("role must be 1 (moderator), 2 (senior) or 3 (admin)")
	}
	raw := make([]byte, 15)
	if _, err := rand.Read(raw); err != nil {
		return nil, err
	}
	pw := base64.RawURLEncoding.EncodeToString(raw)
	phc, err := password.Hash(pw, p)
	if err != nil {
		return nil, err
	}
	secret, err := totp.NewSecret()
	if err != nil {
		return nil, err
	}
	var id int64
	err = pool.QueryRow(ctx, `INSERT INTO staff_users (email, display_name, password_hash, totp_secret, role)
		VALUES ($1,$2,$3,$4,$5) RETURNING id`, email, strings.TrimSpace(name), phc, secret, role).Scan(&id)
	if err != nil {
		return nil, err
	}
	return &NewStaff{ID: id, Password: pw, TOTPSecret: totp.EncodeSecret(secret), TOTPURI: totp.URI("Wasla Admin", email, secret)}, nil
}
