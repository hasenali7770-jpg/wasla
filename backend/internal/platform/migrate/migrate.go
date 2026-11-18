// Package migrate applies db/postgres/migrations/*.up.sql in order and
// records each in wasla_migrations. Files keep golang-migrate naming
// (NNNN_name.up.sql / .down.sql) so either tool can be used.
//
// Each migration file wraps itself in BEGIN/COMMIT. A Postgres advisory lock
// stops two servers starting at the same time from racing.
package migrate

import (
	"context"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"

	"github.com/jackc/pgx/v5/pgxpool"
)

const lockID = 7_241_964 // arbitrary, fixed

// Up applies pending migrations from dir and returns the versions applied.
func Up(ctx context.Context, pool *pgxpool.Pool, dir string) ([]string, error) {
	files, err := filepath.Glob(filepath.Join(dir, "*.up.sql"))
	if err != nil {
		return nil, err
	}
	if len(files) == 0 {
		return nil, fmt.Errorf("migrate: no *.up.sql files in %s", dir)
	}
	sort.Strings(files)

	conn, err := pool.Acquire(ctx)
	if err != nil {
		return nil, err
	}
	defer conn.Release()
	if _, err := conn.Exec(ctx, `SELECT pg_advisory_lock($1)`, lockID); err != nil {
		return nil, err
	}
	defer conn.Exec(context.Background(), `SELECT pg_advisory_unlock($1)`, lockID) //nolint:errcheck

	if _, err := conn.Exec(ctx, `CREATE TABLE IF NOT EXISTS wasla_migrations (
		version text PRIMARY KEY, applied_at timestamptz NOT NULL DEFAULT now())`); err != nil {
		return nil, err
	}
	var applied []string
	for _, f := range files {
		version := strings.SplitN(filepath.Base(f), "_", 2)[0]
		var done bool
		if err := conn.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM wasla_migrations WHERE version = $1)`, version).Scan(&done); err != nil {
			return applied, err
		}
		if done {
			continue
		}
		sql, err := os.ReadFile(f)
		if err != nil {
			return applied, err
		}
		if _, err := conn.Exec(ctx, string(sql)); err != nil {
			return applied, fmt.Errorf("migrate: %s: %w", filepath.Base(f), err)
		}
		if _, err := conn.Exec(ctx, `INSERT INTO wasla_migrations (version) VALUES ($1)`, version); err != nil {
			return applied, err
		}
		applied = append(applied, version)
	}
	return applied, nil
}
