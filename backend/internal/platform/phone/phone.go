// Package phone validates E.164 numbers and derives the values used for
// rate limiting and bans.
package phone

import (
	"crypto/hmac"
	"crypto/sha256"
	"regexp"
)

var e164 = regexp.MustCompile(`^\+[1-9][0-9]{6,14}$`)

// Valid reports whether p is in E.164 form. Clients normalise with
// libphonenumber (default region IQ) before sending.
func Valid(p string) bool { return e164.MatchString(p) }

// Hash is HMAC-SHA256(pepper, phone): stored in banned_phones so a leaked
// ban list does not reveal numbers, while bans still survive account deletion.
func Hash(pepper []byte, p string) []byte {
	m := hmac.New(sha256.New, pepper)
	m.Write([]byte(p))
	return m.Sum(nil)
}

// Prefix returns the country code plus operator digits (e.g. "+96477" for
// Asiacell, "+96478" for Zain, "+96475" for Korek). SMS-pumping attacks hit
// whole number ranges, so spend caps apply per prefix.
func Prefix(p string) string {
	if len(p) > 6 {
		return p[:6]
	}
	return p
}
