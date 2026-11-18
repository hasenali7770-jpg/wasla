package moderation

import (
	"context"
	"crypto/rand"
	"crypto/sha256"
	"embed"
	"encoding/base64"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"html/template"
	"log/slog"
	"net"
	"net/http"
	"strconv"
	"strings"
	"time"
	_ "time/tzdata" // Asia/Baghdad in minimal container images

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/password"
	"wasla/backend/internal/platform/ratelimit"
	"wasla/backend/internal/platform/totp"
)

//go:embed templates/*.html templates/admin.css
var templateFS embed.FS

const (
	cookieName      = "wasla_admin"
	sessionTTL      = 8 * time.Hour
	adminPathPrefix = "/admin"
)

// Admin is the staff moderation panel. It is served on its own listener
// (WASLA_ADMIN_ADDR), which production exposes only on a separate hostname
// behind an IP allowlist.
type Admin struct {
	DB      *pgxpool.Pool
	Redis   *redis.Client
	Actions *Actions
	Limits  *ratelimit.Limiter
	Log     *slog.Logger
	Now     func() time.Time
	// SecureCookie must be true in production (HTTPS only).
	SecureCookie bool

	pages map[string]*template.Template
	loc   *time.Location
}

type staffKey struct{}

// Handler returns the panel's HTTP handler.
func (a *Admin) Handler() (http.Handler, error) {
	loc, err := time.LoadLocation("Asia/Baghdad")
	if err != nil {
		return nil, err
	}
	a.loc = loc
	if err := a.parseTemplates(); err != nil {
		return nil, err
	}
	mux := http.NewServeMux()
	mux.HandleFunc("GET /admin/static/admin.css", a.css)
	mux.HandleFunc("GET /admin/login", a.loginPage)
	mux.HandleFunc("POST /admin/login", a.login)
	mux.Handle("POST /admin/logout", a.auth(a.logout))
	mux.Handle("GET /admin/{$}", a.auth(a.queue))
	mux.Handle("GET /admin/reports/{id}", a.auth(a.report))
	mux.Handle("POST /admin/reports/{id}/assign", a.auth(a.assign))
	mux.Handle("POST /admin/reports/{id}/action", a.auth(a.reportAction))
	mux.Handle("GET /admin/users/{id}", a.auth(a.user))
	mux.Handle("POST /admin/users/{id}/ban", a.auth(a.banUser))
	mux.Handle("POST /admin/users/{id}/unban", a.auth(a.unbanUser))
	mux.Handle("GET /admin/legal", a.auth(a.legalList))
	mux.Handle("POST /admin/legal", a.auth(a.legalCreate))
	mux.Handle("GET /admin/legal/{id}", a.auth(a.legalDetail))
	mux.Handle("POST /admin/legal/{id}/action", a.auth(a.legalAction))
	mux.Handle("POST /admin/legal/{id}/close", a.auth(a.legalClose))
	mux.Handle("GET /admin/blocklist", a.auth(a.blocklist))
	mux.Handle("POST /admin/blocklist", a.auth(a.blocklistAdd))
	mux.Handle("GET /admin/audit", a.auth(a.auditLog))
	return securityHeaders(mux), nil
}

func securityHeaders(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		h := w.Header()
		h.Set("Content-Security-Policy", "default-src 'none'; style-src 'self'; img-src 'self'; form-action 'self'; frame-ancestors 'none'; base-uri 'none'")
		h.Set("X-Content-Type-Options", "nosniff")
		h.Set("Referrer-Policy", "no-referrer")
		h.Set("Cache-Control", "no-store")
		h.Set("X-Frame-Options", "DENY")
		next.ServeHTTP(w, r)
	})
}

// ---------------------------------------------------------------------------
// Authentication
// ---------------------------------------------------------------------------

type adminSession struct {
	Staff Staff
	CSRF  string
}

func (a *Admin) auth(next func(http.ResponseWriter, *http.Request, *adminSession)) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		sess, err := a.loadSession(r)
		if err != nil || sess == nil {
			http.Redirect(w, r, adminPathPrefix+"/login", http.StatusSeeOther)
			return
		}
		if r.Method == http.MethodPost && r.PostFormValue("csrf") != sess.CSRF {
			http.Error(w, "invalid form token, reload the page", http.StatusForbidden)
			return
		}
		next(w, r, sess)
	})
}

func sessionKey(token string) string {
	sum := sha256.Sum256([]byte(token))
	return "admin:sess:" + hex.EncodeToString(sum[:])
}

