// This is a generated file - do not edit.
//
// Generated from wasla/v1/moderation.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'moderation.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'moderation.pbenum.dart';

class ReportedMessages extends $pb.GeneratedMessage {
  factory ReportedMessages({
    $fixnum.Int64? chatId,
    $core.Iterable<$fixnum.Int64>? seqs,
  }) {
    final result = ReportedMessages._();
    if (chatId != null) result.chatId = chatId;
    if (seqs != null) result.seqs.addAll(seqs);
    return result;
  }

  ReportedMessages._();

  factory ReportedMessages.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportedMessages()..mergeFromBuffer(data, registry);
  factory ReportedMessages.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportedMessages()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReportedMessages',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReportedMessages.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'seqs', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportedMessages clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportedMessages copyWith(void Function(ReportedMessages) updates) =>
      super.copyWith((message) => updates(message as ReportedMessages))
          as ReportedMessages;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReportedMessages() / ReportedMessages.new instead')
  static ReportedMessages create() => ReportedMessages._();
  static $pb.GeneratedMessage $_createMessage() => ReportedMessages._();
  @$core.override
  ReportedMessages createEmptyInstance() => ReportedMessages._();
  @$core.pragma('dart2js:noInline')
  static ReportedMessages getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReportedMessages>(
          ReportedMessages.$_createMessage);
  static ReportedMessages? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  /// At most 100.
  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get seqs => $_getList(1);
}

enum ReportRequest_Target { userId, chatId, messages, notSet }

class ReportRequest extends $pb.GeneratedMessage {
  factory ReportRequest({
    $fixnum.Int64? userId,
    $fixnum.Int64? chatId,
    ReportedMessages? messages,
    ReportReason? reason,
    $core.String? comment,
    $core.bool? block,
  }) {
    final result = ReportRequest._();
    if (userId != null) result.userId = userId;
    if (chatId != null) result.chatId = chatId;
    if (messages != null) result.messages = messages;
    if (reason != null) result.reason = reason;
    if (comment != null) result.comment = comment;
    if (block != null) result.block = block;
    return result;
  }

  ReportRequest._();

  factory ReportRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportRequest()..mergeFromBuffer(data, registry);
  factory ReportRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportRequest()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ReportRequest_Target>
      _ReportRequest_TargetByTag = {
    1: ReportRequest_Target.userId,
    2: ReportRequest_Target.chatId,
    3: ReportRequest_Target.messages,
    0: ReportRequest_Target.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReportRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReportRequest.$_createMessage)
    ..oo(0, [1, 2, 3])
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..aInt64(2, _omitFieldNames ? '' : 'chatId')
    ..aOM<ReportedMessages>(3, _omitFieldNames ? '' : 'messages',
        subBuilder: ReportedMessages.$_createMessage)
    ..aE<ReportReason>(4, _omitFieldNames ? '' : 'reason',
        enumValues: ReportReason.values)
    ..aOS(5, _omitFieldNames ? '' : 'comment')
    ..aOB(6, _omitFieldNames ? '' : 'block')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportRequest copyWith(void Function(ReportRequest) updates) =>
      super.copyWith((message) => updates(message as ReportRequest))
          as ReportRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReportRequest() / ReportRequest.new instead')
  static ReportRequest create() => ReportRequest._();
  static $pb.GeneratedMessage $_createMessage() => ReportRequest._();
  @$core.override
  ReportRequest createEmptyInstance() => ReportRequest._();
  @$core.pragma('dart2js:noInline')
  static ReportRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReportRequest>(
          ReportRequest.$_createMessage);
  static ReportRequest? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  ReportRequest_Target whichTarget() =>
      _ReportRequest_TargetByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearTarget() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get chatId => $_getI64(1);
  @$pb.TagNumber(2)
  set chatId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasChatId() => $_has(1);
  @$pb.TagNumber(2)
  void clearChatId() => $_clearField(2);

  @$pb.TagNumber(3)
  ReportedMessages get messages => $_getN(2);
  @$pb.TagNumber(3)
  set messages(ReportedMessages value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMessages() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessages() => $_clearField(3);
  @$pb.TagNumber(3)
  ReportedMessages ensureMessages() => $_ensure(2);

  @$pb.TagNumber(4)
  ReportReason get reason => $_getN(3);
  @$pb.TagNumber(4)
  set reason(ReportReason value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasReason() => $_has(3);
  @$pb.TagNumber(4)
  void clearReason() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get comment => $_getSZ(4);
  @$pb.TagNumber(5)
  set comment($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasComment() => $_has(4);
  @$pb.TagNumber(5)
  void clearComment() => $_clearField(5);

  /// Also block the user (user/private-chat reports only).
  @$pb.TagNumber(6)
  $core.bool get block => $_getBF(5);
  @$pb.TagNumber(6)
  set block($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBlock() => $_has(5);
  @$pb.TagNumber(6)
  void clearBlock() => $_clearField(6);
}

class ReportResponse extends $pb.GeneratedMessage {
  factory ReportResponse({
    $fixnum.Int64? reportId,
  }) {
    final result = ReportResponse._();
    if (reportId != null) result.reportId = reportId;
    return result;
  }

  ReportResponse._();

  factory ReportResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportResponse()..mergeFromBuffer(data, registry);
  factory ReportResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReportResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReportResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReportResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'reportId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReportResponse copyWith(void Function(ReportResponse) updates) =>
      super.copyWith((message) => updates(message as ReportResponse))
          as ReportResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReportResponse() / ReportResponse.new instead')
  static ReportResponse create() => ReportResponse._();
  static $pb.GeneratedMessage $_createMessage() => ReportResponse._();
  @$core.override
  ReportResponse createEmptyInstance() => ReportResponse._();
  @$core.pragma('dart2js:noInline')
  static ReportResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ReportResponse>(
          ReportResponse.$_createMessage);
  static ReportResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get reportId => $_getI64(0);
  @$pb.TagNumber(1)
  set reportId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReportId() => $_has(0);
  @$pb.TagNumber(1)
  void clearReportId() => $_clearField(1);
}

/// ModerationService: user-facing reporting. Reports land in the staff
/// moderation queue (admin panel). Blocking lives in UsersService.
class ModerationServiceApi {
  final $pb.RpcClient _client;

  ModerationServiceApi(this._client);

  $async.Future<ReportResponse> report(
          $pb.ClientContext? ctx, ReportRequest request) =>
      _client.invoke<ReportResponse>(
          ctx, 'ModerationService', 'Report', request, ReportResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
