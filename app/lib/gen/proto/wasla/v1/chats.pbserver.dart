// This is a generated file - do not edit.
//
// Generated from wasla/v1/chats.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'chats.pb.dart' as $4;
import 'chats.pbjson.dart';

export 'chats.pb.dart';

abstract class ChatsServiceBase extends $pb.GeneratedService {
  $async.Future<$4.ListDialogsResponse> listDialogs(
      $pb.ServerContext ctx, $4.ListDialogsRequest request);
  $async.Future<$4.UpdateDialogResponse> updateDialog(
      $pb.ServerContext ctx, $4.UpdateDialogRequest request);
  $async.Future<$4.ReorderPinnedDialogsResponse> reorderPinnedDialogs(
      $pb.ServerContext ctx, $4.ReorderPinnedDialogsRequest request);
  $async.Future<$4.ClearHistoryResponse> clearHistory(
      $pb.ServerContext ctx, $4.ClearHistoryRequest request);
  $async.Future<$4.GetChatsResponse> getChats(
      $pb.ServerContext ctx, $4.GetChatsRequest request);
  $async.Future<$4.GetPrivateChatResponse> getPrivateChat(
      $pb.ServerContext ctx, $4.GetPrivateChatRequest request);
  $async.Future<$4.CreateGroupResponse> createGroup(
      $pb.ServerContext ctx, $4.CreateGroupRequest request);
  $async.Future<$4.UpdateChatInfoResponse> updateChatInfo(
      $pb.ServerContext ctx, $4.UpdateChatInfoRequest request);
  $async.Future<$4.SetDefaultPermissionsResponse> setDefaultPermissions(
      $pb.ServerContext ctx, $4.SetDefaultPermissionsRequest request);
  $async.Future<$4.ListMembersResponse> listMembers(
      $pb.ServerContext ctx, $4.ListMembersRequest request);
  $async.Future<$4.AddMembersResponse> addMembers(
      $pb.ServerContext ctx, $4.AddMembersRequest request);
  $async.Future<$4.RemoveMemberResponse> removeMember(
      $pb.ServerContext ctx, $4.RemoveMemberRequest request);
  $async.Future<$4.SetMemberRoleResponse> setMemberRole(
      $pb.ServerContext ctx, $4.SetMemberRoleRequest request);
  $async.Future<$4.LeaveChatResponse> leaveChat(
      $pb.ServerContext ctx, $4.LeaveChatRequest request);
  $async.Future<$4.CreateInviteLinkResponse> createInviteLink(
      $pb.ServerContext ctx, $4.CreateInviteLinkRequest request);
  $async.Future<$4.RevokeInviteLinkResponse> revokeInviteLink(
      $pb.ServerContext ctx, $4.RevokeInviteLinkRequest request);
  $async.Future<$4.CheckInviteLinkResponse> checkInviteLink(
      $pb.ServerContext ctx, $4.CheckInviteLinkRequest request);
  $async.Future<$4.JoinByInviteLinkResponse> joinByInviteLink(
      $pb.ServerContext ctx, $4.JoinByInviteLinkRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ListDialogs':
        return $4.ListDialogsRequest();
      case 'UpdateDialog':
        return $4.UpdateDialogRequest();
      case 'ReorderPinnedDialogs':
        return $4.ReorderPinnedDialogsRequest();
      case 'ClearHistory':
        return $4.ClearHistoryRequest();
      case 'GetChats':
        return $4.GetChatsRequest();
      case 'GetPrivateChat':
        return $4.GetPrivateChatRequest();
      case 'CreateGroup':
        return $4.CreateGroupRequest();
      case 'UpdateChatInfo':
        return $4.UpdateChatInfoRequest();
      case 'SetDefaultPermissions':
        return $4.SetDefaultPermissionsRequest();
      case 'ListMembers':
        return $4.ListMembersRequest();
      case 'AddMembers':
        return $4.AddMembersRequest();
      case 'RemoveMember':
        return $4.RemoveMemberRequest();
      case 'SetMemberRole':
        return $4.SetMemberRoleRequest();
      case 'LeaveChat':
        return $4.LeaveChatRequest();
      case 'CreateInviteLink':
        return $4.CreateInviteLinkRequest();
      case 'RevokeInviteLink':
        return $4.RevokeInviteLinkRequest();
      case 'CheckInviteLink':
        return $4.CheckInviteLinkRequest();
      case 'JoinByInviteLink':
        return $4.JoinByInviteLinkRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ListDialogs':
        return listDialogs(ctx, request as $4.ListDialogsRequest);
      case 'UpdateDialog':
        return updateDialog(ctx, request as $4.UpdateDialogRequest);
      case 'ReorderPinnedDialogs':
        return reorderPinnedDialogs(
            ctx, request as $4.ReorderPinnedDialogsRequest);
      case 'ClearHistory':
        return clearHistory(ctx, request as $4.ClearHistoryRequest);
      case 'GetChats':
        return getChats(ctx, request as $4.GetChatsRequest);
      case 'GetPrivateChat':
        return getPrivateChat(ctx, request as $4.GetPrivateChatRequest);
      case 'CreateGroup':
        return createGroup(ctx, request as $4.CreateGroupRequest);
      case 'UpdateChatInfo':
        return updateChatInfo(ctx, request as $4.UpdateChatInfoRequest);
      case 'SetDefaultPermissions':
        return setDefaultPermissions(
            ctx, request as $4.SetDefaultPermissionsRequest);
      case 'ListMembers':
        return listMembers(ctx, request as $4.ListMembersRequest);
      case 'AddMembers':
        return addMembers(ctx, request as $4.AddMembersRequest);
      case 'RemoveMember':
        return removeMember(ctx, request as $4.RemoveMemberRequest);
      case 'SetMemberRole':
        return setMemberRole(ctx, request as $4.SetMemberRoleRequest);
      case 'LeaveChat':
        return leaveChat(ctx, request as $4.LeaveChatRequest);
      case 'CreateInviteLink':
        return createInviteLink(ctx, request as $4.CreateInviteLinkRequest);
      case 'RevokeInviteLink':
        return revokeInviteLink(ctx, request as $4.RevokeInviteLinkRequest);
      case 'CheckInviteLink':
        return checkInviteLink(ctx, request as $4.CheckInviteLinkRequest);
      case 'JoinByInviteLink':
        return joinByInviteLink(ctx, request as $4.JoinByInviteLinkRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ChatsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ChatsServiceBase$messageJson;
}
