package server

import (
	"context"
	"encoding/json"
	"testing"
	"time"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/moderation"
	"wasla/backend/internal/platform/password"
)

// privateChatWithMessages creates a private chat where `from` sent texts to
// `to`. (Messaging lands in Sprint 2; until then fixtures write SQL.)
func (e *env) privateChatWithMessages(from, to int64, texts ...string) int64 {
	e.t.Helper()
	ctx := context.Background()
	chatID := from ^ to ^ 0x5a5a
	lo, hi := min(from, to), max(from, to)
	stmts := []struct {
		sql  string
		args []any
	}{
		{`INSERT INTO chats (id, type, member_count, last_seq) VALUES ($1, 1, 2, $2)`, []any{chatID, len(texts)}},
		{`INSERT INTO private_chat_pairs (user_low, user_high, chat_id) VALUES ($1,$2,$3)`, []any{lo, hi, chatID}},
		{`INSERT INTO chat_members (chat_id, user_id) VALUES ($1,$2), ($1,$3)`, []any{chatID, from, to}},
	}
	for i, txt := range texts {
		stmts = append(stmts, struct {
			sql  string
			args []any
		}{`INSERT INTO messages (chat_id, seq, sender_id, random_id, kind, text) VALUES ($1,$2,$3,$4,1,$5)`,
			[]any{chatID, i + 1, from, i + 100, txt}})
	}
	for _, s := range stmts {
		if _, err := e.db.Exec(ctx, s.sql, s.args...); err != nil {
			e.t.Fatal(err)
		}
	}
	return chatID
}

func (e *env) staff(role int16) moderation.Staff {
	e.t.Helper()
	ns, err := moderation.CreateStaff(context.Background(), e.db, "mod"+string(rune('0'+role))+"@wasla.test", "مشرف", role, password.Fast)
	if err != nil {
		e.t.Fatal(err)
	}
	return moderation.Staff{ID: ns.ID, Name: "مشرف", Role: role}
}

