package server

import (
	"context"
	"encoding/base32"
	"io"
	"net/http"
	"net/http/cookiejar"
	"net/http/httptest"
	"net/url"
	"regexp"
	"strconv"
	"strings"
	"testing"
	"time"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/moderation"
	"wasla/backend/internal/platform/password"
	"wasla/backend/internal/platform/totp"
)

type adminClient struct {
	t    *testing.T
	base string
	http *http.Client
}

func (a *adminClient) get(path string) (int, string) {
	a.t.Helper()
	resp, err := a.http.Get(a.base + path)
	if err != nil {
		a.t.Fatal(err)
	}
	defer resp.Body.Close()
	b, _ := io.ReadAll(resp.Body)
	return resp.StatusCode, string(b)
}

func (a *adminClient) post(path string, form url.Values) (int, string) {
	a.t.Helper()
	resp, err := a.http.PostForm(a.base+path, form)
	if err != nil {
		a.t.Fatal(err)
	}
	defer resp.Body.Close()
	b, _ := io.ReadAll(resp.Body)
	return resp.StatusCode, string(b)
}

var csrfRe = regexp.MustCompile(`name="csrf" value="([^"]+)"`)

func TestAdminPanelFlow(t *testing.T) {
	e := newEnv(t)
	ctx := context.Background()
	victim, _, victimID := e.signUp("+9647709999999", "Victim")
	_, _, offenderID := e.signUp("+9647801010101", "Spammer")
	chatID := e.privateChatWithMessages(offenderID, victimID, "buy now!!!")
	var rep pb.ReportResponse
	victim.mustCall(mReport, &pb.ReportRequest{
		Target: &pb.ReportRequest_Messages{Messages: &pb.ReportedMessages{ChatId: chatID, Seqs: []int64{1}}},
		Reason: pb.ReportReason_REPORT_REASON_SPAM}, &rep)

	h, err := e.srv.AdminHandler()
	if err != nil {
		t.Fatal(err)
	}
	hs := httptest.NewServer(h)
	defer hs.Close()
	jar, _ := cookiejar.New(nil)
	a := &adminClient{t: t, base: hs.URL, http: &http.Client{Jar: jar}}

	ns, err := moderation.CreateStaff(ctx, e.db, "Mod@Wasla.test", "مشرفة", moderation.RoleModerator, password.Fast)
	if err != nil {
		t.Fatal(err)
	}
	secret, _ := base32.StdEncoding.WithPadding(base32.NoPadding).DecodeString(ns.TOTPSecret)

	// Not logged in → redirected to login.
	if code, body := a.get("/admin/"); code != 200 || !strings.Contains(body, "دخول المشرفين") {
		t.Fatalf("expected login page, got %d", code)
	}
	// Wrong TOTP fails.
	_, body := a.post("/admin/login", url.Values{"email": {"mod@wasla.test"}, "password": {ns.Password}, "totp": {"000000"}})
	if !strings.Contains(body, "غير صحيحة") {
		t.Fatal("login with wrong TOTP should fail")
	}
	code := totp.Code(secret, time.Now())
	if code == "000000" {
		code = totp.Code(secret, time.Now().Add(30*time.Second))
	}
	_, body = a.post("/admin/login", url.Values{"email": {"mod@wasla.test"}, "password": {ns.Password}, "totp": {code}})
	if !strings.Contains(body, "طابور المراجعة") || !strings.Contains(body, "رسائل مزعجة") {
		t.Fatalf("queue should list the spam report after login")
	}
	csrf := csrfRe.FindStringSubmatch(body)[1]

	// The same TOTP code cannot be replayed.
	jar2, _ := cookiejar.New(nil)
	other := &adminClient{t: t, base: hs.URL, http: &http.Client{Jar: jar2}}
	_, b2 := other.post("/admin/login", url.Values{"email": {"mod@wasla.test"}, "password": {ns.Password}, "totp": {code}})
	if !strings.Contains(b2, "غير صحيحة") {
		t.Fatal("TOTP replay must be rejected")
	}

	// Report page shows the evidence.
	path := "/admin/reports/" + itoa(rep.ReportId)
	if _, body := a.get(path); !strings.Contains(body, "buy now!!!") {
		t.Fatal("report page should show the evidence")
	}
	// Missing CSRF token → 403.
	if code, _ := a.post(path+"/action", url.Values{"action": {"dismiss"}, "reason": {"ok"}}); code != http.StatusForbidden {
		t.Fatalf("expected 403 without CSRF, got %d", code)
	}
	// A moderator cannot ban permanently.
	code2, body := a.post(path+"/action", url.Values{"csrf": {csrf}, "action": {"ban_user"}, "duration": {"perm"}, "reason": {"spam"}})
	if code2 != http.StatusBadRequest || !strings.Contains(body, "senior") {
		t.Fatalf("expected refusal for permanent ban by moderator, got %d", code2)
	}
	// Delete + 7-day ban works.
	if _, body := a.post(path+"/action", url.Values{"csrf": {csrf}, "action": {"delete_and_ban"}, "duration": {"7d"}, "reason": {"spam campaign"}}); !strings.Contains(body, "لا توجد بلاغات مفتوحة") {
		t.Fatal("queue should be empty after the action")
	}
	if _, body := a.get("/admin/audit"); !strings.Contains(body, "حظر مستخدم") || !strings.Contains(body, "حذف محتوى") {
		t.Fatal("audit log should list both actions")
	}
	// Legal requests are admin-only.
	if code, _ := a.get("/admin/legal"); code != http.StatusForbidden {
		t.Fatalf("legal page must be admin-only, got %d", code)
	}
}

func itoa(v int64) string { return strconv.FormatInt(v, 10) }
