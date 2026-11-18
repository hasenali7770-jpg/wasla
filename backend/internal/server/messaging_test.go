package server

import (
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"time"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/moderation"
)

const (
	mSend         = "/wasla.v1.MessagesService/SendMessage"
	mEdit         = "/wasla.v1.MessagesService/EditMessage"
	mDelete       = "/wasla.v1.MessagesService/DeleteMessages"
	mForward      = "/wasla.v1.MessagesService/ForwardMessages"
	mHistory      = "/wasla.v1.MessagesService/GetHistory"
	mRead         = "/wasla.v1.MessagesService/ReadHistory"
	mTyping       = "/wasla.v1.MessagesService/SetTyping"
	mPin          = "/wasla.v1.MessagesService/PinMessage"
	mDialogs      = "/wasla.v1.ChatsService/ListDialogs"
	mUpdateDialog = "/wasla.v1.ChatsService/UpdateDialog"
	mSetUsername  = "/wasla.v1.UsersService/SetUsername"
	mResolve      = "/wasla.v1.UsersService/ResolveUsername"
	mSearch       = "/wasla.v1.UsersService/SearchUsers"
	mGetUsers     = "/wasla.v1.UsersService/GetUsers"
	mImport       = "/wasla.v1.ContactsService/ImportContacts"
	mListContacts = "/wasla.v1.ContactsService/ListContacts"
)

func text(s string) *pb.InputContent {
	return &pb.InputContent{Kind: &pb.InputContent_Text{Text: &pb.FormattedText{Text: s}}}
}

func toUser(id int64) *pb.Peer { return &pb.Peer{Kind: &pb.Peer_UserId{UserId: id}} }

// nextPush waits for the next push carrying a persistent (pts > 0) or the
// requested ephemeral update, skipping unrelated ones.
func (c *client) nextUpdate(t *testing.T, match func(*pb.Update) bool) *pb.Update {
	t.Helper()
	deadline := time.After(3 * time.Second)
	for {
		select {
		case p := <-c.pushes:
			for _, u := range p.GetUpdates() {
				if match(u) {
					return u
				}
			}
		case <-deadline:
			t.Fatal("expected update not received")
			return nil
		}
	}
}