func TestReportTakedownAndBan(t *testing.T) {
	e := newEnv(t)
	ctx := context.Background()
	victim, _, victimID := e.signUp("+9647704444444", "Victim")
	offender, offenderToken, offenderID := e.signUp("+9647805555555", "Offender")
	chatID := e.privateChatWithMessages(offenderID, victimID, "hello", "illegal content", "more illegal content")

	// 1. Victim reports two messages as terrorism and blocks the sender.
	var rep pb.ReportResponse
	victim.mustCall(mReport, &pb.ReportRequest{
		Target: &pb.ReportRequest_Messages{Messages: &pb.ReportedMessages{ChatId: chatID, Seqs: []int64{2, 3}}},
		Reason: pb.ReportReason_REPORT_REASON_TERRORISM, Comment: "تهديد", Block: true,
	}, &rep)

	var prio int16
	var target int64
	var due time.Time
	var evRaw []byte
	if err := e.db.QueryRow(ctx, `SELECT priority, target_user_id, due_at, evidence FROM reports WHERE id = $1`, rep.ReportId).
		Scan(&prio, &target, &due, &evRaw); err != nil {
		t.Fatal(err)
	}
	if prio != moderation.PriorityCritical || target != offenderID {
		t.Fatalf("priority=%d target=%d, want critical and offender", prio, target)
	}
	if time.Until(due) > time.Hour+time.Minute {
		t.Fatalf("critical report must be due within 1h, due %v", due)
	}
	var ev moderation.Evidence
	_ = json.Unmarshal(evRaw, &ev)
	if len(ev.Messages) != 2 || ev.Messages[0].Text != "illegal content" {
		t.Fatalf("evidence snapshot wrong: %+v", ev)
	}
	var blocked pb.ListBlockedResponse
	victim.mustCall(mListBlocked, &pb.ListBlockedRequest{}, &blocked)
	if blocked.Total != 1 || blocked.Users[0].GetId() != offenderID {
		t.Fatalf("report-and-block did not block: %v", &blocked)
	}

	// Repeating the same report does not flood the queue.
	var again pb.ReportResponse
	victim.mustCall(mReport, &pb.ReportRequest{
		Target: &pb.ReportRequest_Messages{Messages: &pb.ReportedMessages{ChatId: chatID, Seqs: []int64{2, 3}}},
		Reason: pb.ReportReason_REPORT_REASON_TERRORISM,
	}, &again)
	if again.ReportId != rep.ReportId {
		t.Fatal("duplicate report created a second queue entry")
	}

	// Outsiders cannot report a chat they are not in.
	outsider, _, _ := e.signUp("+9647506666666", "Outsider")
	err := outsider.call(mReport, &pb.ReportRequest{
		Target: &pb.ReportRequest_Messages{Messages: &pb.ReportedMessages{ChatId: chatID, Seqs: []int64{2}}},
		Reason: pb.ReportReason_REPORT_REASON_SPAM}, &pb.ReportResponse{})
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_NOT_FOUND {
		t.Fatalf("expected NOT_FOUND for outsider, got %v", err)
	}

	// 2. A moderator deletes the messages: both members' devices are told live.
	mod := e.staff(moderation.RoleModerator)
	if err := e.srv.Actions.DeleteMessages(ctx, mod, chatID, []int64{2, 3}, "terrorist content", moderation.Link{ReportID: rep.ReportId}); err != nil {
		t.Fatal(err)
	}
	push := victim.waitPush(t)
	del := push.GetUpdates()[0].GetMessagesDeleted()
	if del == nil || del.GetChatId() != chatID || len(del.GetSeqs()) != 2 {
		t.Fatalf("expected MessagesDeleted push, got %v", push)
	}
	var text string
	var deleted bool
	_ = e.db.QueryRow(ctx, `SELECT text, deleted_at IS NOT NULL FROM messages WHERE chat_id = $1 AND seq = 2`, chatID).Scan(&text, &deleted)
	if !deleted || text != "" {
		t.Fatal("message must be tombstoned with content wiped")
	}
	// Offline devices get it from the log.
	var diff pb.GetDifferenceResponse
	offender.mustCall(mGetDifference, &pb.GetDifferenceRequest{Pts: 0}, &diff)
	if len(diff.Updates) != 1 || diff.Updates[0].GetMessagesDeleted() == nil || diff.Pts != 1 {
		t.Fatalf("GetDifference: %v", &diff)
	}
	var status int16
	_ = e.db.QueryRow(ctx, `SELECT status FROM reports WHERE id = $1`, rep.ReportId).Scan(&status)
	if status != 2 {
		t.Fatalf("report should be actioned, status=%d", status)
	}

	// 3. Moderators cannot ban permanently; senior moderators can.
	if err := e.srv.Actions.BanUser(ctx, mod, offenderID, 0, "terrorism", moderation.Link{}); err == nil {
		t.Fatal("moderator must not be able to ban permanently")
	}
	senior := e.staff(moderation.RoleSeniorModerator)
	if err := e.srv.Actions.BanUser(ctx, senior, offenderID, 0, "terrorism", moderation.Link{}); err != nil {
		t.Fatal(err)
	}
	if code := offender.waitClosed(t); code != 4001 {
		t.Fatalf("banned user's connection should close with 4001, got %d", code)
	}
	if re := e.dial(offenderToken); re.ack.GetAuthenticated() {
		t.Fatal("banned user's token must stop working")
	}
	e.mr.FastForward(2 * time.Minute)
	anon := e.dial("")
	if err := anon.call(mSendCode, &pb.SendCodeRequest{Phone: "+9647805555555", DeviceAttestation: "dev"}, &pb.SendCodeResponse{}); err.GetCode() != pb.ErrorCode_ERROR_CODE_PHONE_BANNED {
		t.Fatalf("banned phone must not get codes, got %v", err)
	}

	// 4. Every action is in the audit log.
	var n int
	_ = e.db.QueryRow(ctx, `SELECT count(*) FROM moderation_actions`).Scan(&n)
	if n != 2 {
		t.Fatalf("expected 2 audited actions, got %d", n)
	}
	if err := e.srv.Actions.DeleteMessages(ctx, mod, chatID, []int64{1}, "", moderation.Link{}); err == nil {
		t.Fatal("actions without a reason must be refused")
	}
}

func TestChatTakedown(t *testing.T) {
	e := newEnv(t)
	ctx := context.Background()
	a, _, aID := e.signUp("+9647707777777", "A")
	_, _, bID := e.signUp("+9647808888888", "B")
	chatID := e.privateChatWithMessages(aID, bID, "x")
	senior := e.staff(moderation.RoleSeniorModerator)
	if err := e.srv.Actions.BanChat(ctx, senior, chatID, "illegal group", moderation.Link{}); err != nil {
		t.Fatal(err)
	}
	left := a.waitPush(t).GetUpdates()[0].GetChatLeft()
	if left == nil || !left.GetKicked() || left.GetChatId() != chatID {
		t.Fatalf("expected ChatLeft{kicked}, got %v", left)
	}
	if err := e.srv.Actions.BanChat(ctx, senior, chatID, "again", moderation.Link{}); err == nil {
		t.Fatal("double takedown should report not found")
	}
}

func TestLegalTargetParsing(t *testing.T) {
	got, err := moderation.ParseLegalTargets("user 12\n\nchat 34\nmessage 34 5, 6,7\n")
	if err != nil {
		t.Fatal(err)
	}
	if len(got) != 3 || got[0].UserID != 12 || got[1].ChatID != 34 || len(got[2].Seqs) != 3 {
		t.Fatalf("parsed %+v", got)
	}
	if _, err := moderation.ParseLegalTargets("delete everything"); err == nil {
		t.Fatal("expected parse error")
	}
}
