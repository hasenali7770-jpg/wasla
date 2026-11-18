package gateway

import (
	"context"
	"log/slog"
	"strconv"
	"strings"
	"sync"

	"github.com/redis/go-redis/v9"
	"google.golang.org/protobuf/proto"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/auth"
	"wasla/backend/internal/updates"
)

// Hub tracks this instance's live connections and routes Redis pub/sub
// messages to them: per-user update pushes and session revocations.
type Hub struct {
	ps  *redis.PubSub
	log *slog.Logger

	mu        sync.Mutex
	byUser    map[int64]map[*conn]struct{}
	bySession map[int64]map[*conn]struct{}
}

// NewHub subscribes to the revocation channel and starts routing.
func NewHub(ctx context.Context, r *redis.Client, log *slog.Logger) (*Hub, error) {
	ps := r.Subscribe(ctx, auth.RevokedChannel)
	if _, err := ps.Receive(ctx); err != nil { // wait for the subscription to be live
		return nil, err
	}
	h := &Hub{ps: ps, log: log, byUser: map[int64]map[*conn]struct{}{}, bySession: map[int64]map[*conn]struct{}{}}
	go h.loop()
	return h, nil
}

// Close stops the hub.
func (h *Hub) Close() error { return h.ps.Close() }

func (h *Hub) add(c *conn, userID, sessionID int64) {
	h.mu.Lock()
	first := len(h.byUser[userID]) == 0
	if h.byUser[userID] == nil {
		h.byUser[userID] = map[*conn]struct{}{}
	}
	h.byUser[userID][c] = struct{}{}
	if h.bySession[sessionID] == nil {
		h.bySession[sessionID] = map[*conn]struct{}{}
	}
	h.bySession[sessionID][c] = struct{}{}
	h.mu.Unlock()
	if first {
		if err := h.ps.Subscribe(context.Background(), updates.UserChannel(userID)); err != nil {
			h.log.Error("hub subscribe", "user_id", userID, "err", err)
		}
	}
}

func (h *Hub) remove(c *conn) {
	c.mu.Lock()
	uid, sid := c.userID, c.sessionID
	c.mu.Unlock()
	if uid == 0 {
		return
	}
	h.mu.Lock()
	delete(h.byUser[uid], c)
	last := len(h.byUser[uid]) == 0
	if last {
		delete(h.byUser, uid)
	}
	delete(h.bySession[sid], c)
	if len(h.bySession[sid]) == 0 {
		delete(h.bySession, sid)
	}
	h.mu.Unlock()
	if last {
		_ = h.ps.Unsubscribe(context.Background(), updates.UserChannel(uid))
	}
}

// Online reports whether the user has a live connection on this instance.
func (h *Hub) Online(userID int64) bool {
	h.mu.Lock()
	defer h.mu.Unlock()
	return len(h.byUser[userID]) > 0
}

func (h *Hub) loop() {
	for msg := range h.ps.Channel() {
		if msg.Channel == auth.RevokedChannel {
			sid, err := strconv.ParseInt(msg.Payload, 10, 64)
			if err != nil {
				continue
			}
			for _, c := range h.conns(h.bySession, sid) {
				c.close(CloseSessionRevoked, "session revoked")
			}
			continue
		}
		uid, err := strconv.ParseInt(strings.TrimPrefix(msg.Channel, "u:"), 10, 64)
		if err != nil {
			continue
		}
		var push pb.UpdatesPush
		if proto.Unmarshal([]byte(msg.Payload), &push) != nil {
			continue
		}
		frame, err := proto.Marshal(&pb.Frame{Kind: &pb.Frame_Updates{Updates: &push}})
		if err != nil {
			continue
		}
		for _, c := range h.conns(h.byUser, uid) {
			c.send(frame)
		}
	}
}

func (h *Hub) conns(m map[int64]map[*conn]struct{}, key int64) []*conn {
	h.mu.Lock()
	defer h.mu.Unlock()
	out := make([]*conn, 0, len(m[key]))
	for c := range m[key] {
		out = append(out, c)
	}
	return out
}
