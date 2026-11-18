// Package ratelimit implements fixed-window counters in Redis. They are
// shared by every server instance, which is what anti-fraud limits need.
package ratelimit

import (
	"context"
	"fmt"
	"time"

	"github.com/redis/go-redis/v9"
)

// Limiter counts events per key per window.
type Limiter struct {
	R   *redis.Client
	Now func() time.Time
}

// Allow records one event for key and reports whether the count is still
// within limit. retryAfter is the time left in the current window.
func (l *Limiter) Allow(ctx context.Context, key string, limit int64, window time.Duration) (ok bool, retryAfter time.Duration, err error) {
	now := l.now()
	bucket := now.UnixNano() / int64(window)
	k := fmt.Sprintf("rl:%s:%d", key, bucket)
	pipe := l.R.TxPipeline()
	incr := pipe.Incr(ctx, k)
	pipe.Expire(ctx, k, window+time.Minute)
	if _, err := pipe.Exec(ctx); err != nil {
		return false, 0, err
	}
	end := time.Unix(0, (bucket+1)*int64(window))
	return incr.Val() <= limit, end.Sub(now), nil
}

func (l *Limiter) now() time.Time {
	if l.Now != nil {
		return l.Now()
	}
	return time.Now()
}
