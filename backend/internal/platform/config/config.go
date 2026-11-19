// Package config loads server configuration from environment variables
// (12-factor). Secrets come from the orchestrator's secret store, never files
// in the repository.
package config

import (
	"encoding/hex"
	"errors"
	"fmt"
	"os"
	"strconv"
	"strings"
)

// Config is the full server configuration.
type Config struct {
	// Env is "dev" or "prod". Dev allows the logging SMS sender and
	// insecure default secrets.
	Env string
	// Role selects which modules this process runs: "all" (Lean MVP default),
	// "gateway", "api" or "worker".
	Role        string
	HTTPAddr    string
	AdminAddr   string
	NodeID      int64
	PostgresURL string
	RedisURL    string
	S3Endpoint  string // host:port the server uses; empty disables file sharing
	S3Bucket    string
	S3Secure    bool
	S3PublicURL string // scheme://host phones use in signed URLs (default: same as endpoint)
	S3Region    string
	S3AccessKey string
	S3SecretKey string
	// MaxUploadBytes caps media uploads (Lean MVP: 500 MB; protocol max 2 GiB).
	MaxUploadBytes int64
	// SmallGroupLimit is the member cap for fan-out-on-write groups.
	SmallGroupLimit int
	MinAppVersion   string
	TrustProxy      bool
	// AlertWebhookURL receives critical-report alerts (Slack/Mattermost format).
	AlertWebhookURL string
	// FCMCredentialsFile is the Firebase service-account key; empty
	// disables push notifications (dev servers only log them).
	FCMCredentialsFile string
	OriginPatterns     []string

	// Secrets (hex-encoded, at least 32 bytes each in prod).
	CodeSecret  []byte
	PhonePepper []byte
}

// Load reads the configuration from the environment.
func Load() (Config, error) {
	c := Config{
		Env:                env("WASLA_ENV", "prod"),
		Role:               env("WASLA_ROLE", "all"),
		HTTPAddr:           env("WASLA_HTTP_ADDR", ":8080"),
		AdminAddr:          env("WASLA_ADMIN_ADDR", "127.0.0.1:8081"),
		PostgresURL:        os.Getenv("WASLA_POSTGRES_URL"),
		RedisURL:           env("WASLA_REDIS_URL", "redis://localhost:6379/0"),
		S3Endpoint:         os.Getenv("WASLA_S3_ENDPOINT"),
		S3Bucket:           env("WASLA_S3_BUCKET", "wasla-media"),
		S3Secure:           os.Getenv("WASLA_S3_SECURE") == "true",
		S3PublicURL:        os.Getenv("WASLA_S3_PUBLIC_URL"),
		S3Region:           env("WASLA_S3_REGION", "us-east-1"),
		S3AccessKey:        os.Getenv("WASLA_S3_ACCESS_KEY"),
		S3SecretKey:        os.Getenv("WASLA_S3_SECRET_KEY"),
		MaxUploadBytes:     500 << 20,
		SmallGroupLimit:    200,
		MinAppVersion:      env("WASLA_MIN_APP_VERSION", "0.1.0"),
		TrustProxy:         os.Getenv("WASLA_TRUST_PROXY") == "true",
		AlertWebhookURL:    os.Getenv("WASLA_ALERT_WEBHOOK_URL"),
		FCMCredentialsFile: os.Getenv("WASLA_FCM_CREDENTIALS_FILE"),
	}
	if v := os.Getenv("WASLA_ORIGIN_PATTERNS"); v != "" {
		c.OriginPatterns = strings.Split(v, ",")
	}
	var err error
	if c.NodeID, err = envInt("WASLA_NODE_ID", 0); err != nil {
		return c, err
	}
	if c.MaxUploadBytes, err = envInt("WASLA_MAX_UPLOAD_BYTES", c.MaxUploadBytes); err != nil {
		return c, err
	}
	switch c.Role {
	case "all", "gateway", "api", "worker":
	default:
		return c, fmt.Errorf("config: unknown WASLA_ROLE %q", c.Role)
	}
	switch c.Env {
	case "dev", "prod":
	default:
		return c, fmt.Errorf("config: WASLA_ENV must be dev or prod, got %q", c.Env)
	}
	if c.PostgresURL == "" {
		return c, errors.New("config: WASLA_POSTGRES_URL is required")
	}
	if c.CodeSecret, err = secret("WASLA_CODE_SECRET", c.Env); err != nil {
		return c, err
	}
	if c.PhonePepper, err = secret("WASLA_PHONE_PEPPER", c.Env); err != nil {
		return c, err
	}
	return c, nil
}

// secret reads a hex secret. In dev a fixed placeholder is allowed.
func secret(key, envName string) ([]byte, error) {
	v := os.Getenv(key)
	if v == "" {
		if envName == "dev" {
			return []byte("dev-only-insecure-secret-" + key), nil
		}
		return nil, fmt.Errorf("config: %s is required in prod (hex, >= 32 bytes)", key)
	}
	b, err := hex.DecodeString(v)
	if err != nil {
		return nil, fmt.Errorf("config: %s must be hex: %w", key, err)
	}
	if len(b) < 32 && envName != "dev" {
		return nil, fmt.Errorf("config: %s must be at least 32 bytes", key)
	}
	return b, nil
}

func env(key, def string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return def
}

func envInt(key string, def int64) (int64, error) {
	v := os.Getenv(key)
	if v == "" {
		return def, nil
	}
	n, err := strconv.ParseInt(v, 10, 64)
	if err != nil {
		return 0, fmt.Errorf("config: %s: %w", key, err)
	}
	return n, nil
}