func (a *Admin) loadSession(r *http.Request) (*adminSession, error) {
	ck, err := r.Cookie(cookieName)
	if err != nil {
		return nil, nil
	}
	vals, err := a.Redis.HGetAll(r.Context(), sessionKey(ck.Value)).Result()
	if err != nil || len(vals) == 0 {
		return nil, err
	}
	id, _ := strconv.ParseInt(vals["staff_id"], 10, 64)
	sess := &adminSession{CSRF: vals["csrf"], Staff: Staff{ID: id}}
	var disabled bool
	err = a.DB.QueryRow(r.Context(), `SELECT display_name, role, disabled_at IS NOT NULL FROM staff_users WHERE id = $1`, id).
		Scan(&sess.Staff.Name, &sess.Staff.Role, &disabled)
	if err != nil || disabled {
		return nil, err
	}
	return sess, nil
}

func (a *Admin) loginPage(w http.ResponseWriter, r *http.Request) {
	a.render(w, "login", nil, map[string]any{"Error": r.URL.Query().Get("e") != ""})
}

func (a *Admin) login(w http.ResponseWriter, r *http.Request) {
	ctx := r.Context()
	email := strings.ToLower(strings.TrimSpace(r.PostFormValue("email")))
	ip := clientIP(r)
	for _, key := range []string{"admin-login-ip:" + ip, "admin-login-email:" + email} {
		ok, _, err := a.Limits.Allow(ctx, key, 10, 15*time.Minute)
		if err != nil || !ok {
			http.Error(w, "too many login attempts, wait 15 minutes", http.StatusTooManyRequests)
			return
		}
	}
	fail := func() { http.Redirect(w, r, adminPathPrefix+"/login?e=1", http.StatusSeeOther) }

	var id int64
	var phc string
	var secret []byte
	err := a.DB.QueryRow(ctx, `SELECT id, password_hash, totp_secret FROM staff_users
		WHERE lower(email) = $1 AND disabled_at IS NULL`, email).Scan(&id, &phc, &secret)
	if err != nil {
		// Same cost as a real check, so response time does not reveal valid emails.
		_, _ = password.Verify(r.PostFormValue("password"), "$argon2id$v=19$m=65536,t=3,p=2$c2FsdHNhbHRzYWx0c2FsdA$ZGVhZGJlZWZkZWFkYmVlZmRlYWRiZWVmZGVhZGJlZWY")
		fail()
		return
	}
	ok, err := password.Verify(r.PostFormValue("password"), phc)
	if err != nil || !ok || len(secret) == 0 {
		fail()
		return
	}
	counter, ok := totp.Verify(secret, strings.TrimSpace(r.PostFormValue("totp")), a.now())
	if !ok {
		fail()
		return
	}
	// Each code works once.
	if set, err := a.Redis.SetNX(ctx, fmt.Sprintf("admin:totp:%d:%d", id, counter), 1, 3*time.Minute).Result(); err != nil || !set {
		fail()
		return
	}
	token, csrf := randToken(), randToken()
	key := sessionKey(token)
	pipe := a.Redis.TxPipeline()
	pipe.HSet(ctx, key, map[string]any{"staff_id": id, "csrf": csrf})
	pipe.Expire(ctx, key, sessionTTL)
	if _, err := pipe.Exec(ctx); err != nil {
		http.Error(w, "internal error", http.StatusInternalServerError)
		return
	}
	http.SetCookie(w, &http.Cookie{Name: cookieName, Value: token, Path: adminPathPrefix, HttpOnly: true,
		Secure: a.SecureCookie, SameSite: http.SameSiteStrictMode, MaxAge: int(sessionTTL.Seconds())})
	a.Log.Info("staff login", "staff_id", id, "ip", ip)
	http.Redirect(w, r, adminPathPrefix+"/", http.StatusSeeOther)
}

func (a *Admin) logout(w http.ResponseWriter, r *http.Request, _ *adminSession) {
	if ck, err := r.Cookie(cookieName); err == nil {
		a.Redis.Del(r.Context(), sessionKey(ck.Value))
	}
	http.SetCookie(w, &http.Cookie{Name: cookieName, Value: "", Path: adminPathPrefix, MaxAge: -1, HttpOnly: true,
		Secure: a.SecureCookie, SameSite: http.SameSiteStrictMode})
	http.Redirect(w, r, adminPathPrefix+"/login", http.StatusSeeOther)
}

// ---------------------------------------------------------------------------
// Review queue and reports
// ---------------------------------------------------------------------------

