package chats

import (
	"context"
	"log/slog"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/msgstore"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/rpc"
	"wasla/backend/internal/updates"
	"wasla/backend/internal/users"
)

// MaxPinned is the number of pinned chats per list (main / archive).
const MaxPinned = 5

// Service implements the Sprint 2 part of wasla.v1.ChatsService (private
// chats, Saved Messages and the chat list). Groups land in weeks 11–12.
type Service struct {
	DB      *pgxpool.Pool
	IDs     IDGen
	Updates *updates.Service
	Log     *slog.Logger
}

func (s *Service) Register(r *rpc.Router) {
	const p = "/wasla.v1.ChatsService/"
	rpc.Register(r, p+"ListDialogs", rpc.Private, s.ListDialogs)
	rpc.Register(r, p+"UpdateDialog", rpc.Private, s.UpdateDialog)
	rpc.Register(r, p+"ReorderPinnedDialogs", rpc.Private, s.ReorderPinnedDialogs)
	rpc.Register(r, p+"ClearHistory", rpc.Private, s.ClearHistory)
	rpc.Register(r, p+"GetChats", rpc.Private, s.GetChats)
	rpc.Register(r, p+"GetPrivateChat", rpc.Private, s.GetPrivateChat)
}

func (s *Service) GetPrivateChat(ctx context.Context, c *rpc.Caller, req *pb.GetPrivateChatRequest) (*pb.GetPrivateChatResponse, error) {
	chatID, err := PrivateChat(ctx, s.DB, s.IDs, c.UserID(), req.GetUserId())
	if err != nil {
		return nil, err
	}
	m, err := Membership(ctx, s.DB, chatID, c.UserID())
	if err != nil {
		return nil, err
	}
	chat, err := ChatProto(ctx, s.DB, m)
	if err != nil {
		return nil, err
	}
	u, err := users.LoadPublic(ctx, s.DB, c.UserID(), req.GetUserId())
	if err != nil {
		return nil, err
	}
	return &pb.GetPrivateChatResponse{Chat: chat, User: u}, nil
}

func (s *Service) GetChats(ctx context.Context, c *rpc.Caller, req *pb.GetChatsRequest) (*pb.GetChatsResponse, error) {
	if len(req.GetChatIds()) > 100 {
		return nil, errs.Invalid("at most 100 chats")
	}
	resp := &pb.GetChatsResponse{}
	for _, id := range req.GetChatIds() {
		m, err := Membership(ctx, s.DB, id, c.UserID())
		if errs.Is(err, pb.ErrorCode_ERROR_CODE_NOT_FOUND) {
			continue
		}
		if err != nil {
			return nil, err
		}
		chat, err := ChatProto(ctx, s.DB, m)
		if err != nil {
			return nil, err
		}
		resp.Chats = append(resp.Chats, chat)
	}
	return resp, nil
}

// dialogFor builds the Dialog for one membership.
func dialogFor(ctx context.Context, q msgstore.Querier, m *Member, viewer int64) (*pb.Dialog, error) {
	d := &pb.Dialog{ChatId: m.ChatID, ReadInboxSeq: m.ReadInbox, ReadOutboxSeq: m.ReadOutbox, Archived: m.Archived}
	if m.PinnedRank != nil {
		d.PinnedRank = *m.PinnedRank + 1000 // client sees positive ranks; order preserved
	}
	if m.MutedUntil != nil && m.MutedUntil.After(time.Now()) {
		d.MutedUntil = m.MutedUntil.Unix()
	}
	top, err := msgstore.Latest(ctx, q, m.ChatID, viewer, m.ClearedSeq)
	if err != nil {
		return nil, err
	}
	if top != nil {
		if d.TopMessage, err = msgstore.ToProto(*top, viewer, false); err != nil {
			return nil, err
		}
	}
	err = q.QueryRow(ctx, `SELECT count(*) FROM (SELECT 1 FROM messages x
		WHERE x.chat_id = $1 AND x.seq > $2 AND x.sender_id <> $3 AND x.deleted_at IS NULL
		  AND NOT EXISTS (SELECT 1 FROM message_hides h WHERE h.user_id = $3 AND h.chat_id = x.chat_id AND h.seq = x.seq)
		LIMIT 1000) z`, m.ChatID, max(m.ReadInbox, m.ClearedSeq), viewer).Scan(&d.UnreadCount)
	return d, err
}

