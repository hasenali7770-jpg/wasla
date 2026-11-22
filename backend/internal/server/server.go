// Package server wires the modules together.
package server

import (
	"context"
	"log/slog"
	"net/http"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"

	"wasla/backend/internal/auth"
	"wasla/backend/internal/chats"
	"wasla/backend/internal/contacts"
	"wasla/backend/internal/gateway"
	"wasla/backend/internal/media"
	"wasla/backend/internal/messaging"
	"wasla/backend/internal/moderation"
	"wasla/backend/internal/platform/ratelimit"
	"wasla/backend/internal/platform/rpc"
	"wasla/backend/internal/updates"
	"wasla/backend/internal/users"
)

// Deps are the external dependencies.
type Deps struct {
	DB       *pgxpool.Pool
	Redis    *redis.Client
	Log      *slog.Logger
	IDs      auth.IDGen
	SMS      auth.Sender
	Attestor auth.Attestor
	AuthCfg  auth.Config
	SLA      moderation.SLA
	// AlertWebhookURL (optional) receives critical-report alerts.
	AlertWebhookURL string
	// Storage (optional) enables photos and files.
	Storage  *media.Storage
	MediaCfg media.Config
	// Gateway options
	MinAppVersion  string
	TrustProxy     bool
	OriginPatterns []string
	SecureCookies  bool
	Now            func() time.Time
}

// Server holds the wired modules.
type Server struct {
	Router  *rpc.Router
	Gateway *gateway.Gateway
	Hub     *gateway.Hub
	Auth    *auth.Service
	Updates *updates.Service
	Actions *moderation.Actions
	Admin   *moderation.Admin
	Reports *moderation.Reports
	Media   *media.Service
	deps    Deps
}

// Registrar is any module that adds RPC methods.
type Registrar interface{ Register(*rpc.Router) }

// NewRouter registers every module's methods and validates them against the
// proto descriptors.
func NewRouter(mods ...Registrar) (*rpc.Router, error) {
	r := rpc.NewRouter()
	for _, m := range mods {
		m.Register(r)
	}
	return r, r.Validate()
}

// New builds the server.
func New(ctx context.Context, d Deps) (*Server, error) {
	limits := &ratelimit.Limiter{R: d.Redis, Now: d.Now}
	upd := &updates.Service{DB: d.DB, Redis: d.Redis, Now: d.Now}
	authSvc := &auth.Service{DB: d.DB, Redis: d.Redis, IDs: d.IDs, SMS: d.SMS, Attestor: d.Attestor,
		Limits: limits, Cfg: d.AuthCfg, Log: d.Log, Now: d.Now}
	usersSvc := &users.Service{DB: d.DB}
	reports := &moderation.Reports{DB: d.DB, Limits: limits, SLA: d.SLA, Log: d.Log, Now: d.Now}
	if d.AlertWebhookURL != "" {
		reports.Alert = &moderation.WebhookAlerter{URL: d.AlertWebhookURL}
	}
	actions := &moderation.Actions{DB: d.DB, Redis: d.Redis, Updates: upd, PhonePepper: d.AuthCfg.PhonePepper, Log: d.Log, Now: d.Now}
	chatsSvc := &chats.Service{DB: d.DB, IDs: d.IDs, Updates: upd, Log: d.Log}
	msgSvc := &messaging.Service{DB: d.DB, IDs: d.IDs, Updates: upd, Limits: limits, Log: d.Log, Now: d.Now}
	contactsSvc := &contacts.Service{DB: d.DB, Limits: limits}
	mediaCfg := d.MediaCfg
	if mediaCfg.MaxUploadBytes == 0 {
		mediaCfg = media.DefaultConfig()
	}
	mediaSvc := &media.Service{DB: d.DB, Store: d.Storage, IDs: d.IDs, Updates: upd, Limits: limits, Cfg: mediaCfg, Log: d.Log}
	if reports.Alert != nil {
		mediaSvc.Alert = reports.Alert
	}
	actions.OnMediaBlocked = mediaSvc.TakedownByHash

	router, err := NewRouter(authSvc, usersSvc, upd, reports, chatsSvc, msgSvc, contactsSvc, mediaSvc)
	if err != nil {
		return nil, err
	}
	hub, err := gateway.NewHub(ctx, d.Redis, d.Log)
	if err != nil {
		return nil, err
	}
	gw := &gateway.Gateway{Router: router, Auth: authSvc, Hub: hub, DB: d.DB, Log: d.Log,
		MinAppVersion: d.MinAppVersion, TrustProxy: d.TrustProxy, OriginPatterns: d.OriginPatterns}
	admin := &moderation.Admin{DB: d.DB, Redis: d.Redis, Actions: actions, Limits: limits, Log: d.Log,
		Now: d.Now, SecureCookie: d.SecureCookies}
	return &Server{Router: router, Gateway: gw, Hub: hub, Auth: authSvc, Updates: upd, Actions: actions, Admin: admin,
		Reports: reports, Media: mediaSvc, deps: d}, nil
}

// PublicHandler serves the client-facing endpoints.
func (s *Server) PublicHandler() http.Handler {
	mux := http.NewServeMux()
	mux.Handle("GET /ws", s.Gateway)
	mux.HandleFunc("GET /healthz", func(w http.ResponseWriter, _ *http.Request) { _, _ = w.Write([]byte("ok")) })
	mux.HandleFunc("GET /readyz", func(w http.ResponseWriter, r *http.Request) {
		ctx, cancel := context.WithTimeout(r.Context(), 2*time.Second)
		defer cancel()
		if err := s.deps.DB.Ping(ctx); err != nil {
			http.Error(w, "db unavailable", http.StatusServiceUnavailable)
			return
		}
		if err := s.deps.Redis.Ping(ctx).Err(); err != nil {
			http.Error(w, "redis unavailable", http.StatusServiceUnavailable)
			return
		}
		_, _ = w.Write([]byte("ready"))
	})
	return mux
}

// AdminHandler serves the moderation panel (separate listener).
func (s *Server) AdminHandler() (http.Handler, error) { return s.Admin.Handler() }
