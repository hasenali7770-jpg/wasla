package chats

import (
	"context"
	"fmt"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/jackc/pgx/v5"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/msgstore"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/rpc"
	"wasla/backend/internal/updates"
	"wasla/backend/internal/users"
)

// MaxGroupMembers is the Lean MVP limit for small groups (fan-out on write).
const MaxGroupMembers = 200

func (s *Service) registerGroups(r *rpc.Router) {
	const p = "/wasla.v1.ChatsService/"
	rpc.Register(r, p+"CreateGroup", rpc.Private, s.CreateGroup)
	rpc.Register(r, p+"UpdateChatInfo", rpc.Private, s.UpdateChatInfo)
	rpc.Register(r, p+"ListMembers", rpc.Private, s.ListMembers)
	rpc.Register(r, p+"AddMembers", rpc.Private, s.AddMembers)
	rpc.Register(r, p+"RemoveMember", rpc.Private, s.RemoveMember)
	rpc.Register(r, p+"SetMemberRole", rpc.Private, s.SetMemberRole)
	rpc.Register(r, p+"LeaveChat", rpc.Private, s.LeaveChat)
}

func cleanTitle(t string) (string, error) {
	t = strings.TrimSpace(t)
	if n := utf8.RuneCountInString(t); n < 1 || n > 128 {
		return "", errs.Invalid("group name must be 1-128 characters")
	}
	return t, nil
}

// group returns the caller's membership in a group (NOT_FOUND for anything else).
func group(ctx context.Context, q Querier, chatID, me int64) (*Member, error) {
	m, err := Membership(ctx, q, chatID, me)
	if err != nil {
		return nil, err
	}
	if m.Type != pb.ChatType_CHAT_TYPE_GROUP {
		return nil, errs.Invalid("not a group")
	}
	return m, nil
}

// can reports whether a member may do something: the owner always; an
// admin with the right; an ordinary member when the group's default
// permissions allow it (perm 0 = admins only).
func can(m *Member, right pb.AdminRight, perm pb.MemberPermission) bool {
	switch m.Role {
	case pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER:
		return true
	case pb.ChatMemberRole_CHAT_MEMBER_ROLE_ADMIN:
		return m.AdminRights&uint64(right) != 0
	}
	return perm != 0 && m.DefaultPerms&uint64(perm) != 0
}

// defaultAdminRights are given to a newly promoted admin when none are named:
// everything except adding other admins.
const defaultAdminRights = uint64(pb.AdminRight_ADMIN_RIGHT_CHANGE_INFO | pb.AdminRight_ADMIN_RIGHT_DELETE_MESSAGES |
	pb.AdminRight_ADMIN_RIGHT_BAN_USERS | pb.AdminRight_ADMIN_RIGHT_INVITE_USERS | pb.AdminRight_ADMIN_RIGHT_PIN_MESSAGES)

// invitable splits candidates into users who can be added by inviter and
// users whose GROUP_INVITES privacy, a block, or a closed account stops it.
func invitable(ctx context.Context, tx pgx.Tx, inviter int64, candidates []int64) (ok, restricted []int64, err error) {
	rows, err := tx.Query(ctx, `
		SELECT u.id,
		  u.deleted_at IS NULL AND (u.banned_at IS NULL OR u.ban_expires_at <= now())
		  AND NOT EXISTS (SELECT 1 FROM user_blocks b WHERE (b.user_id = u.id AND b.blocked_user_id = $1)
		                                              OR (b.user_id = $1 AND b.blocked_user_id = u.id)),
		  COALESCE((SELECT e.allow FROM privacy_exceptions e WHERE e.user_id = u.id AND e.key = $3 AND e.target_user_id = $1),
		    CASE COALESCE((SELECT r.rule FROM privacy_rules r WHERE r.user_id = u.id AND r.key = $3), $4)
		      WHEN $5 THEN false
		      WHEN $6 THEN EXISTS (SELECT 1 FROM contacts c WHERE c.owner_id = u.id AND c.contact_user_id = $1)
		      ELSE true END)
		FROM users u WHERE u.id = ANY($2)`,
		inviter, candidates, int16(pb.PrivacyKey_PRIVACY_KEY_GROUP_INVITES), int16(pb.PrivacyRule_PRIVACY_RULE_EVERYBODY),
		int16(pb.PrivacyRule_PRIVACY_RULE_NOBODY), int16(pb.PrivacyRule_PRIVACY_RULE_CONTACTS))
	if err != nil {
		return nil, nil, err
	}
	defer rows.Close()
	seen := map[int64]bool{}
	for rows.Next() {
		var id int64
		var active, allowed bool
		if err := rows.Scan(&id, &active, &allowed); err != nil {
			return nil, nil, err
		}
		seen[id] = true
		switch {
		case !active:
			// Closed, banned or blocked accounts are silently skipped.
		case !allowed:
			restricted = append(restricted, id)
		default:
			ok = append(ok, id)
		}
	}
	if err := rows.Err(); err != nil {
		return nil, nil, err
	}
	for _, id := range candidates {
		if !seen[id] {
			return nil, nil, errs.NotFound("user %d not found", id)
		}
	}
	return ok, restricted, nil
}