func (s *Service) ListDialogs(ctx context.Context, c *rpc.Caller, req *pb.ListDialogsRequest) (*pb.ListDialogsResponse, error) {
	me := c.UserID()
	limit := req.GetLimit()
	if limit <= 0 || limit > 100 {
		limit = 50
	}
	resp := &pb.ListDialogsResponse{}
	if err := s.DB.QueryRow(ctx, `SELECT pts FROM user_update_state WHERE user_id = $1`, me).Scan(&resp.Pts); err != nil {
		return nil, err
	}
	// First page: all pinned chats, then the newest others. Later pages:
	// keyset on (last message second, chat id) over unpinned chats.
	rows, err := s.DB.Query(ctx, `
		SELECT c.id FROM chat_members m JOIN chats c ON c.id = m.chat_id
		WHERE m.user_id = $1 AND m.archived = $2 AND c.banned_at IS NULL AND c.deleted_at IS NULL
		  AND c.last_seq > m.cleared_seq
		  AND (($3 = 0 AND m.pinned_rank IS NOT NULL)
		       OR (m.pinned_rank IS NULL AND ($3 = 0 OR
		           (extract(epoch FROM c.last_message_at)::bigint, c.id) < ($3::bigint, $4::bigint))))
		ORDER BY (m.pinned_rank IS NULL), m.pinned_rank,
		         extract(epoch FROM c.last_message_at)::bigint DESC, c.id DESC
		LIMIT $5`, me, req.GetArchived(), req.GetOffsetDate(), req.GetOffsetChatId(), limit+1)
	if err != nil {
		return nil, err
	}
	var ids []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			rows.Close()
			return nil, err
		}
		ids = append(ids, id)
	}
	rows.Close()
	if len(ids) > int(limit) {
		ids, resp.HasMore = ids[:limit], true
	}
	seen := map[int64]bool{}
	for _, id := range ids {
		m, err := Membership(ctx, s.DB, id, me)
		if err != nil {
			return nil, err
		}
		d, err := dialogFor(ctx, s.DB, m, me)
		if err != nil {
			return nil, err
		}
		chat, err := ChatProto(ctx, s.DB, m)
		if err != nil {
			return nil, err
		}
		resp.Dialogs = append(resp.Dialogs, d)
		resp.Chats = append(resp.Chats, chat)
		for _, uid := range []int64{m.PeerUserID, d.GetTopMessage().GetSenderId()} {
			if uid == 0 || seen[uid] {
				continue
			}
			seen[uid] = true
			u, err := users.LoadPublic(ctx, s.DB, me, uid)
			if err != nil && !db.NoRows(err) {
				return nil, err
			}
			if u != nil {
				resp.Users = append(resp.Users, u)
			}
		}
	}
	return resp, nil
}

