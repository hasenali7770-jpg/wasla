package server

import (
	"context"
	"io"
	"log/slog"
	"net/http/httptest"
	"strings"
	"sync"
	"testing"
	"time"

	"github.com/alicebob/miniredis/v2"
	"github.com/coder/websocket"
	"github.com/jackc/pgx/v5/pgxpool"
	"github.com/redis/go-redis/v9"
	"google.golang.org/protobuf/proto"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/auth"
	"wasla/backend/internal/moderation"
	"wasla/backend/internal/platform/password"
	"wasla/backend/internal/platform/snowflake"
	"wasla/backend/internal/testutil"
)

// env is a running server plus handles for assertions.
type env struct {
	t     *testing.T
	srv   *Server
	http  *httptest.Server
	db    *pgxpool.Pool
	mr    *miniredis.Miniredis
	redis *redis.Client
	sms   *auth.DevSender
}

func newEnv(t *testing.T) *env {
	t.Helper()
	pool := testutil.Postgres(t)
	mr, rdb := testutil.Redis(t)
	ids, _ := snowflake.New(1)
	sms := &auth.DevSender{}
	cfg := auth.DefaultConfig()
	cfg.CodeSecret, cfg.PhonePepper = []byte("test-code-secret"), []byte("test-phone-pepper")
	cfg.PasswordParams = password.Fast
	cfg.NewSessionGuard = 0
	log := slog.New(slog.NewTextHandler(io.Discard, nil))
	srv, err := New(context.Background(), Deps{
		DB: pool, Redis: rdb, Log: log, IDs: ids, SMS: sms, Attestor: auth.DevAttestor{},
		AuthCfg: cfg, SLA: moderation.DefaultSLA, MinAppVersion: "0.1.0",
	})
	if err != nil {
		t.Fatal(err)
	}
	t.Cleanup(func() { _ = srv.Hub.Close() })
	hs := httptest.NewServer(srv.PublicHandler())
	t.Cleanup(hs.Close)
	return &env{t: t, srv: srv, http: hs, db: pool, mr: mr, redis: rdb, sms: sms}
}

// client is a minimal protocol client, the same shape the Flutter app uses.
type client struct {
	t       *testing.T
	ws      *websocket.Conn
	mu      sync.Mutex
	nextID  uint64
	waiting map[uint64]chan *pb.RpcResponse
	pushes  chan *pb.UpdatesPush
	closed  chan websocket.StatusCode
	ack     *pb.HelloAck
}

func (e *env) dial(token string) *client {
	e.t.Helper()
	ctx, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()
	url := "ws" + strings.TrimPrefix(e.http.URL, "http") + "/ws"
	ws, _, err := websocket.Dial(ctx, url, nil)
	if err != nil {
		e.t.Fatalf("dial: %v", err)
	}
	c := &client{t: e.t, ws: ws, waiting: map[uint64]chan *pb.RpcResponse{},
		pushes: make(chan *pb.UpdatesPush, 32), closed: make(chan websocket.StatusCode, 1)}
	e.t.Cleanup(func() { _ = ws.CloseNow() })
	hello, _ := proto.Marshal(&pb.Frame{Kind: &pb.Frame_Hello{Hello: &pb.Hello{
		ProtocolVersion: 1, SessionToken: token, Platform: pb.Platform_PLATFORM_ANDROID,
		AppVersion: "0.1.0", DeviceModel: "Test Phone", LangCode: "ar-IQ"}}})
	if err := ws.Write(ctx, websocket.MessageBinary, hello); err != nil {
		e.t.Fatal(err)
	}
	_, data, err := ws.Read(ctx)
	if err != nil {
		e.t.Fatalf("read HelloAck: %v", err)
	}
	var f pb.Frame
	if err := proto.Unmarshal(data, &f); err != nil || f.GetHelloAck() == nil {
		e.t.Fatalf("expected HelloAck, got %v", &f)
	}
	c.ack = f.GetHelloAck()
	go c.readLoop()
	return c
}

func (c *client) readLoop() {
	for {
		_, data, err := c.ws.Read(context.Background())
		if err != nil {
			c.closed <- websocket.CloseStatus(err)
			return
		}
		var f pb.Frame
		if proto.Unmarshal(data, &f) != nil {
			continue
		}
		switch k := f.Kind.(type) {
		case *pb.Frame_Response:
			c.mu.Lock()
			ch := c.waiting[k.Response.GetId()]
			delete(c.waiting, k.Response.GetId())
			c.mu.Unlock()
			if ch != nil {
				ch <- k.Response
			}
		case *pb.Frame_Updates:
			c.pushes <- k.Updates
		}
	}
}

