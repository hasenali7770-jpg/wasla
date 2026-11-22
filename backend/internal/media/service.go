package media

import (
	"bytes"
	"context"
	"crypto/rand"
	"crypto/sha256"
	"encoding/base64"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"image"
	"image/jpeg"
	_ "image/png" // decoders for photo processing
	"io"
	"log/slog"
	"path"
	"strings"
	"time"
	"unicode"
	"unicode/utf8"

	"github.com/jackc/pgx/v5"
	"github.com/jackc/pgx/v5/pgxpool"
	xdraw "golang.org/x/image/draw"
	_ "golang.org/x/image/webp"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/chats"
	"wasla/backend/internal/platform/db"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/ratelimit"
	"wasla/backend/internal/platform/rpc"
	"wasla/backend/internal/updates"
)

// S3 multipart rules: every part but the last is at least 5 MiB, and an
// upload has at most 10,000 parts. Files up to 5 MiB use one plain PUT.
const (
	minPartSize = 5 << 20
	maxParts    = 10000
	firstURLs   = 50
)

// Config tunes the media service.
type Config struct {
	MaxUploadBytes int64         // any file (Lean MVP: 500 MB; protocol max 2 GiB)
	MaxPhotoBytes  int64         // photos are compressed by the app first
	SyncScanLimit  int64         // files up to this size are checked against the blocklist before they can be sent
	URLTTL         time.Duration // signed upload/download URLs
}

func DefaultConfig() Config {
	return Config{MaxUploadBytes: 500 << 20, MaxPhotoBytes: 20 << 20, SyncScanLimit: 20 << 20, URLTTL: time.Hour}
}

// Alerter pages the on-call moderator (moderation.WebhookAlerter).
type Alerter interface {
	Alert(ctx context.Context, text string) error
}

// Service implements wasla.v1.MediaService.
type Service struct {
	DB      *pgxpool.Pool
	Store   *Storage // nil: media disabled (RPCs return UNAVAILABLE)
	IDs     chats.IDGen
	Updates *updates.Service
	Limits  *ratelimit.Limiter
	Alert   Alerter
	Cfg     Config
	Log     *slog.Logger
}

func (s *Service) Register(r *rpc.Router) {
	const p = "/wasla.v1.MediaService/"
	rpc.Register(r, p+"CreateUpload", rpc.Private, s.CreateUpload)
	rpc.Register(r, p+"GetUploadPartUrls", rpc.Private, s.GetUploadPartUrls)
	rpc.Register(r, p+"CompleteUpload", rpc.Private, s.CompleteUpload)
	rpc.Register(r, p+"AbortUpload", rpc.Private, s.AbortUpload)
	rpc.Register(r, p+"GetDownloadUrl", rpc.Private, s.GetDownloadUrl)
}

// Row is a media_files row.
type Row struct {
	ID, OwnerID       int64
	Kind              pb.MediaKind
	Mime, Key, Name   string
	Size              int64
	Width, Height     int32
	DurationMs        int32
	Thumbhash, Wave   []byte
	Variants          []Variant
	Status            pb.MediaStatus
	UploadToken, S3ID string
}

// Variant is a server-made rendition stored next to the original.
type Variant struct {
	Type string `json:"type"`
	Key  string `json:"key"`
	W    int32  `json:"w"`
	H    int32  `json:"h"`
	Size int64  `json:"size"`
}

const rowColumns = `id, owner_id, kind, mime_type, storage_key, file_name, size_bytes, COALESCE(width,0), COALESCE(height,0),
	COALESCE(duration_ms,0), thumbhash, waveform, variants, status, COALESCE(upload_token,''), COALESCE(s3_upload_id,'')`

// Querier is satisfied by *pgxpool.Pool and pgx.Tx.
type Querier interface {
	QueryRow(context.Context, string, ...any) pgx.Row
}

