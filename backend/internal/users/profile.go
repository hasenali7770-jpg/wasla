package users

import (
	"context"
	"regexp"
	"strings"
	"unicode/utf8"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/rpc"
)

var usernameRe = regexp.MustCompile(`^[A-Za-z][A-Za-z0-9_]{4,31}$`)

// reserved usernames impersonate the service or staff.
var reserved = []string{"wasla", "admin", "support", "official", "moderator", "security", "help", "team", "staff", "cmc"}

func validUsername(u string) bool {
	if !usernameRe.MatchString(u) || strings.HasSuffix(u, "_") || strings.Contains(u, "__") {
		return false
	}
	l := strings.ToLower(u)
	for _, r := range reserved {
		if strings.Contains(l, r) {
			return false
		}
	}
	return true
}

// RegisterProfile adds the profile/lookup methods (Sprint 2).
func (s *Service) RegisterProfile(r *rpc.Router) {
	const p = "/wasla.v1.UsersService/"
	rpc.Register(r, p+"GetUsers", rpc.Private, s.GetUsers)
	rpc.Register(r, p+"UpdateProfile", rpc.Private, s.UpdateProfile)
	rpc.Register(r, p+"CheckUsername", rpc.Private, s.CheckUsername)
	rpc.Register(r, p+"SetUsername", rpc.Private, s.SetUsername)
	rpc.Register(r, p+"ResolveUsername", rpc.Private, s.ResolveUsername)
	rpc.Register(r, p+"SearchUsers", rpc.Private, s.SearchUsers)
}

func (s *Service) GetUsers(ctx context.Context, c *rpc.Caller, req *pb.GetUsersRequest) (*pb.GetUsersResponse, error) {
	if len(req.GetUserIds()) > 200 {
		return nil, errs.Invalid("at most 200 users")
	}
	resp := &pb.GetUsersResponse{}
	for _, id := range req.GetUserIds() {
		u, err := LoadPublic(ctx, s.DB, c.UserID(), id)
		if db.NoRows(err) {
			continue
		}
		if err != nil {
			return nil, err
		}
		resp.Users = append(resp.Users, u)
	}
	return resp, nil
}

func (s *Service) UpdateProfile(ctx context.Context, c *rpc.Caller, req *pb.UpdateProfileRequest) (*pb.UpdateProfileResponse, error) {
	if req.FirstName != nil {
		v := strings.TrimSpace(req.GetFirstName())
		if n := utf8.RuneCountInString(v); n < 1 || n > 64 {
			return nil, errs.Invalid("first name must be 1-64 characters")
		}
		if _, err := s.DB.Exec(ctx, `UPDATE users SET first_name = $2, updated_at = now() WHERE id = $1`, c.UserID(), v); err != nil {
			return nil, err
		}
	}
	if req.LastName != nil {
		v := strings.TrimSpace(req.GetLastName())
		if utf8.RuneCountInString(v) > 64 {
			return nil, errs.Invalid("last name must be at most 64 characters")
		}
		if _, err := s.DB.Exec(ctx, `UPDATE users SET last_name = $2, updated_at = now() WHERE id = $1`, c.UserID(), v); err != nil {
			return nil, err
		}
	}
	if req.Bio != nil {
		v := strings.TrimSpace(req.GetBio())
		if utf8.RuneCountInString(v) > 140 {
			return nil, errs.Invalid("bio must be at most 140 characters")
		}
		if _, err := s.DB.Exec(ctx, `UPDATE users SET bio = $2, updated_at = now() WHERE id = $1`, c.UserID(), v); err != nil {
			return nil, err
		}
	}
	u, err := LoadSelf(ctx, s.DB, c.UserID())
	if err != nil {
		return nil, err
	}
	return &pb.UpdateProfileResponse{User: u}, nil
}