func uniq(ids []int64, without int64) []int64 {
	seen := map[int64]bool{without: true}
	var out []int64
	for _, id := range ids {
		if id != 0 && !seen[id] {
			seen[id] = true
			out = append(out, id)
		}
	}
	return out
}

// postService stores a service line ("Ali added Sara") and sends it to
// recipients as a new message.
func (s *Service) postService(ctx context.Context, tx pgx.Tx, chatID, actor int64, sc *pb.ServiceContent,
	recipients []int64, pending updates.Pending) (*pb.Message, error) {
	extra, err := protojson.Marshal(sc)
	if err != nil {
		return nil, err
	}
	rid, err := s.IDs.Next()
	if err != nil {
		return nil, err
	}
	row, _, err := msgstore.Insert(ctx, tx, chatID, msgstore.New{SenderID: actor, RandomID: rid, Kind: msgstore.KindService, Extra: extra})
	if err != nil {
		return nil, err
	}
	msg, err := msgstore.ToProto(row, actor, false)
	if err != nil {
		return nil, err
	}
	msg.RandomId = 0
	if _, err := tx.Exec(ctx, `UPDATE chat_members SET read_inbox_seq = GREATEST(read_inbox_seq, $3)
		WHERE chat_id = $1 AND user_id = $2`, chatID, actor, row.Seq); err != nil {
		return nil, err
	}
	return msg, s.Updates.Append(ctx, tx, recipients, &pb.Update{Kind: &pb.Update_NewMessage{NewMessage: &pb.NewMessage{Message: msg}}}, chatID, pending)
}

// chatUpdated sends every member the group as they see it (their own role).
func (s *Service) chatUpdated(ctx context.Context, tx pgx.Tx, chatID int64, pending updates.Pending) error {
	rows, err := tx.Query(ctx, `SELECT user_id, role, admin_rights FROM chat_members WHERE chat_id = $1`, chatID)
	if err != nil {
		return err
	}
	type role struct {
		role   pb.ChatMemberRole
		rights uint64
	}
	roles := map[int64]role{}
	var ids []int64
	for rows.Next() {
		var id int64
		var r int16
		var rights uint64
		if err := rows.Scan(&id, &r, &rights); err != nil {
			rows.Close()
			return err
		}
		roles[id] = role{pb.ChatMemberRole(r), rights}
		ids = append(ids, id)
	}
	rows.Close()
	if len(ids) == 0 {
		return nil
	}
	base, err := ChatProto(ctx, tx, &Member{ChatID: chatID, Type: pb.ChatType_CHAT_TYPE_GROUP})
	if err != nil {
		return err
	}
	if err := tx.QueryRow(ctx, `SELECT default_permissions, last_seq FROM chats WHERE id = $1`, chatID).
		Scan(&base.DefaultPermissions, &base.LastSeq); err != nil {
		return err
	}
	return s.Updates.AppendEach(ctx, tx, ids, func(uid int64) *pb.Update {
		c := proto.Clone(base).(*pb.Chat)
		c.MyRole, c.MyAdminRights = roles[uid].role, roles[uid].rights
		return &pb.Update{Kind: &pb.Update_ChatUpdated{ChatUpdated: &pb.ChatUpdated{Chat: c}}}
	}, chatID, pending)
}

func (s *Service) recount(ctx context.Context, tx pgx.Tx, chatID int64) (int, error) {
	var n int
	err := tx.QueryRow(ctx, `UPDATE chats SET member_count = (SELECT count(*) FROM chat_members WHERE chat_id = $1),
		updated_at = now() WHERE id = $1 RETURNING member_count`, chatID).Scan(&n)
	return n, err
}

