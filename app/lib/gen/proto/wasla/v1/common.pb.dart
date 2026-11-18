// This is a generated file - do not edit.
//
// Generated from wasla/v1/common.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'common.pbenum.dart';

enum Peer_Kind { userId, chatId, notSet }

/// Peer is a conversation target when the chat_id may not be known yet.
/// Sending to your own user_id writes to Saved Messages.
class Peer extends $pb.GeneratedMessage {
  factory Peer({
    $fixnum.Int64? userId,
    $fixnum.Int64? chatId,
  }) {
    final result = Peer._();
    if (userId != null) result.userId = userId;
    if (chatId != null) result.chatId = chatId;
    return result;
  }

  Peer._();

  factory Peer.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Peer()..mergeFromBuffer(data, registry);
  factory Peer.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Peer()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Peer_Kind> _Peer_KindByTag = {
    1: Peer_Kind.userId,
    2: Peer_Kind.chatId,
    0: Peer_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Peer',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Peer.$_createMessage)
    ..oo(0, [1, 2])
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..aInt64(2, _omitFieldNames ? '' : 'chatId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Peer clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Peer copyWith(void Function(Peer) updates) =>
      super.copyWith((message) => updates(message as Peer)) as Peer;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Peer() / Peer.new instead')
  static Peer create() => Peer._();
  static $pb.GeneratedMessage $_createMessage() => Peer._();
  @$core.override
  Peer createEmptyInstance() => Peer._();
  @$core.pragma('dart2js:noInline')
  static Peer getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Peer>(Peer.$_createMessage);
  static Peer? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  Peer_Kind whichKind() => _Peer_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  void clearKind() => $_clearField($_whichOneof(0));

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
}

/// MessageRef points at one message.
class MessageRef extends $pb.GeneratedMessage {
  factory MessageRef({
    $fixnum.Int64? chatId,
    $fixnum.Int64? seq,
  }) {
    final result = MessageRef._();
    if (chatId != null) result.chatId = chatId;
    if (seq != null) result.seq = seq;
    return result;
  }

  MessageRef._();

  factory MessageRef.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageRef()..mergeFromBuffer(data, registry);
  factory MessageRef.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageRef()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessageRef',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MessageRef.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'seq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageRef clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageRef copyWith(void Function(MessageRef) updates) =>
      super.copyWith((message) => updates(message as MessageRef)) as MessageRef;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MessageRef() / MessageRef.new instead')
  static MessageRef create() => MessageRef._();
  static $pb.GeneratedMessage $_createMessage() => MessageRef._();
  @$core.override
  MessageRef createEmptyInstance() => MessageRef._();
  @$core.pragma('dart2js:noInline')
  static MessageRef getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MessageRef>(MessageRef.$_createMessage);
  static MessageRef? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get seq => $_getI64(1);
  @$pb.TagNumber(2)
  set seq($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSeq() => $_has(1);
  @$pb.TagNumber(2)
  void clearSeq() => $_clearField(2);
}

/// Avatar is a user or chat picture. The full image is fetched with
/// MediaService.GetDownloadUrl; thumbhash renders an instant placeholder.
class Avatar extends $pb.GeneratedMessage {
  factory Avatar({
    $fixnum.Int64? mediaId,
    $core.List<$core.int>? thumbhash,
  }) {
    final result = Avatar._();
    if (mediaId != null) result.mediaId = mediaId;
    if (thumbhash != null) result.thumbhash = thumbhash;
    return result;
  }

  Avatar._();

  factory Avatar.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Avatar()..mergeFromBuffer(data, registry);
  factory Avatar.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Avatar()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Avatar',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Avatar.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'mediaId')
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'thumbhash', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Avatar clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Avatar copyWith(void Function(Avatar) updates) =>
      super.copyWith((message) => updates(message as Avatar)) as Avatar;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Avatar() / Avatar.new instead')
  static Avatar create() => Avatar._();
  static $pb.GeneratedMessage $_createMessage() => Avatar._();
  @$core.override
  Avatar createEmptyInstance() => Avatar._();
  @$core.pragma('dart2js:noInline')
  static Avatar getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Avatar>(Avatar.$_createMessage);
  static Avatar? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get mediaId => $_getI64(0);
  @$pb.TagNumber(1)
  set mediaId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get thumbhash => $_getN(1);
  @$pb.TagNumber(2)
  set thumbhash($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasThumbhash() => $_has(1);
  @$pb.TagNumber(2)
  void clearThumbhash() => $_clearField(2);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