type reportRow struct {
	ID           int64
	Priority     int16
	Reason       int16
	Status       int16
	TargetUserID *int64
	TargetName   string
	ChatID       *int64
	MessageCount int
	Comment      string
	CreatedAt    time.Time
	DueAt        time.Time
	AssignedName string
	ReporterID   int64
	Resolution   string
}

func (a *Admin) queue(w http.ResponseWriter, r *http.Request, s *adminSession) {
	ctx := r.Context()
	rows, err := a.DB.Query(ctx, `
		SELECT r.id, r.priority, r.reason, r.status, r.target_user_id, COALESCE(u.first_name || ' ' || u.last_name, ''),
		       r.chat_id, cardinality(r.message_seqs), r.comment, r.created_at, r.due_at, COALESCE(st.display_name, ''),
		       COALESCE(r.reporter_id, 0), COALESCE(r.resolution, '')
		FROM reports r
		LEFT JOIN users u ON u.id = r.target_user_id
		LEFT JOIN staff_users st ON st.id = r.assigned_to
		WHERE r.status = 1
		ORDER BY r.priority, r.due_at
		LIMIT 200`)
	if err != nil {
		a.fail(w, err)
		return
	}
	list, err := scanReports(rows)
	if err != nil {
		a.fail(w, err)
		return
	}
	var counts struct{ Critical, High, Normal, Overdue int }
	err = a.DB.QueryRow(ctx, `
		SELECT count(*) FILTER (WHERE priority = 1), count(*) FILTER (WHERE priority = 2),
		       count(*) FILTER (WHERE priority = 3), count(*) FILTER (WHERE due_at < now())
		FROM reports WHERE status = 1`).Scan(&counts.Critical, &counts.High, &counts.Normal, &counts.Overdue)
	if err != nil {
		a.fail(w, err)
		return
	}
	var openLegal int
	_ = a.DB.QueryRow(ctx, `SELECT count(*) FROM legal_requests WHERE status = 1`).Scan(&openLegal)
	a.render(w, "queue", s, map[string]any{"Reports": list, "Counts": counts, "OpenLegal": openLegal})
}

func scanReports(rows pgx.Rows) ([]reportRow, error) {
	defer rows.Close()
	var out []reportRow
	for rows.Next() {
		var x reportRow
		if err := rows.Scan(&x.ID, &x.Priority, &x.Reason, &x.Status, &x.TargetUserID, &x.TargetName, &x.ChatID,
			&x.MessageCount, &x.Comment, &x.CreatedAt, &x.DueAt, &x.AssignedName, &x.ReporterID, &x.Resolution); err != nil {
			return nil, err
		}
		out = append(out, x)
	}
	return out, rows.Err()
}

func (a *Admin) report(w http.ResponseWriter, r *http.Request, s *adminSession) {
	ctx := r.Context()
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	rows, err := a.DB.Query(ctx, `
		SELECT r.id, r.priority, r.reason, r.status, r.target_user_id, COALESCE(u.first_name || ' ' || u.last_name, ''),
		       r.chat_id, cardinality(r.message_seqs), r.comment, r.created_at, r.due_at, COALESCE(st.display_name, ''),
		       COALESCE(r.reporter_id, 0), COALESCE(r.resolution, '')
		FROM reports r
		LEFT JOIN users u ON u.id = r.target_user_id
		LEFT JOIN staff_users st ON st.id = r.assigned_to
		WHERE r.id = $1`, id)
	if err != nil {
		a.fail(w, err)
		return
	}
	list, err := scanReports(rows)
	if err != nil {
		a.fail(w, err)
		return
	}
	if len(list) == 0 {
		http.NotFound(w, r)
		return
	}
	rep := list[0]
	var evRaw []byte
	var seqs []int64
	if err := a.DB.QueryRow(ctx, `SELECT COALESCE(evidence, '{}'), message_seqs FROM reports WHERE id = $1`, id).Scan(&evRaw, &seqs); err != nil {
		a.fail(w, err)
		return
	}
	var ev Evidence
	_ = json.Unmarshal(evRaw, &ev)

	data := map[string]any{"R": rep, "Evidence": ev, "Seqs": joinInts(seqs)}
	if rep.TargetUserID != nil {
		var prior struct{ Reports, Actions int }
		_ = a.DB.QueryRow(ctx, `SELECT (SELECT count(*) FROM reports WHERE target_user_id = $1 AND id <> $2),
			(SELECT count(*) FROM moderation_actions WHERE target_user_id = $1)`, *rep.TargetUserID, id).
			Scan(&prior.Reports, &prior.Actions)
		data["Prior"] = prior
	}
	a.render(w, "report", s, data)
}

