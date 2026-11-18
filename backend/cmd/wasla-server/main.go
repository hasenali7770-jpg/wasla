// Command wasla-server is the single Wasla backend binary. In the Lean MVP
// one process runs every module (WASLA_ROLE=all); the same binary can later
// run as separate gateway / api / worker deployments without code changes.
//
// Usage:
//
//	wasla-server                       run the server
//	wasla-server staff create --email E --name N --role 1|2|3
package main

import (
	"context"
	"errors"
	"flag"
	"fmt"
	"log/slog"
	"net/http"
	"os"
	"os/signal"
	"syscall"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"

	"wasla/backend/internal/auth"
	"wasla/backend/internal/moderation"
	"wasla/backend/internal/platform/config"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/password"
	"wasla/backend/internal/platform/snowflake"
	"wasla/backend/internal/server"
)

func main() {
	log := slog.New(slog.NewJSONHandler(os.Stdout, nil))
	if err := run(log, os.Args[1:]); err != nil {
		log.Error("fatal", "err", err)
		os.Exit(1)
	}
}

func run(log *slog.Logger, args []string) error {
	cfg, err := config.Load()
	if err != nil {
		return err
	}
	ctx, stop := signal.NotifyContext(context.Background(), syscall.SIGINT, syscall.SIGTERM)
	defer stop()

	pool, err := db.Connect(ctx, cfg.PostgresURL)
	if err != nil {
		return fmt.Errorf("postgres: %w", err)
	}
	defer pool.Close()

	if len(args) >= 2 && args[0] == "staff" && args[1] == "create" {
		return staffCreate(ctx, pool, args[2:])
	}

	ropt, err := redis.ParseURL(cfg.RedisURL)
	if err != nil {
		return fmt.Errorf("redis url: %w", err)
	}
	rdb := redis.NewClient(ropt)
	defer rdb.Close()
	if err := rdb.Ping(ctx).Err(); err != nil {
		return fmt.Errorf("redis: %w", err)
	}

	ids, err := snowflake.New(cfg.NodeID)
	if err != nil {
		return err
	}
	var sms auth.Sender
	var attestor auth.Attestor
	if cfg.Env == "dev" {
		sms, attestor = &auth.DevSender{Log: log}, auth.DevAttestor{}
	} else {
		// Real SMS aggregators are wired in once selected (docs/01-architecture.md §12).
		return errors.New("no SMS provider configured for prod; set WASLA_ENV=dev for local use")
	}
	authCfg := auth.DefaultConfig()
	authCfg.CodeSecret, authCfg.PhonePepper = cfg.CodeSecret, cfg.PhonePepper

	srv, err := server.New(ctx, server.Deps{
		DB: pool, Redis: rdb, Log: log, IDs: ids, SMS: sms, Attestor: attestor, AuthCfg: authCfg,
		SLA: moderation.DefaultSLA, MinAppVersion: cfg.MinAppVersion, TrustProxy: cfg.TrustProxy,
		OriginPatterns: cfg.OriginPatterns, SecureCookies: cfg.Env != "dev",
	})
	if err != nil {
		return err
	}
	defer srv.Hub.Close()
	adminHandler, err := srv.AdminHandler()
	if err != nil {
		return err
	}

	public := &http.Server{Addr: cfg.HTTPAddr, Handler: srv.PublicHandler(), ReadHeaderTimeout: 10 * time.Second}
	admin := &http.Server{Addr: cfg.AdminAddr, Handler: adminHandler, ReadHeaderTimeout: 10 * time.Second}
	errc := make(chan error, 2)
	for _, s := range []*http.Server{public, admin} {
		go func(s *http.Server) {
			log.Info("listening", "addr", s.Addr, "role", cfg.Role, "env", cfg.Env)
			if err := s.ListenAndServe(); err != nil && !errors.Is(err, http.ErrServerClosed) {
				errc <- err
			}
		}(s)
	}
	select {
	case <-ctx.Done():
	case err := <-errc:
		return err
	}
	shutdownCtx, cancel := context.WithTimeout(context.Background(), 20*time.Second)
	defer cancel()
	_ = public.Shutdown(shutdownCtx)
	_ = admin.Shutdown(shutdownCtx)
	log.Info("stopped")
	return nil
}

func staffCreate(ctx context.Context, pool *pgxpool.Pool, args []string) error {
	fs := flag.NewFlagSet("staff create", flag.ContinueOnError)
	email := fs.String("email", "", "staff email")
	name := fs.String("name", "", "display name")
	role := fs.Int("role", 1, "1 moderator, 2 senior moderator, 3 admin")
	if err := fs.Parse(args); err != nil {
		return err
	}
	ns, err := moderation.CreateStaff(ctx, pool, *email, *name, int16(*role), password.Default)
	if err != nil {
		return err
	}
	fmt.Printf("Staff account %d created. Deliver these to %s securely; they are shown only once.\n", ns.ID, *email)
	fmt.Printf("  Password:     %s\n", ns.Password)
	fmt.Printf("  TOTP secret:  %s\n", ns.TOTPSecret)
	fmt.Printf("  TOTP QR URI:  %s\n", ns.TOTPURI)
	return nil
}
