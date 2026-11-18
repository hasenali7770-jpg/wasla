package auth

import (
	"context"
	"errors"
	"fmt"
	"log/slog"
	"sync"

	pb "wasla/backend/gen/proto/wasla/v1"
)

// Sender delivers a login code by SMS or voice call.
type Sender interface {
	// Send returns the provider name used (for cost tracking).
	Send(ctx context.Context, phone, code, lang string, via pb.CodeDelivery) (provider string, err error)
}

// Failover tries each sender in order until one succeeds. Production uses two
// aggregators with direct routes to Asiacell, Zain and Korek (selection is in
// progress; see docs/01-architecture.md §12).
type Failover []Sender

func (f Failover) Send(ctx context.Context, phone, code, lang string, via pb.CodeDelivery) (string, error) {
	var errs []error
	for _, s := range f {
		p, err := s.Send(ctx, phone, code, lang, via)
		if err == nil {
			return p, nil
		}
		errs = append(errs, err)
	}
	return "", fmt.Errorf("all SMS providers failed: %w", errors.Join(errs...))
}

// DevSender logs codes instead of sending them. The server refuses to start
// with it unless WASLA_ENV=dev. It also remembers the last code per phone so
// integration tests can read it.
type DevSender struct {
	Log  *slog.Logger
	mu   sync.Mutex
	last map[string]string
}

func (d *DevSender) Send(_ context.Context, phone, code, _ string, via pb.CodeDelivery) (string, error) {
	d.mu.Lock()
	if d.last == nil {
		d.last = map[string]string{}
	}
	d.last[phone] = code
	d.mu.Unlock()
	if d.Log != nil {
		d.Log.Info("DEV login code (not sent)", "phone", phone, "code", code, "via", via.String())
	}
	return "dev", nil
}

// LastCode returns the most recent code sent to phone.
func (d *DevSender) LastCode(phone string) string {
	d.mu.Lock()
	defer d.mu.Unlock()
	return d.last[phone]
}

// SMSText is the localized message body. The code comes first so Android's
// SMS Retriever / iOS one-time-code autofill can pick it up.
func SMSText(code, lang string) string {
	if len(lang) >= 2 && lang[:2] == "en" {
		return code + " is your Wasla code. Do not share it with anyone."
	}
	return code + " هو رمز الدخول إلى وصلة. لا تشاركه مع أي شخص."
}

// Attestor verifies Play Integrity (Android) / App Attest (iOS) tokens.
// The Google/Apple verifiers are added with the Android release build.
type Attestor interface {
	Verify(ctx context.Context, token, phone string) bool
}

// DevAttestor accepts the literal token "dev".
type DevAttestor struct{}

func (DevAttestor) Verify(_ context.Context, token, _ string) bool { return token == "dev" }