// Load reads one media row.
func Load(ctx context.Context, q Querier, where string, args ...any) (*Row, error) {
	r := &Row{}
	var kind, status int16
	var variants []byte
	err := q.QueryRow(ctx, `SELECT `+rowColumns+` FROM media_files WHERE `+where, args...).Scan(
		&r.ID, &r.OwnerID, &kind, &r.Mime, &r.Key, &r.Name, &r.Size, &r.Width, &r.Height, &r.DurationMs,
		&r.Thumbhash, &r.Wave, &variants, &status, &r.UploadToken, &r.S3ID)
	if db.NoRows(err) {
		return nil, errs.NotFound("file not found")
	}
	if err != nil {
		return nil, err
	}
	r.Kind, r.Status = pb.MediaKind(kind), pb.MediaStatus(status)
	_ = json.Unmarshal(variants, &r.Variants)
	return r, nil
}

// Proto converts a row for clients (storage keys stay private).
func (r *Row) Proto() *pb.Media {
	m := &pb.Media{Id: r.ID, Kind: r.Kind, MimeType: r.Mime, SizeBytes: r.Size, FileName: r.Name,
		Width: r.Width, Height: r.Height, DurationMs: r.DurationMs, Thumbhash: r.Thumbhash, Waveform: r.Wave, Status: r.Status}
	for _, v := range r.Variants {
		m.Variants = append(m.Variants, &pb.MediaVariant{Type: v.Type, Width: v.W, Height: v.H, SizeBytes: v.Size})
	}
	return m
}

var photoMimes = map[string]bool{"image/jpeg": true, "image/png": true, "image/webp": true}

func (s *Service) ready() error {
	if s.Store == nil {
		return errs.New(pb.ErrorCode_ERROR_CODE_UNAVAILABLE, "file sharing is not configured on this server")
	}
	return nil
}

func partSize(size int64) int64 {
	ps := int64(minPartSize)
	if need := (size + maxParts - 1) / maxParts; need > ps {
		ps = (need + (1<<20 - 1)) &^ (1<<20 - 1) // round up to whole MiB
	}
	return ps
}

