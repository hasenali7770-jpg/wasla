// This is a generated file - do not edit.
//
// Generated from wasla/v1/messages.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'messages.pb.dart' as $3;
import 'messages.pbjson.dart';

export 'messages.pb.dart';

abstract class MessagesServiceBase extends $pb.GeneratedService {
  $async.Future<$3.SendMessageResponse> sendMessage(
      $pb.ServerContext ctx, $3.SendMessageRequest request);
  $async.Future<$3.EditMessageResponse> editMessage(
      $pb.ServerContext ctx, $3.EditMessageRequest request);
  $async.Future<$3.DeleteMessagesResponse> deleteMessages(
      $pb.ServerContext ctx, $3.DeleteMessagesRequest request);
  $async.Future<$3.ForwardMessagesResponse> forwardMessages(
      $pb.ServerContext ctx, $3.ForwardMessagesRequest request);
  $async.Future<$3.GetHistoryResponse> getHistory(
      $pb.ServerContext ctx, $3.GetHistoryRequest request);
  $async.Future<$3.GetMessagesResponse> getMessages(
      $pb.ServerContext ctx, $3.GetMessagesRequest request);
  $async.Future<$3.ReadHistoryResponse> readHistory(
      $pb.ServerContext ctx, $3.ReadHistoryRequest request);
  $async.Future<$3.SetTypingResponse> setTyping(
      $pb.ServerContext ctx, $3.SetTypingRequest request);
  $async.Future<$3.PinMessageResponse> pinMessage(
      $pb.ServerContext ctx, $3.PinMessageRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'SendMessage':
        return $3.SendMessageRequest();
      case 'EditMessage':
        return $3.EditMessageRequest();
      case 'DeleteMessages':
        return $3.DeleteMessagesRequest();
      case 'ForwardMessages':
        return $3.ForwardMessagesRequest();
      case 'GetHistory':
        return $3.GetHistoryRequest();
      case 'GetMessages':
        return $3.GetMessagesRequest();
      case 'ReadHistory':
        return $3.ReadHistoryRequest();
      case 'SetTyping':
        return $3.SetTypingRequest();
      case 'PinMessage':
        return $3.PinMessageRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'SendMessage':
        return sendMessage(ctx, request as $3.SendMessageRequest);
      case 'EditMessage':
        return editMessage(ctx, request as $3.EditMessageRequest);
      case 'DeleteMessages':
        return deleteMessages(ctx, request as $3.DeleteMessagesRequest);
      case 'ForwardMessages':
        return forwardMessages(ctx, request as $3.ForwardMessagesRequest);
      case 'GetHistory':
        return getHistory(ctx, request as $3.GetHistoryRequest);
      case 'GetMessages':
        return getMessages(ctx, request as $3.GetMessagesRequest);
      case 'ReadHistory':
        return readHistory(ctx, request as $3.ReadHistoryRequest);
      case 'SetTyping':
        return setTyping(ctx, request as $3.SetTypingRequest);
      case 'PinMessage':
        return pinMessage(ctx, request as $3.PinMessageRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => MessagesServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => MessagesServiceBase$messageJson;
}