func (s *Service) UpdateDialog(ctx context.Context, c *rpc.Caller, req *pb.UpdateDialogRequest) (*pb.UpdateDialogResponse, error) {
	me := c.UserID()
	pending := updates.Pending{}
	var dialog *pb.Dialog
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := Membership(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		if req.Archived != nil {
			if _, err := tx.Exec(ctx, `UPDATE chat_members SET archived = $3, pinned_rank = NULL WHERE chat_id = $1 AND user_id = $2`,
				m.ChatID, me, req.GetArchived()); err != nil {
				return err
			}
			m.Archived = req.GetArchived()
			m.PinnedRank = nil
		}
		if req.Pinned != nil {
			if req.GetPinned() && m.PinnedRank == nil {
				var n int
				var top *int32
				if err := tx.QueryRow(ctx, `SELECT count(*), min(pinned_rank) FROM chat_members
					WHERE user_id = $1 AND archived = $2 AND pinned_rank IS NOT NULL`, me, m.Archived).Scan(&n, &top); err != nil {
					return err
				}
				if n >= MaxPinned {
					return errs.Invalid("you can pin up to %d chats", MaxPinned)
				}
				rank := int32(0)
				if top != nil {
					rank = *top - 1
				}
				if _, err := tx.Exec(ctx, `UPDATE chat_members SET pinned_rank = $3 WHERE chat_id = $1 AND user_id = $2`, m.ChatID, me, rank); err != nil {
					return err
				}
				m.PinnedRank = &rank
			} else if !req.GetPinned() {
				if _, err := tx.Exec(ctx, `UPDATE chat_members SET pinned_rank = NULL WHERE chat_id = $1 AND user_id = $2`, m.ChatID, me); err != nil {
					return err
				}
				m.PinnedRank = nil
			}
		}
		if req.MutedUntil != nil {
			var until *time.Time
			if req.GetMutedUntil() > 0 {
				t := time.Unix(req.GetMutedUntil(), 0)
				until = &t
			}
			if _, err := tx.Exec(ctx, `UPDATE chat_members SET muted_until = $3 WHERE chat_id = $1 AND user_id = $2`, m.ChatID, me, until); err != nil {
				return err
			}
			m.MutedUntil = until
		}
		if dialog, err = dialogFor(ctx, tx, m, me); err != nil {
			return err
		}
		return s.Updates.Append(ctx, tx, []int64{me},
			&pb.Update{Kind: &pb.Update_DialogUpdated{DialogUpdated: &pb.DialogUpdated{Dialog: dialog}}}, m.ChatID, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	pts := pending[me][0].GetPts()
	return &pb.UpdateDialogResponse{Dialog: dialog, Pts: pts, PtsCount: 1}, nil
}

func (s *Service) ReorderPinnedDialogs(ctx context.Context, c *rpc.Caller, req *pb.ReorderPinnedDialogsRequest) (*pb.ReorderPinnedDialogsResponse, error) {
	me := c.UserID()
	if len(req.GetChatIds()) > MaxPinned {
		return nil, errs.Invalid("you can pin up to %d chats", MaxPinned)
	}
	pending := updates.Pending{}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `UPDATE chat_members SET pinned_rank = NULL WHERE user_id = $1 AND archived = $2`, me, req.GetArchived()); err != nil {
			return err
		}
		for i, id := range req.GetChatIds() {
			if _, err := Membership(ctx, tx, id, me); err != nil {
				return err
			}
			if _, err := tx.Exec(ctx, `UPDATE chat_members SET pinned_rank = $3, archived = $4 WHERE chat_id = $1 AND user_id = $2`,
				id, me, i, req.GetArchived()); err != nil {
				return err
			}
		}
		return s.Updates.Append(ctx, tx, []int64{me}, &pb.Update{Kind: &pb.Update_PinnedDialogsReordered{
			PinnedDialogsReordered: &pb.PinnedDialogsReordered{ChatIds: req.GetChatIds(), Archived: req.GetArchived()}}}, 0, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	return &pb.ReorderPinnedDialogsResponse{Pts: pending[me][0].GetPts(), PtsCount: 1}, nil
}

// ClearHistory hides everything up to now for the caller, or for both people
// in a private chat when for_everyone is set (the messages stay in the
// database for moderation evidence; they just stop being shown).
func (s *Service) ClearHistory(ctx context.Context, c *rpc.Caller, req *pb.ClearHistoryRequest) (*pb.ClearHistoryResponse, error) {
	me := c.UserID()
	pending := updates.Pending{}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := Membership(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		who := []int64{me}
		if req.GetForEveryone() {
			if m.Type != pb.ChatType_CHAT_TYPE_PRIVATE {
				return errs.Invalid("clearing for everyone is only possible in private chats")
			}
			who = append(who, m.PeerUserID)
		}
		if _, err := tx.Exec(ctx, `UPDATE chat_members SET cleared_seq = $2 WHERE chat_id = $1 AND user_id = ANY($3)`,
			m.ChatID, m.LastSeq, who); err != nil {
			return err
		}
		return s.Updates.Append(ctx, tx, who, &pb.Update{Kind: &pb.Update_HistoryCleared{
			HistoryCleared: &pb.HistoryCleared{ChatId: m.ChatID, MaxSeq: m.LastSeq}}}, m.ChatID, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	return &pb.ClearHistoryResponse{Pts: pending[me][0].GetPts(), PtsCount: 1}, nil
}
