package media

import (
	"context"
	"fmt"
	"io"
	"net/url"
	"sort"
	"time"

	"github.com/minio/minio-go/v7"
	"github.com/minio/minio-go/v7/pkg/credentials"
)

// StorageConfig points at any S3-compatible service (AWS S3, Cloudflare R2,
// MinIO). PublicURL is the address phones use; it may differ from Endpoint
// (e.g. staging: server → minio:9000, phones → https://<domain>).
type StorageConfig struct {
	Endpoint  string // host:port the server talks to
	Secure    bool
	PublicURL string // scheme://host phones use in signed URLs; empty = same as Endpoint
	AccessKey string
	SecretKey string
	Bucket    string
	Region    string
}

// Storage wraps the S3 calls the media service needs.
type Storage struct {
	ops    *minio.Client // server-side operations
	signer *minio.Client // only signs URLs for the public host; never connects
	core   minio.Core
	bucket string
}

// NewStorage connects and creates the bucket if needed.
func NewStorage(ctx context.Context, c StorageConfig) (*Storage, error) {
	if c.Region == "" {
		c.Region = "us-east-1"
	}
	creds := credentials.NewStaticV4(c.AccessKey, c.SecretKey, "")
	ops, err := minio.New(c.Endpoint, &minio.Options{Creds: creds, Secure: c.Secure, Region: c.Region, BucketLookup: minio.BucketLookupPath})
	if err != nil {
		return nil, err
	}
	signer := ops
	if c.PublicURL != "" {
		u, err := url.Parse(c.PublicURL)
		if err != nil {
			return nil, fmt.Errorf("media: bad public URL: %w", err)
		}
		// Region is fixed, so presigning never makes a network call.
		signer, err = minio.New(u.Host, &minio.Options{Creds: creds, Secure: u.Scheme == "https", Region: c.Region, BucketLookup: minio.BucketLookupPath})
		if err != nil {
			return nil, err
		}
	}
	s := &Storage{ops: ops, signer: signer, core: minio.Core{Client: ops}, bucket: c.Bucket}
	exists, err := ops.BucketExists(ctx, c.Bucket)
	if err != nil {
		return nil, fmt.Errorf("media: storage unreachable: %w", err)
	}
	if !exists {
		if err := ops.MakeBucket(ctx, c.Bucket, minio.MakeBucketOptions{Region: c.Region}); err != nil {
			return nil, err
		}
	}
	return s, nil
}

func (s *Storage) NewMultipart(ctx context.Context, key, mime string) (string, error) {
	return s.core.NewMultipartUpload(ctx, s.bucket, key, minio.PutObjectOptions{ContentType: mime})
}

func (s *Storage) PresignPut(ctx context.Context, key string, ttl time.Duration) (string, error) {
	u, err := s.signer.PresignedPutObject(ctx, s.bucket, key, ttl)
	if err != nil {
		return "", err
	}
	return u.String(), nil
}

func (s *Storage) PresignPart(ctx context.Context, key, uploadID string, part int, ttl time.Duration) (string, error) {
	q := url.Values{"partNumber": {fmt.Sprint(part)}, "uploadId": {uploadID}}
	u, err := s.signer.Presign(ctx, "PUT", s.bucket, key, ttl, q)
	if err != nil {
		return "", err
	}
	return u.String(), nil
}

// Part is an uploaded multipart chunk.
type Part struct {
	Number int
	ETag   string
}

func (s *Storage) ListParts(ctx context.Context, key, uploadID string) ([]Part, error) {
	var out []Part
	marker := 0
	for {
		r, err := s.core.ListObjectParts(ctx, s.bucket, key, uploadID, marker, 1000)
		if err != nil {
			return nil, err
		}
		for _, p := range r.ObjectParts {
			out = append(out, Part{Number: p.PartNumber, ETag: p.ETag})
		}
		if !r.IsTruncated {
			return out, nil
		}
		marker = r.NextPartNumberMarker
	}
}

func (s *Storage) CompleteMultipart(ctx context.Context, key, uploadID string, parts []Part) error {
	sort.Slice(parts, func(i, j int) bool { return parts[i].Number < parts[j].Number })
	cp := make([]minio.CompletePart, len(parts))
	for i, p := range parts {
		cp[i] = minio.CompletePart{PartNumber: p.Number, ETag: p.ETag}
	}
	_, err := s.core.CompleteMultipartUpload(ctx, s.bucket, key, uploadID, cp, minio.PutObjectOptions{})
	return err
}

func (s *Storage) AbortMultipart(ctx context.Context, key, uploadID string) error {
	return s.core.AbortMultipartUpload(ctx, s.bucket, key, uploadID)
}

// Size returns the stored object's size, or an error if it is missing.
func (s *Storage) Size(ctx context.Context, key string) (int64, error) {
	info, err := s.ops.StatObject(ctx, s.bucket, key, minio.StatObjectOptions{})
	if err != nil {
		return 0, err
	}
	return info.Size, nil
}

func (s *Storage) Open(ctx context.Context, key string) (io.ReadCloser, error) {
	return s.ops.GetObject(ctx, s.bucket, key, minio.GetObjectOptions{})
}

func (s *Storage) Put(ctx context.Context, key, mime string, r io.Reader, size int64) error {
	_, err := s.ops.PutObject(ctx, s.bucket, key, r, size, minio.PutObjectOptions{ContentType: mime})
	return err
}

func (s *Storage) Remove(ctx context.Context, key string) error {
	return s.ops.RemoveObject(ctx, s.bucket, key, minio.RemoveObjectOptions{})
}

// PresignGet returns a download URL. A non-empty fileName makes browsers and
// download managers save it under that name.
func (s *Storage) PresignGet(ctx context.Context, key, fileName string, ttl time.Duration) (string, error) {
	q := url.Values{}
	if fileName != "" {
		q.Set("response-content-disposition", "attachment; filename*=UTF-8''"+url.PathEscape(fileName))
	}
	u, err := s.signer.PresignedGetObject(ctx, s.bucket, key, ttl, q)
	if err != nil {
		return "", err
	}
	return u.String(), nil
}
