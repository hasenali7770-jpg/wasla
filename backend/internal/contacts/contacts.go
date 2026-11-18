package contacts

import (
	"context"
	"hash/fnv"
	"sort"
	"strconv"
	"strings"
	"time"
	"unicode/utf8"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/phone"
	"wasla/backend/internal/platform/ratelimit"
	"wasla/backend/internal/platform/rpc"
	"wasla/backend/internal/users"
)

// Phone-number enumeration limits (docs/01-architecture.md §8).
const (
	MaxPerCall   = 500
	MaxNewPerDay = 2000
	MaxLifetime  = 10000
)

// Service implements wasla.v1.ContactsService.
type Service struct {
	DB     *pgxpool.Pool
	Limits *ratelimit.Limiter
}

func (s *Service) Register(r *rpc.Router) {
	const p = "/wasla.v1.ContactsService/"
	rpc.Register(r, p+"ImportContacts", rpc.Private, s.ImportContacts)
	rpc.Register(r, p+"ListContacts", rpc.Private, s.ListContacts)
	rpc.Register(r, p+"DeleteContacts", rpc.Private, s.DeleteContacts)
}

func (s *Service) ImportContacts(ctx context.Context, c *rpc.Caller, req *pb.ImportContactsRequest) (*pb.ImportContactsResponse, error) {
	me := c.UserID()
	in := req.GetContacts()
	if len(in) > MaxPerCall {
		return nil, errs.Invalid("at most %d contacts per call", MaxPerCall)
	}
	var total int
	if err := s.DB.QueryRow(ctx, `SELECT count(*) FROM contacts WHERE owner_id = $1`, me).Scan(&total); err != nil {
		return nil, err
	}
	resp := &pb.ImportContactsResponse{}
	seen := map[int64]bool{}
	err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
		for _, ct := range in {
			ph := ct.GetPhone()
			if !phone.Valid(ph) {
				continue
			}
			first, last := trim(ct.GetFirstName()), trim(ct.GetLastName())
			// Updating a number already saved is free; new numbers count against limits.
			var exists bool
			if err := tx.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM contacts WHERE owner_id = $1 AND phone = $2)`, me, ph).Scan(&exists); err != nil {
				return err
			}
			if !exists {
				if total >= MaxLifetime {
					resp.RetryClientIds = append(resp.RetryClientIds, ct.GetClientId())
					continue
				}
				ok, _, err := s.Limits.Allow(ctx, "contacts-new:"+strconv.FormatInt(me, 10), MaxNewPerDay, 24*time.Hour)
				if err != nil {
					return err
				}
				if !ok {
					resp.RetryClientIds = append(resp.RetryClientIds, ct.GetClientId())
					continue
				}
				total++
			}
			var uid *int64
			err := tx.QueryRow(ctx, `
				INSERT INTO contacts (owner_id, phone, first_name, last_name, contact_user_id)
				VALUES ($1, $2, $3, $4, (SELECT id FROM users WHERE phone = $2 AND deleted_at IS NULL))
				ON CONFLICT (owner_id, phone) DO UPDATE SET first_name = EXCLUDED.first_name, last_name = EXCLUDED.last_name,
					contact_user_id = EXCLUDED.contact_user_id, updated_at = now()
				RETURNING contact_user_id`, me, ph, first, last).Scan(&uid)
			if err != nil {
				return err
			}
			if uid != nil && *uid != me {
				resp.Imported = append(resp.Imported, &pb.ImportedContact{ClientId: ct.GetClientId(), UserId: *uid})
				seen[*uid] = true
			}
		}
		return nil
	})
	if err != nil {
		return nil, err
	}
	for uid := range seen {
		u, err := users.LoadPublic(ctx, s.DB, me, uid)
		if err != nil {
			return nil, err
		}
		resp.Users = append(resp.Users, u)
	}
	return resp, nil
}

func (s *Service) ListContacts(ctx context.Context, c *rpc.Caller, req *pb.ListContactsRequest) (*pb.ListContactsResponse, error) {
	me := c.UserID()
	rows, err := s.DB.Query(ctx, `SELECT DISTINCT ct.contact_user_id FROM contacts ct JOIN users u ON u.id = ct.contact_user_id
		WHERE ct.owner_id = $1 AND u.deleted_at IS NULL AND ct.contact_user_id <> $1`, me)
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
	sort.Slice(ids, func(i, j int) bool { return ids[i] < ids[j] })
	h := fnv.New64a()
	for _, id := range ids {
		h.Write([]byte(strconv.FormatInt(id, 10) + ","))
	}
	hash := int64(h.Sum64() >> 1)
	if req.GetHash() != 0 && req.GetHash() == hash {
		return &pb.ListContactsResponse{NotModified: true, Hash: hash}, nil
	}
	resp := &pb.ListContactsResponse{Hash: hash}
	for _, id := range ids {
		u, err := users.LoadPublic(ctx, s.DB, me, id)
		if err != nil {
			return nil, err
		}
		resp.Users = append(resp.Users, u)
	}
	return resp, nil
}

func (s *Service) DeleteContacts(ctx context.Context, c *rpc.Caller, req *pb.DeleteContactsRequest) (*pb.DeleteContactsResponse, error) {
	if _, err := s.DB.Exec(ctx, `DELETE FROM contacts WHERE owner_id = $1 AND contact_user_id = ANY($2)`,
		c.UserID(), req.GetUserIds()); err != nil {
		return nil, err
	}
	return &pb.DeleteContactsResponse{}, nil
}

func trim(s string) string {
	s = strings.TrimSpace(s)
	if utf8.RuneCountInString(s) > 64 {
		s = string([]rune(s)[:64])
	}
	return s
}
