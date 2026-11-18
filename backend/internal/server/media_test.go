package server

import (
	"bytes"
	"context"
	"crypto/rand"
	"crypto/sha256"
	"image"
	"image/color"
	"image/jpeg"
	"io"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/johannesboyne/gofakes3"
	"github.com/johannesboyne/gofakes3/backend/s3mem"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/media"
	"wasla/backend/internal/moderation"
)

const (
	mCreateUpload   = "/wasla.v1.MediaService/CreateUpload"
	mPartUrls       = "/wasla.v1.MediaService/GetUploadPartUrls"
	mCompleteUpload = "/wasla.v1.MediaService/CompleteUpload"
	mDownloadURL    = "/wasla.v1.MediaService/GetDownloadUrl"
	mSetPhoto       = "/wasla.v1.UsersService/SetProfilePhoto"
	mSetPrivacy     = "/wasla.v1.UsersService/SetPrivacy"
)

// withFakeS3 runs an in-memory S3 server for the test.
func withFakeS3(t *testing.T) func(*Deps) {
	t.Helper()
	ts := httptest.NewServer(gofakes3.New(s3mem.New()).Server())
	t.Cleanup(ts.Close)
	st, err := media.NewStorage(context.Background(), media.StorageConfig{
		Endpoint: strings.TrimPrefix(ts.URL, "http://"), AccessKey: "test", SecretKey: "testtesttest", Bucket: "wasla-media",
	})
	if err != nil {
		t.Fatal(err)
	}
	return func(d *Deps) { d.Storage = st }
}

func jpegBytes(t *testing.T, w, h int) []byte {
	t.Helper()
	img := image.NewRGBA(image.Rect(0, 0, w, h))
	for x := 0; x < w; x++ {
		for y := 0; y < h; y++ {
			img.Set(x, y, color.RGBA{uint8(x), uint8(y), 120, 255})
		}
	}
	var buf bytes.Buffer
	if err := jpeg.Encode(&buf, img, nil); err != nil {
		t.Fatal(err)
	}
	return buf.Bytes()
}

func httpPut(t *testing.T, url string, body []byte) string {
	t.Helper()
	req, _ := http.NewRequest(http.MethodPut, url, bytes.NewReader(body))
	resp, err := http.DefaultClient.Do(req)
	if err != nil {
		t.Fatal(err)
	}
	resp.Body.Close()
	if resp.StatusCode != 200 {
		t.Fatalf("PUT %d", resp.StatusCode)
	}
	return resp.Header.Get("ETag")
}

func httpGet(t *testing.T, url string) []byte {
	t.Helper()
	resp, err := http.Get(url)
	if err != nil {
		t.Fatal(err)
	}
	defer resp.Body.Close()
	b, _ := io.ReadAll(resp.Body)
	if resp.StatusCode != 200 {
		t.Fatalf("GET %d: %s", resp.StatusCode, b)
	}
	return b
}

// upload sends data through the real upload protocol and returns the media.
func upload(t *testing.T, c *client, kind pb.MediaKind, mime, name string, data []byte) (*pb.Media, *pb.Error) {
	t.Helper()
	var cr pb.CreateUploadResponse
	c.mustCall(mCreateUpload, &pb.CreateUploadRequest{Kind: kind, MimeType: mime, SizeBytes: int64(len(data)), FileName: name}, &cr)
	ps := int(cr.PartSizeBytes)
	var parts []*pb.CompletedPart
	for _, u := range cr.Urls {
		start := (int(u.PartNumber) - 1) * ps
		end := min(start+ps, len(data))
		parts = append(parts, &pb.CompletedPart{PartNumber: u.PartNumber, Etag: httpPut(t, u.Url, data[start:end])})
	}
	var done pb.CompleteUploadResponse
	if err := c.call(mCompleteUpload, &pb.CompleteUploadRequest{UploadId: cr.UploadId, Parts: parts, Thumbhash: []byte{1, 2, 3}}, &done); err != nil {
		return nil, err
	}
	return done.Media, nil
}