// call performs an RPC; it returns the API error (nil on success).
func (c *client) call(method string, req, resp proto.Message) *pb.Error {
	c.t.Helper()
	payload, _ := proto.Marshal(req)
	c.mu.Lock()
	c.nextID++
	id := c.nextID
	ch := make(chan *pb.RpcResponse, 1)
	c.waiting[id] = ch
	c.mu.Unlock()
	frame, _ := proto.Marshal(&pb.Frame{Kind: &pb.Frame_Request{Request: &pb.RpcRequest{Id: id, Method: method, Payload: payload}}})
	if err := c.ws.Write(context.Background(), websocket.MessageBinary, frame); err != nil {
		c.t.Fatalf("write: %v", err)
	}
	select {
	case r := <-ch:
		if e := r.GetError(); e != nil {
			return e
		}
		if err := proto.Unmarshal(r.GetPayload(), resp); err != nil {
			c.t.Fatalf("unmarshal %s response: %v", method, err)
		}
		return nil
	case <-time.After(5 * time.Second):
		c.t.Fatalf("%s: timeout", method)
		return nil
	}
}

// mustCall fails the test on an API error.
func (c *client) mustCall(method string, req, resp proto.Message) {
	c.t.Helper()
	if e := c.call(method, req, resp); e != nil {
		c.t.Fatalf("%s: %s %s", method, e.GetCode(), e.GetMessage())
	}
}

func (c *client) waitPush(t *testing.T) *pb.UpdatesPush {
	t.Helper()
	select {
	case p := <-c.pushes:
		return p
	case <-time.After(3 * time.Second):
		t.Fatal("no update push received")
		return nil
	}
}

func (c *client) waitClosed(t *testing.T) websocket.StatusCode {
	t.Helper()
	select {
	case code := <-c.closed:
		return code
	case <-time.After(3 * time.Second):
		t.Fatal("connection was not closed")
		return 0
	}
}

const (
	mSendCode      = "/wasla.v1.AuthService/SendCode"
	mSignIn        = "/wasla.v1.AuthService/SignIn"
	mSignUp        = "/wasla.v1.AuthService/SignUp"
	mCheckPassword = "/wasla.v1.AuthService/CheckPassword"
	mSetPassword   = "/wasla.v1.AuthService/SetPassword"
	mLogOut        = "/wasla.v1.AuthService/LogOut"
	mListSessions  = "/wasla.v1.AuthService/ListSessions"
	mRevokeOthers  = "/wasla.v1.AuthService/RevokeOtherSessions"
	mDeleteAccount = "/wasla.v1.AuthService/DeleteAccount"
	mGetMe         = "/wasla.v1.UsersService/GetMe"
	mBlock         = "/wasla.v1.UsersService/BlockUser"
	mListBlocked   = "/wasla.v1.UsersService/ListBlocked"
	mGetDifference = "/wasla.v1.UpdatesService/GetDifference"
	mReport        = "/wasla.v1.ModerationService/Report"
)

// signUp registers a new account and returns (client, token, user ID).
func (e *env) signUp(phoneNum, name string) (*client, string, int64) {
	e.t.Helper()
	c := e.dial("")
	var sent pb.SendCodeResponse
	c.mustCall(mSendCode, &pb.SendCodeRequest{Phone: phoneNum, DeviceAttestation: "dev"}, &sent)
	var in pb.SignInResponse
	c.mustCall(mSignIn, &pb.SignInRequest{Phone: phoneNum, CodeHash: sent.CodeHash, Code: e.sms.LastCode(phoneNum)}, &in)
	if in.GetSignUpRequired() == nil {
		e.t.Fatalf("expected sign_up_required, got %v", &in)
	}
	var up pb.SignUpResponse
	c.mustCall(mSignUp, &pb.SignUpRequest{Phone: phoneNum, CodeHash: sent.CodeHash, FirstName: name,
		TermsVersion: in.GetSignUpRequired().GetTermsVersion()}, &up)
	return c, up.GetAuthorization().GetSessionToken(), up.GetAuthorization().GetUser().GetId()
}
