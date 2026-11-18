package gateway

import (
	"context"
	"errors"
	"log/slog"
	"net"
	"net/http"
	"net/netip"
	"strings"
	"sync"
	"time"

	"github.com/coder/websocket"
	"github.com/jackc/pgx/v5/pgxpool"
	"google.golang.org/protobuf/proto"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/errs"
	"wasla/backend/internal/platform/rpc"
)

// Close codes (docs/03-protocol.md §2).
const (
	CloseSessionRevoked websocket.StatusCode = 4001
	CloseProtocolOld    websocket.StatusCode = 4002
	CloseTooSlow        websocket.StatusCode = 4003
)

const (
	protocolVersion = 1
	helloTimeout    = 10 * time.Second
	idleTimeout     = 90 * time.Second
	rpcTimeout      = 30 * time.Second
	writeTimeout    = 10 * time.Second
	maxFrameBytes   = 1 << 20
	maxInFlight     = 16
	outQueue        = 128
	// Per-connection request rate: sustained 30/s, bursts of 60.
	rateRefill = 30.0
	rateBurst  = 60.0
)

// Authenticator resolves session tokens (implemented by auth.Service).
type Authenticator interface {
	Authenticate(ctx context.Context, token string) (sessionID, userID int64, ok bool, err error)
}

// Gateway serves /ws.
type Gateway struct {
	Router        *rpc.Router
	Auth          Authenticator
	Hub           *Hub
	DB            *pgxpool.Pool
	Log           *slog.Logger
	MinAppVersion string
	// TrustProxy: take the client IP from the right-most X-Forwarded-For entry
	// (the one our load balancer appended). Only enable behind our own LB.
	TrustProxy     bool
	OriginPatterns []string
}

func (g *Gateway) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	ws, err := websocket.Accept(w, r, &websocket.AcceptOptions{
		OriginPatterns:  g.OriginPatterns,
		CompressionMode: websocket.CompressionNoContextTakeover,
	})
	if err != nil {
		return
	}
	ws.SetReadLimit(maxFrameBytes)
	ctx, cancel := context.WithCancel(context.Background())
	c := &conn{ws: ws, out: make(chan []byte, outQueue), ctx: ctx, cancel: cancel, tokens: rateBurst, last: time.Now()}
	defer c.close(websocket.StatusNormalClosure, "")
	go c.writeLoop()

	// 1. Hello
	helloCtx, hcancel := context.WithTimeout(ctx, helloTimeout)
	_, data, err := ws.Read(helloCtx)
	hcancel()
	if err != nil {
		return
	}
	var f pb.Frame
	if proto.Unmarshal(data, &f) != nil || f.GetHello() == nil {
		c.close(websocket.StatusPolicyViolation, "expected Hello")
		return
	}
	hello := f.GetHello()
	if hello.GetProtocolVersion() != protocolVersion {
		c.close(CloseProtocolOld, "unsupported protocol version")
		return
	}
	c.caller = rpc.NewCaller(g.clientIP(r), func(sid, uid int64) {
		c.mu.Lock()
		c.userID, c.sessionID = uid, sid
		c.mu.Unlock()
		g.Hub.add(c, uid, sid)
	})
	c.caller.Platform = hello.GetPlatform()
	c.caller.AppVersion = trim(hello.GetAppVersion(), 32)
	c.caller.DeviceModel = trim(hello.GetDeviceModel(), 64)
	c.caller.OSVersion = trim(hello.GetOsVersion(), 32)
	c.caller.LangCode = trim(hello.GetLangCode(), 16)

	if tok := hello.GetSessionToken(); tok != "" {
		sid, uid, ok, err := g.Auth.Authenticate(ctx, tok)
		if err != nil {
			g.Log.Error("authenticate", "err", err)
			c.close(websocket.StatusInternalError, "try again")
			return
		}
		if ok {
			c.caller.Bind(sid, uid)
		}
	}
	defer g.disconnected(c)
	c.sendFrame(&pb.Frame{Kind: &pb.Frame_HelloAck{HelloAck: &pb.HelloAck{
		ServerTime: time.Now().Unix(), Authenticated: c.caller.Authenticated(),
		UserId: c.caller.UserID(), MinAppVersion: g.MinAppVersion,
	}}})

	// 2. Request loop
	sem := make(chan struct{}, maxInFlight)
	var wg sync.WaitGroup
	defer wg.Wait()
	defer c.cancel() // runs first: abort in-flight RPCs when the client goes away
	for {
		readCtx, rcancel := context.WithTimeout(ctx, idleTimeout)
		_, data, err := ws.Read(readCtx)
		rcancel()
		if err != nil {
			return
		}
		var f pb.Frame
		if proto.Unmarshal(data, &f) != nil {
			c.close(websocket.StatusPolicyViolation, "malformed frame")
			return
		}
		switch k := f.Kind.(type) {
		case *pb.Frame_Ping:
			c.sendFrame(&pb.Frame{Kind: &pb.Frame_Pong{Pong: &pb.Pong{Nonce: k.Ping.GetNonce()}}})
		case *pb.Frame_Request:
			req := k.Request
			if !c.allow() {
				c.sendError(req.GetId(), errs.RateLimited(1))
				continue
			}
			select {
			case sem <- struct{}{}:
			default:
				c.sendError(req.GetId(), errs.RateLimited(1))
				continue
			}
			wg.Add(1)
			go func() {
				defer func() { <-sem; wg.Done() }()
				g.handle(c, req)
			}()
		}
	}
}