func TestPhotoSendAndDownload(t *testing.T) {
	e := newEnv(t, withFakeS3(t))
	ali, _, aliID := e.signUp("+9647701200001", "Ali")
	sara, _, saraID := e.signUp("+9647801200002", "Sara")

	photo, apiErr := upload(t, ali, pb.MediaKind_MEDIA_KIND_PHOTO, "image/jpeg", "beach.jpg", jpegBytes(t, 800, 600))
	if apiErr != nil {
		t.Fatalf("upload: %v", apiErr)
	}
	if photo.Status != pb.MediaStatus_MEDIA_STATUS_READY || photo.Width != 800 || len(photo.Variants) != 2 {
		t.Fatalf("photo after upload: %v", photo)
	}

	// Sara cannot send Ali's upload as her own.
	err := sara.call(mSend, &pb.SendMessageRequest{Peer: toUser(aliID), RandomId: 9, Content: &pb.InputContent{
		Kind: &pb.InputContent_Media{Media: &pb.InputMedia{MediaId: photo.Id}}}}, &pb.SendMessageResponse{})
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_NOT_FOUND {
		t.Fatalf("sending someone else's upload: %v", err)
	}

	var sent pb.SendMessageResponse
	ali.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 1, Content: &pb.InputContent{
		Kind: &pb.InputContent_Media{Media: &pb.InputMedia{MediaId: photo.Id, Caption: &pb.FormattedText{Text: "البحر 🌊"}}}}}, &sent)
	got := sara.nextUpdate(t, func(u *pb.Update) bool { return u.GetNewMessage() != nil }).GetNewMessage().GetMessage()
	ph := got.GetContent().GetPhoto()
	if ph == nil || ph.GetMedia().GetId() != photo.Id || ph.GetCaption().GetText() != "البحر 🌊" {
		t.Fatalf("Sara got %v", got)
	}

	// Sara downloads the medium thumbnail through the message.
	var dl pb.GetDownloadUrlResponse
	sara.mustCall(mDownloadURL, &pb.GetDownloadUrlRequest{MediaId: photo.Id, Variant: "thumb_m",
		Context: &pb.GetDownloadUrlRequest_Message{Message: &pb.MessageRef{ChatId: got.ChatId, Seq: got.Seq}}}, &dl)
	img, err2 := jpeg.Decode(bytes.NewReader(httpGet(t, dl.Url)))
	if err2 != nil || img.Bounds().Dx() != 320 || img.Bounds().Dy() != 240 {
		t.Fatalf("thumbnail: %v %v", err2, img.Bounds())
	}

	// Someone outside the chat cannot get a link, even knowing the ids.
	outsider, _, _ := e.signUp("+9647701200004", "Outsider")
	err = outsider.call(mDownloadURL, &pb.GetDownloadUrlRequest{MediaId: photo.Id,
		Context: &pb.GetDownloadUrlRequest_Message{Message: &pb.MessageRef{ChatId: got.ChatId, Seq: got.Seq}}}, &dl)
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_NOT_FOUND {
		t.Fatalf("outsider download: %v", err)
	}
	if err := outsider.call(mDownloadURL, &pb.GetDownloadUrlRequest{MediaId: photo.Id}, &dl); err.GetCode() != pb.ErrorCode_ERROR_CODE_INVALID_ARGUMENT {
		t.Fatalf("download without context: %v", err)
	}

	// Not a real image → refused.
	_, apiErr = upload(t, ali, pb.MediaKind_MEDIA_KIND_PHOTO, "image/jpeg", "fake.jpg", []byte("not an image at all"))
	if apiErr.GetCode() != pb.ErrorCode_ERROR_CODE_INVALID_ARGUMENT {
		t.Fatalf("fake image: %v", apiErr)
	}
}

