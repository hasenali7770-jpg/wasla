package snowflake

import (
	"sync"
	"testing"
	"time"
)

func TestUniqueAndIncreasing(t *testing.T) {
	g, err := New(7)
	if err != nil {
		t.Fatal(err)
	}
	var prev int64
	for i := 0; i < 100_000; i++ {
		id, err := g.Next()
		if err != nil {
			t.Fatal(err)
		}
		if id <= prev {
			t.Fatalf("id %d not greater than previous %d", id, prev)
		}
		prev = id
	}
}

func TestConcurrentUnique(t *testing.T) {
	g, _ := New(1)
	const workers, per = 8, 10_000
	ids := make(chan int64, workers*per)
	var wg sync.WaitGroup
	for w := 0; w < workers; w++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for i := 0; i < per; i++ {
				id, err := g.Next()
				if err != nil {
					t.Error(err)
					return
				}
				ids <- id
			}
		}()
	}
	wg.Wait()
	close(ids)
	seen := make(map[int64]struct{}, workers*per)
	for id := range ids {
		if _, dup := seen[id]; dup {
			t.Fatalf("duplicate id %d", id)
		}
		seen[id] = struct{}{}
	}
}

func TestTimeRoundTrip(t *testing.T) {
	fixed := time.Date(2026, 11, 18, 12, 0, 0, 0, time.UTC)
	g, _ := New(0)
	g.now = func() time.Time { return fixed }
	id, _ := g.Next()
	if got := Time(id); !got.Equal(fixed) {
		t.Fatalf("Time(id) = %v, want %v", got, fixed)
	}
}

func TestClockBackwards(t *testing.T) {
	now := time.Date(2026, 6, 1, 0, 0, 0, 0, time.UTC)
	g, _ := New(0)
	g.now = func() time.Time { return now }
	if _, err := g.Next(); err != nil {
		t.Fatal(err)
	}
	now = now.Add(-time.Second)
	if _, err := g.Next(); err != ErrClockBackwards {
		t.Fatalf("want ErrClockBackwards, got %v", err)
	}
}

func TestNodeRange(t *testing.T) {
	if _, err := New(1024); err == nil {
		t.Fatal("expected error for node 1024")
	}
}
