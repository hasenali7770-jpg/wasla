package server

import (
	"testing"
	"time"

	pb "wasla/backend/gen/proto/wasla/v1"
	"wasla/backend/internal/auth"
	"wasla/backend/internal/chats"
	"wasla/backend/internal/contacts"
	"wasla/backend/internal/media"
	"wasla/backend/internal/messaging"
	"wasla/backend/internal/moderation"
	"wasla/backend/internal/updates"
	"wasla/backend/internal/users"
)

func TestRouterMatchesProto(t *testing.T) {
	r, err := NewRouter(&auth.Service{}, &users.Service{}, &updates.Service{}, &moderation.Reports{},
		&chats.Service{}, &messaging.Service{}, &contacts.Service{}, &media.Service{})
	if err != nil {
		t.Fatal(err)
	}
	if n := len(r.Methods()); n != 50 {
		t.Fatalf("expected 50 methods (Sprint 1-3), got %d", n)
	}
}

func TestSignUpThenSignInWithToken(t *testing.T) {
	e := newEnv(t)
	c, token, uid := e.signUp("+9647701234567", "علي")
	if uid == 0 || token == "" {
		t.Fatal("missing authorization")
	}
	var me pb.GetMeResponse
	c.mustCall(mGetMe, &pb.GetMeRequest{}, &me)
	if me.GetUser().GetFirstName() != "علي" || me.GetUser().GetPhone() != "+9647701234567" {
		t.Fatalf("unexpected profile %v", me.GetUser())
	}

	// A new connection authenticates from the stored token.
	c2 := e.dial(token)
	if !c2.ack.GetAuthenticated() || c2.ack.GetUserId() != uid {
		t.Fatalf("token login failed: %v", c2.ack)
	}

	// Unauthenticated connections only reach AuthService.
	anon := e.dial("")
	if err := anon.call(mGetMe, &pb.GetMeRequest{}, &me); err.GetCode() != pb.ErrorCode_ERROR_CODE_UNAUTHENTICATED {
		t.Fatalf("expected UNAUTHENTICATED, got %v", err)
	}

	// Signing in again on the same number returns the existing account.
	e.mr.FastForward(2 * time.Minute) // past the resend cooldown
	var sent pb.SendCodeResponse
	anon.mustCall(mSendCode, &pb.SendCodeRequest{Phone: "+9647701234567", DeviceAttestation: "dev"}, &sent)
	var in pb.SignInResponse
	anon.mustCall(mSignIn, &pb.SignInRequest{Phone: "+9647701234567", CodeHash: sent.CodeHash,
		Code: e.sms.LastCode("+9647701234567")}, &in)
	if in.GetAuthorization().GetUser().GetId() != uid {
		t.Fatalf("expected existing account, got %v", &in)
	}
	var list pb.ListSessionsResponse
	anon.mustCall(mListSessions, &pb.ListSessionsRequest{}, &list)
	if len(list.Sessions) != 2 {
		t.Fatalf("expected 2 sessions, got %d", len(list.Sessions))
	}
}

func TestWrongCodeAndAttemptLimit(t *testing.T) {
	e := newEnv(t)
	c := e.dial("")
	const ph = "+9647801111111"
	var sent pb.SendCodeResponse
	c.mustCall(mSendCode, &pb.SendCodeRequest{Phone: ph, DeviceAttestation: "dev"}, &sent)
	if sent.DevCode != "" {
		t.Fatal("the login code must never be returned unless ExposeDevCode is set")
	}
	wrong := "00000"
	if e.sms.LastCode(ph) == wrong {
		wrong = "11111"
	}
	var in pb.SignInResponse
	for i := 0; i < 5; i++ {
		if err := c.call(mSignIn, &pb.SignInRequest{Phone: ph, CodeHash: sent.CodeHash, Code: wrong}, &in); err.GetCode() != pb.ErrorCode_ERROR_CODE_PHONE_CODE_INVALID {
			t.Fatalf("attempt %d: expected PHONE_CODE_INVALID, got %v", i+1, err)
		}
	}
	// 6th attempt burns the code, even if it is right.
	err := c.call(mSignIn, &pb.SignInRequest{Phone: ph, CodeHash: sent.CodeHash, Code: e.sms.LastCode(ph)}, &in)
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_PHONE_CODE_EXPIRED {
		t.Fatalf("expected PHONE_CODE_EXPIRED, got %v", err)
	}
	if err := c.call(mSendCode, &pb.SendCodeRequest{Phone: "07701234567"}, &sent); err.GetCode() != pb.ErrorCode_ERROR_CODE_PHONE_INVALID {
		t.Fatalf("expected PHONE_INVALID for non-E.164, got %v", err)
	}
}

