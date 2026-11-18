// Package snowflake generates 64-bit, roughly time-ordered, unique IDs for
// users, chats, sessions and media.
//
// Layout (most significant bit first):
//
//	1 bit  unused (always 0, so IDs stay positive in int64 / Postgres bigint)
//	41 bits milliseconds since Epoch (≈ 69 years)
//	10 bits node ID (0–1023, unique per running process)
//	12 bits sequence within the millisecond (4096 IDs/ms per node)
package snowflake

import (
	"errors"
	"sync"
	"time"
)

// Epoch is 2026-01-01T00:00:00Z.
var Epoch = time.Date(2026, 1, 1, 0, 0, 0, 0, time.UTC)

const (
	nodeBits = 10
	seqBits  = 12
	maxNode  = 1<<nodeBits - 1
	maxSeq   = 1<<seqBits - 1
)

// ErrClockBackwards is returned when the wall clock moved back further than
// the generator is willing to wait out.
var ErrClockBackwards = errors.New("snowflake: clock moved backwards")

// Generator is safe for concurrent use.
type Generator struct {
	mu     sync.Mutex
	node   int64
	lastMs int64
	seq    int64
	now    func() time.Time
}

// New returns a generator for the given node ID (0–1023).
func New(node int64) (*Generator, error) {
	if node < 0 || node > maxNode {
		return nil, errors.New("snowflake: node ID out of range 0-1023")
	}
	return &Generator{node: node, now: time.Now}, nil
}

// Next returns a new ID.
func (g *Generator) Next() (int64, error) {
	g.mu.Lock()
	defer g.mu.Unlock()

	ms := g.now().Sub(Epoch).Milliseconds()
	if ms < g.lastMs {
		// Small NTP corrections: wait them out rather than risk duplicates.
		if g.lastMs-ms > 50 {
			return 0, ErrClockBackwards
		}
		for ms < g.lastMs {
			time.Sleep(time.Millisecond)
			ms = g.now().Sub(Epoch).Milliseconds()
		}
	}
	if ms == g.lastMs {
		g.seq = (g.seq + 1) & maxSeq
		if g.seq == 0 { // sequence exhausted for this millisecond
			for ms <= g.lastMs {
				time.Sleep(100 * time.Microsecond)
				ms = g.now().Sub(Epoch).Milliseconds()
			}
		}
	} else {
		g.seq = 0
	}
	g.lastMs = ms
	return ms<<(nodeBits+seqBits) | g.node<<seqBits | g.seq, nil
}

// Time extracts the creation time from an ID.
func Time(id int64) time.Time {
	return Epoch.Add(time.Duration(id>>(nodeBits+seqBits)) * time.Millisecond)
}
