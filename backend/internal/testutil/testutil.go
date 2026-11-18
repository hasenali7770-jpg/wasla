// Package testutil provides real dependencies for integration tests:
// a fresh Postgres database with all migrations applied (needs
// WASLA_TEST_POSTGRES_URL, a URL whose user may CREATE DATABASE) and an
// in-memory Redis.
package testutil

import (
	"context"
	"crypto/rand"
	"encoding/hex"
	"os"
	"path/filepath"
	"sort"
	"testing"

	"github.com/alicebob/miniredis/v2"
	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"
)

// Postgres returns a pool on a new, migrated database that is dropped when
// the test ends. Skips the test if WASLA_TEST_POSTGRES_URL is unset.
func Postgres(t *testing.T) *pgxpool.Pool {
	t.Helper()
	adminURL := os.Getenv("WASLA_TEST_POSTGRES_URL")
	if adminURL == "" {
		t.Skip("WASLA_TEST_POSTGRES_URL not set; skipping integration test")
	}
	ctx := context.Background()
	admin, err := pgx.Connect(ctx, adminURL)
	if err != nil {
		t.Fatalf("connect admin: %v", err)
	}
	b := make([]byte, 6)
	_, _ = rand.Read(b)
	name := "wasla_test_" + hex.EncodeToString(b)
	if _, err := admin.Exec(ctx, "CREATE DATABASE "+name); err != nil {
		t.Fatalf("create database: %v", err)
	}
	cfg, err := pgxpool.ParseConfig(adminURL)
	if err != nil {
		t.Fatal(err)
	}
	cfg.ConnConfig.Database = name
	pool, err := pgxpool.NewWithConfig(ctx, cfg)
	if err != nil {
		t.Fatal(err)
	}
	t.Cleanup(func() {
		pool.Close()
		_, _ = admin.Exec(context.Background(), "DROP DATABASE IF EXISTS "+name+" WITH (FORCE)")
		_ = admin.Close(context.Background())
	})
	for _, f := range migrations(t) {
		sql, err := os.ReadFile(f)
		if err != nil {
			t.Fatal(err)
		}
		if _, err := pool.Exec(ctx, string(sql)); err != nil {
			t.Fatalf("migration %s: %v", filepath.Base(f), err)
		}
	}
	return pool
}

func migrations(t *testing.T) []string {
	dir, err := os.Getwd()
	if err != nil {
		t.Fatal(err)
	}
	for {
		m := filepath.Join(dir, "db", "postgres", "migrations")
		if st, err := os.Stat(m); err == nil && st.IsDir() {
			files, _ := filepath.Glob(filepath.Join(m, "*.up.sql"))
			sort.Strings(files)
			return files
		}
		parent := filepath.Dir(dir)
		if parent == dir {
			t.Fatal("db/postgres/migrations not found above working directory")
		}
		dir = parent
	}
}

// Redis returns an in-memory Redis and a client for it.
func Redis(t *testing.T) (*miniredis.Miniredis, *redis.Client) {
	t.Helper()
	mr := miniredis.RunT(t)
	c := redis.NewClient(&redis.Options{Addr: mr.Addr()})
	t.Cleanup(func() { _ = c.Close() })
	return mr, c
}
