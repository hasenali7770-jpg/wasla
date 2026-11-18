package server

import (
	"context"
	"sync"
	"testing"
	"time"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/push"
	"wasla/backend/internal/updates"
)

const mRegisterPush = "/wasla.v1.AuthService/RegisterPushToken"

// recordingSender remembers pushes; tokens in dead are reported unregistered.
type recordingSender struct {
	mu   sync.Mutex
	got  []string // "token:chat"
	dead map[string]bool
	ch   chan struct{}
}

func (r *recordingSender) Send(_ context.Context, token string, m push.Message) error {
	r.mu.Lock()
	defer r.mu.Unlock()
	defer func() { r.ch <- struct{}{} }()
	if r.dead[token] {
		return push.ErrUnregistered
	}
	r.got = append(r.got, token+":"+itoa(m.ChatID))
	return nil
}

func (r *recordingSender) wait(t *testing.T) {
	t.Helper()
	select {
	case <-r.ch:
	case <-time.After(5 * time.Second):
		t.Fatal("no push attempt")
	}
}

func (r *recordingSender) none(t *testing.T) {
	t.Helper()
	select {
	case <-r.ch:
		t.Fatalf("unexpected push: %v", r.got)
	case <-time.After(300 * time.Millisecond):
	}
}

// goOffline closes a client and waits until no gateway listens for the user.
func goOffline(t *testing.T, e *env, c *client, userID int64) {
	t.Helper()
	_ = c.ws.CloseNow()
	for i := 0; i < 100; i++ {
		n, _ := e.redis.PubSubNumSub(context.Background(), updates.UserChannel(userID)).Result()
		if n[updates.UserChannel(userID)] == 0 {
			return
		}
		time.Sleep(20 * time.Millisecond)
	}
	t.Fatal("user still subscribed")
}

func TestPushOnlyWhenOfflineAndNotMuted(t *testing.T) {
	rec := &recordingSender{dead: map[string]bool{}, ch: make(chan struct{}, 16)}
	e := newEnv(t, func(d *Deps) { d.Push = rec })
	ali, _, aliID := e.signUp("+9647701111111", "علي")
	sara, saraToken, saraID := e.signUp("+9647702222222", "سارة")
	sara.mustCall(mRegisterPush, &pb.RegisterPushTokenRequest{Provider: pb.PushProvider_PUSH_PROVIDER_FCM, Token: "sara-phone"},
		&pb.RegisterPushTokenResponse{})

	// Sara is connected: the message arrives live, no push.
	var r pb.SendMessageResponse
	ali.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 1, Content: text("أهلاً")}, &r)
	chatID := r.GetMessage().GetChatId()
	rec.none(t)

	// Sara's app is closed: one push to her phone, carrying only the chat.
	goOffline(t, e, sara, saraID)
	ali.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 2, Content: text("وينك؟")}, &r)
	rec.wait(t)
	if len(rec.got) != 1 || rec.got[0] != "sara-phone:"+itoa(chatID) {
		t.Fatalf("pushes: %v", rec.got)
	}
	// Ali (the sender, online) gets nothing for his own message.
	_ = aliID

	// Muted chat: no push.
	sara2 := e.dial(saraToken)
	mute := time.Now().Add(time.Hour).Unix()
	sara2.mustCall(mUpdateDialog, &pb.UpdateDialogRequest{ChatId: chatID, MutedUntil: &mute}, &pb.UpdateDialogResponse{})
	goOffline(t, e, sara2, saraID)
	ali.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 3, Content: text("؟")}, &r)
	rec.none(t)

	// Unmuted, but the app was uninstalled: the dead token is forgotten.
	_, err := e.db.Exec(context.Background(), `UPDATE chat_members SET muted_until = NULL WHERE user_id = $1`, saraID)
	if err != nil {
		t.Fatal(err)
	}
	rec.mu.Lock()
	rec.dead["sara-phone"] = true
	rec.mu.Unlock()
	ali.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 4, Content: text("مرحبا")}, &r)
	rec.wait(t)
	var left int
	for i := 0; i < 50; i++ {
		_ = e.db.QueryRow(context.Background(), `SELECT count(*) FROM sessions WHERE user_id = $1 AND push_token IS NOT NULL`, saraID).Scan(&left)
		if left == 0 {
			break
		}
		time.Sleep(20 * time.Millisecond)
	}
	if left != 0 {
		t.Fatal("unregistered token was not cleared")
	}
}