func (a *Admin) assign(w http.ResponseWriter, r *http.Request, s *adminSession) {
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	if _, err := a.DB.Exec(r.Context(), `UPDATE reports SET assigned_to = $1, assigned_at = now() WHERE id = $2 AND status = 1`,
		s.Staff.ID, id); err != nil {
		a.fail(w, err)
		return
	}
	http.Redirect(w, r, fmt.Sprintf("%s/reports/%d", adminPathPrefix, id), http.StatusSeeOther)
}

func (a *Admin) reportAction(w http.ResponseWriter, r *http.Request, s *adminSession) {
	ctx := r.Context()
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	var target, chat *int64
	var seqs []int64
	if err := a.DB.QueryRow(ctx, `SELECT target_user_id, chat_id, message_seqs FROM reports WHERE id = $1`, id).
		Scan(&target, &chat, &seqs); err != nil {
		a.fail(w, err)
		return
	}
	reason := r.PostFormValue("reason")
	link := Link{ReportID: id}
	var err error
	switch r.PostFormValue("action") {
	case "dismiss":
		err = a.Actions.Dismiss(ctx, s.Staff, id, reason)
	case "delete_messages":
		if chat == nil || len(seqs) == 0 {
			err = errs.Invalid("this report has no messages to delete")
		} else {
			err = a.Actions.DeleteMessages(ctx, s.Staff, *chat, seqs, reason, link)
		}
	case "delete_and_ban":
		if chat == nil || len(seqs) == 0 || target == nil {
			err = errs.Invalid("this report has no single author to ban")
		} else if err = a.Actions.DeleteMessages(ctx, s.Staff, *chat, seqs, reason, link); err == nil {
			err = a.Actions.BanUser(ctx, s.Staff, *target, banDuration(r.PostFormValue("duration")), reason, Link{})
		}
	case "ban_user":
		if target == nil {
			err = errs.Invalid("this report has no user target")
		} else {
			err = a.Actions.BanUser(ctx, s.Staff, *target, banDuration(r.PostFormValue("duration")), reason, link)
		}
	case "ban_chat":
		if chat == nil {
			err = errs.Invalid("this report has no chat")
		} else {
			err = a.Actions.BanChat(ctx, s.Staff, *chat, reason, link)
		}
	default:
		err = errs.Invalid("unknown action")
	}
	if a.actionError(w, s, err) {
		return
	}
	http.Redirect(w, r, adminPathPrefix+"/", http.StatusSeeOther)
}

// banDuration parses the form value: "1d", "7d", "30d" or "perm".
func banDuration(v string) time.Duration {
	switch v {
	case "1d":
		return 24 * time.Hour
	case "7d":
		return 7 * 24 * time.Hour
	case "30d":
		return 30 * 24 * time.Hour
	case "perm":
		return 0
	}
	return 24 * time.Hour
}

// ---------------------------------------------------------------------------
// Users
// ---------------------------------------------------------------------------

func (a *Admin) user(w http.ResponseWriter, r *http.Request, s *adminSession) {
	ctx := r.Context()
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	var u struct {
		ID                    int64
		Name, Username, Phone string
		CreatedAt             time.Time
		BannedAt, BanExpires  *time.Time
		BanReason             string
		Deleted               bool
		Sessions              int
	}
	err := a.DB.QueryRow(ctx, `
		SELECT id, first_name || ' ' || last_name, COALESCE(username, ''), COALESCE(phone, ''), created_at,
		       banned_at, ban_expires_at, COALESCE(ban_reason, ''), deleted_at IS NOT NULL,
		       (SELECT count(*) FROM sessions WHERE user_id = users.id AND revoked_at IS NULL)
		FROM users WHERE id = $1`, id).
		Scan(&u.ID, &u.Name, &u.Username, &u.Phone, &u.CreatedAt, &u.BannedAt, &u.BanExpires, &u.BanReason, &u.Deleted, &u.Sessions)
	if db.NoRows(err) {
		http.NotFound(w, r)
		return
	}
	if err != nil {
		a.fail(w, err)
		return
	}
	rows, err := a.DB.Query(ctx, `
		SELECT r.id, r.priority, r.reason, r.status, r.target_user_id, '', r.chat_id, cardinality(r.message_seqs),
		       r.comment, r.created_at, r.due_at, '', COALESCE(r.reporter_id, 0), COALESCE(r.resolution, '')
		FROM reports r WHERE r.target_user_id = $1 ORDER BY r.created_at DESC LIMIT 50`, id)
	if err != nil {
		a.fail(w, err)
		return
	}
	reports, err := scanReports(rows)
	if err != nil {
		a.fail(w, err)
		return
	}
	actions, err := a.loadActions(ctx, "a.target_user_id = $1", id)
	if err != nil {
		a.fail(w, err)
		return
	}
	a.render(w, "user", s, map[string]any{"U": u, "Reports": reports, "Actions": actions})
}

