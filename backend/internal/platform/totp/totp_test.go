package totp

import (
	"testing"
	"time"
)

// RFC 6238 Appendix B test vectors (SHA-1 secret "12345678901234567890").
func TestRFC6238Vectors(t *testing.T) {
	secret := []byte("12345678901234567890")
	cases := []struct {
		unix int64
		want string // 8-digit values from the RFC
	}{
		{59, "94287082"},
		{1111111109, "07081804"},
		{1111111111, "14050471"},
		{1234567890, "89005924"},
		{2000000000, "69279037"},
	}
	for _, c := range cases {
		if got := codeAt(secret, uint64(c.unix)/step, 8); got != c.want {
			t.Errorf("t=%d: got %s want %s", c.unix, got, c.want)
		}
		// The 6-digit code is the last 6 digits of the 8-digit one.
		if got := Code(secret, time.Unix(c.unix, 0)); got != c.want[2:] {
			t.Errorf("t=%d 6-digit: got %s want %s", c.unix, got, c.want[2:])
		}
	}
}

func TestVerifyWindow(t *testing.T) {
	secret, _ := NewSecret()
	now := time.Unix(1_800_000_000, 0)
	prev := Code(secret, now.Add(-30*time.Second))
	if _, ok := Verify(secret, prev, now); !ok {
		t.Fatal("previous step should verify")
	}
	old := Code(secret, now.Add(-90*time.Second))
	if _, ok := Verify(secret, old, now); ok {
		t.Fatal("code three steps old must not verify")
	}
	if _, ok := Verify(secret, "12345", now); ok {
		t.Fatal("short code must not verify")
	}
}
