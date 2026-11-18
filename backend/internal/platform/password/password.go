// Package password hashes passwords with argon2id and encodes them in the
// standard PHC string format:
//
//	$argon2id$v=19$m=65536,t=3,p=2$<salt b64>$<hash b64>
package password

import (
	"crypto/rand"
	"crypto/subtle"
	"encoding/base64"
	"errors"
	"fmt"
	"strings"

	"golang.org/x/crypto/argon2"
)

// Params are argon2id cost parameters.
type Params struct {
	MemoryKiB uint32
	Time      uint32
	Threads   uint8
}

// Default matches docs/01-architecture.md §8 (64 MiB, t=3, p=2).
var Default = Params{MemoryKiB: 64 * 1024, Time: 3, Threads: 2}

// Fast is for tests only.
var Fast = Params{MemoryKiB: 1024, Time: 1, Threads: 1}

var enc = base64.RawStdEncoding

// Hash returns a PHC string for pw.
func Hash(pw string, p Params) (string, error) {
	salt := make([]byte, 16)
	if _, err := rand.Read(salt); err != nil {
		return "", err
	}
	key := argon2.IDKey([]byte(pw), salt, p.Time, p.MemoryKiB, p.Threads, 32)
	return fmt.Sprintf("$argon2id$v=%d$m=%d,t=%d,p=%d$%s$%s",
		argon2.Version, p.MemoryKiB, p.Time, p.Threads, enc.EncodeToString(salt), enc.EncodeToString(key)), nil
}

// ErrMalformed means the stored hash could not be parsed.
var ErrMalformed = errors.New("password: malformed hash")

// Verify reports whether pw matches the PHC string.
func Verify(pw, phc string) (bool, error) {
	parts := strings.Split(phc, "$")
	if len(parts) != 6 || parts[1] != "argon2id" {
		return false, ErrMalformed
	}
	var v int
	if _, err := fmt.Sscanf(parts[2], "v=%d", &v); err != nil || v != argon2.Version {
		return false, ErrMalformed
	}
	var p Params
	if _, err := fmt.Sscanf(parts[3], "m=%d,t=%d,p=%d", &p.MemoryKiB, &p.Time, &p.Threads); err != nil {
		return false, ErrMalformed
	}
	salt, err := enc.DecodeString(parts[4])
	if err != nil {
		return false, ErrMalformed
	}
	want, err := enc.DecodeString(parts[5])
	if err != nil || len(want) == 0 {
		return false, ErrMalformed
	}
	got := argon2.IDKey([]byte(pw), salt, p.Time, p.MemoryKiB, p.Threads, uint32(len(want)))
	return subtle.ConstantTimeCompare(got, want) == 1, nil
}