func ptsOf(p updates.Pending, me int64) (int64, int32) {
	if ups := p[me]; len(ups) > 0 {
		return ups[len(ups)-1].GetPts(), int32(len(ups))
	}
	return 0, 0
}

// CreateGroup creates a small group with the caller as owner.
func (s *Service) CreateGroup(ctx context.Context, c *rpc.Caller, req *pb.CreateGroupRequest) (*pb.CreateGroupResponse, error) {
	me := c.UserID()
	title, err := cleanTitle(req.GetTitle())
	if err != nil {
		return nil, err
	}
	if req.GetRandomId() == 0 {
		return nil, errs.Invalid("random_id is required")
	}
	invited := uniq(req.GetUserIds(), me)
	if len(invited)+1 > MaxGroupMembers {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_CHAT_MEMBER_LIMIT, "a group can have at most %d members", MaxGroupMembers)
	}
	// A retried request returns the group it already created.
	idemKey := fmt.Sprintf("creategroup:%d:%d", me, req.GetRandomId())
	if existing, err := s.Updates.Redis.Get(ctx, idemKey).Int64(); err == nil && existing != 0 {
		m, err := group(ctx, s.DB, existing, me)
		if err == nil {
			chat, err := ChatProto(ctx, s.DB, m)
			return &pb.CreateGroupResponse{Chat: chat}, err
		}
	}
	chatID, err := s.IDs.Next()
	if err != nil {
		return nil, err
	}
	pending := updates.Pending{}
	var restricted []int64
	var chat *pb.Chat
	err = db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		ok, r, err := invitable(ctx, tx, me, invited)
		if err != nil {
			return err
		}
		restricted = r
		if _, err := tx.Exec(ctx, `INSERT INTO chats (id, type, title, creator_id, member_count) VALUES ($1,$2,$3,$4,$5)`,
			chatID, int16(pb.ChatType_CHAT_TYPE_GROUP), title, me, len(ok)+1); err != nil {
			return err
		}
		if _, err := tx.Exec(ctx, `INSERT INTO chat_members (chat_id, user_id, role, invited_by) VALUES ($1,$2,$3,NULL)`,
			chatID, me, int16(pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER)); err != nil {
			return err
		}
		if len(ok) > 0 {
			if _, err := tx.Exec(ctx, `INSERT INTO chat_members (chat_id, user_id, invited_by) SELECT $1, u, $2 FROM unnest($3::bigint[]) u`,
				chatID, me, ok); err != nil {
				return err
			}
		}
		members := append([]int64{me}, ok...)
		if _, err := s.postService(ctx, tx, chatID, me, &pb.ServiceContent{Action: &pb.ServiceContent_ChatCreated{
			ChatCreated: &pb.ChatCreated{Title: title}}}, members, pending); err != nil {
			return err
		}
		if len(ok) > 0 {
			if _, err := s.postService(ctx, tx, chatID, me, &pb.ServiceContent{Action: &pb.ServiceContent_MembersAdded{
				MembersAdded: &pb.MembersAdded{UserIds: ok}}}, members, pending); err != nil {
				return err
			}
		}
		m, err := group(ctx, tx, chatID, me)
		if err != nil {
			return err
		}
		chat, err = ChatProto(ctx, tx, m)
		return err
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Redis.Set(ctx, idemKey, chatID, 24*time.Hour)
	s.Updates.Publish(ctx, pending)
	resp := &pb.CreateGroupResponse{Chat: chat, PrivacyRestrictedUserIds: restricted}
	resp.Pts, resp.PtsCount = ptsOf(pending, me)
	return resp, nil
}

