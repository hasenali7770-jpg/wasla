package updates

import (
	"context"
	"fmt"
	"sort"
	"time"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"
	"google.golang.org/protobuf/proto"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/rpc"
)

// UserChannel is the Redis pub/sub channel a gateway subscribes to for a
// connected user. Payload: serialized wasla.v1.UpdatesPush.
func UserChannel(userID int64) string { return fmt.Sprintf("u:%d", userID) }

// Pending is a set of per-user updates produced inside a transaction, to be
// published once the transaction has committed.
type Pending map[int64][]*pb.Update

// Service implements wasla.v1.UpdatesService and the internal Append API.
type Service struct {
	DB    *pgxpool.Pool
	Redis *redis.Client
	Now   func() time.Time
}

// Append gives each user the next pts and stores update (a template: pts is
// filled in per user) in their log. It must run inside the caller's
// transaction. Rows are locked in user_id order so concurrent Appends over
// overlapping user sets cannot deadlock.
func (s *Service) Append(ctx context.Context, tx pgx.Tx, userIDs []int64, update *pb.Update, chatID int64, out Pending) error {
	if len(userIDs) == 0 {
		return nil
	}
	ids := append([]int64(nil), userIDs...)
	sort.Slice(ids, func(i, j int) bool { return ids[i] < ids[j] })

	rows, err := tx.Query(ctx, `
		WITH locked AS (
			SELECT user_id FROM user_update_state
			WHERE user_id = ANY($1) ORDER BY user_id FOR UPDATE
		)
		UPDATE user_update_state s SET pts = s.pts + 1
		FROM locked WHERE s.user_id = locked.user_id
		RETURNING s.user_id, s.pts`, ids)
	if err != nil {
		return err
	}
	type up struct{ user, pts int64 }
	var bumped []up
	for rows.Next() {
		var u up
		if err := rows.Scan(&u.user, &u.pts); err != nil {
			rows.Close()
			return err
		}
		bumped = append(bumped, u)
	}
	rows.Close()
	if err := rows.Err(); err != nil {
		return err
	}

	kind := kindOf(update)
	date := s.now().Unix()
	batch := &pgx.Batch{}
	for _, u := range bumped {
		upd := proto.Clone(update).(*pb.Update)
		upd.Pts, upd.PtsCount, upd.Date = u.pts, 1, date
		payload, err := proto.Marshal(upd)
		if err != nil {
			return err
		}
		var chat any
		if chatID != 0 {
			chat = chatID
		}
		batch.Queue(`INSERT INTO user_updates (user_id, pts, kind, chat_id, payload) VALUES ($1,$2,$3,$4,$5)`,
			u.user, u.pts, kind, chat, payload)
		if out != nil {
			out[u.user] = append(out[u.user], upd)
		}
	}
	return tx.SendBatch(ctx, batch).Close()
}

// Publish pushes committed updates to connected devices. Losing a publish is
// harmless: devices recover through GetDifference.
func (s *Service) Publish(ctx context.Context, p Pending) {
	for user, ups := range p {
		b, err := proto.Marshal(&pb.UpdatesPush{Updates: ups})
		if err != nil {
			continue
		}
		s.Redis.Publish(ctx, UserChannel(user), b)
	}
}

// PublishEphemeral sends a pts=0 update (typing, status) to users.
func (s *Service) PublishEphemeral(ctx context.Context, userIDs []int64, u *pb.Update) {
	u.Pts, u.PtsCount, u.Date = 0, 0, s.now().Unix()
	b, err := proto.Marshal(&pb.UpdatesPush{Updates: []*pb.Update{u}})
	if err != nil {
		return
	}
	for _, id := range userIDs {
		s.Redis.Publish(ctx, UserChannel(id), b)
	}
}

// Register adds UpdatesService methods to the router.
func (s *Service) Register(r *rpc.Router) {
	rpc.Register(r, "/wasla.v1.UpdatesService/GetState", rpc.Private, s.GetState)
	rpc.Register(r, "/wasla.v1.UpdatesService/GetDifference", rpc.Private, s.GetDifference)
}

func (s *Service) GetState(ctx context.Context, c *rpc.Caller, _ *pb.GetStateRequest) (*pb.GetStateResponse, error) {
	var pts int64
	err := s.DB.QueryRow(ctx, `SELECT pts FROM user_update_state WHERE user_id = $1`, c.UserID()).Scan(&pts)
	if err != nil {
		return nil, err
	}
	return &pb.GetStateResponse{Pts: pts, Date: s.now().Unix()}, nil
}

func (s *Service) GetDifference(ctx context.Context, c *rpc.Caller, req *pb.GetDifferenceRequest) (*pb.GetDifferenceResponse, error) {
	limit := req.GetLimit()
	if limit <= 0 || limit > 1000 {
		limit = 500
	}
	var current, oldest int64
	err := s.DB.QueryRow(ctx, `
		SELECT s.pts, COALESCE((SELECT min(pts) FROM user_updates WHERE user_id = $1), s.pts + 1)
		FROM user_update_state s WHERE s.user_id = $1`, c.UserID()).Scan(&current, &oldest)
	if err != nil {
		return nil, err
	}
	// The log no longer holds everything after the client's pts.
	if req.GetPts() < oldest-1 && req.GetPts() < current {
		return &pb.GetDifferenceResponse{Pts: current, TooLong: true}, nil
	}
	rows, err := s.DB.Query(ctx, `
		SELECT payload FROM user_updates WHERE user_id = $1 AND pts > $2
		ORDER BY pts LIMIT $3`, c.UserID(), req.GetPts(), limit+1)
	if err != nil {
		return nil, err
	}
	defer rows.Close()
	resp := &pb.GetDifferenceResponse{Pts: req.GetPts()}
	for rows.Next() {
		var payload []byte
		if err := rows.Scan(&payload); err != nil {
			return nil, err
		}
		if int32(len(resp.Updates)) == limit {
			resp.HasMore = true
			break
		}
		u := &pb.Update{}
		if err := proto.Unmarshal(payload, u); err != nil {
			return nil, err
		}
		resp.Updates = append(resp.Updates, u)
		resp.Pts = u.Pts
	}
	return resp, rows.Err()
}

func (s *Service) now() time.Time {
	if s.Now != nil {
		return s.Now()
	}
	return time.Now()
}

// kindOf returns the Update oneof field number (stored in user_updates.kind).
func kindOf(u *pb.Update) int16 {
	m := u.ProtoReflect()
	od := m.Descriptor().Oneofs().ByName("kind")
	if f := m.WhichOneof(od); f != nil {
		return int16(f.Number())
	}
	return 0
}
