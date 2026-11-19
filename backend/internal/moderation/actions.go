package moderation

import (
	"context"
	"fmt"
	"log/slog"
	"strconv"
	"strings"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/auth"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/phone"
	"wasla/backend/internal/updates"
)

// Staff roles.
const (
	RoleModerator       int16 = 1
	RoleSeniorModerator int16 = 2
	RoleAdmin           int16 = 3
)

// Action codes stored in moderation_actions.action.
const (
	ActionWarn          int16 = 1
	ActionDeleteContent int16 = 2
	ActionBanUser       int16 = 3
	ActionUnbanUser     int16 = 4
	ActionBanChat       int16 = 5
	ActionDismiss       int16 = 6
	ActionBlockMedia    int16 = 7
)

// Staff is an authenticated moderator.
type Staff struct {
	ID   int64
	Name string
	Role int16
}

// Link ties an action to the report and/or legal request that caused it.
type Link struct {
	ReportID       int64
	LegalRequestID int64
}

// Actions performs moderation actions. Every action runs in one transaction
// with its audit record, so there is never an unaudited takedown.
type Actions struct {
	DB          *pgxpool.Pool
	Redis       *redis.Client
	Updates     *updates.Service
	PhonePepper []byte
	Log         *slog.Logger
	Now         func() time.Time
	// OnMediaBlocked (optional) removes files already shared with a newly
	// blocklisted hash (media.Service.TakedownByHash).
	OnMediaBlocked func(ctx context.Context, sha256 []byte, reason pb.ReportReason) error
}

// MaxModeratorBan is the longest ban a (non-senior) moderator may issue.
const MaxModeratorBan = 7 * 24 * time.Hour

func requireReason(reason string) (string, error) {
	r := strings.TrimSpace(reason)
	if len([]rune(r)) < 3 {
		return "", errs.Invalid("a reason is required for every moderation action")
	}
	return r, nil
}

func (a *Actions) audit(ctx context.Context, tx pgx.Tx, st Staff, action int16, user, chat int64, seqs []int64,
	reason string, expires *time.Time, link Link) error {
	_, err := tx.Exec(ctx, `
		INSERT INTO moderation_actions (staff_id, report_id, legal_request_id, target_user_id, chat_id, message_seqs, action, reason, expires_at)
		VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9)`,
		st.ID, nullable(link.ReportID), nullable(link.LegalRequestID), nullable(user), nullable(chat),
		seqsOrEmpty(seqs), action, reason, expires)
	if err != nil {
		return err
	}
	if link.ReportID != 0 {
		status := int16(2)
		if action == ActionDismiss {
			status = 3
		}
		_, err = tx.Exec(ctx, `UPDATE reports SET status = $1, handled_by = $2, handled_at = now(), resolution = $3
			WHERE id = $4 AND status = 1`, status, st.ID, reason, link.ReportID)
	}
	return err
}

// DeleteMessages removes messages for everyone (tombstones them) and pushes
// MessagesDeleted to every member's devices.
func (a *Actions) DeleteMessages(ctx context.Context, st Staff, chatID int64, seqs []int64, reason string, link Link) error {
	reason, err := requireReason(reason)
	if err != nil {
		return err
	}
	if len(seqs) == 0 {
		return errs.Invalid("no messages selected")
	}
	pending := updates.Pending{}
	err = db.InTx(ctx, a.DB, func(tx pgx.Tx) error {
		rows, err := tx.Query(ctx, `
			UPDATE messages SET deleted_at = now(), text = '', entities = NULL, media_id = NULL, fwd = NULL, extra = NULL
			WHERE chat_id = $1 AND seq = ANY($2) AND deleted_at IS NULL RETURNING seq`, chatID, seqs)
		if err != nil {
			return err
		}
		var deleted []int64
		for rows.Next() {
			var s int64
			if err := rows.Scan(&s); err != nil {
				rows.Close()
				return err
			}
			deleted = append(deleted, s)
		}
		rows.Close()
		if err := rows.Err(); err != nil {
			return err
		}
		if len(deleted) > 0 {
			members, err := chatMembers(ctx, tx, chatID)
			if err != nil {
				return err
			}
			upd := &pb.Update{Kind: &pb.Update_MessagesDeleted{MessagesDeleted: &pb.MessagesDeleted{ChatId: chatID, Seqs: deleted}}}
			if err := a.Updates.Append(ctx, tx, members, upd, chatID, pending); err != nil {
				return err
			}
		}
		return a.audit(ctx, tx, st, ActionDeleteContent, 0, chatID, seqs, reason, nil, link)
	})
	if err != nil {
		return err
	}
	a.Updates.Publish(ctx, pending)
	return nil
}