func TestPrivateChatMessaging(t *testing.T) {
	e := newEnv(t)
	ali, _, aliID := e.signUp("+9647701000001", "علي")
	sara, _, saraID := e.signUp("+9647801000002", "سارة")

	// Sara finds Ali by username and writes first.
	ali.mustCall(mSetUsername, &pb.SetUsernameRequest{Username: "ali_baghdad"}, &pb.SetUsernameResponse{})
	var found pb.ResolveUsernameResponse
	sara.mustCall(mResolve, &pb.ResolveUsernameRequest{Username: "@Ali_Baghdad"}, &found)
	if found.GetUser().GetId() != aliID || found.GetUser().GetPhone() != "" {
		t.Fatalf("resolve: %v (phone must stay hidden)", found.GetUser())
	}
	var sent pb.SendMessageResponse
	sara.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(aliID), RandomId: 111, Content: &pb.InputContent{
		Kind: &pb.InputContent_Text{Text: &pb.FormattedText{Text: "مرحبا علي", Entities: []*pb.TextEntity{
			{Type: pb.TextEntityType_TEXT_ENTITY_TYPE_BOLD, Offset: 0, Length: 5}}}}}}, &sent)
	msg := sent.GetMessage()
	chatID := msg.GetChatId()
	if msg.GetSeq() != 1 || msg.GetRandomId() != 111 || sent.GetPts() == 0 || sent.GetPtsCount() != 1 {
		t.Fatalf("send response: %v", &sent)
	}
	got := ali.nextUpdate(t, func(u *pb.Update) bool { return u.GetNewMessage() != nil }).GetNewMessage().GetMessage()
	if got.GetContent().GetText().GetText().GetText() != "مرحبا علي" || got.GetRandomId() != 0 ||
		len(got.GetContent().GetText().GetText().GetEntities()) != 1 {
		t.Fatalf("Ali got %v (random_id must be hidden from recipients)", got)
	}

	// Retrying the same random_id does not duplicate.
	var retry pb.SendMessageResponse
	sara.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(aliID), RandomId: 111, Content: text("مرحبا علي")}, &retry)
	if retry.GetMessage().GetSeq() != 1 || retry.GetPtsCount() != 0 {
		t.Fatalf("retry created a new message: %v", &retry)
	}

	// Ali's chat list: one unread message from Sara.
	var dl pb.ListDialogsResponse
	ali.mustCall(mDialogs, &pb.ListDialogsRequest{}, &dl)
	if len(dl.Dialogs) != 1 || dl.Dialogs[0].GetUnreadCount() != 1 || dl.Chats[0].GetPeerUserId() != saraID {
		t.Fatalf("dialogs: %v", &dl)
	}

	// Typing indicator (ephemeral, pts 0).
	sara.mustCall(mTyping, &pb.SetTypingRequest{ChatId: chatID, Action: pb.TypingAction_TYPING_ACTION_TYPING}, &pb.SetTypingResponse{})
	if ty := ali.nextUpdate(t, func(u *pb.Update) bool { return u.GetTyping() != nil }); ty.GetPts() != 0 || ty.GetTyping().GetUserId() != saraID {
		t.Fatalf("typing: %v", ty)
	}

	// Ali reads → Sara gets ✓✓.
	ali.mustCall(mRead, &pb.ReadHistoryRequest{ChatId: chatID, MaxSeq: 1}, &pb.ReadHistoryResponse{})
	if ro := sara.nextUpdate(t, func(u *pb.Update) bool { return u.GetReadOutbox() != nil }); ro.GetReadOutbox().GetMaxSeq() != 1 {
		t.Fatalf("read outbox: %v", ro)
	}

	// Sara edits; Ali replies; Sara deletes her first message for everyone.
	sara.mustCall(mEdit, &pb.EditMessageRequest{ChatId: chatID, Seq: 1, Text: &pb.FormattedText{Text: "مرحبا يا علي"}}, &pb.EditMessageResponse{})
	if ed := ali.nextUpdate(t, func(u *pb.Update) bool { return u.GetMessageEdited() != nil }); ed.GetMessageEdited().GetMessage().GetEditDate() == 0 {
		t.Fatal("edit date missing")
	}
	if err := ali.call(mEdit, &pb.EditMessageRequest{ChatId: chatID, Seq: 1, Text: &pb.FormattedText{Text: "x"}}, &pb.EditMessageResponse{}); err.GetCode() != pb.ErrorCode_ERROR_CODE_PERMISSION_DENIED {
		t.Fatalf("editing someone else's message: %v", err)
	}
	var reply pb.SendMessageResponse
	ali.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 222, Content: text("أهلاً"), ReplyToSeq: 1}, &reply)
	if reply.GetMessage().GetReplyToSeq() != 1 || reply.GetMessage().GetChatId() != chatID {
		t.Fatalf("reply: %v", reply.GetMessage())
	}
	sara.mustCall(mDelete, &pb.DeleteMessagesRequest{ChatId: chatID, Seqs: []int64{1}, ForEveryone: true}, &pb.DeleteMessagesResponse{})
	ali.nextUpdate(t, func(u *pb.Update) bool { return u.GetMessagesDeleted() != nil })

	// Ali deletes his reply only for himself.
	ali.mustCall(mDelete, &pb.DeleteMessagesRequest{ChatId: chatID, Seqs: []int64{2}}, &pb.DeleteMessagesResponse{})
	var hA, hS pb.GetHistoryResponse
	ali.mustCall(mHistory, &pb.GetHistoryRequest{ChatId: chatID}, &hA)
	sara.mustCall(mHistory, &pb.GetHistoryRequest{ChatId: chatID}, &hS)
	if len(hA.Messages) != 0 || len(hS.Messages) != 1 || hS.Messages[0].GetSeq() != 2 {
		t.Fatalf("history after deletes: ali=%d sara=%v", len(hA.Messages), hS.Messages)
	}

	// Sara forwards Ali's reply to her Saved Messages, credited to Ali; pins it.
	var fw pb.ForwardMessagesResponse
	sara.mustCall(mForward, &pb.ForwardMessagesRequest{FromChatId: chatID, Seqs: []int64{2}, ToPeer: toUser(saraID), RandomIds: []int64{333}}, &fw)
	saved := fw.Messages[0]
	if saved.GetForward().GetFromUserId() != aliID || saved.GetChatId() == chatID {
		t.Fatalf("forward: %v", saved)
	}
	sara.mustCall(mPin, &pb.PinMessageRequest{ChatId: saved.GetChatId(), Seq: saved.GetSeq()}, &pb.PinMessageResponse{})
	var hSaved pb.GetHistoryResponse
	sara.mustCall(mHistory, &pb.GetHistoryRequest{ChatId: saved.GetChatId()}, &hSaved)
	if !hSaved.Messages[0].GetPinned() {
		t.Fatal("message should be pinned")
	}

	// Pin and mute Sara's chat list entry for Ali.
	pin, mute := true, time.Now().Add(time.Hour).Unix()
	var ud pb.UpdateDialogResponse
	ali.mustCall(mUpdateDialog, &pb.UpdateDialogRequest{ChatId: chatID, Pinned: &pin, MutedUntil: &mute}, &ud)
	if ud.GetDialog().GetPinnedRank() == 0 || ud.GetDialog().GetMutedUntil() == 0 {
		t.Fatalf("update dialog: %v", ud.GetDialog())
	}

	// A fresh device of Sara's catches up through GetDifference with gap-free pts.
	var diff pb.GetDifferenceResponse
	sara.mustCall(mGetDifference, &pb.GetDifferenceRequest{Pts: 0}, &diff)
	for i, u := range diff.Updates {
		if u.GetPts() != int64(i+1) {
			t.Fatalf("pts gap at %d: %d", i, u.GetPts())
		}
	}
	if len(diff.Updates) < 6 {
		t.Fatalf("expected Sara's log to hold her updates, got %d", len(diff.Updates))
	}
}