func TestLargeFileMultipartAndResume(t *testing.T) {
	e := newEnv(t, withFakeS3(t))
	ali, _, _ := e.signUp("+9647701300001", "Ali")
	data := make([]byte, 12<<20) // 12 MiB → 3 parts of 5 MiB
	_, _ = rand.Read(data)

	var cr pb.CreateUploadResponse
	ali.mustCall(mCreateUpload, &pb.CreateUploadRequest{Kind: pb.MediaKind_MEDIA_KIND_DOCUMENT, MimeType: "application/pdf",
		SizeBytes: int64(len(data)), FileName: "../../etc/التقرير.pdf"}, &cr)
	if cr.PartCount != 3 || cr.PartSizeBytes != 5<<20 || len(cr.Urls) != 3 {
		t.Fatalf("multipart plan: %v", &cr)
	}
	// Upload part 1, then "lose" the app: resume asks what is already there.
	httpPut(t, cr.Urls[0].Url, data[:5<<20])
	var resume pb.GetUploadPartUrlsResponse
	ali.mustCall(mPartUrls, &pb.GetUploadPartUrlsRequest{UploadId: cr.UploadId, PartNumbers: []int32{2, 3}}, &resume)
	if len(resume.UploadedParts) != 1 || resume.UploadedParts[0].PartNumber != 1 || len(resume.Urls) != 2 {
		t.Fatalf("resume: %v", &resume)
	}
	httpPut(t, resume.Urls[0].Url, data[5<<20:10<<20])
	httpPut(t, resume.Urls[1].Url, data[10<<20:])
	var done pb.CompleteUploadResponse
	ali.mustCall(mCompleteUpload, &pb.CompleteUploadRequest{UploadId: cr.UploadId}, &done) // parts listed server-side
	if done.Media.Status != pb.MediaStatus_MEDIA_STATUS_READY || done.Media.FileName != "التقرير.pdf" {
		t.Fatalf("document: %v (file name must lose its path)", done.Media)
	}
	var dl pb.GetDownloadUrlResponse
	ali.mustCall(mDownloadURL, &pb.GetDownloadUrlRequest{MediaId: done.Media.Id}, &dl)
	if got := httpGet(t, dl.Url); !bytes.Equal(got, data) {
		t.Fatal("downloaded file differs from upload")
	}
	if !strings.Contains(dl.Url, "response-content-disposition") {
		t.Fatal("documents download with their file name")
	}

	// Limits.
	err := ali.call(mCreateUpload, &pb.CreateUploadRequest{Kind: pb.MediaKind_MEDIA_KIND_DOCUMENT, SizeBytes: 600 << 20}, &cr)
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_FILE_TOO_LARGE {
		t.Fatalf("too large: %v", err)
	}
	err = ali.call(mCreateUpload, &pb.CreateUploadRequest{Kind: pb.MediaKind_MEDIA_KIND_VIDEO, MimeType: "video/mp4", SizeBytes: 100}, &cr)
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_UNIMPLEMENTED {
		t.Fatalf("video for now: %v", err)
	}
}

func TestBlocklistedMediaIsRejectedAndTakenDown(t *testing.T) {
	e := newEnv(t, withFakeS3(t))
	ctx := context.Background()
	ali, _, aliID := e.signUp("+9647701400001", "Ali")
	sara, _, saraID := e.signUp("+9647801400002", "Sara")
	senior := e.staff(moderation.RoleSeniorModerator)

	// 1. A file already on the blocklist never reaches anyone.
	bad := jpegBytes(t, 64, 64)
	sum := sha256.Sum256(bad)
	if err := e.srv.Actions.BlockMedia(ctx, senior, sum[:], pb.ReportReason_REPORT_REASON_CHILD_ABUSE, "known"); err != nil {
		t.Fatal(err)
	}
	if _, apiErr := upload(t, ali, pb.MediaKind_MEDIA_KIND_PHOTO, "image/jpeg", "x.jpg", bad); apiErr.GetCode() != pb.ErrorCode_ERROR_CODE_PERMISSION_DENIED {
		t.Fatalf("blocklisted upload: %v", apiErr)
	}
	var source, prio int16
	var target int64
	if err := e.db.QueryRow(ctx, `SELECT source, priority, target_user_id FROM reports WHERE reporter_id IS NULL`).Scan(&source, &prio, &target); err != nil {
		t.Fatalf("automatic report: %v", err)
	}
	if source != 2 || prio != moderation.PriorityCritical || target != aliID {
		t.Fatalf("report source=%d prio=%d target=%d", source, prio, target)
	}

	// 2. A file shared before its hash was blocklisted is taken down everywhere.
	later := jpegBytes(t, 70, 70)
	photo, apiErr := upload(t, ali, pb.MediaKind_MEDIA_KIND_PHOTO, "image/jpeg", "y.jpg", later)
	if apiErr != nil {
		t.Fatal(apiErr)
	}
	var sent pb.SendMessageResponse
	ali.mustCall(mSend, &pb.SendMessageRequest{Peer: toUser(saraID), RandomId: 5, Content: &pb.InputContent{
		Kind: &pb.InputContent_Media{Media: &pb.InputMedia{MediaId: photo.Id}}}}, &sent)
	sara.nextUpdate(t, func(u *pb.Update) bool { return u.GetNewMessage() != nil })

	sum2 := sha256.Sum256(later)
	if err := e.srv.Actions.BlockMedia(ctx, senior, sum2[:], pb.ReportReason_REPORT_REASON_TERRORISM, "found later"); err != nil {
		t.Fatal(err)
	}
	del := sara.nextUpdate(t, func(u *pb.Update) bool { return u.GetMessagesDeleted() != nil }).GetMessagesDeleted()
	if del.GetChatId() != sent.Message.ChatId || del.GetSeqs()[0] != sent.Message.Seq {
		t.Fatalf("takedown push: %v", del)
	}
	var dl pb.GetDownloadUrlResponse
	if err := ali.call(mDownloadURL, &pb.GetDownloadUrlRequest{MediaId: photo.Id}, &dl); err.GetCode() != pb.ErrorCode_ERROR_CODE_NOT_FOUND {
		t.Fatalf("taken-down file must be gone: %v", err)
	}
}

