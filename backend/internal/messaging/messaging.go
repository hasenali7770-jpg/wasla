package messaging

import (
	"context"
	"log/slog"
	"strconv"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/chats"
	"wasla/backend/internal/msgstore"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/phone"
	"wasla/backend/internal/platform/ratelimit"
	"wasla/backend/internal/platform/rpc"
	"wasla/backend/internal/updates"
	"wasla/backend/internal/users"
)

// Service implements wasla.v1.MessagesService (text, location and contact
// messages; media arrives with the media service).
type Service struct {
	DB      *pgxpool.Pool
	IDs     chats.IDGen
	Updates *updates.Service
	Limits  *ratelimit.Limiter
	Log     *slog.Logger
	Now     func() time.Time
}

func (s *Service) Register(r *rpc.Router) {
	const p = "/wasla.v1.MessagesService/"
	rpc.Register(r, p+"SendMessage", rpc.Private, s.SendMessage)
	rpc.Register(r, p+"EditMessage", rpc.Private, s.EditMessage)
	rpc.Register(r, p+"DeleteMessages", rpc.Private, s.DeleteMessages)
	rpc.Register(r, p+"ForwardMessages", rpc.Private, s.ForwardMessages)
	rpc.Register(r, p+"GetHistory", rpc.Private, s.GetHistory)
	rpc.Register(r, p+"GetMessages", rpc.Private, s.GetMessages)
	rpc.Register(r, p+"ReadHistory", rpc.Private, s.ReadHistory)
	rpc.Register(r, p+"SetTyping", rpc.Private, s.SetTyping)
	rpc.Register(r, p+"PinMessage", rpc.Private, s.PinMessage)
}

// resolvePeer turns a Peer into a chat id (creating private chats on first use).
func (s *Service) resolvePeer(ctx context.Context, me int64, p *pb.Peer) (int64, error) {
	switch k := p.GetKind().(type) {
	case *pb.Peer_UserId:
		return chats.PrivateChat(ctx, s.DB, s.IDs, me, k.UserId)
	case *pb.Peer_ChatId:
		return k.ChatId, nil
	}
	return 0, errs.Invalid("peer is required")
}

func (s *Service) limit(ctx context.Context, key string, n int64, window time.Duration) error {
	ok, retry, err := s.Limits.Allow(ctx, key, n, window)
	if err != nil {
		return err
	}
	if !ok {
		return errs.RateLimited(int32(retry.Seconds()) + 1)
	}
	return nil
}

// encodeContent validates client content and maps it to a storage row.
func (s *Service) encodeContent(ctx context.Context, in *pb.InputContent) (msgstore.New, error) {
	var n msgstore.New
	switch k := in.GetKind().(type) {
	case *pb.InputContent_Text:
		text, ents, err := msgstore.EncodeText(k.Text)
		if err != nil {
			return n, err
		}
		n.Kind, n.Text, n.Entities = msgstore.KindText, text, ents
	case *pb.InputContent_Location:
		l := k.Location
		if l.GetLatitude() < -90 || l.GetLatitude() > 90 || l.GetLongitude() < -180 || l.GetLongitude() > 180 {
			return n, errs.Invalid("invalid coordinates")
		}
		b, err := msgstore.EncodeJSON(&pb.LocationContent{Latitude: l.GetLatitude(), Longitude: l.GetLongitude(), AccuracyMeters: l.GetAccuracyMeters()})
		if err != nil {
			return n, err
		}
		n.Kind, n.Extra = msgstore.KindLocation, b
	case *pb.InputContent_Contact:
		ct := k.Contact
		if !phone.Valid(ct.GetPhone()) || strings.TrimSpace(ct.GetFirstName()) == "" ||
			utf8.RuneCountInString(ct.GetFirstName()) > 64 || utf8.RuneCountInString(ct.GetLastName()) > 64 {
			return n, errs.Invalid("contact needs an E.164 phone and a name")
		}
		out := &pb.ContactContent{Phone: ct.GetPhone(), FirstName: strings.TrimSpace(ct.GetFirstName()), LastName: strings.TrimSpace(ct.GetLastName())}
		var uid int64
		if err := s.DB.QueryRow(ctx, `SELECT id FROM users WHERE phone = $1 AND deleted_at IS NULL`, ct.GetPhone()).Scan(&uid); err == nil {
			out.UserId = uid
		} else if !db.NoRows(err) {
			return n, err
		}
		b, err := msgstore.EncodeJSON(out)
		if err != nil {
			return n, err
		}
		n.Kind, n.Extra = msgstore.KindContact, b
	case *pb.InputContent_Media:
		return n, errs.New(pb.ErrorCode_ERROR_CODE_UNIMPLEMENTED, "photos, videos and files arrive in a later update")
	default:
		return n, errs.Invalid("content is required")
	}
	return n, nil
}

