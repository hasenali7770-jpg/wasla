package migrate_test

import (
	"context"
	"testing"

	"wasla/backend/internal/platform/migrate"
	"wasla/backend/internal/testutil"
)

func TestUpIsIdempotent(t *testing.T) {
	pool := testutil.Postgres(t) // already migrated once by the helper
	applied, err := migrate.Up(context.Background(), pool, testutil.MigrationsDir(t))
	if err != nil {
		t.Fatal(err)
	}
	if len(applied) != 0 {
		t.Fatalf("second run applied %v, want nothing", applied)
	}
	var n int
	if err := pool.QueryRow(context.Background(), `SELECT count(*) FROM wasla_migrations`).Scan(&n); err != nil || n < 2 {
		t.Fatalf("expected recorded migrations, got %d (%v)", n, err)
	}
}
