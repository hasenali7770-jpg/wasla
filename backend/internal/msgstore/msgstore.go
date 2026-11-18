// Package msgstore reads and writes rows of the messages table and converts
// them to and from wasla.v1.Message. Shared by messaging and chats; this is
// also the seam where storage moves to ScyllaDB later (ADR-004).
package msgstore

import (
	"context"
	"encoding/json"
	"fmt"
	"time"
	"unicode/utf16"

	"github.com/jackc/pgx/v5"
	"google.golang.org/protobuf/encoding/protojson"
	"google.golang.org/protobuf/proto"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/errs"
)

// Kind values are the MessageContent oneof field numbers (messages.kind).
const (
	KindText     int16 = 1
	KindPhoto    int16 = 2
	KindVideo    int16 = 3
	KindDocument int16 = 4
	KindVoice    int16 = 5
	KindLocation int16 = 6
	KindContact  int16 = 7
	KindService  int16 = 8
)

const (
	MaxTextLen    = 4096
	MaxEntities   = 100
	EditWindow    = 48 * time.Hour
	selectColumns = `chat_id, seq, sender_id, random_id, kind, text, entities, reply_to_seq, fwd, extra, created_at, edited_at, deleted_at, media_id`
)

// Row is one messages row.
type Row struct {
	ChatID, Seq, SenderID, RandomID int64
	Kind                            int16
	Text                            string
	Entities, Fwd, Extra            []byte
	ReplyTo                         *int64
	CreatedAt                       time.Time
	EditedAt, DeletedAt             *time.Time
	MediaID                         *int64
}

// New is a message to insert (content already validated).
type New struct {
	SenderID, RandomID int64
	Kind               int16
	Text               string
	Entities           []byte
	ReplyTo            int64
	Fwd                []byte
	Extra              []byte // location/contact/service JSON; for photo/document the Media JSON
	MediaID            int64
}

// Querier is satisfied by pgx.Tx and *pgxpool.Pool.
type Querier interface {
	Query(context.Context, string, ...any) (pgx.Rows, error)
	QueryRow(context.Context, string, ...any) pgx.Row
}

func scan(rows pgx.Rows) ([]Row, error) {
	defer rows.Close()
	var out []Row
	for rows.Next() {
		var r Row
		if err := rows.Scan(&r.ChatID, &r.Seq, &r.SenderID, &r.RandomID, &r.Kind, &r.Text, &r.Entities,
			&r.ReplyTo, &r.Fwd, &r.Extra, &r.CreatedAt, &r.EditedAt, &r.DeletedAt, &r.MediaID); err != nil {
			return nil, err
		}
		out = append(out, r)
	}
	return out, rows.Err()
}

// Insert allocates the next seq in the chat and stores the message. If the
// sender already sent random_id in this chat, the existing row is returned
// with created=false (idempotent retry).
func Insert(ctx context.Context, tx pgx.Tx, chatID int64, m New) (row Row, created bool, err error) {
	existing, err := query(ctx, tx, `SELECT `+selectColumns+` FROM messages
		WHERE chat_id = $1 AND sender_id = $2 AND random_id = $3`, chatID, m.SenderID, m.RandomID)
	if err != nil {
		return Row{}, false, err
	}
	if len(existing) == 1 {
		return existing[0], false, nil
	}
	var seq int64
	if err := tx.QueryRow(ctx, `UPDATE chats SET last_seq = last_seq + 1, last_message_at = now(), updated_at = now()
		WHERE id = $1 RETURNING last_seq`, chatID).Scan(&seq); err != nil {
		return Row{}, false, err
	}
	var reply any
	if m.ReplyTo != 0 {
		reply = m.ReplyTo
	}
	var mediaID any
	if m.MediaID != 0 {
		mediaID = m.MediaID
	}
	out, err := query(ctx, tx, `INSERT INTO messages (chat_id, seq, sender_id, random_id, kind, text, entities, reply_to_seq, fwd, extra, media_id)
		VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11) RETURNING `+selectColumns,
		chatID, seq, m.SenderID, m.RandomID, m.Kind, m.Text, nullJSON(m.Entities), reply, nullJSON(m.Fwd), nullJSON(m.Extra), mediaID)
	if err != nil {
		return Row{}, false, err
	}
	return out[0], true, nil
}

// Get loads specific messages (including tombstones) in seq order.
func Get(ctx context.Context, q Querier, chatID int64, seqs []int64) ([]Row, error) {
	return query(ctx, q, `SELECT `+selectColumns+` FROM messages
		WHERE chat_id = $1 AND seq = ANY($2) ORDER BY seq`, chatID, seqs)
}

// History returns visible messages for viewer: not deleted, not hidden by
// "delete for me", after the viewer's cleared_seq.
func History(ctx context.Context, q Querier, chatID, viewer, afterSeq, beforeSeq int64, newest bool, limit int) ([]Row, error) {
	order := "ASC"
	if newest {
		order = "DESC"
	}
	return query(ctx, q, `SELECT `+selectColumns+` FROM messages m
		WHERE m.chat_id = $1 AND m.seq > $2 AND m.seq < $3 AND m.deleted_at IS NULL
		  AND NOT EXISTS (SELECT 1 FROM message_hides h WHERE h.user_id = $4 AND h.chat_id = m.chat_id AND h.seq = m.seq)
		ORDER BY m.seq `+order+` LIMIT $5`, chatID, afterSeq, beforeSeq, viewer, limit)
}

// Latest returns the newest visible message for viewer, or nil.
func Latest(ctx context.Context, q Querier, chatID, viewer, clearedSeq int64) (*Row, error) {
	rows, err := History(ctx, q, chatID, viewer, clearedSeq, 1<<62, true, 1)
	if err != nil || len(rows) == 0 {
		return nil, err
	}
	return &rows[0], nil
}

