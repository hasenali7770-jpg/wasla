package moderation

import (
	"context"
	"encoding/json"
	"log/slog"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/ratelimit"
	"wasla/backend/internal/platform/rpc"
)

// Priority levels for the review queue.
const (
	PriorityCritical int16 = 1
	PriorityHigh     int16 = 2
	PriorityNormal   int16 = 3
)

// PriorityFor maps a report reason to its queue priority.
func PriorityFor(r pb.ReportReason) int16 {
	switch r {
	case pb.ReportReason_REPORT_REASON_CHILD_ABUSE, pb.ReportReason_REPORT_REASON_TERRORISM:
		return PriorityCritical
	case pb.ReportReason_REPORT_REASON_VIOLENCE, pb.ReportReason_REPORT_REASON_ILLEGAL_GOODS,
		pb.ReportReason_REPORT_REASON_SCAM:
		return PriorityHigh
	default:
		return PriorityNormal
	}
}

// SLA is the time allowed to handle a report, per priority.
type SLA map[int16]time.Duration

// DefaultSLA: critical 1 h, high 4 h, normal 24 h. Adjust once counsel
// confirms the CMC's takedown timelines.
var DefaultSLA = SLA{PriorityCritical: time.Hour, PriorityHigh: 4 * time.Hour, PriorityNormal: 24 * time.Hour}

// Reports implements wasla.v1.ModerationService (user-facing reporting).
type Reports struct {
	DB     *pgxpool.Pool
	Limits *ratelimit.Limiter
	SLA    SLA
	Log    *slog.Logger
	Now    func() time.Time
	// Alert (optional) notifies the on-call moderator of critical reports.
	Alert Alerter
}

func (s *Reports) Register(r *rpc.Router) {
	rpc.Register(r, "/wasla.v1.ModerationService/Report", rpc.Private, s.Report)
}

// evidenceMessage is one reported message as captured at report time.
type evidenceMessage struct {
	Seq      int64  `json:"seq"`
	SenderID int64  `json:"sender_id"`
	Kind     int16  `json:"kind"`
	Text     string `json:"text"`
	MediaID  int64  `json:"media_id,omitempty"`
	Date     int64  `json:"date"`
	Deleted  bool   `json:"deleted,omitempty"`
}

type evidenceChat struct {
	ID          int64  `json:"id"`
	Type        int16  `json:"type"`
	Title       string `json:"title"`
	MemberCount int32  `json:"member_count"`
}

// Evidence is stored in reports.evidence so deleting the content later does
// not destroy what the moderator needs to see.
type Evidence struct {
	Chat     *evidenceChat     `json:"chat,omitempty"`
	Messages []evidenceMessage `json:"messages,omitempty"`
}