func (a *Admin) banUser(w http.ResponseWriter, r *http.Request, s *adminSession) {
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	err := a.Actions.BanUser(r.Context(), s.Staff, id, banDuration(r.PostFormValue("duration")), r.PostFormValue("reason"), Link{})
	if a.actionError(w, s, err) {
		return
	}
	http.Redirect(w, r, fmt.Sprintf("%s/users/%d", adminPathPrefix, id), http.StatusSeeOther)
}

func (a *Admin) unbanUser(w http.ResponseWriter, r *http.Request, s *adminSession) {
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	if a.actionError(w, s, a.Actions.UnbanUser(r.Context(), s.Staff, id, r.PostFormValue("reason"))) {
		return
	}
	http.Redirect(w, r, fmt.Sprintf("%s/users/%d", adminPathPrefix, id), http.StatusSeeOther)
}

// ---------------------------------------------------------------------------
// Legal requests (authorities)
// ---------------------------------------------------------------------------

type legalRow struct {
	ID                                           int64
	Authority, ReferenceNo, Description, Targets string
	Type, Status                                 int16
	ReceivedAt                                   time.Time
	DueAt                                        *time.Time
	LegalReview, Response, CreatedBy             string
}

func (a *Admin) legalList(w http.ResponseWriter, r *http.Request, s *adminSession) {
	if s.Staff.Role < RoleAdmin {
		http.Error(w, "admins only", http.StatusForbidden)
		return
	}
	list, err := a.loadLegal(r.Context(), "true ORDER BY (l.status <> 1), l.due_at NULLS LAST, l.received_at DESC LIMIT 100")
	if err != nil {
		a.fail(w, err)
		return
	}
	a.render(w, "legal", s, map[string]any{"Requests": list})
}