// AddMembers adds users to a group.
func (s *Service) AddMembers(ctx context.Context, c *rpc.Caller, req *pb.AddMembersRequest) (*pb.AddMembersResponse, error) {
	me := c.UserID()
	pending := updates.Pending{}
	var restricted []int64
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := group(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		if !can(m, pb.AdminRight_ADMIN_RIGHT_INVITE_USERS, pb.MemberPermission_MEMBER_PERMISSION_ADD_MEMBERS) {
			return errs.Denied("you can't add members to this group")
		}
		// Lock the chat row so concurrent adds can't pass the member limit.
		var count int
		if err := tx.QueryRow(ctx, `SELECT member_count FROM chats WHERE id = $1 FOR UPDATE`, m.ChatID).Scan(&count); err != nil {
			return err
		}
		candidates := uniq(req.GetUserIds(), me)
		ok, r, err := invitable(ctx, tx, me, candidates)
		if err != nil {
			return err
		}
		restricted = r
		var added []int64
		if len(ok) > 0 {
			rows, err := tx.Query(ctx, `INSERT INTO chat_members (chat_id, user_id, invited_by) SELECT $1, u, $2 FROM unnest($3::bigint[]) u
				ON CONFLICT DO NOTHING RETURNING user_id`, m.ChatID, me, ok)
			if err != nil {
				return err
			}
			for rows.Next() {
				var id int64
				if err := rows.Scan(&id); err != nil {
					rows.Close()
					return err
				}
				added = append(added, id)
			}
			rows.Close()
		}
		if len(added) == 0 {
			return nil // everyone was already in, or restricted
		}
		n, err := s.recount(ctx, tx, m.ChatID)
		if err != nil {
			return err
		}
		if n > MaxGroupMembers {
			return errs.New(pb.ErrorCode_ERROR_CODE_CHAT_MEMBER_LIMIT, "a group can have at most %d members", MaxGroupMembers)
		}
		members, err := MemberIDs(ctx, tx, m.ChatID)
		if err != nil {
			return err
		}
		if _, err := s.postService(ctx, tx, m.ChatID, me, &pb.ServiceContent{Action: &pb.ServiceContent_MembersAdded{
			MembersAdded: &pb.MembersAdded{UserIds: added}}}, members, pending); err != nil {
			return err
		}
		return s.chatUpdated(ctx, tx, m.ChatID, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	resp := &pb.AddMembersResponse{PrivacyRestrictedUserIds: restricted}
	resp.Pts, resp.PtsCount = ptsOf(pending, me)
	return resp, nil
}

// removeMember takes userID out of the group; kicked is false when they leave.
func (s *Service) removeMember(ctx context.Context, tx pgx.Tx, m *Member, actor, userID int64, kicked bool, pending updates.Pending) error {
	var role int16
	err := tx.QueryRow(ctx, `DELETE FROM chat_members WHERE chat_id = $1 AND user_id = $2 RETURNING role`, m.ChatID, userID).Scan(&role)
	if db.NoRows(err) {
		return errs.NotFound("not a member")
	}
	if err != nil {
		return err
	}
	if err := s.Updates.Append(ctx, tx, []int64{userID}, &pb.Update{Kind: &pb.Update_ChatLeft{ChatLeft: &pb.ChatLeft{
		ChatId: m.ChatID, Kicked: kicked}}}, m.ChatID, pending); err != nil {
		return err
	}
	if _, err := s.recount(ctx, tx, m.ChatID); err != nil {
		return err
	}
	members, err := MemberIDs(ctx, tx, m.ChatID)
	if err != nil {
		return err
	}
	if len(members) == 0 {
		_, err := tx.Exec(ctx, `UPDATE chats SET deleted_at = now() WHERE id = $1`, m.ChatID)
		return err
	}
	// The owner left: the longest-serving admin, else member, takes over.
	if pb.ChatMemberRole(role) == pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER {
		if _, err := tx.Exec(ctx, `UPDATE chat_members SET role = $2, admin_rights = 0 WHERE chat_id = $1 AND user_id =
			(SELECT user_id FROM chat_members WHERE chat_id = $1 ORDER BY role DESC, joined_at, user_id LIMIT 1)`,
			m.ChatID, int16(pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER)); err != nil {
			return err
		}
	}
	sc := &pb.ServiceContent{Action: &pb.ServiceContent_MemberLeft{MemberLeft: &pb.MemberLeft{}}}
	if kicked {
		sc = &pb.ServiceContent{Action: &pb.ServiceContent_MemberRemoved{MemberRemoved: &pb.MemberRemoved{UserId: userID}}}
	}
	if _, err := s.postService(ctx, tx, m.ChatID, actor, sc, members, pending); err != nil {
		return err
	}
	return s.chatUpdated(ctx, tx, m.ChatID, pending)
}

// RemoveMember removes someone else from a group.
func (s *Service) RemoveMember(ctx context.Context, c *rpc.Caller, req *pb.RemoveMemberRequest) (*pb.RemoveMemberResponse, error) {
	me := c.UserID()
	if req.GetUserId() == me {
		return nil, errs.Invalid("use LeaveChat to leave")
	}
	pending := updates.Pending{}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := group(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		if !can(m, pb.AdminRight_ADMIN_RIGHT_BAN_USERS, 0) {
			return errs.Denied("only admins can remove members")
		}
		target, err := Membership(ctx, tx, m.ChatID, req.GetUserId())
		if err != nil {
			return err
		}
		// Admins can remove members; only the owner can remove admins; nobody removes the owner.
		if target.Role == pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER ||
			(target.Role == pb.ChatMemberRole_CHAT_MEMBER_ROLE_ADMIN && m.Role != pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER) {
			return errs.Denied("you can't remove this member")
		}
		return s.removeMember(ctx, tx, m, me, req.GetUserId(), true, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	resp := &pb.RemoveMemberResponse{}
	resp.Pts, resp.PtsCount = ptsOf(pending, me)
	return resp, nil
}

// LeaveChat leaves a group.
func (s *Service) LeaveChat(ctx context.Context, c *rpc.Caller, req *pb.LeaveChatRequest) (*pb.LeaveChatResponse, error) {
	me := c.UserID()
	pending := updates.Pending{}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := group(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		return s.removeMember(ctx, tx, m, me, me, false, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	resp := &pb.LeaveChatResponse{}
	resp.Pts, resp.PtsCount = ptsOf(pending, me)
	return resp, nil
}

// SetMemberRole makes a member an admin or back. Ownership can't be given
// away this way in the MVP.
func (s *Service) SetMemberRole(ctx context.Context, c *rpc.Caller, req *pb.SetMemberRoleRequest) (*pb.SetMemberRoleResponse, error) {
	me := c.UserID()
	role := req.GetRole()
	if role != pb.ChatMemberRole_CHAT_MEMBER_ROLE_ADMIN && role != pb.ChatMemberRole_CHAT_MEMBER_ROLE_MEMBER {
		return nil, errs.Invalid("role must be admin or member")
	}
	pending := updates.Pending{}
	var member *pb.ChatMember
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := group(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		if !can(m, pb.AdminRight_ADMIN_RIGHT_ADD_ADMINS, 0) {
			return errs.Denied("only the owner can change admins")
		}
		target, err := Membership(ctx, tx, m.ChatID, req.GetUserId())
		if err != nil {
			return err
		}
		if target.Role == pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER {
			return errs.Denied("the owner's role can't be changed")
		}
		rights := uint64(0)
		if role == pb.ChatMemberRole_CHAT_MEMBER_ROLE_ADMIN {
			rights = req.GetAdminRights()
			if rights == 0 {
				rights = defaultAdminRights
			}
			// An admin can't hand out rights they don't have themselves.
			if m.Role != pb.ChatMemberRole_CHAT_MEMBER_ROLE_OWNER {
				rights &= m.AdminRights
			}
		}
		var joined time.Time
		var invitedBy *int64
		if err := tx.QueryRow(ctx, `UPDATE chat_members SET role = $3, admin_rights = $4 WHERE chat_id = $1 AND user_id = $2
			RETURNING joined_at, invited_by`, m.ChatID, req.GetUserId(), int16(role), rights).Scan(&joined, &invitedBy); err != nil {
			return err
		}
		member = &pb.ChatMember{UserId: req.GetUserId(), Role: role, AdminRights: rights, JoinedAt: joined.Unix()}
		if invitedBy != nil {
			member.InvitedBy = *invitedBy
		}
		return s.chatUpdated(ctx, tx, m.ChatID, pending)
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	resp := &pb.SetMemberRoleResponse{Member: member}
	resp.Pts, resp.PtsCount = ptsOf(pending, me)
	return resp, nil
}

// UpdateChatInfo renames a group or changes its description or photo.
func (s *Service) UpdateChatInfo(ctx context.Context, c *rpc.Caller, req *pb.UpdateChatInfoRequest) (*pb.UpdateChatInfoResponse, error) {
	me := c.UserID()
	pending := updates.Pending{}
	var chat *pb.Chat
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		m, err := group(ctx, tx, req.GetChatId(), me)
		if err != nil {
			return err
		}
		if !can(m, pb.AdminRight_ADMIN_RIGHT_CHANGE_INFO, pb.MemberPermission_MEMBER_PERMISSION_CHANGE_INFO) {
			return errs.Denied("you can't change this group's info")
		}
		members, err := MemberIDs(ctx, tx, m.ChatID)
		if err != nil {
			return err
		}
		if req.Title != nil {
			title, err := cleanTitle(req.GetTitle())
			if err != nil {
				return err
			}
			if _, err := tx.Exec(ctx, `UPDATE chats SET title = $2, updated_at = now() WHERE id = $1`, m.ChatID, title); err != nil {
				return err
			}
			if _, err := s.postService(ctx, tx, m.ChatID, me, &pb.ServiceContent{Action: &pb.ServiceContent_ChatTitleChanged{
				ChatTitleChanged: &pb.ChatTitleChanged{Title: title}}}, members, pending); err != nil {
				return err
			}
		}
		if req.About != nil {
			about := strings.TrimSpace(req.GetAbout())
			if utf8.RuneCountInString(about) > 255 {
				return errs.Invalid("description must be at most 255 characters")
			}
			if _, err := tx.Exec(ctx, `UPDATE chats SET about = $2, updated_at = now() WHERE id = $1`, m.ChatID, about); err != nil {
				return err
			}
		}
		if req.PhotoMediaId != nil {
			var photo any
			if id := req.GetPhotoMediaId(); id != 0 {
				var ok bool
				if err := tx.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM media_files WHERE id = $1 AND owner_id = $2
					AND kind = $3 AND status = $4)`, id, me, int16(pb.MediaKind_MEDIA_KIND_PHOTO),
					int16(pb.MediaStatus_MEDIA_STATUS_READY)).Scan(&ok); err != nil {
					return err
				}
				if !ok {
					return errs.NotFound("photo not found")
				}
				photo = id
			}
			if _, err := tx.Exec(ctx, `UPDATE chats SET photo_id = $2, updated_at = now() WHERE id = $1`, m.ChatID, photo); err != nil {
				return err
			}
			if _, err := s.postService(ctx, tx, m.ChatID, me, &pb.ServiceContent{Action: &pb.ServiceContent_ChatPhotoChanged{
				ChatPhotoChanged: &pb.ChatPhotoChanged{MediaId: req.GetPhotoMediaId()}}}, members, pending); err != nil {
				return err
			}
		}
		if err := s.chatUpdated(ctx, tx, m.ChatID, pending); err != nil {
			return err
		}
		chat, err = ChatProto(ctx, tx, m)
		return err
	})
	if err != nil {
		return nil, err
	}
	s.Updates.Publish(ctx, pending)
	resp := &pb.UpdateChatInfoResponse{Chat: chat}
	resp.Pts, resp.PtsCount = ptsOf(pending, me)
	return resp, nil
}

// ListMembers lists a group's members, owner and admins first.
func (s *Service) ListMembers(ctx context.Context, c *rpc.Caller, req *pb.ListMembersRequest) (*pb.ListMembersResponse, error) {
	me := c.UserID()
	m, err := group(ctx, s.DB, req.GetChatId(), me)
	if err != nil {
		return nil, err
	}
	limit := req.GetLimit()
	if limit <= 0 || limit > MaxGroupMembers {
		limit = MaxGroupMembers
	}
	rows, err := s.DB.Query(ctx, `SELECT user_id, role, admin_rights, joined_at, COALESCE(invited_by, 0) FROM chat_members
		WHERE chat_id = $1 ORDER BY role DESC, joined_at, user_id OFFSET $2 LIMIT $3`, m.ChatID, max(req.GetOffset(), 0), limit)
	if err != nil {
		return nil, err
	}
	resp := &pb.ListMembersResponse{}
	for rows.Next() {
		var cm pb.ChatMember
		var role int16
		var joined time.Time
		if err := rows.Scan(&cm.UserId, &role, &cm.AdminRights, &joined, &cm.InvitedBy); err != nil {
			rows.Close()
			return nil, err
		}
		cm.Role, cm.JoinedAt = pb.ChatMemberRole(role), joined.Unix()
		resp.Members = append(resp.Members, &cm)
	}
	rows.Close()
	if err := rows.Err(); err != nil {
		return nil, err
	}
	for _, cm := range resp.Members {
		u, err := users.LoadPublic(ctx, s.DB, me, cm.UserId)
		if err != nil {
			return nil, err
		}
		resp.Users = append(resp.Users, u)
	}
	if err := s.DB.QueryRow(ctx, `SELECT member_count FROM chats WHERE id = $1`, m.ChatID).Scan(&resp.Total); err != nil {
		return nil, err
	}
	return resp, nil
}