func TestProfilePhotoPrivacy(t *testing.T) {
	e := newEnv(t, withFakeS3(t))
	ali, _, aliID := e.signUp("+9647701500001", "Ali")
	sara, _, _ := e.signUp("+9647801500002", "Sara")
	photo, apiErr := upload(t, ali, pb.MediaKind_MEDIA_KIND_PHOTO, "image/jpeg", "me.jpg", jpegBytes(t, 400, 400))
	if apiErr != nil {
		t.Fatal(apiErr)
	}
	ali.mustCall(mSetPhoto, &pb.SetProfilePhotoRequest{MediaId: photo.Id}, &pb.SetProfilePhotoResponse{})

	var gu pb.GetUsersResponse
	sara.mustCall(mGetUsers, &pb.GetUsersRequest{UserIds: []int64{aliID}}, &gu)
	if gu.Users[0].GetPhoto().GetMediaId() != photo.Id || len(gu.Users[0].GetPhoto().GetThumbhash()) == 0 {
		t.Fatalf("Sara should see Ali's photo: %v", gu.Users[0])
	}
	var dl pb.GetDownloadUrlResponse
	sara.mustCall(mDownloadURL, &pb.GetDownloadUrlRequest{MediaId: photo.Id, Variant: "thumb_s",
		Context: &pb.GetDownloadUrlRequest_UserId{UserId: aliID}}, &dl)

	// Ali hides his photo from everyone.
	_, err := e.db.Exec(context.Background(), `INSERT INTO privacy_rules (user_id, key, rule) VALUES ($1, 3, 3)`, aliID)
	if err != nil {
		t.Fatal(err)
	}
	sara.mustCall(mGetUsers, &pb.GetUsersRequest{UserIds: []int64{aliID}}, &gu)
	if gu.Users[0].GetPhoto() != nil {
		t.Fatal("hidden photo must not be listed")
	}
	if err := sara.call(mDownloadURL, &pb.GetDownloadUrlRequest{MediaId: photo.Id,
		Context: &pb.GetDownloadUrlRequest_UserId{UserId: aliID}}, &dl); err.GetCode() != pb.ErrorCode_ERROR_CODE_NOT_FOUND {
		t.Fatalf("hidden photo download: %v", err)
	}
}

func TestMediaDisabledWithoutStorage(t *testing.T) {
	e := newEnv(t)
	ali, _, _ := e.signUp("+9647701600001", "Ali")
	err := ali.call(mCreateUpload, &pb.CreateUploadRequest{Kind: pb.MediaKind_MEDIA_KIND_PHOTO, MimeType: "image/jpeg", SizeBytes: 10}, &pb.CreateUploadResponse{})
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_UNAVAILABLE {
		t.Fatalf("without storage: %v", err)
	}
}
