// Package totp implements RFC 6238 time-based one-time passwords (SHA-1,
// 30-second step, 6 digits), compatible with Google Authenticator, Authy and
// Microsoft Authenticator. Used for staff (moderator) logins.
package totp

import (
	"crypto/hmac"
	"crypto/rand"
	"crypto/sha1" //nolint:gosec // RFC 6238 default, required by authenticator apps
	"crypto/subtle"
	"encoding/base32"
	"encoding/binary"
	"fmt"
	"net/url"
	"time"
)

const (
	step   = 30
	digits = 6
)

var b32 = base32.StdEncoding.WithPadding(base32.NoPadding)

// NewSecret returns a random 160-bit secret.
func NewSecret() ([]byte, error) {
	s := make([]byte, 20)
	_, err := rand.Read(s)
	return s, err
}

// EncodeSecret returns the base32 form users type into authenticator apps.
func EncodeSecret(secret []byte) string { return b32.EncodeToString(secret) }

// URI returns an otpauth:// URI (render it as a QR code).
func URI(issuer, account string, secret []byte) string {
	label := url.PathEscape(issuer + ":" + account)
	q := url.Values{"secret": {EncodeSecret(secret)}, "issuer": {issuer}}
	return "otpauth://totp/" + label + "?" + q.Encode()
}

// Code returns the code for the 30-second counter containing t.
func Code(secret []byte, t time.Time) string {
	return codeAt(secret, uint64(t.Unix())/step, digits)
}

func codeAt(secret []byte, counter uint64, n int) string {
	var msg [8]byte
	binary.BigEndian.PutUint64(msg[:], counter)
	mac := hmac.New(sha1.New, secret)
	mac.Write(msg[:])
	sum := mac.Sum(nil)
	off := sum[len(sum)-1] & 0x0f
	v := binary.BigEndian.Uint32(sum[off:off+4]) & 0x7fffffff
	mod := uint32(1)
	for i := 0; i < n; i++ {
		mod *= 10
	}
	return fmt.Sprintf("%0*d", n, v%mod)
}

// Verify checks code against the current step and one step either side
// (clock drift). It returns the matched counter so callers can reject replays.
func Verify(secret []byte, code string, now time.Time) (counter uint64, ok bool) {
	if len(code) != digits {
		return 0, false
	}
	c := uint64(now.Unix()) / step
	for _, cand := range []uint64{c, c - 1, c + 1} {
		if subtle.ConstantTimeCompare([]byte(codeAt(secret, cand, digits)), []byte(code)) == 1 {
			return cand, true
		}
	}
	return 0, false
}
