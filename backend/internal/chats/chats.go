package chats

import (
	"context"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
)

// IDGen produces Snowflake IDs.
type IDGen interface{ Next() (int64, error) }

// Querier is satisfied by *pgxpool.Pool and pgx.Tx.
type Querier interface {
	Query(context.Context, string, ...any) (pgx.Rows, error)
	QueryRow(context.Context, string, ...any) pgx.Row
}

// Member is a user's membership in a chat, plus the chat facts most callers need.
type Member struct {
	ChatID       int64
	Type         pb.ChatType
	Role         pb.ChatMemberRole
	AdminRights  uint64
	DefaultPerms uint64
	LastSeq      int64
	ReadInbox    int64
	ReadOutbox   int64
	ClearedSeq   int64
	PeerUserID   int64 // private chats: the other user; saved: self
	PinnedRank   *int32
	Archived     bool
	MutedUntil   *time.Time
}

// Membership returns the caller's membership. Chats that do not exist, that
// the user is not in, or that moderation took down all look the same: NOT_FOUND.
func Membership(ctx context.Context, q Querier, chatID, userID int64) (*Member, error) {
	m := &Member{ChatID: chatID}
	var typ, role int16
	var peer *int64
	err := q.QueryRow(ctx, `
		SELECT c.type, m.role, m.admin_rights, c.default_permissions, c.last_seq,
		       m.read_inbox_seq, m.read_outbox_seq, m.cleared_seq, m.pinned_rank, m.archived, m.muted_until,
		       (SELECT CASE WHEN p.user_low = $2 THEN p.user_high ELSE p.user_low END
		          FROM private_chat_pairs p WHERE p.chat_id = c.id)
		FROM chat_members m JOIN chats c ON c.id = m.chat_id
		WHERE m.chat_id = $1 AND m.user_id = $2 AND c.banned_at IS NULL AND c.deleted_at IS NULL`,
		chatID, userID).Scan(&typ, &role, &m.AdminRights, &m.DefaultPerms, &m.LastSeq,
		&m.ReadInbox, &m.ReadOutbox, &m.ClearedSeq, &m.PinnedRank, &m.Archived, &m.MutedUntil, &peer)
	if db.NoRows(err) {
		return nil, errs.NotFound("chat not found")
	}
	if err != nil {
		return nil, err
	}
	m.Type, m.Role = pb.ChatType(typ), pb.ChatMemberRole(role)
	if peer != nil {
		m.PeerUserID = *peer
	}
	return m, nil
}

// MemberIDs lists all members of a chat.
func MemberIDs(ctx context.Context, q Querier, chatID int64) ([]int64, error) {
	rows, err := q.Query(ctx, `SELECT user_id FROM chat_members WHERE chat_id = $1`, chatID)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var ids []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		ids = append(ids, id)
	}
	return ids, rows.Err()
}

// PrivateChat returns the chat between me and other, creating it if needed.
// other == me is Saved Messages.
func PrivateChat(ctx context.Context, pool *pgxpool.Pool, ids IDGen, me, other int64) (int64, error) {
	lo, hi := min(me, other), max(me, other)
	var chatID int64
	err := pool.QueryRow(ctx, `SELECT chat_id FROM private_chat_pairs WHERE user_low = $1 AND user_high = $2`, lo, hi).Scan(&chatID)
	if err == nil {
		return chatID, nil
	}
	if !db.NoRows(err) {
		return 0, err
	}
	if me != other {
		var deleted bool
		err := pool.QueryRow(ctx, `SELECT deleted_at IS NOT NULL FROM users WHERE id = $1`, other).Scan(&deleted)
		if db.NoRows(err) || deleted {
			return 0, errs.NotFound("user not found")
		}
		if err != nil {
			return 0, err
		}
	}
	newID, err := ids.Next()
	if err != nil {
		return 0, err
	}
	typ, count := pb.ChatType_CHAT_TYPE_PRIVATE, 2
	if me == other {
		typ, count = pb.ChatType_CHAT_TYPE_SAVED, 1
	}
	err = db.InTx(ctx, pool, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `INSERT INTO chats (id, type, member_count) VALUES ($1,$2,$3)`, newID, int16(typ), count); err != nil {
			return err
		}
		if _, err := tx.Exec(ctx, `INSERT INTO private_chat_pairs (user_low, user_high, chat_id) VALUES ($1,$2,$3)`, lo, hi, newID); err != nil {
			return err
		}
		_, err := tx.Exec(ctx, `INSERT INTO chat_members (chat_id, user_id) SELECT $1, u FROM unnest($2::bigint[]) AS u
			ON CONFLICT DO NOTHING`, newID, []int64{lo, hi})
		return err
	})
	if db.IsUniqueViolation(err, "private_chat_pairs_pkey") {
		// Created concurrently by the other side: use theirs.
		err = pool.QueryRow(ctx, `SELECT chat_id FROM private_chat_pairs WHERE user_low = $1 AND user_high = $2`, lo, hi).Scan(&chatID)
		return chatID, err
	}
	return newID, err
}