// BanUser bans an account (d == 0 means permanent): sessions are revoked
// and disconnected at once, and the phone number cannot sign up again,
// even if the account is deleted.
func (a *Actions) BanUser(ctx context.Context, st Staff, userID int64, d time.Duration, reason string, link Link) error {
	reason, err := requireReason(reason)
	if err != nil {
		return err
	}
	if (d == 0 || d > MaxModeratorBan) && st.Role < RoleSeniorModerator {
		return errs.Denied("bans longer than 7 days need a senior moderator")
	}
	var expires *time.Time
	if d > 0 {
		t := a.now().Add(d)
		expires = &t
	}
	var revoked []int64
	err = db.InTx(ctx, a.DB, func(tx pgx.Tx) error {
		var ph *string
		err := tx.QueryRow(ctx, `UPDATE users SET banned_at = now(), ban_expires_at = $2, ban_reason = $3, updated_at = now()
			WHERE id = $1 RETURNING phone`, userID, expires, reason).Scan(&ph)
		if db.NoRows(err) {
			return errs.NotFound("user not found")
		}
		if err != nil {
			return err
		}
		if ph != nil {
			if _, err := tx.Exec(ctx, `
				INSERT INTO banned_phones (phone_hash, reason, expires_at) VALUES ($1,$2,$3)
				ON CONFLICT (phone_hash) DO UPDATE SET reason = EXCLUDED.reason, expires_at = EXCLUDED.expires_at`,
				phone.Hash(a.PhonePepper, *ph), reason, expires); err != nil {
				return err
			}
		}
		if revoked, err = auth.RevokeSessions(ctx, tx, "user_id = $1", userID); err != nil {
			return err
		}
		if err := a.audit(ctx, tx, st, ActionBanUser, userID, 0, nil, reason, expires, link); err != nil {
			return err
		}
		// Every other open report about this user is resolved by the ban.
		_, err = tx.Exec(ctx, `UPDATE reports SET status = 2, handled_by = $1, handled_at = now(), resolution = $2
			WHERE target_user_id = $3 AND status = 1`, st.ID, "user banned: "+reason, userID)
		return err
	})
	if err != nil {
		return err
	}
	auth.Kick(ctx, a.Redis, revoked)
	a.Log.Info("user banned", "user_id", userID, "staff_id", st.ID, "permanent", d == 0)
	return nil
}

// UnbanUser lifts a ban (senior moderators only).
func (a *Actions) UnbanUser(ctx context.Context, st Staff, userID int64, reason string) error {
	reason, err := requireReason(reason)
	if err != nil {
		return err
	}
	if st.Role < RoleSeniorModerator {
		return errs.Denied("only senior moderators can lift bans")
	}
	return db.InTx(ctx, a.DB, func(tx pgx.Tx) error {
		var ph *string
		err := tx.QueryRow(ctx, `UPDATE users SET banned_at = NULL, ban_expires_at = NULL, ban_reason = NULL, updated_at = now()
			WHERE id = $1 RETURNING phone`, userID).Scan(&ph)
		if db.NoRows(err) {
			return errs.NotFound("user not found")
		}
		if err != nil {
			return err
		}
		if ph != nil {
			if _, err := tx.Exec(ctx, `DELETE FROM banned_phones WHERE phone_hash = $1`, phone.Hash(a.PhonePepper, *ph)); err != nil {
				return err
			}
		}
		return a.audit(ctx, tx, st, ActionUnbanUser, userID, 0, nil, reason, nil, Link{})
	})
}