// cleanName keeps a safe display name: no paths, no control characters.
func cleanName(n string) string {
	n = path.Base(strings.ReplaceAll(n, `\`, "/"))
	n = strings.Map(func(r rune) rune {
		if unicode.IsControl(r) || r == unicode.ReplacementChar {
			return -1
		}
		return r
	}, n)
	if n == "." || n == "/" {
		n = ""
	}
	if utf8.RuneCountInString(n) > 200 {
		n = string([]rune(n)[:200])
	}
	return n
}

func (s *Service) CreateUpload(ctx context.Context, c *rpc.Caller, req *pb.CreateUploadRequest) (*pb.CreateUploadResponse, error) {
	if err := s.ready(); err != nil {
		return nil, err
	}
	me := c.UserID()
	if s.Limits != nil {
		ok, retry, err := s.Limits.Allow(ctx, fmt.Sprintf("upload:%d", me), 200, time.Hour)
		if err != nil {
			return nil, err
		}
		if !ok {
			return nil, errs.RateLimited(int32(retry.Seconds()) + 1)
		}
	}
	size, mime := req.GetSizeBytes(), strings.ToLower(strings.TrimSpace(req.GetMimeType()))
	switch req.GetKind() {
	case pb.MediaKind_MEDIA_KIND_PHOTO:
		if !photoMimes[mime] {
			return nil, errs.Invalid("photos must be JPEG, PNG or WebP")
		}
		if size > s.Cfg.MaxPhotoBytes {
			return nil, errs.New(pb.ErrorCode_ERROR_CODE_FILE_TOO_LARGE, "photo too large")
		}
	case pb.MediaKind_MEDIA_KIND_DOCUMENT:
		if mime == "" || len(mime) > 127 {
			mime = "application/octet-stream"
		}
	default:
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_UNIMPLEMENTED, "video and voice messages arrive in a later update")
	}
	if size <= 0 {
		return nil, errs.Invalid("empty file")
	}
	if size > s.Cfg.MaxUploadBytes {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_FILE_TOO_LARGE, "files can be up to %d MB", s.Cfg.MaxUploadBytes>>20)
	}
	id, err := s.IDs.Next()
	if err != nil {
		return nil, err
	}
	key := fmt.Sprintf("m/%d/%d/orig", id>>40, id)
	tok := make([]byte, 24)
	if _, err := rand.Read(tok); err != nil {
		return nil, err
	}
	token := base64.RawURLEncoding.EncodeToString(tok)
	resp := &pb.CreateUploadResponse{UploadId: token, MediaId: id}
	exp := time.Now().Add(s.Cfg.URLTTL).Unix()
	var s3id any
	if size <= minPartSize {
		u, err := s.Store.PresignPut(ctx, key, s.Cfg.URLTTL)
		if err != nil {
			return nil, err
		}
		resp.PartSizeBytes, resp.PartCount = int32(size), 1
		resp.Urls = []*pb.UploadPartUrl{{PartNumber: 1, Url: u, ExpiresAt: exp}}
	} else {
		ps := partSize(size)
		uid, err := s.Store.NewMultipart(ctx, key, mime)
		if err != nil {
			return nil, err
		}
		s3id = uid
		resp.PartSizeBytes, resp.PartCount = int32(ps), int32((size+ps-1)/ps)
		for n := 1; n <= int(resp.PartCount) && n <= firstURLs; n++ {
			u, err := s.Store.PresignPart(ctx, key, uid, n, s.Cfg.URLTTL)
			if err != nil {
				return nil, err
			}
			resp.Urls = append(resp.Urls, &pb.UploadPartUrl{PartNumber: int32(n), Url: u, ExpiresAt: exp})
		}
	}
	_, err = s.DB.Exec(ctx, `INSERT INTO media_files (id, owner_id, kind, mime_type, size_bytes, storage_key, file_name,
		width, height, duration_ms, status, upload_token, s3_upload_id)
		VALUES ($1,$2,$3,$4,$5,$6,$7,NULLIF($8,0),NULLIF($9,0),NULLIF($10,0),1,$11,$12)`,
		id, me, int16(req.GetKind()), mime, size, key, cleanName(req.GetFileName()),
		req.GetWidth(), req.GetHeight(), req.GetDurationMs(), token, s3id)
	if err != nil {
		return nil, err
	}
	return resp, nil
}

func (s *Service) pending(ctx context.Context, me int64, token string) (*Row, error) {
	r, err := Load(ctx, s.DB, `upload_token = $1 AND owner_id = $2 AND status = 1`, token, me)
	if errs.Is(err, pb.ErrorCode_ERROR_CODE_NOT_FOUND) {
		return nil, errs.NotFound("upload not found or already finished")
	}
	return r, err
}

func (s *Service) GetUploadPartUrls(ctx context.Context, c *rpc.Caller, req *pb.GetUploadPartUrlsRequest) (*pb.GetUploadPartUrlsResponse, error) {
	if err := s.ready(); err != nil {
		return nil, err
	}
	r, err := s.pending(ctx, c.UserID(), req.GetUploadId())
	if err != nil {
		return nil, err
	}
	if len(req.GetPartNumbers()) > 100 {
		return nil, errs.Invalid("at most 100 parts per call")
	}
	exp := time.Now().Add(s.Cfg.URLTTL).Unix()
	resp := &pb.GetUploadPartUrlsResponse{}
	if r.S3ID == "" {
		u, err := s.Store.PresignPut(ctx, r.Key, s.Cfg.URLTTL)
		if err != nil {
			return nil, err
		}
		resp.Urls = []*pb.UploadPartUrl{{PartNumber: 1, Url: u, ExpiresAt: exp}}
		return resp, nil
	}
	ps := partSize(r.Size)
	count := int32((r.Size + ps - 1) / ps)
	for _, n := range req.GetPartNumbers() {
		if n < 1 || n > count {
			return nil, errs.Invalid("part %d out of range 1-%d", n, count)
		}
		u, err := s.Store.PresignPart(ctx, r.Key, r.S3ID, int(n), s.Cfg.URLTTL)
		if err != nil {
			return nil, err
		}
		resp.Urls = append(resp.Urls, &pb.UploadPartUrl{PartNumber: n, Url: u, ExpiresAt: exp})
	}
	done, err := s.Store.ListParts(ctx, r.Key, r.S3ID)
	if err != nil {
		return nil, err
	}
	for _, p := range done {
		resp.UploadedParts = append(resp.UploadedParts, &pb.CompletedPart{PartNumber: int32(p.Number), Etag: p.ETag})
	}
	return resp, nil
}

func (s *Service) CompleteUpload(ctx context.Context, c *rpc.Caller, req *pb.CompleteUploadRequest) (*pb.CompleteUploadResponse, error) {
	if err := s.ready(); err != nil {
		return nil, err
	}
	r, err := s.pending(ctx, c.UserID(), req.GetUploadId())
	if err != nil {
		return nil, err
	}
	if r.S3ID != "" {
		parts := make([]Part, 0, len(req.GetParts()))
		for _, p := range req.GetParts() {
			parts = append(parts, Part{Number: int(p.GetPartNumber()), ETag: p.GetEtag()})
		}
		if len(parts) == 0 {
			if parts, err = s.Store.ListParts(ctx, r.Key, r.S3ID); err != nil {
				return nil, err
			}
		}
		if err := s.Store.CompleteMultipart(ctx, r.Key, r.S3ID, parts); err != nil {
			return nil, errs.New(pb.ErrorCode_ERROR_CODE_UPLOAD_INCOMPLETE, "upload incomplete: %v", err)
		}
	}
	got, err := s.Store.Size(ctx, r.Key)
	if err != nil || got != r.Size {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_UPLOAD_INCOMPLETE, "uploaded %d of %d bytes", got, r.Size)
	}
	if th := req.GetThumbhash(); len(th) > 0 && len(th) <= 64 {
		r.Thumbhash = th
	}
	if wf := req.GetWaveform(); len(wf) > 0 && len(wf) <= 128 {
		r.Wave = wf
	}
	if r.Size <= s.Cfg.SyncScanLimit {
		if err := s.processNow(ctx, r); err != nil {
			return nil, err
		}
	} else {
		if err := s.markReady(ctx, r, nil); err != nil {
			return nil, err
		}
		go s.scanLater(r.ID) // big files: checked in the background, taken down on a match
	}
	return &pb.CompleteUploadResponse{Media: r.Proto()}, nil
}

// processNow hashes the file, checks the blocklist and makes photo
// thumbnails, all before anyone can receive it.
func (s *Service) processNow(ctx context.Context, r *Row) error {
	rc, err := s.Store.Open(ctx, r.Key)
	if err != nil {
		return err
	}
	data, err := io.ReadAll(io.LimitReader(rc, r.Size+1))
	rc.Close()
	if err != nil {
		return err
	}
	sum := sha256.Sum256(data)
	if reason, hit, err := s.blocked(ctx, sum[:]); err != nil {
		return err
	} else if hit {
		s.reject(ctx, r, sum[:], reason)
		return errs.Denied("this file cannot be shared on Wasla")
	}
	if r.Kind == pb.MediaKind_MEDIA_KIND_PHOTO {
		img, _, err := image.Decode(bytes.NewReader(data))
		if err != nil {
			s.fail(ctx, r)
			return errs.Invalid("not a valid image")
		}
		b := img.Bounds()
		r.Width, r.Height = int32(b.Dx()), int32(b.Dy())
		for _, v := range []struct {
			name string
			max  int
		}{{"thumb_s", 90}, {"thumb_m", 320}} {
			vr, err := s.thumbnail(ctx, r, img, v.name, v.max)
			if err != nil {
				return err
			}
			r.Variants = append(r.Variants, vr)
		}
	}
	return s.markReady(ctx, r, sum[:])
}

func (s *Service) thumbnail(ctx context.Context, r *Row, img image.Image, name string, maxSide int) (Variant, error) {
	b := img.Bounds()
	w, h := b.Dx(), b.Dy()
	if w > maxSide || h > maxSide {
		if w >= h {
			h, w = max(1, h*maxSide/w), maxSide
		} else {
			w, h = max(1, w*maxSide/h), maxSide
		}
	}
	dst := image.NewRGBA(image.Rect(0, 0, w, h))
	xdraw.CatmullRom.Scale(dst, dst.Bounds(), img, b, xdraw.Over, nil)
	var buf bytes.Buffer
	if err := jpeg.Encode(&buf, dst, &jpeg.Options{Quality: 80}); err != nil {
		return Variant{}, err
	}
	key := strings.TrimSuffix(r.Key, "orig") + name
	if err := s.Store.Put(ctx, key, "image/jpeg", bytes.NewReader(buf.Bytes()), int64(buf.Len())); err != nil {
		return Variant{}, err
	}
	return Variant{Type: name, Key: key, W: int32(w), H: int32(h), Size: int64(buf.Len())}, nil
}

func (s *Service) markReady(ctx context.Context, r *Row, sum []byte) error {
	variants, _ := json.Marshal(r.Variants)
	if r.Variants == nil {
		variants = []byte("[]")
	}
	r.Status = pb.MediaStatus_MEDIA_STATUS_READY
	_, err := s.DB.Exec(ctx, `UPDATE media_files SET status = 3, ready_at = now(), upload_token = NULL, s3_upload_id = NULL,
		sha256 = COALESCE($2, sha256), width = NULLIF($3,0), height = NULLIF($4,0), thumbhash = $5, waveform = $6, variants = $7
		WHERE id = $1`, r.ID, nilIfEmpty(sum), r.Width, r.Height, nilIfEmpty(r.Thumbhash), nilIfEmpty(r.Wave), variants)
	return err
}

func (s *Service) fail(ctx context.Context, r *Row) {
	_ = s.Store.Remove(ctx, r.Key)
	_, _ = s.DB.Exec(ctx, `UPDATE media_files SET status = 4, upload_token = NULL, s3_upload_id = NULL WHERE id = $1`, r.ID)
}

func (s *Service) blocked(ctx context.Context, sum []byte) (pb.ReportReason, bool, error) {
	var reason int16
	err := s.DB.QueryRow(ctx, `SELECT reason FROM media_blocklist WHERE sha256 = $1`, sum).Scan(&reason)
	if db.NoRows(err) {
		return 0, false, nil
	}
	return pb.ReportReason(reason), err == nil, err
}

// reject deletes a blocklisted file and opens a critical automatic report
// on the uploader, then pages the on-call moderator.
func (s *Service) reject(ctx context.Context, r *Row, sum []byte, reason pb.ReportReason) {
	s.fail(ctx, r)
	ev, _ := json.Marshal(map[string]any{"media_id": r.ID, "sha256": hex.EncodeToString(sum), "file_name": r.Name, "mime": r.Mime})
	var reportID int64
	err := s.DB.QueryRow(ctx, `INSERT INTO reports (reporter_id, source, target_user_id, reason, comment, evidence, priority, due_at)
		VALUES (NULL, 2, $1, $2, $3, $4, 1, now() + interval '1 hour') RETURNING id`,
		r.OwnerID, int16(reason), "Automatic: uploaded file matches the known illegal media list", ev).Scan(&reportID)
	if err != nil {
		s.Log.Error("blocklist report failed", "media_id", r.ID, "err", err)
		return
	}
	s.Log.Warn("blocklisted media rejected", "media_id", r.ID, "user_id", r.OwnerID, "report_id", reportID)
	if s.Alert != nil {
		go func() {
			actx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
			defer cancel()
			_ = s.Alert.Alert(actx, fmt.Sprintf("🚨 Wasla: blocklisted file uploaded — automatic critical report #%d. Open the admin panel: /admin/reports/%d", reportID, reportID))
		}()
	}
}

// scanLater checks a large file after it was accepted; on a match every
// message carrying it is deleted for everyone.
func (s *Service) scanLater(id int64) {
	ctx, cancel := context.WithTimeout(context.Background(), 30*time.Minute)
	defer cancel()
	r, err := Load(ctx, s.DB, `id = $1`, id)
	if err != nil {
		return
	}
	rc, err := s.Store.Open(ctx, r.Key)
	if err != nil {
		s.Log.Error("background scan: open", "media_id", id, "err", err)
		return
	}
	h := sha256.New()
	_, err = io.Copy(h, rc)
	rc.Close()
	if err != nil {
		s.Log.Error("background scan: read", "media_id", id, "err", err)
		return
	}
	sum := h.Sum(nil)
	reason, hit, err := s.blocked(ctx, sum)
	if err != nil {
		return
	}
	if !hit {
		_, _ = s.DB.Exec(ctx, `UPDATE media_files SET sha256 = $2 WHERE id = $1`, id, sum)
		return
	}
	s.reject(ctx, r, sum, reason)
	if err := s.takedownMessages(ctx, id); err != nil {
		s.Log.Error("background scan: takedown", "media_id", id, "err", err)
	}
}

// TakedownByHash removes every stored file with this SHA-256 (called when
// moderators add it to the blocklist): the files are deleted, every message
// carrying them disappears for everyone, and each uploader gets an automatic
// critical report.
func (s *Service) TakedownByHash(ctx context.Context, sum []byte, reason pb.ReportReason) error {
	rows, err := s.DB.Query(ctx, `SELECT id FROM media_files WHERE sha256 = $1 AND status = 3`, sum)
	if err != nil {
		return err
	}
	var ids []int64
	for rows.Next() {
		var id int64
		if err := rows.Scan(&id); err != nil {
			rows.Close()
			return err
		}
		ids = append(ids, id)
	}
	rows.Close()
	for _, id := range ids {
		r, err := Load(ctx, s.DB, `id = $1`, id)
		if err != nil {
			return err
		}
		if s.Store != nil {
			s.reject(ctx, r, sum, reason)
		}
		if err := s.takedownMessages(ctx, id); err != nil {
			return err
		}
	}
	return nil
}

// takedownMessages tombstones every message that carries the media.
func (s *Service) takedownMessages(ctx context.Context, mediaID int64) error {
	rows, err := s.DB.Query(ctx, `SELECT chat_id, seq FROM messages WHERE media_id = $1 AND deleted_at IS NULL`, mediaID)
	if err != nil {
		return err
	}
	byChat := map[int64][]int64{}
	for rows.Next() {
		var c, sq int64
		if err := rows.Scan(&c, &sq); err != nil {
			rows.Close()
			return err
		}
		byChat[c] = append(byChat[c], sq)
	}
	rows.Close()
	for chatID, seqs := range byChat {
		pending := updates.Pending{}
		err := db.InTx(ctx, s.DB, func(tx pgx.Tx) error {
			if _, err := tx.Exec(ctx, `UPDATE messages SET deleted_at = now(), text = '', entities = NULL, media_id = NULL, fwd = NULL, extra = NULL
				WHERE chat_id = $1 AND seq = ANY($2)`, chatID, seqs); err != nil {
				return err
			}
			members, err := chats.MemberIDs(ctx, tx, chatID)
			if err != nil {
				return err
			}
			return s.Updates.Append(ctx, tx, members, &pb.Update{Kind: &pb.Update_MessagesDeleted{
				MessagesDeleted: &pb.MessagesDeleted{ChatId: chatID, Seqs: seqs}}}, chatID, pending)
		})
		if err != nil {
			return err
		}
		s.Updates.Publish(ctx, pending)
	}
	return nil
}

func (s *Service) AbortUpload(ctx context.Context, c *rpc.Caller, req *pb.AbortUploadRequest) (*pb.AbortUploadResponse, error) {
	if err := s.ready(); err != nil {
		return nil, err
	}
	r, err := s.pending(ctx, c.UserID(), req.GetUploadId())
	if err != nil {
		return nil, err
	}
	if r.S3ID != "" {
		_ = s.Store.AbortMultipart(ctx, r.Key, r.S3ID)
	} else {
		_ = s.Store.Remove(ctx, r.Key)
	}
	if _, err := s.DB.Exec(ctx, `DELETE FROM media_files WHERE id = $1`, r.ID); err != nil {
		return nil, err
	}
	return &pb.AbortUploadResponse{}, nil
}

// GetDownloadUrl checks that the caller may see the file through the given
// context (a message, a profile or a chat photo), then signs a URL.
func (s *Service) GetDownloadUrl(ctx context.Context, c *rpc.Caller, req *pb.GetDownloadUrlRequest) (*pb.GetDownloadUrlResponse, error) {
	if err := s.ready(); err != nil {
		return nil, err
	}
	me := c.UserID()
	r, err := Load(ctx, s.DB, `id = $1`, req.GetMediaId())
	if err != nil {
		return nil, err
	}
	if r.Status != pb.MediaStatus_MEDIA_STATUS_READY {
		return nil, errs.NotFound("file not available")
	}
	if r.OwnerID != me {
		if err := s.canSee(ctx, me, r.ID, req); err != nil {
			return nil, err
		}
	}
	key, name := r.Key, ""
	if v := req.GetVariant(); v != "" {
		key = ""
		for _, x := range r.Variants {
			if x.Type == v {
				key = x.Key
			}
		}
		if key == "" {
			return nil, errs.NotFound("no %s version of this file", v)
		}
	} else if r.Kind == pb.MediaKind_MEDIA_KIND_DOCUMENT {
		name = r.Name
	}
	u, err := s.Store.PresignGet(ctx, key, name, s.Cfg.URLTTL)
	if err != nil {
		return nil, err
	}
	return &pb.GetDownloadUrlResponse{Url: u, ExpiresAt: time.Now().Add(s.Cfg.URLTTL).Unix()}, nil
}

func (s *Service) canSee(ctx context.Context, me, mediaID int64, req *pb.GetDownloadUrlRequest) error {
	var ok bool
	var err error
	switch k := req.GetContext().(type) {
	case *pb.GetDownloadUrlRequest_Message:
		m, merr := chats.Membership(ctx, s.DB, k.Message.GetChatId(), me)
		if merr != nil {
			return errs.NotFound("file not found")
		}
		err = s.DB.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM messages WHERE chat_id = $1 AND seq = $2 AND media_id = $3
			AND deleted_at IS NULL AND seq > $4)`, m.ChatID, k.Message.GetSeq(), mediaID, m.ClearedSeq).Scan(&ok)
	case *pb.GetDownloadUrlRequest_UserId:
		// Profile photos follow the owner's PROFILE_PHOTO privacy rule.
		err = s.DB.QueryRow(ctx, `
			SELECT EXISTS (SELECT 1 FROM users u WHERE u.id = $1 AND u.deleted_at IS NULL
			  AND (u.photo_id = $2 OR EXISTS (SELECT 1 FROM profile_photos p WHERE p.user_id = $1 AND p.media_id = $2))
			  AND NOT EXISTS (SELECT 1 FROM user_blocks b WHERE b.user_id = $1 AND b.blocked_user_id = $3)
			  AND COALESCE((SELECT rule FROM privacy_rules WHERE user_id = $1 AND key = 3), 1) <> 3
			  AND (COALESCE((SELECT rule FROM privacy_rules WHERE user_id = $1 AND key = 3), 1) <> 2
			       OR EXISTS (SELECT 1 FROM contacts ct WHERE ct.owner_id = $1 AND ct.contact_user_id = $3)))`,
			k.UserId, mediaID, me).Scan(&ok)
	case *pb.GetDownloadUrlRequest_ChatId:
		if _, merr := chats.Membership(ctx, s.DB, k.ChatId, me); merr != nil {
			return errs.NotFound("file not found")
		}
		err = s.DB.QueryRow(ctx, `SELECT EXISTS (SELECT 1 FROM chats WHERE id = $1 AND photo_id = $2)`, k.ChatId, mediaID).Scan(&ok)
	default:
		return errs.Invalid("say where the file was seen (message, user or chat)")
	}
	if err != nil {
		return err
	}
	if !ok {
		return errs.NotFound("file not found")
	}
	return nil
}

func nilIfEmpty(b []byte) any {
	if len(b) == 0 {
		return nil
	}
	return b
}