// Blocked reports whether a or b blocked the other.
func Blocked(ctx context.Context, q Querier, a, b int64) (bool, error) {
	var blocked bool
	err := q.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM user_blocks
		WHERE (user_id = $1 AND blocked_user_id = $2) OR (user_id = $2 AND blocked_user_id = $1))`, a, b).Scan(&blocked)
	return blocked, err
}

// CanWrite checks that the member may post in the chat.
func CanWrite(ctx context.Context, q Querier, m *Member, userID int64) error {
	switch m.Type {
	case pb.ChatType_CHAT_TYPE_SAVED:
		return nil
	case pb.ChatType_CHAT_TYPE_PRIVATE:
		var peerGone bool
		if err := q.QueryRow(ctx, `SELECT deleted_at IS NOT NULL OR (banned_at IS NOT NULL AND
			(ban_expires_at IS NULL OR ban_expires_at > now())) FROM users WHERE id = $1`, m.PeerUserID).Scan(&peerGone); err != nil {
			return err
		}
		if peerGone {
			return errs.New(pb.ErrorCode_ERROR_CODE_CHAT_WRITE_FORBIDDEN, "this account is no longer available")
		}
		blocked, err := Blocked(ctx, q, userID, m.PeerUserID)
		if err != nil {
			return err
		}
		if blocked {
			return errs.New(pb.ErrorCode_ERROR_CODE_PEER_BLOCKED, "blocked")
		}
		return nil
	default:
		if m.Role >= pb.ChatMemberRole_CHAT_MEMBER_ROLE_ADMIN ||
			m.DefaultPerms&uint64(pb.MemberPermission_MEMBER_PERMISSION_SEND_MESSAGES) != 0 {
			return nil
		}
		return errs.New(pb.ErrorCode_ERROR_CODE_CHAT_WRITE_FORBIDDEN, "sending is restricted in this chat")
	}
}

// ChatProto builds the Chat view for viewer.
func ChatProto(ctx context.Context, q Querier, m *Member) (*pb.Chat, error) {
	c := &pb.Chat{Id: m.ChatID, Type: m.Type, PeerUserId: m.PeerUserID, MyRole: m.Role,
		MyAdminRights: m.AdminRights, DefaultPermissions: m.DefaultPerms, LastSeq: m.LastSeq}
	var photo, creator *int64
	var created time.Time
	err := q.QueryRow(ctx, `SELECT title, about, photo_id, member_count, creator_id, created_at FROM chats WHERE id = $1`, m.ChatID).
		Scan(&c.Title, &c.About, &photo, &c.MemberCount, &creator, &created)
	if err != nil {
		return nil, err
	}
	if photo != nil {
		c.Photo = &pb.Avatar{MediaId: *photo}
	}
	if creator != nil {
		c.CreatorId = *creator
	}
	c.CreatedAt = created.Unix()
	return c, nil
}
