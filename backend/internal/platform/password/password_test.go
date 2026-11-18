package password

import (
	"strings"
	"testing"
)

func TestHashVerify(t *testing.T) {
	h, err := Hash("كلمة-سر-قوية 123", Fast)
	if err != nil {
		t.Fatal(err)
	}
	if !strings.HasPrefix(h, "$argon2id$v=19$m=1024,t=1,p=1$") {
		t.Fatalf("unexpected PHC string %q", h)
	}
	if ok, err := Verify("كلمة-سر-قوية 123", h); err != nil || !ok {
		t.Fatalf("correct password rejected: %v", err)
	}
	if ok, _ := Verify("wrong", h); ok {
		t.Fatal("wrong password accepted")
	}
	h2, _ := Hash("كلمة-سر-قوية 123", Fast)
	if h == h2 {
		t.Fatal("salts must differ")
	}
}

func TestMalformed(t *testing.T) {
	for _, bad := range []string{"", "$bcrypt$x", "$argon2id$v=19$m=x$a$b", "$argon2id$v=18$m=1,t=1,p=1$AA$AA"} {
		if _, err := Verify("x", bad); err != ErrMalformed {
			t.Errorf("%q: want ErrMalformed, got %v", bad, err)
		}
	}
}