// newMessageUpdate builds per-user NewMessage updates: random_id only for the sender.
func newMessageUpdate(msg *pb.Message, sender int64) func(int64) *pb.Update {
	others := proto.Clone(msg).(*pb.Message)
	others.RandomId = 0
	return func(uid int64) *pb.Update {
		m := others
		if uid == sender {
			m = msg
		}
		return &pb.Update{Kind: &pb.Update_NewMessage{NewMessage: &pb.NewMessage{Message: m}}}
	}
}

func (s *Service) SendMessage(ctx context.Context, c *rpc.Caller, req *pb.SendMessageRequest) (*pb.SendMessageResponse, error) {
	me := c.UserID()
	if req.GetRandomId() == 0 {
		return nil, errs.Invalid("random_id is required")
	}
	if err := s.limit(ctx, "send:"+itoa(me), 60, time.Minute); err != nil {
		return nil, err
	}
	content, err := s.encodeContent(ctx, req.GetContent())
	if err != nil {
		return nil, err
	}
	chatID, err := s.resolvePeer(ctx, me, req.GetPeer())
	if err != nil {
		return nil, err
	}
	content.SenderID, content.RandomID, content.ReplyTo = me, req.GetRandomId(), req.GetReplyToSeq()

	pending := updates.Pending{}
	var msg *pb.Message
	var created bool
	err = db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := chats.Membership(ctx, tx, chatID, me)
		if err != nil {
			return err
		}
		if err := chats.CanWrite(ctx, tx, m, me); err != nil {
			return err
		}
		if content.ReplyTo != 0 {
			rows, err := msgstore.Get(ctx, tx, chatID, []int64{content.ReplyTo})
			if err != nil {
				return err
			}
			if len(rows) == 0 {
				content.ReplyTo = 0 // replied-to message no longer exists: send as a normal message
			}
		}
		row, isNew, err := msgstore.Insert(ctx, tx, chatID, content)
		if err != nil {
			return err
		}
		created = isNew
		if msg, err = msgstore.ToProto(row, me, false); err != nil {
			return err
		}
		if !isNew {
			return nil
		}
		// The sender has read everything up to their own message.
		if _, err := tx.Exec(ctx, `UPDATE chat_members SET read_inbox_seq = GREATEST(read_inbox_seq, $3)
			WHERE chat_id = $1 AND user_id = $2`, chatID, me, row.Seq); err != nil {
			return err
		}
		members, err := chats.MemberIDs(ctx, tx, chatID)
		if err != nil {
			return err
		}
		return s.Updates.AppendEach(ctx, tx, members, newMessageUpdate(msg, me), chatID, pending)
	})
	if err != nil {
		return nil, err
	}
	resp := &pb.SendMessageResponse{Message: msg}
	if created {
		s.Updates.Publish(ctx, pending)
		resp.Pts, resp.PtsCount = pending[me][0].GetPts(), 1
	} else {
		// Retry of an already-stored message: report the current state.
		if err := s.DB.QueryRow(ctx, `SELECT pts FROM user_update_state WHERE user_id = $1`, me).Scan(&resp.Pts); err != nil {
			return nil, err
		}
	}
	return resp, nil
}