// ToProto converts a row. Tombstones come back with empty content.
func ToProto(r Row, viewer int64, pinned bool) (*pb.Message, error) {
	m := &pb.Message{ChatId: r.ChatID, Seq: r.Seq, SenderId: r.SenderID, Date: r.CreatedAt.Unix(), Pinned: pinned}
	if r.EditedAt != nil {
		m.EditDate = r.EditedAt.Unix()
	}
	if r.ReplyTo != nil {
		m.ReplyToSeq = *r.ReplyTo
	}
	if r.SenderID == viewer {
		m.RandomId = r.RandomID
	}
	if r.DeletedAt != nil {
		return m, nil
	}
	if len(r.Fwd) > 0 {
		var f pb.ForwardInfo
		if err := protojson.Unmarshal(r.Fwd, &f); err != nil {
			return nil, err
		}
		m.Forward = &f
	}
	c := &pb.MessageContent{}
	switch r.Kind {
	case KindText:
		ft, err := formatted(r.Text, r.Entities)
		if err != nil {
			return nil, err
		}
		c.Kind = &pb.MessageContent_Text{Text: &pb.TextContent{Text: ft}}
	case KindLocation:
		var l pb.LocationContent
		if err := protojson.Unmarshal(r.Extra, &l); err != nil {
			return nil, err
		}
		c.Kind = &pb.MessageContent_Location{Location: &l}
	case KindContact:
		var ct pb.ContactContent
		if err := protojson.Unmarshal(r.Extra, &ct); err != nil {
			return nil, err
		}
		c.Kind = &pb.MessageContent_Contact{Contact: &ct}
	case KindPhoto, KindDocument:
		var md pb.Media
		if err := protojson.Unmarshal(r.Extra, &md); err != nil {
			return nil, err
		}
		var caption *pb.FormattedText
		if r.Text != "" {
			ft, err := formatted(r.Text, r.Entities)
			if err != nil {
				return nil, err
			}
			caption = ft
		}
		if r.Kind == KindPhoto {
			c.Kind = &pb.MessageContent_Photo{Photo: &pb.PhotoContent{Media: &md, Caption: caption}}
		} else {
			c.Kind = &pb.MessageContent_Document{Document: &pb.DocumentContent{Media: &md, Caption: caption}}
		}
	case KindService:
		var sc pb.ServiceContent
		if err := protojson.Unmarshal(r.Extra, &sc); err != nil {
			return nil, err
		}
		c.Kind = &pb.MessageContent_Service{Service: &sc}
	default:
		// Video and voice arrive in a later update.
		return nil, fmt.Errorf("msgstore: unsupported kind %d", r.Kind)
	}
	m.Content = c
	return m, nil
}

func formatted(text string, entities []byte) (*pb.FormattedText, error) {
	ft := &pb.FormattedText{Text: text}
	if len(entities) == 0 {
		return ft, nil
	}
	var raw []json.RawMessage
	if err := json.Unmarshal(entities, &raw); err != nil {
		return nil, err
	}
	for _, e := range raw {
		var te pb.TextEntity
		if err := protojson.Unmarshal(e, &te); err != nil {
			return nil, err
		}
		ft.Entities = append(ft.Entities, &te)
	}
	return ft, nil
}

// EncodeText validates a FormattedText and returns its text and entities JSON.
func EncodeText(ft *pb.FormattedText) (string, []byte, error) {
	text := ft.GetText()
	n := len([]rune(text))
	if n == 0 {
		return "", nil, errs.Invalid("message is empty")
	}
	if n > MaxTextLen {
		return "", nil, errs.New(pb.ErrorCode_ERROR_CODE_MESSAGE_TOO_LONG, "message longer than %d characters", MaxTextLen)
	}
	ents := ft.GetEntities()
	if len(ents) == 0 {
		return text, nil, nil
	}
	if len(ents) > MaxEntities {
		return "", nil, errs.Invalid("too many formatting entities")
	}
	u16 := int32(len(utf16.Encode([]rune(text))))
	parts := make([]json.RawMessage, 0, len(ents))
	for _, e := range ents {
		if e.GetType() == pb.TextEntityType_TEXT_ENTITY_TYPE_UNSPECIFIED || e.GetOffset() < 0 || e.GetLength() <= 0 ||
			e.GetOffset()+e.GetLength() > u16 {
			return "", nil, errs.Invalid("entity out of range")
		}
		b, err := protojson.Marshal(e)
		if err != nil {
			return "", nil, err
		}
		parts = append(parts, b)
	}
	b, err := json.Marshal(parts)
	return text, b, err
}

// MaxCaptionLen is the longest photo/file caption.
const MaxCaptionLen = 1024

// EncodeCaption validates an optional caption.
func EncodeCaption(ft *pb.FormattedText) (string, []byte, error) {
	if ft == nil || ft.GetText() == "" {
		return "", nil, nil
	}
	if len([]rune(ft.GetText())) > MaxCaptionLen {
		return "", nil, errs.New(pb.ErrorCode_ERROR_CODE_MESSAGE_TOO_LONG, "caption longer than %d characters", MaxCaptionLen)
	}
	return EncodeText(ft)
}

// EncodeJSON stores a content sub-message (location, contact, service) as JSON.
func EncodeJSON(m proto.Message) ([]byte, error) { return protojson.Marshal(m) }

func nullJSON(b []byte) any {
	if len(b) == 0 {
		return nil
	}
	return b
}

// query runs a SELECT returning selectColumns and scans the rows.
func query(ctx context.Context, q Querier, sql string, args ...any) ([]Row, error) {
	rows, err := q.Query(ctx, sql, args...)
	if err != nil {
		return nil, err
	}
	return scan(rows)
}
