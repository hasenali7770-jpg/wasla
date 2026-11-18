// This is a generated file - do not edit.
//
// Generated from wasla/v1/auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'auth.pb.dart' as $2;
import 'auth.pbjson.dart';

export 'auth.pb.dart';

abstract class AuthServiceBase extends $pb.GeneratedService {
  $async.Future<$2.SendCodeResponse> sendCode(
      $pb.ServerContext ctx, $2.SendCodeRequest request);
  $async.Future<$2.ResendCodeResponse> resendCode(
      $pb.ServerContext ctx, $2.ResendCodeRequest request);
  $async.Future<$2.SignInResponse> signIn(
      $pb.ServerContext ctx, $2.SignInRequest request);
  $async.Future<$2.SignUpResponse> signUp(
      $pb.ServerContext ctx, $2.SignUpRequest request);
  $async.Future<$2.CheckPasswordResponse> checkPassword(
      $pb.ServerContext ctx, $2.CheckPasswordRequest request);
  $async.Future<$2.LogOutResponse> logOut(
      $pb.ServerContext ctx, $2.LogOutRequest request);
  $async.Future<$2.ListSessionsResponse> listSessions(
      $pb.ServerContext ctx, $2.ListSessionsRequest request);
  $async.Future<$2.RevokeSessionResponse> revokeSession(
      $pb.ServerContext ctx, $2.RevokeSessionRequest request);
  $async.Future<$2.RevokeOtherSessionsResponse> revokeOtherSessions(
      $pb.ServerContext ctx, $2.RevokeOtherSessionsRequest request);
  $async.Future<$2.RegisterPushTokenResponse> registerPushToken(
      $pb.ServerContext ctx, $2.RegisterPushTokenRequest request);
  $async.Future<$2.SetPasswordResponse> setPassword(
      $pb.ServerContext ctx, $2.SetPasswordRequest request);
  $async.Future<$2.DeleteAccountResponse> deleteAccount(
      $pb.ServerContext ctx, $2.DeleteAccountRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'SendCode':
        return $2.SendCodeRequest();
      case 'ResendCode':
        return $2.ResendCodeRequest();
      case 'SignIn':
        return $2.SignInRequest();
      case 'SignUp':
        return $2.SignUpRequest();
      case 'CheckPassword':
        return $2.CheckPasswordRequest();
      case 'LogOut':
        return $2.LogOutRequest();
      case 'ListSessions':
        return $2.ListSessionsRequest();
      case 'RevokeSession':
        return $2.RevokeSessionRequest();
      case 'RevokeOtherSessions':
        return $2.RevokeOtherSessionsRequest();
      case 'RegisterPushToken':
        return $2.RegisterPushTokenRequest();
      case 'SetPassword':
        return $2.SetPasswordRequest();
      case 'DeleteAccount':
        return $2.DeleteAccountRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'SendCode':
        return sendCode(ctx, request as $2.SendCodeRequest);
      case 'ResendCode':
        return resendCode(ctx, request as $2.ResendCodeRequest);
      case 'SignIn':
        return signIn(ctx, request as $2.SignInRequest);
      case 'SignUp':
        return signUp(ctx, request as $2.SignUpRequest);
      case 'CheckPassword':
        return checkPassword(ctx, request as $2.CheckPasswordRequest);
      case 'LogOut':
        return logOut(ctx, request as $2.LogOutRequest);
      case 'ListSessions':
        return listSessions(ctx, request as $2.ListSessionsRequest);
      case 'RevokeSession':
        return revokeSession(ctx, request as $2.RevokeSessionRequest);
      case 'RevokeOtherSessions':
        return revokeOtherSessions(
            ctx, request as $2.RevokeOtherSessionsRequest);
      case 'RegisterPushToken':
        return registerPushToken(ctx, request as $2.RegisterPushTokenRequest);
      case 'SetPassword':
        return setPassword(ctx, request as $2.SetPasswordRequest);
      case 'DeleteAccount':
        return deleteAccount(ctx, request as $2.DeleteAccountRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => AuthServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => AuthServiceBase$messageJson;
}