func (s *Service) EditMessage(ctx context.Context, c *rpc.Caller, req *pb.EditMessageRequest) (*pb.EditMessageResponse, error) {
	me := c.UserID()
	text, ents, err := msgstore.EncodeText(req.GetText())
	if err != nil {
		return nil, err
	}
	pending := updates.Pending{}
	var msg *pb.Message
	err = db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		if _, err := chats.Membership(ctx, tx, req.GetChatId(), me); err != nil {
			return err
		}
		rows, err := msgstore.Get(ctx, tx, req.GetChatId(), []int64{req.GetSeq()})
		if err != nil {
			return err
		}
		if len(rows) == 0 || rows[0].DeletedAt != nil {
			return errs.NotFound("message not found")
		}
		r := rows[0]
		if r.SenderID != me {
			return errs.Denied("you can only edit your own messages")
		}
		if r.Kind != msgstore.KindText {
			return errs.Invalid("only text messages can be edited")
		}
		if s.now().Sub(r.CreatedAt) > msgstore.EditWindow {
			return errs.New(pb.ErrorCode_ERROR_CODE_MESSAGE_EDIT_EXPIRED, "messages can be edited for 48 hours")
		}
		var entsArg any
		if len(ents) > 0 {
			entsArg = ents
		}
		if _, err := tx.Exec(ctx, `UPDATE messages SET text = $3, entities = $4, edited_at = now() WHERE chat_id = $1 AND seq = $2`,
			r.ChatID, r.Seq, text, entsArg); err != nil {
			return err
		}
		rows, err = msgstore.Get(ctx, tx, r.ChatID, []int64{r.Seq})
		if err != nil {
			return err
		}
		if msg, err = msgstore.ToProto(rows[0], me, false); err != nil {
			return err
		}
		members, err := chats.MemberIDs(ctx, tx, r.ChatID)
		if err != nil {
			return err
		}
		others := proto.Clone(msg).(*pb.Message)
		others.RandomId = 0
		return s.Updates.AppendEach(ctx, tx, members, func(uid int64) *pb.Update {
			m := others
			if uid == me {
				m = msg
			}
			return &pb.Update{Kind: &pb.Update_MessageEdited{MessageEdited: &pb.MessageEdited{Message: m}}}
		}, r.ChatID, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	return &pb.EditMessageResponse{Message: msg, Pts: pending[me][0].GetPts(), PtsCount: 1}, nil
}

func (s *Service) DeleteMessages(ctx context.Context, c *rpc.Caller, req *pb.DeleteMessagesRequest) (*pb.DeleteMessagesResponse, error) {
	me := c.UserID()
	seqs := req.GetSeqs()
	if len(seqs) == 0 || len(seqs) > 100 {
		return nil, errs.Invalid("delete 1-100 messages")
	}
	pending := updates.Pending{}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := chats.Membership(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		rows, err := msgstore.Get(ctx, tx, m.ChatID, seqs)
		if err != nil {
			return err
		}
		var ids []int64
		for _, r := range rows {
			if r.DeletedAt == nil {
				ids = append(ids, r.Seq)
			}
		}
		if len(ids) == 0 {
			return errs.NotFound("messages not found")
		}
		update := &pb.Update{Kind: &pb.Update_MessagesDeleted{MessagesDeleted: &pb.MessagesDeleted{ChatId: m.ChatID, Seqs: ids}}}
		if !req.GetForEveryone() {
			if _, err := tx.Exec(ctx, `INSERT INTO message_hides (user_id, chat_id, seq) SELECT $1, $2, s FROM unnest($3::bigint[]) s
				ON CONFLICT DO NOTHING`, me, m.ChatID, ids); err != nil {
				return err
			}
			return s.Updates.Append(ctx, tx, []int64{me}, update, m.ChatID, pending)
		}
		// In private chats and Saved Messages either person may delete any
		// message for both; in groups only your own unless you are an admin.
		if m.Type != pb.ChatType_CHAT_TYPE_PRIVATE && m.Type != pb.ChatType_CHAT_TYPE_SAVED {
			canAny := m.Role == pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER ||
				m.AdminRights&uint64(pb.AdminRight_ADMIN_RIGHT_DELETE_MESSAGES) != 0
			for _, r := range rows {
				if r.SenderID != me && !canAny {
					return errs.Denied("you can only delete your own messages")
				}
			}
		}
		if _, err := tx.Exec(ctx, `UPDATE messages SET deleted_at = now(), text = '', entities = NULL, media_id = NULL, fwd = NULL, extra = NULL
			WHERE chat_id = $1 AND seq = ANY($2)`, m.ChatID, ids); err != nil {
			return err
		}
		if _, err := tx.Exec(ctx, `DELETE FROM chat_pins WHERE chat_id = $1 AND seq = ANY($2)`, m.ChatID, ids); err != nil {
			return err
		}
		members, err := chats.MemberIDs(ctx, tx, m.ChatID)
		if err != nil {
			return err
		}
		return s.Updates.Append(ctx, tx, members, update, m.ChatID, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	return &pb.DeleteMessagesResponse{Pts: pending[me][0].GetPts(), PtsCount: 1}, nil
}

func (s *Service) ForwardMessages(ctx context.Context, c *rpc.Caller, req *pb.ForwardMessagesRequest) (*pb.ForwardMessagesResponse, error) {
	me := c.UserID()
	seqs := req.GetSeqs()
	if len(seqs) == 0 || len(seqs) > 100 || len(req.GetRandomIds()) != len(seqs) {
		return nil, errs.Invalid("forward 1-100 messages with one random_id each")
	}
	if err := s.limit(ctx, "send:"+itoa(me), 60, time.Minute); err != nil {
		return nil, err
	}
	if _, err := chats.Membership(ctx, s.DB, req.GetFromChatId(), me); err != nil {
		return nil, err
	}
	src, err := msgstore.Get(ctx, s.DB, req.GetFromChatId(), seqs)
	if err != nil {
		return nil, err
	}
	toChat, err := s.resolvePeer(ctx, me, req.GetToPeer())
	if err != nil {
		return nil, err
	}
	bySeq := map[int64]msgstore.Row{}
	for _, r := range src {
		bySeq[r.Seq] = r
	}
	pending := updates.Pending{}
	resp := &pb.ForwardMessagesResponse{}
	err = db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := chats.Membership(ctx, tx, toChat, me)
		if err != nil {
			return err
		}
		if err := chats.CanWrite(ctx, tx, m, me); err != nil {
			return err
		}
		members, err := chats.MemberIDs(ctx, tx, toChat)
		if err != nil {
			return err
		}
		for i, seq := range seqs {
			r, ok := bySeq[seq]
			if !ok || r.DeletedAt != nil || r.Kind == msgstore.KindService {
				continue
			}
			n := msgstore.New{SenderID: me, RandomID: req.GetRandomIds()[i], Kind: r.Kind, Text: r.Text,
				Entities: r.Entities, Extra: r.Extra}
			if !req.GetHideSender() {
				if n.Fwd, err = s.forwardInfo(ctx, tx, r, me); err != nil {
					return err
				}
			}
			row, created, err := msgstore.Insert(ctx, tx, toChat, n)
			if err != nil {
				return err
			}
			msg, err := msgstore.ToProto(row, me, false)
			if err != nil {
				return err
			}
			resp.Messages = append(resp.Messages, msg)
			if !created {
				continue
			}
			if err := s.Updates.AppendEach(ctx, tx, members, newMessageUpdate(msg, me), toChat, pending); err != nil {
				return err
			}
			resp.PtsCount++
		}
		if len(resp.Messages) == 0 {
			return errs.NotFound("nothing to forward")
		}
		_, err = tx.Exec(ctx, `UPDATE chat_members SET read_inbox_seq = GREATEST(read_inbox_seq, (SELECT last_seq FROM chats WHERE id = $1))
			WHERE chat_id = $1 AND user_id = $2`, toChat, me)
		return err
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	if ups := pending[me]; len(ups) > 0 {
		resp.Pts = ups[len(ups)-1].GetPts()
	} else if err := s.DB.QueryRow(ctx, `SELECT pts FROM user_update_state WHERE user_id = $1`, me).Scan(&resp.Pts); err != nil {
		return nil, err
	}
	return resp, nil
}

// forwardInfo credits the original author, unless their FORWARDS privacy is
// "nobody" (then only the name is shown, without a link to the account).
func (s *Service) forwardInfo(ctx context.Context, tx pgx.Tx, r msgstore.Row, me int64) ([]byte, error) {
	if len(r.Fwd) > 0 {
		return r.Fwd, nil // already a forward: keep the original credit
	}
	f := &pb.ForwardInfo{FromUserId: r.SenderID, OriginalDate: r.CreatedAt.Unix(), FromChatId: r.ChatID, FromSeq: r.Seq}
	var name string
	var hidden bool
	err := tx.QueryRow(ctx, `SELECT trim(first_name || ' ' || last_name),
		EXISTS (SELECT 1 FROM privacy_rules WHERE user_id = $1 AND key = $2 AND rule = $3)
		FROM users WHERE id = $1`, r.SenderID, int16(pb.PrivacyKey_PRIVACY_KEY_FORWARDS), int16(pb.PrivacyRule_PRIVACY_RULE_NOBODY)).
		Scan(&name, &hidden)
	if err != nil {
		return nil, err
	}
	f.FromName = name
	if hidden && r.SenderID != me {
		f.FromUserId = 0
	}
	return protojson.Marshal(f)
}

func (s *Service) GetHistory(ctx context.Context, c *rpc.Caller, req *pb.GetHistoryRequest) (*pb.GetHistoryResponse, error) {
	me := c.UserID()
	m, err := chats.Membership(ctx, s.DB, req.GetChatId(), me)
	if err != nil {
		return nil, err
	}
	limit := int(req.GetLimit())
	if limit <= 0 || limit > 100 {
		limit = 50
	}
	off := req.GetOffsetSeq()
	var rows []msgstore.Row
	switch req.GetDirection() {
	case pb.HistoryDirection_HISTORY_DIRECTION_NEWER:
		rows, err = msgstore.History(ctx, s.DB, m.ChatID, me, max(off, m.ClearedSeq), 1<<62, false, limit+1)
	case pb.HistoryDirection_HISTORY_DIRECTION_AROUND:
		var older, newer []msgstore.Row
		if older, err = msgstore.History(ctx, s.DB, m.ChatID, me, m.ClearedSeq, off+1, true, limit/2+1); err == nil {
			newer, err = msgstore.History(ctx, s.DB, m.ChatID, me, max(off, m.ClearedSeq), 1<<62, false, limit/2)
		}
		for i := len(older) - 1; i >= 0; i-- {
			rows = append(rows, older[i])
		}
		rows = append(rows, newer...)
	default: // OLDER
		before := off
		if before <= 0 {
			before = 1 << 62
		}
		rows, err = msgstore.History(ctx, s.DB, m.ChatID, me, m.ClearedSeq, before, true, limit+1)
	}
	if err != nil {
		return nil, err
	}
	resp := &pb.GetHistoryResponse{}
	if len(rows) > limit {
		rows, resp.HasMore = rows[:limit], true
	}
	return resp, s.fill(ctx, me, m.ChatID, rows, &resp.Messages, &resp.Users)
}

func (s *Service) GetMessages(ctx context.Context, c *rpc.Caller, req *pb.GetMessagesRequest) (*pb.GetMessagesResponse, error) {
	me := c.UserID()
	if len(req.GetSeqs()) == 0 || len(req.GetSeqs()) > 100 {
		return nil, errs.Invalid("request 1-100 messages")
	}
	m, err := chats.Membership(ctx, s.DB, req.GetChatId(), me)
	if err != nil {
		return nil, err
	}
	rows, err := msgstore.Get(ctx, s.DB, m.ChatID, req.GetSeqs())
	if err != nil {
		return nil, err
	}
	visible := rows[:0]
	for _, r := range rows {
		if r.Seq > m.ClearedSeq {
			visible = append(visible, r)
		}
	}
	resp := &pb.GetMessagesResponse{}
	return resp, s.fill(ctx, me, m.ChatID, visible, &resp.Messages, &resp.Users)
}

// fill converts rows and attaches their senders.
func (s *Service) fill(ctx context.Context, me, chatID int64, rows []msgstore.Row, msgs *[]*pb.Message, us *[]*pb.User) error {
	pinned := map[int64]bool{}
	pr, err := s.DB.Query(ctx, `SELECT seq FROM chat_pins WHERE chat_id = $1`, chatID)
	if err != nil {
		return err
	}
	for pr.Next() {
		var seq int64
		if err := pr.Scan(&seq); err != nil {
			pr.Close()
			return err
		}
		pinned[seq] = true
	}
	pr.Close()
	seen := map[int64]bool{}
	for _, r := range rows {
		msg, err := msgstore.ToProto(r, me, pinned[r.Seq])
		if err != nil {
			return err
		}
		*msgs = append(*msgs, msg)
		if !seen[r.SenderID] {
			seen[r.SenderID] = true
			u, err := users.LoadPublic(ctx, s.DB, me, r.SenderID)
			if err != nil && !db.NoRows(err) {
				return err
			}
			if u != nil {
				*us = append(*us, u)
			}
		}
	}
	return nil
}

func (s *Service) ReadHistory(ctx context.Context, c *rpc.Caller, req *pb.ReadHistoryRequest) (*pb.ReadHistoryResponse, error) {
	me := c.UserID()
	pending := updates.Pending{}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := chats.Membership(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		upTo := min(req.GetMaxSeq(), m.LastSeq)
		if upTo <= m.ReadInbox {
			return nil // nothing new
		}
		if _, err := tx.Exec(ctx, `UPDATE chat_members SET read_inbox_seq = $3 WHERE chat_id = $1 AND user_id = $2`,
			m.ChatID, me, upTo); err != nil {
			return err
		}
		// Others whose messages are now read get a ✓✓ (read_outbox) update.
		rows, err := tx.Query(ctx, `UPDATE chat_members SET read_outbox_seq = $3
			WHERE chat_id = $1 AND user_id <> $2 AND read_outbox_seq < $3 RETURNING user_id`, m.ChatID, me, upTo)
		if err != nil {
			return err
		}
		targets := []int64{me}
		for rows.Next() {
			var uid int64
			if err := rows.Scan(&uid); err != nil {
				rows.Close()
				return err
			}
			targets = append(targets, uid)
		}
		rows.Close()
		var stillUnread int32
		if err := tx.QueryRow(ctx, `SELECT count(*) FROM (SELECT 1 FROM messages WHERE chat_id = $1 AND seq > $2
			AND sender_id <> $3 AND deleted_at IS NULL LIMIT 1000) z`, m.ChatID, upTo, me).Scan(&stillUnread); err != nil {
			return err
		}
		return s.Updates.AppendEach(ctx, tx, targets, func(uid int64) *pb.Update {
			if uid == me {
				return &pb.Update{Kind: &pb.Update_ReadInbox{ReadInbox: &pb.ReadInbox{ChatId: m.ChatID, MaxSeq: upTo, StillUnreadCount: stillUnread}}}
			}
			return &pb.Update{Kind: &pb.Update_ReadOutbox{ReadOutbox: &pb.ReadOutbox{ChatId: m.ChatID, MaxSeq: upTo}}}
		}, m.ChatID, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	resp := &pb.ReadHistoryResponse{}
	if ups := pending[me]; len(ups) > 0 {
		resp.Pts, resp.PtsCount = ups[0].GetPts(), 1
	} else if err := s.DB.QueryRow(ctx, `SELECT pts FROM user_update_state WHERE user_id = $1`, me).Scan(&resp.Pts); err != nil {
		return nil, err
	}
	return resp, nil
}

func (s *Service) SetTyping(ctx context.Context, c *rpc.Caller, req *pb.SetTypingRequest) (*pb.SetTypingResponse, error) {
	me := c.UserID()
	m, err := chats.Membership(ctx, s.DB, req.GetChatId(), me)
	if err != nil {
		return nil, err
	}
	if m.Type == pb.ChatType_CHAT_TYPE_SAVED {
		return &pb.SetTypingResponse{}, nil
	}
	// Clients send this every ~5 s while typing; extra calls are dropped quietly.
	if ok, _, err := s.Limits.Allow(ctx, "typing:"+itoa(me)+":"+itoa(m.ChatID), 3, 5*time.Second); err != nil || !ok {
		return &pb.SetTypingResponse{}, err
	}
	members, err := chats.MemberIDs(ctx, s.DB, m.ChatID)
	if err != nil {
		return nil, err
	}
	others := members[:0]
	for _, id := range members {
		if id != me {
			others = append(others, id)
		}
	}
	s.Updates.PublishEphemeral(ctx, others, &pb.Update{Kind: &pb.Update_Typing{Typing: &pb.Typing{
		ChatId: m.ChatID, UserId: me, Action: req.GetAction()}}})
	return &pb.SetTypingResponse{}, nil
}

func (s *Service) PinMessage(ctx context.Context, c *rpc.Caller, req *pb.PinMessageRequest) (*pb.PinMessageResponse, error) {
	me := c.UserID()
	pending := updates.Pending{}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := chats.Membership(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		if m.Type == pb.ChatType_CHAT_TYPE_GROUP && m.Role == pb.ChatMemberRole_CHAT_MEMBER_ROLE_MEMBER &&
			m.DefaultPerms&uint64(pb.MemberPermission_MEMBER_PERMISSION_PIN_MESSAGES) == 0 {
			return errs.Denied("only admins can pin messages here")
		}
		rows, err := msgstore.Get(ctx, tx, m.ChatID, []int64{req.GetSeq()})
		if err != nil {
			return err
		}
		if len(rows) == 0 || rows[0].DeletedAt != nil {
			return errs.NotFound("message not found")
		}
		if req.GetUnpin() {
			_, err = tx.Exec(ctx, `DELETE FROM chat_pins WHERE chat_id = $1 AND seq = $2`, m.ChatID, req.GetSeq())
		} else {
			_, err = tx.Exec(ctx, `INSERT INTO chat_pins (chat_id, seq, pinned_by) VALUES ($1,$2,$3) ON CONFLICT DO NOTHING`,
				m.ChatID, req.GetSeq(), me)
		}
		if err != nil {
			return err
		}
		members, err := chats.MemberIDs(ctx, tx, m.ChatID)
		if err != nil {
			return err
		}
		return s.Updates.Append(ctx, tx, members, &pb.Update{Kind: &pb.Update_MessagePinned{MessagePinned: &pb.MessagePinnedUpdate{
			ChatId: m.ChatID, Seq: req.GetSeq(), Pinned: !req.GetUnpin()}}}, m.ChatID, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	return &pb.PinMessageResponse{Pts: pending[me][0].GetPts(), PtsCount: 1}, nil
}

func (s *Service) now() time.Time {
	if s.Now != nil {
		return s.Now()
	}
	return time.Now()
}

func itoa(v int64) string { return strconv.FormatInt(v, 10) }
