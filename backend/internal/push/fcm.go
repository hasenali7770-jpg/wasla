package push

import (
	"bytes"
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
	"fmt"
	"io"
	"net/http"
	"net/url"
	"os"
	"strings"
	"sync"
	"time"
)

// ErrUnregistered means the token is no longer valid (app uninstalled or
// data cleared). The caller should forget it.
var ErrUnregistered = errors.New("push: token unregistered")

// Message is what a push carries. It deliberately has no message text or
// sender name: the phone fetches the content over our own connection, so
// Google never sees it.
type Message struct {
	ChatID int64
	// Collapse groups pushes: a newer one for the same chat replaces the
	// older one on the phone.
	Collapse string
}

// Sender delivers one push to one device token.
type Sender interface {
	Send(ctx context.Context, token string, m Message) error
}

// serviceAccount is the part of a Google service-account key file we use.
type serviceAccount struct {
	ProjectID   string `json:"project_id"`
	ClientEmail string `json:"client_email"`
	PrivateKey  string `json:"private_key"`
	TokenURI    string `json:"token_uri"`
}

// FCM sends through the Firebase Cloud Messaging HTTP v1 API.
type FCM struct {
	acct    serviceAccount
	key     *rsa.PrivateKey
	http    *http.Client
	sendURL string

	mu      sync.Mutex
	token   string
	expires time.Time
}

// NewFCMFromFile loads a service-account key file (FCM_SERVICE_ACCOUNT_JSON).
func NewFCMFromFile(path string) (*FCM, error) {
	b, err := os.ReadFile(path)
	if err != nil {
		return nil, err
	}
	return NewFCM(b, "")
}

// NewFCM parses a service-account key. endpoint overrides the FCM base URL
// (tests); empty means https://fcm.googleapis.com.
func NewFCM(keyJSON []byte, endpoint string) (*FCM, error) {
	var a serviceAccount
	if err := json.Unmarshal(cleanKey(keyJSON), &a); err != nil {
		// Never include the content: it is a private key.
		return nil, fmt.Errorf("push: service-account file is not valid JSON (%d bytes); re-paste the whole file into FCM_SERVICE_ACCOUNT_JSON", len(keyJSON))
	}
	if a.ProjectID == "" || a.ClientEmail == "" || a.PrivateKey == "" {
		return nil, errors.New("push: service-account file is missing project_id, client_email or private_key")
	}
	if a.TokenURI == "" {
		a.TokenURI = "https://oauth2.googleapis.com/token"
	}
	block, _ := pem.Decode([]byte(a.PrivateKey))
	if block == nil {
		return nil, errors.New("push: private_key is not PEM")
	}
	k, err := x509.ParsePKCS8PrivateKey(block.Bytes)
	if err != nil {
		return nil, fmt.Errorf("push: private_key: %w", err)
	}
	rk, ok := k.(*rsa.PrivateKey)
	if !ok {
		return nil, errors.New("push: private_key is not RSA")
	}
	if endpoint == "" {
		endpoint = "https://fcm.googleapis.com"
	}
	return &FCM{
		acct:    a,
		key:     rk,
		http:    &http.Client{Timeout: 15 * time.Second},
		sendURL: fmt.Sprintf("%s/v1/projects/%s/messages:send", strings.TrimRight(endpoint, "/"), a.ProjectID),
	}, nil
}

// cleanKey accepts the key file as commonly pasted into a secret: with a
// UTF-8 byte-order mark (Windows Notepad), surrounding whitespace, or
// base64-encoded.
func cleanKey(b []byte) []byte {
	b = bytes.TrimSpace(bytes.TrimPrefix(bytes.TrimSpace(b), []byte("\xef\xbb\xbf")))
	if len(b) > 0 && b[0] != '{' {
		if dec, err := base64.StdEncoding.DecodeString(string(b)); err == nil {
			return bytes.TrimSpace(bytes.TrimPrefix(dec, []byte("\xef\xbb\xbf")))
		}
	}
	return b
}

// ProjectID is the Firebase project the key belongs to (for logs).
func (f *FCM) ProjectID() string { return f.acct.ProjectID }