// BanChat takes a whole group down: it disappears for every member.
func (a *Actions) BanChat(ctx context.Context, st Staff, chatID int64, reason string, link Link) error {
	reason, err := requireReason(reason)
	if err != nil {
		return err
	}
	if st.Role < RoleSeniorModerator {
		return errs.Denied("only senior moderators can take down chats")
	}
	pending := updates.Pending{}
	err = db.InTx(ctx, a.DB, func(tx pgx.Tx) error {
		tag, err := tx.Exec(ctx, `UPDATE chats SET banned_at = now(), ban_reason = $2, updated_at = now()
			WHERE id = $1 AND banned_at IS NULL`, chatID, reason)
		if err != nil {
			return err
		}
		if tag.RowsAffected() == 0 {
			return errs.NotFound("chat not found or already taken down")
		}
		members, err := chatMembers(ctx, tx, chatID)
		if err != nil {
			return err
		}
		upd := &pb.Update{Kind: &pb.Update_ChatLeft{ChatLeft: &pb.ChatLeft{ChatId: chatID, Kicked: true}}}
		if err := a.Updates.Append(ctx, tx, members, upd, chatID, pending); err != nil {
			return err
		}
		if err := a.audit(ctx, tx, st, ActionBanChat, 0, chatID, nil, reason, nil, link); err != nil {
			return err
		}
		_, err = tx.Exec(ctx, `UPDATE reports SET status = 2, handled_by = $1, handled_at = now(), resolution = $2
			WHERE chat_id = $3 AND status = 1`, st.ID, "chat taken down: "+reason, chatID)
		return err
	})
	if err != nil {
		return err
	}
	a.Updates.Publish(ctx, pending)
	return nil
}

// Dismiss closes a report with no action.
func (a *Actions) Dismiss(ctx context.Context, st Staff, reportID int64, reason string) error {
	reason, err := requireReason(reason)
	if err != nil {
		return err
	}
	return db.InTx(ctx, a.DB, func(tx pgx.Tx) error {
		return a.audit(ctx, tx, st, ActionDismiss, 0, 0, nil, reason, nil, Link{ReportID: reportID})
	})
}

// BlockMedia adds a SHA-256 to the known-illegal-media list.
func (a *Actions) BlockMedia(ctx context.Context, st Staff, sha256 []byte, reason pb.ReportReason, note string) error {
	if len(sha256) != 32 {
		return errs.Invalid("SHA-256 must be 64 hex characters")
	}
	if st.Role < RoleSeniorModerator {
		return errs.Denied("only senior moderators can edit the media blocklist")
	}
	err := db.InTx(ctx, a.DB, func(tx pgx.Tx) error {
		if _, err := tx.Exec(ctx, `INSERT INTO media_blocklist (sha256, reason, note, added_by) VALUES ($1,$2,$3,$4)
			ON CONFLICT (sha256) DO NOTHING`, sha256, int16(reason), note, st.ID); err != nil {
			return err
		}
		return a.audit(ctx, tx, st, ActionBlockMedia, 0, 0, nil, fmt.Sprintf("media blocklisted (%s): %s", reason, note), nil, Link{})
	})
	if err != nil || a.OnMediaBlocked == nil {
		return err
	}
	// Copies already shared are taken down too.
	return a.OnMediaBlocked(ctx, sha256, reason)
}

func chatMembers(ctx context.Context, tx pgx.Tx, chatID int64) ([]int64, error) {
	rows, err := tx.Query(ctx, `SELECT user_id FROM chat_members WHERE chat_id = $1`, chatID)
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

func (a *Actions) now() time.Time {
	if a.Now != nil {
		return a.Now()
	}
	return time.Now()
}

func itoa(v int64) string { return strconv.FormatInt(v, 10) }