func TestSendCodeLimits(t *testing.T) {
	e := newEnv(t)
	c := e.dial("")
	const ph = "+9647502222222"
	var sent pb.SendCodeResponse
	c.mustCall(mSendCode, &pb.SendCodeRequest{Phone: ph}, &sent)
	// Resend cooldown.
	if err := c.call(mSendCode, &pb.SendCodeRequest{Phone: ph}, &sent); err.GetCode() != pb.ErrorCode_ERROR_CODE_RATE_LIMITED {
		t.Fatalf("expected cooldown RATE_LIMITED, got %v", err)
	}
	// Without attestation the hourly per-phone limit is halved (5 -> 2).
	e.mr.FastForward(61 * time.Second)
	c.mustCall(mSendCode, &pb.SendCodeRequest{Phone: ph}, &sent)
	e.mr.FastForward(61 * time.Second)
	err := c.call(mSendCode, &pb.SendCodeRequest{Phone: ph}, &sent)
	if err.GetCode() != pb.ErrorCode_ERROR_CODE_RATE_LIMITED || err.GetRetryAfterSeconds() <= 0 {
		t.Fatalf("expected hourly RATE_LIMITED with retry hint, got %v", err)
	}
	var blocked int
	_ = e.db.QueryRow(t.Context(), `SELECT count(*) FROM otp_requests WHERE phone = $1 AND status = 4`, ph).Scan(&blocked)
	if blocked != 1 {
		t.Fatalf("expected 1 blocked attempt logged for fraud analytics, got %d", blocked)
	}
}

func TestTwoStepPassword(t *testing.T) {
	e := newEnv(t)
	const ph = "+9647703333333"
	c, _, uid := e.signUp(ph, "Sara")
	c.mustCall(mSetPassword, &pb.SetPasswordRequest{NewPassword: "correct horse", Hint: "حصان"}, &pb.SetPasswordResponse{})
	c.mustCall(mLogOut, &pb.LogOutRequest{}, &pb.LogOutResponse{})
	if code := c.waitClosed(t); code != 4001 {
		t.Fatalf("expected close 4001 after logout, got %d", code)
	}

	e.mr.FastForward(2 * time.Minute)
	c2 := e.dial("")
	var sent pb.SendCodeResponse
	c2.mustCall(mSendCode, &pb.SendCodeRequest{Phone: ph, DeviceAttestation: "dev"}, &sent)
	var in pb.SignInResponse
	c2.mustCall(mSignIn, &pb.SignInRequest{Phone: ph, CodeHash: sent.CodeHash, Code: e.sms.LastCode(ph)}, &in)
	pr := in.GetPasswordRequired()
	if pr == nil || pr.GetHint() != "حصان" {
		t.Fatalf("expected password_required with hint, got %v", &in)
	}
	var out pb.CheckPasswordResponse
	if err := c2.call(mCheckPassword, &pb.CheckPasswordRequest{LoginToken: pr.LoginToken, Password: "wrong"}, &out); err.GetCode() != pb.ErrorCode_ERROR_CODE_PASSWORD_INVALID {
		t.Fatalf("expected PASSWORD_INVALID, got %v", err)
	}
	c2.mustCall(mCheckPassword, &pb.CheckPasswordRequest{LoginToken: pr.LoginToken, Password: "correct horse"}, &out)
	if out.GetAuthorization().GetUser().GetId() != uid {
		t.Fatal("wrong user after password check")
	}
	// Deleting the account requires the password.
	if err := c2.call(mDeleteAccount, &pb.DeleteAccountRequest{}, &pb.DeleteAccountResponse{}); err.GetCode() != pb.ErrorCode_ERROR_CODE_PASSWORD_INVALID {
		t.Fatalf("expected PASSWORD_INVALID on delete without password, got %v", err)
	}
	c2.mustCall(mDeleteAccount, &pb.DeleteAccountRequest{Password: "correct horse"}, &pb.DeleteAccountResponse{})
	var phone *string
	_ = e.db.QueryRow(t.Context(), `SELECT phone FROM users WHERE id = $1`, uid).Scan(&phone)
	if phone != nil {
		t.Fatal("phone must be wiped on account deletion")
	}
}
