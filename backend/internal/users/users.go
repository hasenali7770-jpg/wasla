package users

import (
	"context"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/rpc"
)

// Querier is satisfied by *pgxpool.Pool and pgx.Tx.
type Querier interface {
	QueryRow(context.Context, string, ...any) pgx.Row
}

// LoadSelf returns the full profile of the requesting user.
func LoadSelf(ctx context.Context, q Querier, id int64) (*pb.User, error) {
	u := &pb.User{Id: id, IsSelf: true}
	var username, ph *string
	var photo *int64
	err := q.QueryRow(ctx, `SELECT first_name, last_name, username, phone, bio, photo_id FROM users WHERE id = $1`, id).
		Scan(&u.FirstName, &u.LastName, &username, &ph, &u.Bio, &photo)
	if err != nil {
		return nil, err
	}
	if username != nil {
		u.Username = *username
	}
	if ph != nil {
		u.Phone = *ph
	}
	if photo != nil {
		u.Photo = &pb.Avatar{MediaId: *photo}
	}
	return u, nil
}

// LoadPublic returns the profile of another user as seen by viewer. The phone
// number is shown only to viewers who saved it themselves (most restrictive
// behaviour until the full privacy engine lands).
func LoadPublic(ctx context.Context, q Querier, viewer, id int64) (*pb.User, error) {
	if viewer == id {
		return LoadSelf(ctx, q, id)
	}
	u := &pb.User{Id: id}
	var username, ph *string
	var photo *int64
	var deleted bool
	err := q.QueryRow(ctx, `
		SELECT u.first_name, u.last_name, u.username, u.bio, u.photo_id, u.deleted_at IS NOT NULL, u.phone,
		       EXISTS (SELECT 1 FROM user_blocks b WHERE b.user_id = $1 AND b.blocked_user_id = u.id),
		       EXISTS (SELECT 1 FROM contacts c WHERE c.owner_id = $1 AND c.contact_user_id = u.id),
		       EXISTS (SELECT 1 FROM contacts c WHERE c.owner_id = u.id AND c.contact_user_id = $1)
		FROM users u WHERE u.id = $2`, viewer, id).
		Scan(&u.FirstName, &u.LastName, &username, &u.Bio, &photo, &deleted, &ph, &u.IsBlocked, &u.IsContact, &u.IsMutualContact)
	if err != nil {
		return nil, err
	}
	u.IsDeleted = deleted
	u.IsMutualContact = u.IsMutualContact && u.IsContact
	// Viewers who saved this number already know it; nobody else sees it
	// until the privacy engine lands.
	if ph != nil && u.IsContact {
		u.Phone = *ph
	}
	if username != nil {
		u.Username = *username
	}
	if photo != nil && !deleted {
		u.Photo = &pb.Avatar{MediaId: *photo}
	}
	return u, nil
}

// Service implements wasla.v1.UsersService except profile photos (with the
// media service) and privacy settings (privacy engine).
type Service struct {
	DB *pgxpool.Pool
}

func (s *Service) Register(r *rpc.Router) {
	const p = "/wasla.v1.UsersService/"
	rpc.Register(r, p+"GetMe", rpc.Private, s.GetMe)
	rpc.Register(r, p+"BlockUser", rpc.Private, s.BlockUser)
	rpc.Register(r, p+"UnblockUser", rpc.Private, s.UnblockUser)
	rpc.Register(r, p+"ListBlocked", rpc.Private, s.ListBlocked)
	s.RegisterProfile(r)
}

func (s *Service) GetMe(ctx context.Context, c *rpc.Caller, _ *pb.GetMeRequest) (*pb.GetMeResponse, error) {
	u, err := LoadSelf(ctx, s.DB, c.UserID())
	if err != nil {
		return nil, err
	}
	return &pb.GetMeResponse{User: u}, nil
}

func (s *Service) BlockUser(ctx context.Context, c *rpc.Caller, req *pb.BlockUserRequest) (*pb.BlockUserResponse, error) {
	if req.GetUserId() == c.UserID() {
		return nil, errs.Invalid("cannot block yourself")
	}
	tag, err := s.DB.Exec(ctx, `INSERT INTO user_blocks (user_id, blocked_user_id)
		SELECT $1, id FROM users WHERE id = $2 ON CONFLICT DO NOTHING`, c.UserID(), req.GetUserId())
	if err != nil {
		return nil, err
	}
	if tag.RowsAffected() == 0 {
		var exists bool
		if err := s.DB.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM users WHERE id = $1)`, req.GetUserId()).Scan(&exists); err != nil {
			return nil, err
		}
		if !exists {
			return nil, errs.NotFound("user not found")
		}
	}
	return &pb.BlockUserResponse{}, nil
}

func (s *Service) UnblockUser(ctx context.Context, c *rpc.Caller, req *pb.UnblockUserRequest) (*pb.UnblockUserResponse, error) {
	if _, err := s.DB.Exec(ctx, `DELETE FROM user_blocks WHERE user_id = $1 AND blocked_user_id = $2`,
		c.UserID(), req.GetUserId()); err != nil {
		return nil, err
	}
	return &pb.UnblockUserResponse{}, nil
}

func (s *Service) ListBlocked(ctx context.Context, c *rpc.Caller, req *pb.ListBlockedRequest) (*pb.ListBlockedResponse, error) {
	limit := req.GetLimit()
	if limit <= 0 || limit > 100 {
		limit = 50
	}
	resp := &pb.ListBlockedResponse{}
	if err := s.DB.QueryRow(ctx, `SELECT count(*) FROM user_blocks WHERE user_id = $1`, c.UserID()).Scan(&resp.Total); err != nil {
		return nil, err
	}
	rows, err := s.DB.Query(ctx, `SELECT blocked_user_id FROM user_blocks WHERE user_id = $1
		ORDER BY created_at DESC OFFSET $2 LIMIT $3`, c.UserID(), max(req.GetOffset(), 0), limit)
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
	for _, id := range ids {
		u, err := LoadPublic(ctx, s.DB, c.UserID(), id)
		if err != nil && !db.NoRows(err) {
			return nil, err
		}
		if u != nil {
			resp.Users = append(resp.Users, u)
		}
	}
	return resp, nil
}