// accessToken returns a cached OAuth token, refreshing it 5 minutes early.
func (f *FCM) accessToken(ctx context.Context) (string, error) {
	f.mu.Lock()
	defer f.mu.Unlock()
	if f.token != "" && time.Until(f.expires) > 5*time.Minute {
		return f.token, nil
	}
	now := time.Now()
	enc := base64.RawURLEncoding
	header := enc.EncodeToString([]byte(`{"alg":"RS256","typ":"JWT"}`))
	claims, _ := json.Marshal(map[string]any{
		"iss":   f.acct.ClientEmail,
		"scope": "https://www.googleapis.com/auth/firebase.messaging",
		"aud":   f.acct.TokenURI,
		"iat":   now.Unix(),
		"exp":   now.Add(time.Hour).Unix(),
	})
	unsigned := header + "." + enc.EncodeToString(claims)
	sum := sha256.Sum256([]byte(unsigned))
	sig, err := rsa.SignPKCS1v15(rand.Reader, f.key, crypto.SHA256, sum[:])
	if err != nil {
		return "", err
	}
	form := url.Values{
		"grant_type": {"urn:ietf:params:oauth:grant-type:jwt-bearer"},
		"assertion":  {unsigned + "." + enc.EncodeToString(sig)},
	}
	req, _ := http.NewRequestWithContext(ctx, http.MethodPost, f.acct.TokenURI, strings.NewReader(form.Encode()))
	req.Header.Set("Content-Type", "application/x-www-form-urlencoded")
	resp, err := f.http.Do(req)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()
	body, _ := io.ReadAll(io.LimitReader(resp.Body, 1<<16))
	if resp.StatusCode != http.StatusOK {
		return "", fmt.Errorf("push: token endpoint %d: %s", resp.StatusCode, body)
	}
	var t struct {
		AccessToken string `json:"access_token"`
		ExpiresIn   int    `json:"expires_in"`
	}
	if err := json.Unmarshal(body, &t); err != nil || t.AccessToken == "" {
		return "", fmt.Errorf("push: bad token response")
	}
	f.token, f.expires = t.AccessToken, now.Add(time.Duration(t.ExpiresIn)*time.Second)
	return f.token, nil
}

// Send delivers a "new messages" push. The visible text comes from the
// app's own string resources (title_loc_key / body_loc_key), so it is in
// the phone's language and contains nothing from the message.
func (f *FCM) Send(ctx context.Context, token string, m Message) error {
	at, err := f.accessToken(ctx)
	if err != nil {
		return err
	}
	chat := fmt.Sprint(m.ChatID)
	body, _ := json.Marshal(map[string]any{"message": map[string]any{
		"token": token,
		"data":  map[string]string{"type": "new_message", "chat_id": chat},
		"android": map[string]any{
			"priority":     "HIGH",
			"collapse_key": m.Collapse,
			"ttl":          "86400s",
			"notification": map[string]any{
				"title_loc_key": "push_title",
				"body_loc_key":  "push_new_message",
				"channel_id":    "messages",
				"tag":           "chat_" + chat,
				"icon":          "ic_notification",
				"color":         "#0F6E35",
			},
		},
	}})
	req, _ := http.NewRequestWithContext(ctx, http.MethodPost, f.sendURL, bytes.NewReader(body))
	req.Header.Set("Authorization", "Bearer "+at)
	req.Header.Set("Content-Type", "application/json")
	resp, err := f.http.Do(req)
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	rb, _ := io.ReadAll(io.LimitReader(resp.Body, 1<<16))
	switch {
	case resp.StatusCode == http.StatusOK:
		return nil
	case resp.StatusCode == http.StatusNotFound || bytes.Contains(rb, []byte("UNREGISTERED")):
		return ErrUnregistered
	case resp.StatusCode == http.StatusBadRequest && bytes.Contains(rb, []byte("registration token")):
		return ErrUnregistered
	case resp.StatusCode == http.StatusUnauthorized:
		f.mu.Lock()
		f.token = "" // fetch a new token next time
		f.mu.Unlock()
	}
	return fmt.Errorf("push: fcm %d: %s", resp.StatusCode, rb)
}
