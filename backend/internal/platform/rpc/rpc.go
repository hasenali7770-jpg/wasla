// Package rpc routes RPC calls (from the WebSocket gateway, and later the
// Connect HTTP fallback) to typed handlers.
package rpc

import (
	"context"
	"fmt"
	"net/netip"
	"sync/atomic"

	"google.golang.org/protobuf/proto"
	"google.golang.org/protobuf/reflect/protoreflect"
	"google.golang.org/protobuf/reflect/protoregistry"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/platform/errs"
)

// Caller describes who is making a call. One Caller lives as long as its
// connection; it becomes authenticated either from Hello or when an auth
// handler calls Bind.
type Caller struct {
	IP          netip.Addr
	Platform    pb.Platform
	DeviceModel string
	OSVersion   string
	AppVersion  string
	LangCode    string

	userID    atomic.Int64
	sessionID atomic.Int64
	onBind    func(sessionID, userID int64)
}

// NewCaller returns an unauthenticated caller. onBind (optional) is invoked
// when the connection becomes authenticated.
func NewCaller(ip netip.Addr, onBind func(sessionID, userID int64)) *Caller {
	return &Caller{IP: ip, onBind: onBind}
}

func (c *Caller) UserID() int64       { return c.userID.Load() }
func (c *Caller) SessionID() int64    { return c.sessionID.Load() }
func (c *Caller) Authenticated() bool { return c.userID.Load() != 0 }

// Bind marks the caller as authenticated with a session.
func (c *Caller) Bind(sessionID, userID int64) {
	c.sessionID.Store(sessionID)
	c.userID.Store(userID)
	if c.onBind != nil {
		c.onBind(sessionID, userID)
	}
}

type handler func(ctx context.Context, c *Caller, payload []byte) (proto.Message, error)

type route struct {
	h       handler
	public  bool
	reqType protoreflect.FullName
	resType protoreflect.FullName
}

// Router maps full method names ("/wasla.v1.AuthService/SendCode") to handlers.
type Router struct {
	routes map[string]route
}

func NewRouter() *Router { return &Router{routes: map[string]route{}} }

// Access controls whether a method needs an authenticated caller.
type Access bool

const (
	Public  Access = true
	Private Access = false
)

// Register adds a typed handler. Req is inferred from fn.
func Register[Req any, PReq interface {
	*Req
	proto.Message
}, Resp proto.Message](r *Router, method string, access Access, fn func(context.Context, *Caller, PReq) (Resp, error)) {
	if _, dup := r.routes[method]; dup {
		panic("rpc: duplicate method " + method)
	}
	var zeroReq PReq = new(Req)
	var zeroResp Resp
	r.routes[method] = route{
		public:  bool(access),
		reqType: zeroReq.ProtoReflect().Descriptor().FullName(),
		resType: zeroResp.ProtoReflect().Descriptor().FullName(),
		h: func(ctx context.Context, c *Caller, payload []byte) (proto.Message, error) {
			req := PReq(new(Req))
			if err := proto.Unmarshal(payload, req); err != nil {
				return nil, errs.Invalid("malformed request")
			}
			return fn(ctx, c, req)
		},
	}
}

// Dispatch runs a method and returns the serialized response.
func (r *Router) Dispatch(ctx context.Context, c *Caller, method string, payload []byte) ([]byte, error) {
	rt, ok := r.routes[method]
	if !ok {
		return nil, errs.New(pb.ErrorCode_ERROR_CODE_UNIMPLEMENTED, "unknown method %s", method)
	}
	if !rt.public && !c.Authenticated() {
		return nil, errs.Unauthenticated()
	}
	resp, err := rt.h(ctx, c, payload)
	if err != nil {
		return nil, err
	}
	return proto.Marshal(resp)
}

// Validate checks every route against the compiled proto descriptors: the
// method must exist and its request/response types must match. Called at
// startup and in tests, so a typo in a method name can never ship.
func (r *Router) Validate() error {
	for name, rt := range r.routes {
		// "/wasla.v1.AuthService/SendCode" -> "wasla.v1.AuthService.SendCode"
		if len(name) < 2 || name[0] != '/' {
			return fmt.Errorf("rpc: bad method name %q", name)
		}
		full := ""
		for i, ch := range name[1:] {
			if ch == '/' {
				full = name[1:i+1] + "." + name[i+2:]
				break
			}
		}
		d, err := protoregistry.GlobalFiles.FindDescriptorByName(protoreflect.FullName(full))
		if err != nil {
			return fmt.Errorf("rpc: method %s not found in proto descriptors", name)
		}
		md, ok := d.(protoreflect.MethodDescriptor)
		if !ok {
			return fmt.Errorf("rpc: %s is not a method", name)
		}
		if md.Input().FullName() != rt.reqType || md.Output().FullName() != rt.resType {
			return fmt.Errorf("rpc: %s registered with %s→%s, proto says %s→%s",
				name, rt.reqType, rt.resType, md.Input().FullName(), md.Output().FullName())
		}
	}
	return nil
}

// Methods returns the registered method names (for docs and tests).
func (r *Router) Methods() []string {
	out := make([]string, 0, len(r.routes))
	for m := range r.routes {
		out = append(out, m)
	}
	return out
}