func TestBlockingAndTakedownEnforcement(t *testing.T) {
	e := newEnv(t)
	ali, _, aliID := e.signUp("+9647701000003", "Ali")
	sara, _, saraID := e.signUp("+9647801000004", "Sara")
	var sent pb.SendMessageResponse
	sara.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(aliID), RandomId: 1, Content: text("hi")}, &sent)
	chatID := sent.GetMessage().GetChatId()

	ali.mustCall(mBlock, &pb.BlockUserRequest{UserId: saraID}, &pb.BlockUserResponse{})
	for who, c := range map[string]*client{"blocked": sara, "blocker": ali} {
		err := c.call(mSend, &pb.SendMessageRequest{Peer: &pb.Peer{Kind: &pb.Peer_ChatId{ChatId: chatID}}, RandomId: 2, Content: text("x")}, &pb.SendMessageResponse{})
		if err.GetCode() != pb.ErrorCode_ERROR_CODE_PEER_BLOCKED {
			t.Fatalf("%s sending: expected PEER_BLOCKED, got %v", who, err)
		}
	}

	// A moderator takes the chat down: it vanishes for both.
	senior := e.staff(moderation.RoleSeniorModerator)
	if err := e.srv.Actions.BanChat(context.Background(), senior, chatID, "illegal content", moderation.Link{}); err != nil {
		t.Fatal(err)
	}
	if err := sara.call(mHistory, &pb.GetHistoryRequest{ChatId: chatID}, &pb.GetHistoryResponse{}); err.GetCode() != pb.ErrorCode_ERROR_CODE_NOT_FOUND {
		t.Fatalf("history of a banned chat: %v", err)
	}
	var dl pb.ListDialogsResponse
	sara.mustCall(mDialogs, &pb.ListDialogsRequest{}, &dl)
	if len(dl.Dialogs) != 0 {
		t.Fatalf("banned chat still listed: %v", &dl)
	}

	// Unsupported content is refused clearly.
	err := sara.call(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 3, Content: &pb.InputContent{
		Kind: &pb.InputContent_Media{Media: &pb.InputMedia{MediaId: 1}}}}, &pb.SendMessageResponse{})
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_UNIMPLEMENTED {
		t.Fatalf("media before media service: %v", err)
	}
	if err := sara.call(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 4, Content: text(strings.Repeat("ا", 4097))}, &pb.SendMessageResponse{}); err.GetCode() != pb.ErrorCode_ERROR_CODE_MESSAGE_TOO_LONG {
		t.Fatalf("long message: %v", err)
	}
}