func (s *Service) CheckUsername(ctx context.Context, c *rpc.Caller, req *pb.CheckUsernameRequest) (*pb.CheckUsernameResponse, error) {
	u := strings.TrimPrefix(req.GetUsername(), "@")
	if !validUsername(u) {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_USERNAME_INVALID, "5-32 letters, digits or _, starting with a letter")
	}
	var taken bool
	err := s.DB.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM users WHERE lower(username) = lower($1) AND id <> $2)`, u, c.UserID()).Scan(&taken)
	return &pb.CheckUsernameResponse{Available: !taken}, err
}

func (s *Service) SetUsername(ctx context.Context, c *rpc.Caller, req *pb.SetUsernameRequest) (*pb.SetUsernameResponse, error) {
	u := strings.TrimPrefix(req.GetUsername(), "@")
	var arg any
	if u != "" {
		if !validUsername(u) {
			return nil, errs.New(pb.ErrorCode_ERROR_CODE_USERNAME_INVALID, "5-32 letters, digits or _, starting with a letter")
		}
		arg = u
	}
	_, err := s.DB.Exec(ctx, `UPDATE users SET username = $2, updated_at = now() WHERE id = $1`, c.UserID(), arg)
	if db.IsUniqueViolation(err, "users_username_uq") {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_USERNAME_TAKEN, "username is taken")
	}
	if err != nil {
		return nil, err
	}
	me, err := LoadSelf(ctx, s.DB, c.UserID())
	if err != nil {
		return nil, err
	}
	return &pb.SetUsernameResponse{User: me}, nil
}

func (s *Service) ResolveUsername(ctx context.Context, c *rpc.Caller, req *pb.ResolveUsernameRequest) (*pb.ResolveUsernameResponse, error) {
	u := strings.TrimPrefix(strings.TrimSpace(req.GetUsername()), "@")
	var id int64
	err := s.DB.QueryRow(ctx, `SELECT id FROM users WHERE lower(username) = lower($1) AND deleted_at IS NULL
		AND (banned_at IS NULL OR ban_expires_at <= now())`, u).Scan(&id)
	if db.NoRows(err) {
		return nil, errs.NotFound("no user with this username")
	}
	if err != nil {
		return nil, err
	}
	user, err := LoadPublic(ctx, s.DB, c.UserID(), id)
	if err != nil {
		return nil, err
	}
	return &pb.ResolveUsernameResponse{User: user}, nil
}

// SearchUsers matches the caller's contacts by name (any length ≥ 1) and
// public usernames by prefix (≥ 4 characters, to make bulk scraping harder).
func (s *Service) SearchUsers(ctx context.Context, c *rpc.Caller, req *pb.SearchUsersRequest) (*pb.SearchUsersResponse, error) {
	q := strings.TrimSpace(strings.TrimPrefix(req.GetQuery(), "@"))
	limit := req.GetLimit()
	if limit <= 0 || limit > 50 {
		limit = 20
	}
	resp := &pb.SearchUsersResponse{}
	if q == "" {
		return resp, nil
	}
	me := c.UserID()
	like := "%" + strings.NewReplacer(`\`, `\\`, `%`, `\%`, `_`, `\_`).Replace(strings.ToLower(q)) + "%"
	ids, err := s.ids(ctx, `SELECT u.id FROM contacts ct JOIN users u ON u.id = ct.contact_user_id
		WHERE ct.owner_id = $1 AND u.deleted_at IS NULL
		  AND (lower(ct.first_name || ' ' || ct.last_name) LIKE $2 OR lower(u.first_name || ' ' || u.last_name) LIKE $2
		       OR lower(coalesce(u.username, '')) LIKE $2)
		ORDER BY u.first_name LIMIT $3`, me, like, limit)
	if err != nil {
		return nil, err
	}
	seen := map[int64]bool{}
	for _, id := range ids {
		seen[id] = true
		u, err := LoadPublic(ctx, s.DB, me, id)
		if err != nil {
			return nil, err
		}
		resp.Contacts = append(resp.Contacts, u)
	}
	if len([]rune(q)) >= 4 {
		prefix := strings.NewReplacer(`\`, `\\`, `%`, `\%`, `_`, `\_`).Replace(strings.ToLower(q)) + "%"
		gids, err := s.ids(ctx, `SELECT id FROM users WHERE lower(username) LIKE $1 AND deleted_at IS NULL
			AND (banned_at IS NULL OR ban_expires_at <= now()) AND id <> $2
			ORDER BY length(username), username LIMIT $3`, prefix, me, limit)
		if err != nil {
			return nil, err
		}
		for _, id := range gids {
			if seen[id] {
				continue
			}
			u, err := LoadPublic(ctx, s.DB, me, id)
			if err != nil {
				return nil, err
			}
			resp.Global = append(resp.Global, u)
		}
	}
	return resp, nil
}

func (s *Service) ids(ctx context.Context, sql string, args ...any) ([]int64, error) {
	rows, err := s.DB.Query(ctx, sql, args...)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	var out []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			return nil, err
		}
		out = append(out, id)
	}
	return out, rows.Err()
}
