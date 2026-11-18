package push

import (
	"context"
	"crypto"
	"crypto/rand"
	"crypto/rsa"
	"crypto/sha256"
	"crypto/x509"
	"encoding/base64"
	"encoding/json"
	"encoding/pem"
	"errors"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"sync"
	"testing"
)

// fakeGoogle plays both the OAuth token endpoint and the FCM send endpoint.
type fakeGoogle struct {
	t          *testing.T
	pub        *rsa.PublicKey
	mu         sync.Mutex
	tokenCalls int
	sent       []map[string]any
	status     int
	body       string
}

func (g *fakeGoogle) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	g.mu.Lock()
	defer g.mu.Unlock()
	switch {
	case r.URL.Path == "/token":
		g.tokenCalls++
		_ = r.ParseForm()
		parts := strings.Split(r.Form.Get("assertion"), ".")
		if len(parts) != 3 {
			http.Error(w, "bad jwt", 400)
			return
		}
		sig, _ := base64.RawURLEncoding.DecodeString(parts[2])
		sum := sha256.Sum256([]byte(parts[0] + "." + parts[1]))
		if err := rsa.VerifyPKCS1v15(g.pub, crypto.SHA256, sum[:], sig); err != nil {
			http.Error(w, "bad signature", 400)
			return
		}
		claims, _ := base64.RawURLEncoding.DecodeString(parts[1])
		var c map[string]any
		_ = json.Unmarshal(claims, &c)
		if c["iss"] != "push@wasla-test.iam.gserviceaccount.com" || c["scope"] != "https://www.googleapis.com/auth/firebase.messaging" {
			http.Error(w, "bad claims", 400)
			return
		}
		_, _ = io.WriteString(w, `{"access_token":"at-1","expires_in":3600,"token_type":"Bearer"}`)
	case r.URL.Path == "/v1/projects/wasla-test/messages:send":
		if r.Header.Get("Authorization") != "Bearer at-1" {
			http.Error(w, "unauthorized", 401)
			return
		}
		var m map[string]any
		_ = json.NewDecoder(r.Body).Decode(&m)
		g.sent = append(g.sent, m)
		if g.status != 0 {
			w.WriteHeader(g.status)
			_, _ = io.WriteString(w, g.body)
			return
		}
		_, _ = io.WriteString(w, `{"name":"projects/wasla-test/messages/1"}`)
	default:
		http.NotFound(w, r)
	}
}

func newFake(t *testing.T) (*FCM, *fakeGoogle) {
	key, err := rsa.GenerateKey(rand.Reader, 2048)
	if err != nil {
		t.Fatal(err)
	}
	der, _ := x509.MarshalPKCS8PrivateKey(key)
	g := &fakeGoogle{t: t, pub: &key.PublicKey}
	srv := httptest.NewServer(g)
	t.Cleanup(srv.Close)
	keyJSON, _ := json.Marshal(map[string]string{
		"type":         "service_account",
		"project_id":   "wasla-test",
		"client_email": "push@wasla-test.iam.gserviceaccount.com",
		"private_key":  string(pem.EncodeToMemory(&pem.Block{Type: "PRIVATE KEY", Bytes: der})),
		"token_uri":    srv.URL + "/token",
	})
	f, err := NewFCM(keyJSON, srv.URL)
	if err != nil {
		t.Fatal(err)
	}
	return f, g
}

func TestFCMSendsContentFreePushAndCachesToken(t *testing.T) {
	f, g := newFake(t)
	ctx := context.Background()
	for i := 0; i < 2; i++ {
		if err := f.Send(ctx, "device-token", Message{ChatID: 42, Collapse: "chat_42"}); err != nil {
			t.Fatal(err)
		}
	}
	if g.tokenCalls != 1 {
		t.Fatalf("token fetched %d times, want 1 (cached)", g.tokenCalls)
	}
	msg := g.sent[0]["message"].(map[string]any)
	if msg["token"] != "device-token" {
		t.Fatalf("token: %v", msg["token"])
	}
	data := msg["data"].(map[string]any)
	if data["chat_id"] != "42" || data["type"] != "new_message" || len(data) != 2 {
		t.Fatalf("data: %v", data)
	}
	n := msg["android"].(map[string]any)["notification"].(map[string]any)
	if n["body_loc_key"] != "push_new_message" || n["tag"] != "chat_42" || n["channel_id"] != "messages" {
		t.Fatalf("notification: %v", n)
	}
	// Privacy: no text fields go to Google.
	for _, k := range []string{"title", "body"} {
		if _, ok := n[k]; ok {
			t.Fatalf("notification must not carry %q", k)
		}
	}
	if _, ok := msg["notification"]; ok {
		t.Fatal("no top-level notification text")
	}
}

func TestFCMUnregisteredToken(t *testing.T) {
	f, g := newFake(t)
	g.status, g.body = 404, `{"error":{"status":"NOT_FOUND","details":[{"errorCode":"UNREGISTERED"}]}}`
	if err := f.Send(context.Background(), "old", Message{ChatID: 1}); !errors.Is(err, ErrUnregistered) {
		t.Fatalf("want ErrUnregistered, got %v", err)
	}
	g.status, g.body = 500, `{"error":{"status":"INTERNAL"}}`
	if err := f.Send(context.Background(), "x", Message{ChatID: 1}); err == nil || errors.Is(err, ErrUnregistered) {
		t.Fatalf("a server error is not unregistered: %v", err)
	}
}

func TestBadKeyFile(t *testing.T) {
	if _, err := NewFCM([]byte(`{"project_id":"p"}`), ""); err == nil {
		t.Fatal("expected error for incomplete key")
	}
	if _, err := NewFCM([]byte(`not json`), ""); err == nil {
		t.Fatal("expected error for bad JSON")
	}
}
