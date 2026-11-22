package push

import (
	"context"
	"errors"
	"fmt"
	"log/slog"
	"sync"
	"time"

	"github.com/jackc/pgx/v5/pgxpool"

	pb "wasla/backend/gen/proto/wasla/v1"
)

// Notifier turns new messages for offline users into pushes. It is fed by
// updates.Service when an update reached no connected device, works in the
// background, and never blocks or fails a send.
type Notifier struct {
	DB     *pgxpool.Pool
	Sender Sender
	Log    *slog.Logger

	once   sync.Once
	mu     sync.RWMutex // guards closed vs. sends on queue
	closed bool
	queue  chan job
	wg     sync.WaitGroup
}

type job struct {
	user int64
	chat int64
}

const (
	queueSize = 10000
	workers   = 8
)

func (n *Notifier) start() {
	n.queue = make(chan job, queueSize)
	for i := 0; i < workers; i++ {
		n.wg.Add(1)
		go func() {
			defer n.wg.Done()
			for j := range n.queue {
				ctx, cancel := context.WithTimeout(context.Background(), 20*time.Second)
				if err := n.deliver(ctx, j); err != nil {
					n.Log.Warn("push failed", "user", j.user, "err", err)
				}
				cancel()
			}
		}()
	}
}

// Offline is called with the updates a user missed because no device was
// connected. Only new messages from someone else cause a push.
func (n *Notifier) Offline(userID int64, ups []*pb.Update) {
	if n == nil || n.Sender == nil {
		return
	}
	n.once.Do(n.start)
	n.mu.RLock()
	defer n.mu.RUnlock()
	if n.closed {
		return
	}
	seen := map[int64]bool{}
	for _, u := range ups {
		m := u.GetNewMessage().GetMessage()
		if m == nil || m.GetSenderId() == userID || seen[m.GetChatId()] {
			continue
		}
		seen[m.GetChatId()] = true
		select {
		case n.queue <- job{user: userID, chat: m.GetChatId()}:
		default:
			n.Log.Warn("push queue full; dropping", "user", userID)
		}
	}
}

// Close waits for queued pushes (tests and shutdown).
func (n *Notifier) Close() {
	if n == nil {
		return
	}
	n.once.Do(n.start)
	n.mu.Lock()
	if n.closed {
		n.mu.Unlock()
		return
	}
	n.closed = true
	close(n.queue)
	n.mu.Unlock()
	n.wg.Wait()
}

func (n *Notifier) deliver(ctx context.Context, j job) error {
	var muted bool
	err := n.DB.QueryRow(ctx, `SELECT COALESCE(muted_until > now(), false) FROM chat_members
		WHERE chat_id = $1 AND user_id = $2`, j.chat, j.user).Scan(&muted)
	if err != nil {
		return fmt.Errorf("mute check: %w", err)
	}
	if muted {
		return nil
	}
	rows, err := n.DB.Query(ctx, `SELECT id, push_token FROM sessions
		WHERE user_id = $1 AND revoked_at IS NULL AND push_provider = $2 AND push_token IS NOT NULL`,
		j.user, int16(pb.PushProvider_PUSH_PROVIDER_FCM))
	if err != nil {
		return err
	}
	type dev struct {
		session int64
		token   string
	}
	var devs []dev
	for rows.Next() {
		var d dev
		if err := rows.Scan(&d.session, &d.token); err != nil {
			rows.Close()
			return err
		}
		devs = append(devs, d)
	}
	rows.Close()
	var errs []error
	for _, d := range devs {
		err := n.Sender.Send(ctx, d.token, Message{ChatID: j.chat, Collapse: fmt.Sprintf("chat_%d", j.chat)})
		if errors.Is(err, ErrUnregistered) {
			_, err = n.DB.Exec(ctx, `UPDATE sessions SET push_provider = NULL, push_token = NULL
				WHERE id = $1 AND push_token = $2`, d.session, d.token)
		}
		if err != nil {
			errs = append(errs, err)
		}
	}
	return errors.Join(errs...)
}

// LogSender only logs (dev servers without a Firebase key).
type LogSender struct{ Log *slog.Logger }

func (l LogSender) Send(_ context.Context, token string, m Message) error {
	l.Log.Info("push (dev, not sent)", "chat", m.ChatID, "token_suffix", suffix(token))
	return nil
}

func suffix(s string) string {
	if len(s) <= 6 {
		return s
	}
	return s[len(s)-6:]
}