func TestContactsAndSearch(t *testing.T) {
	e := newEnv(t)
	ali, _, aliID := e.signUp("+9647701000005", "Ali")
	sara, _, _ := e.signUp("+9647801000006", "Sara")
	ali.mustCall(mSetUsername, &pb.SetUsernameRequest{Username: "ali_karrada"}, &pb.SetUsernameResponse{})

	var imp pb.ImportContactsResponse
	sara.mustCall(mImport, &pb.ImportContactsRequest{Contacts: []*pb.InputContact{
		{ClientId: 1, Phone: "+9647701000005", FirstName: "علي", LastName: "الصديق"},
		{ClientId: 2, Phone: "+9647709999999", FirstName: "Not on Wasla"},
		{ClientId: 3, Phone: "bad"},
	}}, &imp)
	if len(imp.Imported) != 1 || imp.Imported[0].GetUserId() != aliID || imp.Users[0].GetPhone() != "+9647701000005" {
		t.Fatalf("import: %v", &imp)
	}
	var lc pb.ListContactsResponse
	sara.mustCall(mListContacts, &pb.ListContactsRequest{}, &lc)
	var again pb.ListContactsResponse
	sara.mustCall(mListContacts, &pb.ListContactsRequest{Hash: lc.Hash}, &again)
	if len(lc.Users) != 1 || !again.NotModified {
		t.Fatalf("list contacts: %v / %v", &lc, &again)
	}
	// Ali has not saved Sara: he does not see her number.
	var gu pb.GetUsersResponse
	ali.mustCall(mGetUsers, &pb.GetUsersRequest{UserIds: []int64{imp.Imported[0].GetUserId()}}, &gu)
	var gs pb.GetUsersResponse
	sara.mustCall(mGetUsers, &pb.GetUsersRequest{UserIds: []int64{aliID}}, &gs)
	if !gs.Users[0].GetIsContact() || gs.Users[0].GetPhone() == "" {
		t.Fatalf("Sara saved Ali, so she should see his number: %v", gs.Users[0])
	}

	var sr pb.SearchUsersResponse
	sara.mustCall(mSearch, &pb.SearchUsersRequest{Query: "الصديق"}, &sr)
	if len(sr.Contacts) != 1 {
		t.Fatalf("contact search by saved name: %v", &sr)
	}
	var short pb.SearchUsersResponse
	ali.mustCall(mSearch, &pb.SearchUsersRequest{Query: "ali"}, &short)
	if len(short.Global) != 0 {
		t.Fatal("global username search needs at least 4 characters")
	}
	var g pb.SearchUsersResponse
	sara.mustCall(mSearch, &pb.SearchUsersRequest{Query: "ali_k"}, &g)
	if len(g.Contacts)+len(g.Global) != 1 {
		t.Fatalf("username search: %v", &g)
	}
	for _, bad := range []string{"admin_ali", "abc", "9lives", "wasla_support"} {
		if err := sara.call(mSetUsername, &pb.SetUsernameRequest{Username: bad}, &pb.SetUsernameResponse{}); err.GetCode() != pb.ErrorCode_ERROR_CODE_USERNAME_INVALID {
			t.Fatalf("username %q should be invalid, got %v", bad, err)
		}
	}
	if err := sara.call(mSetUsername, &pb.SetUsernameRequest{Username: "ALI_KARRADA"}, &pb.SetUsernameResponse{}); err.GetCode() != pb.ErrorCode_ERROR_CODE_USERNAME_TAKEN {
		t.Fatalf("taken username: %v", err)
	}
}

func TestCriticalReportAlertsModerator(t *testing.T) {
	got := make(chan string, 1)
	hook := httptest.NewServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		var body map[string]string
		_ = json.NewDecoder(r.Body).Decode(&body)
		got <- body["text"]
	}))
	defer hook.Close()
	e := newEnv(t, func(d *Deps) { d.AlertWebhookURL = hook.URL })
	victim, _, _ := e.signUp("+9647701000007", "Victim")
	_, _, badID := e.signUp("+9647801000008", "Bad")

	var rep pb.ReportResponse
	victim.mustCall(mReport, &pb.ReportRequest{Target: &pb.ReportRequest_UserId{UserId: badID},
		Reason: pb.ReportReason_REPORT_REASON_CHILD_ABUSE}, &rep)
	select {
	case txt := <-got:
		if !strings.Contains(txt, "critical report") || !strings.Contains(txt, "CHILD_ABUSE") {
			t.Fatalf("alert text: %q", txt)
		}
	case <-time.After(3 * time.Second):
		t.Fatal("no alert sent for a critical report")
	}
	// Normal reports do not page anyone.
	victim.mustCall(mReport, &pb.ReportRequest{Target: &pb.ReportRequest_UserId{UserId: badID},
		Reason: pb.ReportReason_REPORT_REASON_SPAM}, &rep)
	select {
	case txt := <-got:
		t.Fatalf("unexpected alert for a spam report: %q", txt)
	case <-time.After(300 * time.Millisecond):
	}
}