func (a *Admin) loadLegal(ctx context.Context, where string, args ...any) ([]legalRow, error) {
	rows, err := a.DB.Query(ctx, `
		SELECT l.id, l.authority, l.reference_no, l.description, l.targets::text, l.request_type, l.status,
		       l.received_at, l.due_at, l.legal_review, l.response, st.display_name
		FROM legal_requests l JOIN staff_users st ON st.id = l.created_by WHERE `+where, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var out []legalRow
	for rows.Next() {
		var x legalRow
		if err := rows.Scan(&x.ID, &x.Authority, &x.ReferenceNo, &x.Description, &x.Targets, &x.Type, &x.Status,
			&x.ReceivedAt, &x.DueAt, &x.LegalReview, &x.Response, &x.CreatedBy); err != nil {
			return nil, err
		}
		out = append(out, x)
	}
	return out, rows.Err()
}

// LegalTarget is one item named in a legal request.
type LegalTarget struct {
	UserID int64   `json:"user_id,omitempty"`
	ChatID int64   `json:"chat_id,omitempty"`
	Seqs   []int64 `json:"seqs,omitempty"`
}

// ParseLegalTargets reads one target per line: "user 123", "chat 456" or
// "message 456 12,13,14".
func ParseLegalTargets(text string) ([]LegalTarget, error) {
	var out []LegalTarget
	for i, line := range strings.Split(text, "\n") {
		f := strings.Fields(line)
		if len(f) == 0 {
			continue
		}
		bad := fmt.Errorf("line %d: expected 'user ID', 'chat ID' or 'message CHAT_ID SEQ,SEQ'", i+1)
		id, err := strconv.ParseInt(safeIndex(f, 1), 10, 64)
		if err != nil {
			return nil, bad
		}
		switch strings.ToLower(f[0]) {
		case "user":
			out = append(out, LegalTarget{UserID: id})
		case "chat":
			out = append(out, LegalTarget{ChatID: id})
		case "message", "messages":
			seqs, err := parseInts(strings.Join(f[min(2, len(f)):], ""))
			if err != nil || len(seqs) == 0 {
				return nil, bad
			}
			out = append(out, LegalTarget{ChatID: id, Seqs: seqs})
		default:
			return nil, bad
		}
	}
	return out, nil
}

func (a *Admin) legalCreate(w http.ResponseWriter, r *http.Request, s *adminSession) {
	if s.Staff.Role < RoleAdmin {
		http.Error(w, "admins only", http.StatusForbidden)
		return
	}
	targets, err := ParseLegalTargets(r.PostFormValue("targets"))
	if a.actionError(w, s, wrapInvalid(err)) {
		return
	}
	reqType, _ := strconv.Atoi(r.PostFormValue("type"))
	authority := strings.TrimSpace(r.PostFormValue("authority"))
	desc := strings.TrimSpace(r.PostFormValue("description"))
	if authority == "" || desc == "" || reqType < 1 || reqType > 3 {
		a.actionError(w, s, errs.Invalid("authority, type and description are required"))
		return
	}
	var due *time.Time
	if v := r.PostFormValue("due"); v != "" {
		t, err := time.ParseInLocation("2006-01-02", v, a.loc)
		if err != nil {
			a.actionError(w, s, errs.Invalid("due date must be YYYY-MM-DD"))
			return
		}
		t = t.Add(24*time.Hour - time.Second)
		due = &t
	}
	tj, _ := json.Marshal(targets)
	var id int64
	err = a.DB.QueryRow(r.Context(), `
		INSERT INTO legal_requests (authority, reference_no, request_type, description, targets, due_at, legal_review, created_by)
		VALUES ($1,$2,$3,$4,$5,$6,$7,$8) RETURNING id`,
		authority, strings.TrimSpace(r.PostFormValue("reference")), reqType, desc, tj, due,
		strings.TrimSpace(r.PostFormValue("legal_review")), s.Staff.ID).Scan(&id)
	if err != nil {
		a.fail(w, err)
		return
	}
	http.Redirect(w, r, fmt.Sprintf("%s/legal/%d", adminPathPrefix, id), http.StatusSeeOther)
}

func (a *Admin) legalDetail(w http.ResponseWriter, r *http.Request, s *adminSession) {
	if s.Staff.Role < RoleAdmin {
		http.Error(w, "admins only", http.StatusForbidden)
		return
	}
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	list, err := a.loadLegal(r.Context(), "l.id = $1", id)
	if err != nil {
		a.fail(w, err)
		return
	}
	if len(list) == 0 {
		http.NotFound(w, r)
		return
	}
	var targets []LegalTarget
	_ = json.Unmarshal([]byte(list[0].Targets), &targets)
	actions, err := a.loadActions(r.Context(), "a.legal_request_id = $1", id)
	if err != nil {
		a.fail(w, err)
		return
	}
	a.render(w, "legal_detail", s, map[string]any{"L": list[0], "Targets": targets, "Actions": actions})
}

// legalAction carries out one target of a legal request, linked for audit.
func (a *Admin) legalAction(w http.ResponseWriter, r *http.Request, s *adminSession) {
	if s.Staff.Role < RoleAdmin {
		http.Error(w, "admins only", http.StatusForbidden)
		return
	}
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	ctx := r.Context()
	link := Link{LegalRequestID: id}
	reason := r.PostFormValue("reason")
	userID, _ := strconv.ParseInt(r.PostFormValue("user_id"), 10, 64)
	chatID, _ := strconv.ParseInt(r.PostFormValue("chat_id"), 10, 64)
	var err error
	switch r.PostFormValue("action") {
	case "ban_user":
		err = a.Actions.BanUser(ctx, s.Staff, userID, banDuration(r.PostFormValue("duration")), reason, link)
	case "ban_chat":
		err = a.Actions.BanChat(ctx, s.Staff, chatID, reason, link)
	case "delete_messages":
		var seqs []int64
		if seqs, err = parseInts(r.PostFormValue("seqs")); err == nil {
			err = a.Actions.DeleteMessages(ctx, s.Staff, chatID, seqs, reason, link)
		}
	default:
		err = errs.Invalid("unknown action")
	}
	if a.actionError(w, s, err) {
		return
	}
	http.Redirect(w, r, fmt.Sprintf("%s/legal/%d", adminPathPrefix, id), http.StatusSeeOther)
}

func (a *Admin) legalClose(w http.ResponseWriter, r *http.Request, s *adminSession) {
	if s.Staff.Role < RoleAdmin {
		http.Error(w, "admins only", http.StatusForbidden)
		return
	}
	id, ok := pathID(w, r)
	if !ok {
		return
	}
	status, _ := strconv.Atoi(r.PostFormValue("status"))
	response := strings.TrimSpace(r.PostFormValue("response"))
	if status < 2 || status > 4 || response == "" {
		a.actionError(w, s, errs.Invalid("choose an outcome and write the response sent to the authority"))
		return
	}
	if _, err := a.DB.Exec(r.Context(), `UPDATE legal_requests SET status = $1, response = $2, legal_review = $3,
		closed_by = $4, closed_at = now() WHERE id = $5 AND status = 1`,
		status, response, strings.TrimSpace(r.PostFormValue("legal_review")), s.Staff.ID, id); err != nil {
		a.fail(w, err)
		return
	}
	http.Redirect(w, r, fmt.Sprintf("%s/legal/%d", adminPathPrefix, id), http.StatusSeeOther)
}

// ---------------------------------------------------------------------------
// Media blocklist and audit log
// ---------------------------------------------------------------------------

func (a *Admin) blocklist(w http.ResponseWriter, r *http.Request, s *adminSession) {
	rows, err := a.DB.Query(r.Context(), `SELECT encode(sha256, 'hex'), reason, note, created_at FROM media_blocklist
		ORDER BY created_at DESC LIMIT 200`)
	if err != nil {
		a.fail(w, err)
		return
	}
	defer rows.Close()
	type entry struct {
		SHA, Note string
		Reason    int16
		CreatedAt time.Time
	}
	var list []entry
	for rows.Next() {
		var e entry
		if err := rows.Scan(&e.SHA, &e.Reason, &e.Note, &e.CreatedAt); err != nil {
			a.fail(w, err)
			return
		}
		list = append(list, e)
	}
	a.render(w, "blocklist", s, map[string]any{"Entries": list})
}

func (a *Admin) blocklistAdd(w http.ResponseWriter, r *http.Request, s *adminSession) {
	sum, err := hex.DecodeString(strings.TrimSpace(r.PostFormValue("sha256")))
	if err != nil {
		sum = nil
	}
	reason, _ := strconv.Atoi(r.PostFormValue("reason"))
	err = a.Actions.BlockMedia(r.Context(), s.Staff, sum, pb.ReportReason(reason), strings.TrimSpace(r.PostFormValue("note")))
	if a.actionError(w, s, err) {
		return
	}
	http.Redirect(w, r, adminPathPrefix+"/blocklist", http.StatusSeeOther)
}

type actionRow struct {
	ID           int64
	Staff        string
	Action       int16
	TargetUserID *int64
	ChatID       *int64
	Seqs         string
	Reason       string
	ReportID     *int64
	LegalID      *int64
	ExpiresAt    *time.Time
	CreatedAt    time.Time
}

func (a *Admin) loadActions(ctx context.Context, where string, args ...any) ([]actionRow, error) {
	rows, err := a.DB.Query(ctx, `
		SELECT a.id, st.display_name, a.action, a.target_user_id, a.chat_id, array_to_string(a.message_seqs, ','),
		       a.reason, a.report_id, a.legal_request_id, a.expires_at, a.created_at
		FROM moderation_actions a JOIN staff_users st ON st.id = a.staff_id
		WHERE `+where+` ORDER BY a.created_at DESC LIMIT 200`, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var out []actionRow
	for rows.Next() {
		var x actionRow
		if err := rows.Scan(&x.ID, &x.Staff, &x.Action, &x.TargetUserID, &x.ChatID, &x.Seqs, &x.Reason,
			&x.ReportID, &x.LegalID, &x.ExpiresAt, &x.CreatedAt); err != nil {
			return nil, err
		}
		out = append(out, x)
	}
	return out, rows.Err()
}

func (a *Admin) auditLog(w http.ResponseWriter, r *http.Request, s *adminSession) {
	list, err := a.loadActions(r.Context(), "true")
	if err != nil {
		a.fail(w, err)
		return
	}
	a.render(w, "audit", s, map[string]any{"Actions": list})
}

// ---------------------------------------------------------------------------
// Rendering helpers
// ---------------------------------------------------------------------------

var reasonNames = map[int16]string{
	1: "رسائل مزعجة", 2: "احتيال", 3: "عنف", 4: "إرهاب", 5: "إساءة للأطفال", 6: "محتوى إباحي",
	7: "بضائع ممنوعة", 8: "نشر بيانات شخصية", 9: "تحرّش أو مضايقة", 10: "حساب مزيّف", 11: "حقوق نشر", 12: "أخرى",
}

var actionNames = map[int16]string{
	ActionWarn: "تحذير", ActionDeleteContent: "حذف محتوى", ActionBanUser: "حظر مستخدم", ActionUnbanUser: "رفع حظر",
	ActionBanChat: "إغلاق محادثة", ActionDismiss: "رفض البلاغ", ActionBlockMedia: "حظر ملف وسائط",
}

func (a *Admin) parseTemplates() error {
	funcs := template.FuncMap{
		"reason":   func(r int16) string { return reasonNames[r] },
		"action":   func(x int16) string { return actionNames[x] },
		"priority": func(p int16) string { return map[int16]string{1: "حرجة", 2: "عالية", 3: "عادية"}[p] },
		"status": func(s int16) string {
			return map[int16]string{1: "مفتوح", 2: "تم اتخاذ إجراء", 3: "مرفوض"}[s]
		},
		"legalType": func(t int16) string {
			return map[int16]string{1: "إزالة محتوى", 2: "إيقاف حساب", 3: "طلب بيانات مستخدم"}[t]
		},
		"legalStatus": func(s int16) string {
			return map[int16]string{1: "مفتوح", 2: "تم التنفيذ", 3: "تنفيذ جزئي", 4: "مرفوض لعدم كفاية السند القانوني"}[s]
		},
		"ts": func(t time.Time) string { return t.In(a.loc).Format("2006-01-02 15:04") },
		"tsp": func(t *time.Time) string {
			if t == nil {
				return "—"
			}
			return t.In(a.loc).Format("2006-01-02 15:04")
		},
		"overdue": func(t time.Time) bool { return a.now().After(t) },
		"unix":    func(v int64) string { return time.Unix(v, 0).In(a.loc).Format("2006-01-02 15:04") },
		"deref": func(p *int64) int64 {
			if p == nil {
				return 0
			}
			return *p
		},
		"joinInts": joinInts,
	}
	a.pages = map[string]*template.Template{}
	for _, page := range []string{"login", "queue", "report", "user", "legal", "legal_detail", "blocklist", "audit", "error"} {
		t, err := template.New("layout.html").Funcs(funcs).ParseFS(templateFS, "templates/layout.html", "templates/"+page+".html")
		if err != nil {
			return fmt.Errorf("template %s: %w", page, err)
		}
		a.pages[page] = t
	}
	return nil
}

func (a *Admin) render(w http.ResponseWriter, page string, s *adminSession, data map[string]any) {
	if data == nil {
		data = map[string]any{}
	}
	data["Session"] = s
	w.Header().Set("Content-Type", "text/html; charset=utf-8")
	if err := a.pages[page].Execute(w, data); err != nil {
		a.Log.Error("admin render", "page", page, "err", err)
	}
}

func (a *Admin) css(w http.ResponseWriter, _ *http.Request) {
	b, _ := templateFS.ReadFile("templates/admin.css")
	w.Header().Set("Content-Type", "text/css; charset=utf-8")
	_, _ = w.Write(b)
}

// actionError renders user-facing errors; returns true if err != nil.
func (a *Admin) actionError(w http.ResponseWriter, s *adminSession, err error) bool {
	if err == nil {
		return false
	}
	if out, ok := errs.ToProto(err); ok {
		w.WriteHeader(http.StatusBadRequest)
		a.render(w, "error", s, map[string]any{"Message": out.GetMessage()})
		return true
	}
	a.fail(w, err)
	return true
}

func (a *Admin) fail(w http.ResponseWriter, err error) {
	a.Log.Error("admin", "err", err)
	http.Error(w, "internal error", http.StatusInternalServerError)
}

func (a *Admin) now() time.Time {
	if a.Now != nil {
		return a.Now()
	}
	return time.Now()
}

func pathID(w http.ResponseWriter, r *http.Request) (int64, bool) {
	id, err := strconv.ParseInt(r.PathValue("id"), 10, 64)
	if err != nil {
		http.NotFound(w, r)
		return 0, false
	}
	return id, true
}

func clientIP(r *http.Request) string {
	host, _, err := net.SplitHostPort(r.RemoteAddr)
	if err != nil {
		return r.RemoteAddr
	}
	return host
}

func randToken() string {
	b := make([]byte, 32)
	_, _ = rand.Read(b)
	return base64.RawURLEncoding.EncodeToString(b)
}

func joinInts(v []int64) string {
	s := make([]string, len(v))
	for i, x := range v {
		s[i] = strconv.FormatInt(x, 10)
	}
	return strings.Join(s, ",")
}

func parseInts(v string) ([]int64, error) {
	var out []int64
	for _, p := range strings.Split(v, ",") {
		p = strings.TrimSpace(p)
		if p == "" {
			continue
		}
		n, err := strconv.ParseInt(p, 10, 64)
		if err != nil {
			return nil, errs.Invalid("invalid number %q", p)
		}
		out = append(out, n)
	}
	return out, nil
}

func safeIndex(f []string, i int) string {
	if i < len(f) {
		return f[i]
	}
	return ""
}

func wrapInvalid(err error) error {
	if err == nil {
		return nil
	}
	return errs.Invalid("%s", err.Error())
}
