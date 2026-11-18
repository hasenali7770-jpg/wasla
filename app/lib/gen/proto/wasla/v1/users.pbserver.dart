// This is a generated file - do not edit.
//
// Generated from wasla/v1/users.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'users.pb.dart' as $1;
import 'users.pbjson.dart';

export 'users.pb.dart';

abstract class UsersServiceBase extends $pb.GeneratedService {
  $async.Future<$1.GetMeResponse> getMe(
      $pb.ServerContext ctx, $1.GetMeRequest request);
  $async.Future<$1.GetUsersResponse> getUsers(
      $pb.ServerContext ctx, $1.GetUsersRequest request);
  $async.Future<$1.UpdateProfileResponse> updateProfile(
      $pb.ServerContext ctx, $1.UpdateProfileRequest request);
  $async.Future<$1.SetProfilePhotoResponse> setProfilePhoto(
      $pb.ServerContext ctx, $1.SetProfilePhotoRequest request);
  $async.Future<$1.DeleteProfilePhotoResponse> deleteProfilePhoto(
      $pb.ServerContext ctx, $1.DeleteProfilePhotoRequest request);
  $async.Future<$1.CheckUsernameResponse> checkUsername(
      $pb.ServerContext ctx, $1.CheckUsernameRequest request);
  $async.Future<$1.SetUsernameResponse> setUsername(
      $pb.ServerContext ctx, $1.SetUsernameRequest request);
  $async.Future<$1.ResolveUsernameResponse> resolveUsername(
      $pb.ServerContext ctx, $1.ResolveUsernameRequest request);
  $async.Future<$1.SearchUsersResponse> searchUsers(
      $pb.ServerContext ctx, $1.SearchUsersRequest request);
  $async.Future<$1.GetPrivacyResponse> getPrivacy(
      $pb.ServerContext ctx, $1.GetPrivacyRequest request);
  $async.Future<$1.SetPrivacyResponse> setPrivacy(
      $pb.ServerContext ctx, $1.SetPrivacyRequest request);
  $async.Future<$1.BlockUserResponse> blockUser(
      $pb.ServerContext ctx, $1.BlockUserRequest request);
  $async.Future<$1.UnblockUserResponse> unblockUser(
      $pb.ServerContext ctx, $1.UnblockUserRequest request);
  $async.Future<$1.ListBlockedResponse> listBlocked(
      $pb.ServerContext ctx, $1.ListBlockedRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetMe':
        return $1.GetMeRequest();
      case 'GetUsers':
        return $1.GetUsersRequest();
      case 'UpdateProfile':
        return $1.UpdateProfileRequest();
      case 'SetProfilePhoto':
        return $1.SetProfilePhotoRequest();
      case 'DeleteProfilePhoto':
        return $1.DeleteProfilePhotoRequest();
      case 'CheckUsername':
        return $1.CheckUsernameRequest();
      case 'SetUsername':
        return $1.SetUsernameRequest();
      case 'ResolveUsername':
        return $1.ResolveUsernameRequest();
      case 'SearchUsers':
        return $1.SearchUsersRequest();
      case 'GetPrivacy':
        return $1.GetPrivacyRequest();
      case 'SetPrivacy':
        return $1.SetPrivacyRequest();
      case 'BlockUser':
        return $1.BlockUserRequest();
      case 'UnblockUser':
        return $1.UnblockUserRequest();
      case 'ListBlocked':
        return $1.ListBlockedRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetMe':
        return getMe(ctx, request as $1.GetMeRequest);
      case 'GetUsers':
        return getUsers(ctx, request as $1.GetUsersRequest);
      case 'UpdateProfile':
        return updateProfile(ctx, request as $1.UpdateProfileRequest);
      case 'SetProfilePhoto':
        return setProfilePhoto(ctx, request as $1.SetProfilePhotoRequest);
      case 'DeleteProfilePhoto':
        return deleteProfilePhoto(ctx, request as $1.DeleteProfilePhotoRequest);
      case 'CheckUsername':
        return checkUsername(ctx, request as $1.CheckUsernameRequest);
      case 'SetUsername':
        return setUsername(ctx, request as $1.SetUsernameRequest);
      case 'ResolveUsername':
        return resolveUsername(ctx, request as $1.ResolveUsernameRequest);
      case 'SearchUsers':
        return searchUsers(ctx, request as $1.SearchUsersRequest);
      case 'GetPrivacy':
        return getPrivacy(ctx, request as $1.GetPrivacyRequest);
      case 'SetPrivacy':
        return setPrivacy(ctx, request as $1.SetPrivacyRequest);
      case 'BlockUser':
        return blockUser(ctx, request as $1.BlockUserRequest);
      case 'UnblockUser':
        return unblockUser(ctx, request as $1.UnblockUserRequest);
      case 'ListBlocked':
        return listBlocked(ctx, request as $1.ListBlockedRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => UsersServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => UsersServiceBase$messageJson;
}
