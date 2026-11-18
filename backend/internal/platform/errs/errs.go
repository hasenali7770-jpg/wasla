// Package errs defines the API error type. Handlers return *errs.Error for
// expected failures; anything else is logged and reported to the client as
// ERROR_CODE_INTERNAL without details.
package errs

import (
	"errors"
	"fmt"

	pb "wasla/backend/gen/proto/wasla/v1"
)

// Error is an API error with a stable, client-visible code.
type Error struct {
	Code       pb.ErrorCode
	Msg        string
	RetryAfter int32
}

func (e *Error) Error() string { return fmt.Sprintf("%s: %s", e.Code, e.Msg) }

// New returns an API error.
func New(code pb.ErrorCode, format string, args ...any) *Error {
	return &Error{Code: code, Msg: fmt.Sprintf(format, args...)}
}

// RateLimited returns ERROR_CODE_RATE_LIMITED with a retry hint.
func RateLimited(retryAfterSeconds int32) *Error {
	return &Error{Code: pb.ErrorCode_ERROR_CODE_RATE_LIMITED, Msg: "too many requests", RetryAfter: retryAfterSeconds}
}

// Shorthands for the most common codes.
func Invalid(format string, args ...any) *Error {
	return New(pb.ErrorCode_ERROR_CODE_INVALID_ARGUMENT, format, args...)
}
func NotFound(format string, args ...any) *Error {
	return New(pb.ErrorCode_ERROR_CODE_NOT_FOUND, format, args...)
}
func Denied(format string, args ...any) *Error {
	return New(pb.ErrorCode_ERROR_CODE_PERMISSION_DENIED, format, args...)
}
func Unauthenticated() *Error {
	return New(pb.ErrorCode_ERROR_CODE_UNAUTHENTICATED, "authentication required")
}

// ToProto converts any error into the wire form. ok is false for unexpected
// (internal) errors, which the caller should log.
func ToProto(err error) (out *pb.Error, ok bool) {
	var e *Error
	if errors.As(err, &e) {
		return &pb.Error{Code: e.Code, Message: e.Msg, RetryAfterSeconds: e.RetryAfter}, true
	}
	return &pb.Error{Code: pb.ErrorCode_ERROR_CODE_INTERNAL, Message: "internal error"}, false
}

// Is reports whether err is an API error with the given code.
func Is(err error, code pb.ErrorCode) bool {
	var e *Error
	return errors.As(err, &e) && e.Code == code
}