func (s *Reports) Report(ctx context.Context, c *rpc.Caller, req *pb.ReportRequest) (*pb.ReportResponse, error) {
	if req.GetReason() == pb.ReportReason_REPORT_REASON_UNSPECIFIED {
		return nil, errs.Invalid("reason is required")
	}
	comment := strings.TrimSpace(req.GetComment())
	if utf8.RuneCountInString(comment) > 512 {
		return nil, errs.Invalid("comment must be at most 512 characters")
	}
	ok, retry, err := s.Limits.Allow(ctx, "report:"+itoa(c.UserID()), 20, time.Hour)
	if err != nil {
		return nil, err
	}
	if !ok {
		return nil, errs.RateLimited(int32(retry.Seconds()) + 1)
	}

	me := c.UserID()
	var (
		targetUser int64
		chatID     int64
		seqs       []int64
		ev         Evidence
		blockUser  int64
	)
	err = db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		switch t := req.GetTarget().(type) {
		case *pb.ReportRequest_UserId:
			if t.UserId == me {
				return errs.Invalid("cannot report yourself")
			}
			var exists bool
			if err := tx.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM users WHERE id = $1)`, t.UserId).Scan(&exists); err != nil {
				return err
			}
			if !exists {
				return errs.NotFound("user not found")
			}
			targetUser, blockUser = t.UserId, t.UserId
			// Context: the reported user's recent messages in the private chat.
			lo, hi := min(me, t.UserId), max(me, t.UserId)
			var pc int64
			err := tx.QueryRow(ctx, `SELECT chat_id FROM private_chat_pairs WHERE user_low = $1 AND user_high = $2`, lo, hi).Scan(&pc)
			if err == nil {
				chatID = pc
				ev.Messages, err = snapshot(ctx, tx, pc, nil, t.UserId, 20)
				if err != nil {
					return err
				}
			} else if !db.NoRows(err) {
				return err
			}
		case *pb.ReportRequest_ChatId:
			if err := requireMember(ctx, tx, t.ChatId, me); err != nil {
				return err
			}
			chatID = t.ChatId
			ch, err := loadChat(ctx, tx, t.ChatId)
			if err != nil {
				return err
			}
			ev.Chat = ch
			if ev.Messages, err = snapshot(ctx, tx, t.ChatId, nil, 0, 20); err != nil {
				return err
			}
		case *pb.ReportRequest_Messages:
			m := t.Messages
			if len(m.GetSeqs()) == 0 || len(m.GetSeqs()) > 100 {
				return errs.Invalid("report 1-100 messages")
			}
			if err := requireMember(ctx, tx, m.GetChatId(), me); err != nil {
				return err
			}
			chatID, seqs = m.GetChatId(), m.GetSeqs()
			ch, err := loadChat(ctx, tx, chatID)
			if err != nil {
				return err
			}
			ev.Chat = ch
			if ev.Messages, err = snapshot(ctx, tx, chatID, seqs, 0, 100); err != nil {
				return err
			}
			if len(ev.Messages) == 0 {
				return errs.NotFound("messages not found")
			}
			// If every reported message has one author, that author is the target.
			targetUser = ev.Messages[0].SenderID
			for _, msg := range ev.Messages {
				if msg.SenderID != targetUser {
					targetUser = 0
					break
				}
			}
			if targetUser == me {
				return errs.Invalid("cannot report your own messages")
			}
			if ch.Type == int16(pb.ChatType_CHAT_TYPE_PRIVATE) {
				blockUser = targetUser
			}
		default:
			return errs.Invalid("target is required")
		}
		return nil
	})
	if err != nil {
		return nil, err
	}

	var id int64
	var reused bool
	err = db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		// One open report per reporter and target per day: repeat taps return
		// the same report instead of flooding the queue.
		err := tx.QueryRow(ctx, `
			SELECT id FROM reports
			WHERE reporter_id = $1 AND status = 1 AND created_at > now() - interval '24 hours'
			  AND target_user_id IS NOT DISTINCT FROM $2 AND chat_id IS NOT DISTINCT FROM $3
			  AND message_seqs = $4
			LIMIT 1`, me, nullable(targetUser), nullable(chatID), seqsOrEmpty(seqs)).Scan(&id)
		if err == nil {
			reused = true
			return nil
		}
		if !db.NoRows(err) {
			return err
		}
		evJSON, err := json.Marshal(ev)
		if err != nil {
			return err
		}
		prio := PriorityFor(req.GetReason())
		due := s.now().Add(s.sla(prio))
		err = tx.QueryRow(ctx, `
			INSERT INTO reports (reporter_id, target_user_id, chat_id, message_seqs, reason, comment, evidence, priority, due_at)
			VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9) RETURNING id`,
			me, nullable(targetUser), nullable(chatID), seqsOrEmpty(seqs), int16(req.GetReason()), comment, evJSON, prio, due).Scan(&id)
		if err != nil {
			return err
		}
		if req.GetBlock() && blockUser != 0 {
			_, err = tx.Exec(ctx, `INSERT INTO user_blocks (user_id, blocked_user_id) VALUES ($1,$2) ON CONFLICT DO NOTHING`, me, blockUser)
		}
		return err
	})
	if err != nil {
		return nil, err
	}
	if PriorityFor(req.GetReason()) == PriorityCritical && !reused {
		s.logger().Warn("critical report received", "report_id", id, "reason", req.GetReason().String())
		s.alertCritical(id, req.GetReason().String())
	}
	return &pb.ReportResponse{ReportId: id}, nil
}

func (s *Reports) sla(p int16) time.Duration {
	if d, ok := s.SLA[p]; ok {
		return d
	}
	return DefaultSLA[p]
}

func (s *Reports) now() time.Time {
	if s.Now != nil {
		return s.Now()
	}
	return time.Now()
}

func requireMember(ctx context.Context, tx pgx.Tx, chatID, userID int64) error {
	var ok bool
	if err := tx.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM chat_members WHERE chat_id = $1 AND user_id = $2)`,
		chatID, userID).Scan(&ok); err != nil {
		return err
	}
	if !ok {
		return errs.NotFound("chat not found")
	}
	return nil
}

func loadChat(ctx context.Context, tx pgx.Tx, chatID int64) (*evidenceChat, error) {
	ch := &evidenceChat{ID: chatID}
	err := tx.QueryRow(ctx, `SELECT type, title, member_count FROM chats WHERE id = $1`, chatID).
		Scan(&ch.Type, &ch.Title, &ch.MemberCount)
	return ch, err
}

// snapshot copies messages into evidence: either the given seqs, or the
// latest `limit` messages (optionally only from one sender).
func snapshot(ctx context.Context, tx pgx.Tx, chatID int64, seqs []int64, sender int64, limit int) ([]evidenceMessage, error) {
	var rows pgx.Rows
	var err error
	if seqs != nil {
		rows, err = tx.Query(ctx, `
			SELECT seq, sender_id, kind, text, COALESCE(media_id, 0), extract(epoch FROM created_at)::bigint, deleted_at IS NOT NULL
			FROM messages WHERE chat_id = $1 AND seq = ANY($2) ORDER BY seq LIMIT $3`, chatID, seqs, limit)
	} else {
		rows, err = tx.Query(ctx, `
			SELECT seq, sender_id, kind, text, COALESCE(media_id, 0), extract(epoch FROM created_at)::bigint, deleted_at IS NOT NULL
			FROM messages WHERE chat_id = $1 AND ($2 = 0 OR sender_id = $2) AND deleted_at IS NULL
			ORDER BY seq DESC LIMIT $3`, chatID, sender, limit)
	}
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var out []evidenceMessage
	for rows.Next() {
		var m evidenceMessage
		if err := rows.Scan(&m.Seq, &m.SenderID, &m.Kind, &m.Text, &m.MediaID, &m.Date, &m.Deleted); err != nil {
			return nil, err
		}
		out = append(out, m)
	}
	return out, rows.Err()
}

func nullable(v int64) any {
	if v == 0 {
		return nil
	}
	return v
}

func seqsOrEmpty(s []int64) []int64 {
	if s == nil {
		return []int64{}
	}
	return s
}
