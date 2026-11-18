// Package config loads server configuration from environment variables
// (12-factor). Secrets come from the orchestrator's secret store, never files
// in the repository.
package config

import (
	"fmt"
	"os"
	"strconv"
)

// Config is the full server configuration.
type Config struct {
	// Role selects which modules this process runs: "all" (Lean MVP default),
	// "gateway", "api" or "worker".
	Role        string
	HTTPAddr    string
	NodeID      int64
	PostgresURL string
	RedisURL    string
	S3Endpoint  string
	S3Bucket    string
	// MaxUploadBytes caps media uploads (Lean MVP: 500 MB; protocol max 2 GiB).
	MaxUploadBytes int64
	// SmallGroupLimit is the member cap for fan-out-on-write groups.
	SmallGroupLimit int
}

// Load reads the configuration from the environment.
func Load() (Config, error) {
	c := Config{
		Role:            env("WASLA_ROLE", "all"),
		HTTPAddr:        env("WASLA_HTTP_ADDR", ":8080"),
		PostgresURL:     os.Getenv("WASLA_POSTGRES_URL"),
		RedisURL:        env("WASLA_REDIS_URL", "redis://localhost:6379/0"),
		S3Endpoint:      os.Getenv("WASLA_S3_ENDPOINT"),
		S3Bucket:        env("WASLA_S3_BUCKET", "wasla-media"),
		MaxUploadBytes:  500 << 20,
		SmallGroupLimit: 200,
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
	return c, nil
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