func (g *Gateway) handle(c *conn, req *pb.RpcRequest) {
	ctx, cancel := context.WithTimeout(c.ctx, rpcTimeout)
	defer cancel()
	payload, err := g.Router.Dispatch(ctx, c.caller, req.GetMethod(), req.GetPayload())
	if err != nil {
		c.sendError(req.GetId(), g.logged(req.GetMethod(), err))
		return
	}
	c.sendFrame(&pb.Frame{Kind: &pb.Frame_Response{Response: &pb.RpcResponse{
		Id: req.GetId(), Result: &pb.RpcResponse_Payload{Payload: payload}}}})
}

func (g *Gateway) logged(method string, err error) error {
	if _, ok := errs.ToProto(err); !ok && !errors.Is(err, context.Canceled) {
		g.Log.Error("rpc failed", "method", method, "err", err)
	}
	return err
}

func (g *Gateway) disconnected(c *conn) {
	g.Hub.remove(c)
	c.mu.Lock()
	uid := c.userID
	c.mu.Unlock()
	if uid != 0 && g.DB != nil {
		ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
		defer cancel()
		_, _ = g.DB.Exec(ctx, `UPDATE users SET last_seen_at = now() WHERE id = $1`, uid)
	}
}

func (g *Gateway) clientIP(r *http.Request) netip.Addr {
	if g.TrustProxy {
		if xff := r.Header.Get("X-Forwarded-For"); xff != "" {
			parts := strings.Split(xff, ",")
			if a, err := netip.ParseAddr(strings.TrimSpace(parts[len(parts)-1])); err == nil {
				return a.Unmap()
			}
		}
	}
	host, _, err := net.SplitHostPort(r.RemoteAddr)
	if err != nil {
		host = r.RemoteAddr
	}
	a, _ := netip.ParseAddr(host)
	return a.Unmap()
}

func trim(s string, n int) string {
	if len(s) > n {
		return s[:n]
	}
	return s
}

// ---------------------------------------------------------------------------
// conn
// ---------------------------------------------------------------------------

type conn struct {
	ws     *websocket.Conn
	caller *rpc.Caller
	out    chan []byte
	ctx    context.Context
	cancel context.CancelFunc

	mu        sync.Mutex
	userID    int64
	sessionID int64
	closing   bool // close requested; already-computed responses may still flush
	shut      bool // socket is closing; nothing more is queued
	tokens    float64
	last      time.Time
}

func (c *conn) writeLoop() {
	for {
		select {
		case <-c.ctx.Done():
			return
		case b := <-c.out:
			ctx, cancel := context.WithTimeout(c.ctx, writeTimeout)
			err := c.ws.Write(ctx, websocket.MessageBinary, b)
			cancel()
			if err != nil {
				c.close(websocket.StatusGoingAway, "write failed")
				return
			}
		}
	}
}

// send queues a serialized frame. A client that cannot keep up is
// disconnected; it will resync with GetDifference on reconnect.
func (c *conn) send(b []byte) {
	c.mu.Lock()
	shut := c.shut
	c.mu.Unlock()
	if shut {
		return
	}
	select {
	case c.out <- b:
	default:
		c.close(CloseTooSlow, "client too slow")
	}
}

func (c *conn) sendFrame(f *pb.Frame) {
	b, err := proto.Marshal(f)
	if err == nil {
		c.send(b)
	}
}

func (c *conn) sendError(id uint64, err error) {
	e, _ := errs.ToProto(err)
	c.sendFrame(&pb.Frame{Kind: &pb.Frame_Response{Response: &pb.RpcResponse{
		Id: id, Result: &pb.RpcResponse_Error{Error: e}}}})
}

// allow is a token bucket limiting request rate per connection.
func (c *conn) allow() bool {
	c.mu.Lock()
	defer c.mu.Unlock()
	now := time.Now()
	c.tokens = min(rateBurst, c.tokens+now.Sub(c.last).Seconds()*rateRefill)
	c.last = now
	if c.tokens < 1 {
		return false
	}
	c.tokens--
	return true
}

func (c *conn) close(code websocket.StatusCode, reason string) {
	c.mu.Lock()
	if c.closing {
		c.mu.Unlock()
		return
	}
	c.closing = true
	c.mu.Unlock()
	go func() {
		// Let in-flight responses flush (e.g. the reply to the LogOut that
		// revoked this very session), then close.
		time.Sleep(100 * time.Millisecond)
		c.mu.Lock()
		c.shut = true
		c.mu.Unlock()
		_ = c.ws.Close(code, reason)
		c.cancel()
	}()
}
