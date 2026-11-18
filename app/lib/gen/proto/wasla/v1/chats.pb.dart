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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'chats.pbenum.dart';
import 'common.pb.dart' as $0;
import 'messages.pb.dart' as $1;
import 'users.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'chats.pbenum.dart';

class Chat extends $pb.GeneratedMessage {
  factory Chat({
    $fixnum.Int64? id,
    ChatType? type,
    $core.String? title,
    $core.String? about,
    $0.Avatar? photo,
    $fixnum.Int64? peerUserId,
    $core.int? memberCount,
    $fixnum.Int64? creatorId,
    $fixnum.Int64? defaultPermissions,
    ChatMemberRole? myRole,
    $fixnum.Int64? myAdminRights,
    $fixnum.Int64? lastSeq,
    $fixnum.Int64? createdAt,
  }) {
    final result = Chat._();
    if (id != null) result.id = id;
    if (type != null) result.type = type;
    if (title != null) result.title = title;
    if (about != null) result.about = about;
    if (photo != null) result.photo = photo;
    if (peerUserId != null) result.peerUserId = peerUserId;
    if (memberCount != null) result.memberCount = memberCount;
    if (creatorId != null) result.creatorId = creatorId;
    if (defaultPermissions != null)
      result.defaultPermissions = defaultPermissions;
    if (myRole != null) result.myRole = myRole;
    if (myAdminRights != null) result.myAdminRights = myAdminRights;
    if (lastSeq != null) result.lastSeq = lastSeq;
    if (createdAt != null) result.createdAt = createdAt;
    return result;
  }

  Chat._();

  factory Chat.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Chat()..mergeFromBuffer(data, registry);
  factory Chat.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Chat()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Chat',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Chat.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aE<ChatType>(2, _omitFieldNames ? '' : 'type',
        enumValues: ChatType.values)
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'about')
    ..aOM<$0.Avatar>(5, _omitFieldNames ? '' : 'photo',
        subBuilder: $0.Avatar.$_createMessage)
    ..aInt64(6, _omitFieldNames ? '' : 'peerUserId')
    ..aI(7, _omitFieldNames ? '' : 'memberCount')
    ..aInt64(8, _omitFieldNames ? '' : 'creatorId')
    ..a<$fixnum.Int64>(
        9, _omitFieldNames ? '' : 'defaultPermissions', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aE<ChatMemberRole>(10, _omitFieldNames ? '' : 'myRole',
        enumValues: ChatMemberRole.values)
    ..a<$fixnum.Int64>(
        11, _omitFieldNames ? '' : 'myAdminRights', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(12, _omitFieldNames ? '' : 'lastSeq')
    ..aInt64(13, _omitFieldNames ? '' : 'createdAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Chat clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Chat copyWith(void Function(Chat) updates) =>
      super.copyWith((message) => updates(message as Chat)) as Chat;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Chat() / Chat.new instead')
  static Chat create() => Chat._();
  static $pb.GeneratedMessage $_createMessage() => Chat._();
  @$core.override
  Chat createEmptyInstance() => Chat._();
  @$core.pragma('dart2js:noInline')
  static Chat getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Chat>(Chat.$_createMessage);
  static Chat? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  ChatType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(ChatType value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => $_clearField(2);

  /// Groups only. For private chats the client shows the peer's name.
  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get about => $_getSZ(3);
  @$pb.TagNumber(4)
  set about($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAbout() => $_has(3);
  @$pb.TagNumber(4)
  void clearAbout() => $_clearField(4);

  @$pb.TagNumber(5)
  $0.Avatar get photo => $_getN(4);
  @$pb.TagNumber(5)
  set photo($0.Avatar value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPhoto() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhoto() => $_clearField(5);
  @$pb.TagNumber(5)
  $0.Avatar ensurePhoto() => $_ensure(4);

  /// PRIVATE: the other user. SAVED: the requester.
  @$pb.TagNumber(6)
  $fixnum.Int64 get peerUserId => $_getI64(5);
  @$pb.TagNumber(6)
  set peerUserId($fixnum.Int64 value) => $_setInt64(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPeerUserId() => $_has(5);
  @$pb.TagNumber(6)
  void clearPeerUserId() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get memberCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set memberCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasMemberCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearMemberCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get creatorId => $_getI64(7);
  @$pb.TagNumber(8)
  set creatorId($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasCreatorId() => $_has(7);
  @$pb.TagNumber(8)
  void clearCreatorId() => $_clearField(8);

  @$pb.TagNumber(9)
  $fixnum.Int64 get defaultPermissions => $_getI64(8);
  @$pb.TagNumber(9)
  set defaultPermissions($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasDefaultPermissions() => $_has(8);
  @$pb.TagNumber(9)
  void clearDefaultPermissions() => $_clearField(9);

  @$pb.TagNumber(10)
  ChatMemberRole get myRole => $_getN(9);
  @$pb.TagNumber(10)
  set myRole(ChatMemberRole value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasMyRole() => $_has(9);
  @$pb.TagNumber(10)
  void clearMyRole() => $_clearField(10);

  @$pb.TagNumber(11)
  $fixnum.Int64 get myAdminRights => $_getI64(10);
  @$pb.TagNumber(11)
  set myAdminRights($fixnum.Int64 value) => $_setInt64(10, value);
  @$pb.TagNumber(11)
  $core.bool hasMyAdminRights() => $_has(10);
  @$pb.TagNumber(11)
  void clearMyAdminRights() => $_clearField(11);

  @$pb.TagNumber(12)
  $fixnum.Int64 get lastSeq => $_getI64(11);
  @$pb.TagNumber(12)
  set lastSeq($fixnum.Int64 value) => $_setInt64(11, value);
  @$pb.TagNumber(12)
  $core.bool hasLastSeq() => $_has(11);
  @$pb.TagNumber(12)
  void clearLastSeq() => $_clearField(12);

  @$pb.TagNumber(13)
  $fixnum.Int64 get createdAt => $_getI64(12);
  @$pb.TagNumber(13)
  set createdAt($fixnum.Int64 value) => $_setInt64(12, value);
  @$pb.TagNumber(13)
  $core.bool hasCreatedAt() => $_has(12);
  @$pb.TagNumber(13)
  void clearCreatedAt() => $_clearField(13);
}

/// Dialog is the requester's entry for a chat in the chat list.
class Dialog extends $pb.GeneratedMessage {
  factory Dialog({
    $fixnum.Int64? chatId,
    $1.Message? topMessage,
    $core.int? unreadCount,
    $fixnum.Int64? readInboxSeq,
    $fixnum.Int64? readOutboxSeq,
    $core.int? pinnedRank,
    $core.bool? archived,
    $fixnum.Int64? mutedUntil,
  }) {
    final result = Dialog._();
    if (chatId != null) result.chatId = chatId;
    if (topMessage != null) result.topMessage = topMessage;
    if (unreadCount != null) result.unreadCount = unreadCount;
    if (readInboxSeq != null) result.readInboxSeq = readInboxSeq;
    if (readOutboxSeq != null) result.readOutboxSeq = readOutboxSeq;
    if (pinnedRank != null) result.pinnedRank = pinnedRank;
    if (archived != null) result.archived = archived;
    if (mutedUntil != null) result.mutedUntil = mutedUntil;
    return result;
  }

  Dialog._();

  factory Dialog.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Dialog()..mergeFromBuffer(data, registry);
  factory Dialog.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Dialog()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Dialog',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Dialog.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aOM<$1.Message>(2, _omitFieldNames ? '' : 'topMessage',
        subBuilder: $1.Message.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'unreadCount')
    ..aInt64(4, _omitFieldNames ? '' : 'readInboxSeq')
    ..aInt64(5, _omitFieldNames ? '' : 'readOutboxSeq')
    ..aI(6, _omitFieldNames ? '' : 'pinnedRank')
    ..aOB(7, _omitFieldNames ? '' : 'archived')
    ..aInt64(8, _omitFieldNames ? '' : 'mutedUntil')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Dialog clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Dialog copyWith(void Function(Dialog) updates) =>
      super.copyWith((message) => updates(message as Dialog)) as Dialog;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Dialog() / Dialog.new instead')
  static Dialog create() => Dialog._();
  static $pb.GeneratedMessage $_createMessage() => Dialog._();
  @$core.override
  Dialog createEmptyInstance() => Dialog._();
  @$core.pragma('dart2js:noInline')
  static Dialog getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Dialog>(Dialog.$_createMessage);
  static Dialog? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Message get topMessage => $_getN(1);
  @$pb.TagNumber(2)
  set topMessage($1.Message value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasTopMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearTopMessage() => $_clearField(2);
  @$pb.TagNumber(2)
  $1.Message ensureTopMessage() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get unreadCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set unreadCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnreadCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnreadCount() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get readInboxSeq => $_getI64(3);
  @$pb.TagNumber(4)
  set readInboxSeq($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReadInboxSeq() => $_has(3);
  @$pb.TagNumber(4)
  void clearReadInboxSeq() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get readOutboxSeq => $_getI64(4);
  @$pb.TagNumber(5)
  set readOutboxSeq($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasReadOutboxSeq() => $_has(4);
  @$pb.TagNumber(5)
  void clearReadOutboxSeq() => $_clearField(5);

  /// 0 = not pinned; lower values sort first.
  @$pb.TagNumber(6)
  $core.int get pinnedRank => $_getIZ(5);
  @$pb.TagNumber(6)
  set pinnedRank($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasPinnedRank() => $_has(5);
  @$pb.TagNumber(6)
  void clearPinnedRank() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.bool get archived => $_getBF(6);
  @$pb.TagNumber(7)
  set archived($core.bool value) => $_setBool(6, value);
  @$pb.TagNumber(7)
  $core.bool hasArchived() => $_has(6);
  @$pb.TagNumber(7)
  void clearArchived() => $_clearField(7);

  /// 0 = not muted. Far-future value = muted forever.
  @$pb.TagNumber(8)
  $fixnum.Int64 get mutedUntil => $_getI64(7);
  @$pb.TagNumber(8)
  set mutedUntil($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasMutedUntil() => $_has(7);
  @$pb.TagNumber(8)
  void clearMutedUntil() => $_clearField(8);
}

class ChatMember extends $pb.GeneratedMessage {
  factory ChatMember({
    $fixnum.Int64? userId,
    ChatMemberRole? role,
    $fixnum.Int64? adminRights,
    $fixnum.Int64? joinedAt,
    $fixnum.Int64? invitedBy,
  }) {
    final result = ChatMember._();
    if (userId != null) result.userId = userId;
    if (role != null) result.role = role;
    if (adminRights != null) result.adminRights = adminRights;
    if (joinedAt != null) result.joinedAt = joinedAt;
    if (invitedBy != null) result.invitedBy = invitedBy;
    return result;
  }

  ChatMember._();

  factory ChatMember.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatMember()..mergeFromBuffer(data, registry);
  factory ChatMember.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatMember()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatMember',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ChatMember.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..aE<ChatMemberRole>(2, _omitFieldNames ? '' : 'role',
        enumValues: ChatMemberRole.values)
    ..a<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'adminRights', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aInt64(4, _omitFieldNames ? '' : 'joinedAt')
    ..aInt64(5, _omitFieldNames ? '' : 'invitedBy')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMember clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatMember copyWith(void Function(ChatMember) updates) =>
      super.copyWith((message) => updates(message as ChatMember)) as ChatMember;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatMember() / ChatMember.new instead')
  static ChatMember create() => ChatMember._();
  static $pb.GeneratedMessage $_createMessage() => ChatMember._();
  @$core.override
  ChatMember createEmptyInstance() => ChatMember._();
  @$core.pragma('dart2js:noInline')
  static ChatMember getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatMember>(ChatMember.$_createMessage);
  static ChatMember? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  ChatMemberRole get role => $_getN(1);
  @$pb.TagNumber(2)
  set role(ChatMemberRole value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(2)
  void clearRole() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get adminRights => $_getI64(2);
  @$pb.TagNumber(3)
  set adminRights($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAdminRights() => $_has(2);
  @$pb.TagNumber(3)
  void clearAdminRights() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get joinedAt => $_getI64(3);
  @$pb.TagNumber(4)
  set joinedAt($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasJoinedAt() => $_has(3);
  @$pb.TagNumber(4)
  void clearJoinedAt() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get invitedBy => $_getI64(4);
  @$pb.TagNumber(5)
  set invitedBy($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasInvitedBy() => $_has(4);
  @$pb.TagNumber(5)
  void clearInvitedBy() => $_clearField(5);
}

class ChatInvite extends $pb.GeneratedMessage {
  factory ChatInvite({
    $core.String? code,
    $core.String? url,
    $core.String? title,
    $fixnum.Int64? createdBy,
    $fixnum.Int64? expiresAt,
    $core.int? usageLimit,
    $core.int? usageCount,
    $core.bool? revoked,
  }) {
    final result = ChatInvite._();
    if (code != null) result.code = code;
    if (url != null) result.url = url;
    if (title != null) result.title = title;
    if (createdBy != null) result.createdBy = createdBy;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (usageLimit != null) result.usageLimit = usageLimit;
    if (usageCount != null) result.usageCount = usageCount;
    if (revoked != null) result.revoked = revoked;
    return result;
  }

  ChatInvite._();

  factory ChatInvite.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatInvite()..mergeFromBuffer(data, registry);
  factory ChatInvite.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatInvite()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatInvite',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ChatInvite.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aInt64(4, _omitFieldNames ? '' : 'createdBy')
    ..aInt64(5, _omitFieldNames ? '' : 'expiresAt')
    ..aI(6, _omitFieldNames ? '' : 'usageLimit')
    ..aI(7, _omitFieldNames ? '' : 'usageCount')
    ..aOB(8, _omitFieldNames ? '' : 'revoked')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatInvite clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatInvite copyWith(void Function(ChatInvite) updates) =>
      super.copyWith((message) => updates(message as ChatInvite)) as ChatInvite;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatInvite() / ChatInvite.new instead')
  static ChatInvite create() => ChatInvite._();
  static $pb.GeneratedMessage $_createMessage() => ChatInvite._();
  @$core.override
  ChatInvite createEmptyInstance() => ChatInvite._();
  @$core.pragma('dart2js:noInline')
  static ChatInvite getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatInvite>(ChatInvite.$_createMessage);
  static ChatInvite? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  /// https://wasla.app/+<code>
  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get createdBy => $_getI64(3);
  @$pb.TagNumber(4)
  set createdBy($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasCreatedBy() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreatedBy() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get expiresAt => $_getI64(4);
  @$pb.TagNumber(5)
  set expiresAt($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiresAt() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresAt() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get usageLimit => $_getIZ(5);
  @$pb.TagNumber(6)
  set usageLimit($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasUsageLimit() => $_has(5);
  @$pb.TagNumber(6)
  void clearUsageLimit() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get usageCount => $_getIZ(6);
  @$pb.TagNumber(7)
  set usageCount($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasUsageCount() => $_has(6);
  @$pb.TagNumber(7)
  void clearUsageCount() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.bool get revoked => $_getBF(7);
  @$pb.TagNumber(8)
  set revoked($core.bool value) => $_setBool(7, value);
  @$pb.TagNumber(8)
  $core.bool hasRevoked() => $_has(7);
  @$pb.TagNumber(8)
  void clearRevoked() => $_clearField(8);
}

class ListDialogsRequest extends $pb.GeneratedMessage {
  factory ListDialogsRequest({
    $core.bool? archived,
    $fixnum.Int64? offsetDate,
    $fixnum.Int64? offsetChatId,
    $core.int? limit,
  }) {
    final result = ListDialogsRequest._();
    if (archived != null) result.archived = archived;
    if (offsetDate != null) result.offsetDate = offsetDate;
    if (offsetChatId != null) result.offsetChatId = offsetChatId;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListDialogsRequest._();

  factory ListDialogsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListDialogsRequest()..mergeFromBuffer(data, registry);
  factory ListDialogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListDialogsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListDialogsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListDialogsRequest.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'archived')
    ..aInt64(2, _omitFieldNames ? '' : 'offsetDate')
    ..aInt64(3, _omitFieldNames ? '' : 'offsetChatId')
    ..aI(4, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDialogsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDialogsRequest copyWith(void Function(ListDialogsRequest) updates) =>
      super.copyWith((message) => updates(message as ListDialogsRequest))
          as ListDialogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ListDialogsRequest() / ListDialogsRequest.new instead')
  static ListDialogsRequest create() => ListDialogsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListDialogsRequest._();
  @$core.override
  ListDialogsRequest createEmptyInstance() => ListDialogsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListDialogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListDialogsRequest>(
          ListDialogsRequest.$_createMessage);
  static ListDialogsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get archived => $_getBF(0);
  @$pb.TagNumber(1)
  set archived($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasArchived() => $_has(0);
  @$pb.TagNumber(1)
  void clearArchived() => $_clearField(1);

  /// Keyset pagination: pass the top_message date and chat_id of the last
  /// dialog from the previous page. Zeros for the first page.
  @$pb.TagNumber(2)
  $fixnum.Int64 get offsetDate => $_getI64(1);
  @$pb.TagNumber(2)
  set offsetDate($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffsetDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffsetDate() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get offsetChatId => $_getI64(2);
  @$pb.TagNumber(3)
  set offsetChatId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOffsetChatId() => $_has(2);
  @$pb.TagNumber(3)
  void clearOffsetChatId() => $_clearField(3);

  /// At most 100.
  @$pb.TagNumber(4)
  $core.int get limit => $_getIZ(3);
  @$pb.TagNumber(4)
  set limit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearLimit() => $_clearField(4);
}

class ListDialogsResponse extends $pb.GeneratedMessage {
  factory ListDialogsResponse({
    $core.Iterable<Dialog>? dialogs,
    $core.Iterable<Chat>? chats,
    $core.Iterable<$2.User>? users,
    $core.bool? hasMore,
    $fixnum.Int64? pts,
  }) {
    final result = ListDialogsResponse._();
    if (dialogs != null) result.dialogs.addAll(dialogs);
    if (chats != null) result.chats.addAll(chats);
    if (users != null) result.users.addAll(users);
    if (hasMore != null) result.hasMore = hasMore;
    if (pts != null) result.pts = pts;
    return result;
  }

  ListDialogsResponse._();

  factory ListDialogsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListDialogsResponse()..mergeFromBuffer(data, registry);
  factory ListDialogsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListDialogsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListDialogsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListDialogsResponse.$_createMessage)
    ..pPM<Dialog>(1, _omitFieldNames ? '' : 'dialogs',
        subBuilder: Dialog.$_createMessage)
    ..pPM<Chat>(2, _omitFieldNames ? '' : 'chats',
        subBuilder: Chat.$_createMessage)
    ..pPM<$2.User>(3, _omitFieldNames ? '' : 'users',
        subBuilder: $2.User.$_createMessage)
    ..aOB(4, _omitFieldNames ? '' : 'hasMore')
    ..aInt64(5, _omitFieldNames ? '' : 'pts')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDialogsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListDialogsResponse copyWith(void Function(ListDialogsResponse) updates) =>
      super.copyWith((message) => updates(message as ListDialogsResponse))
          as ListDialogsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ListDialogsResponse() / ListDialogsResponse.new instead')
  static ListDialogsResponse create() => ListDialogsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListDialogsResponse._();
  @$core.override
  ListDialogsResponse createEmptyInstance() => ListDialogsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListDialogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListDialogsResponse>(
          ListDialogsResponse.$_createMessage);
  static ListDialogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Dialog> get dialogs => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<Chat> get chats => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$2.User> get users => $_getList(2);

  @$pb.TagNumber(4)
  $core.bool get hasMore => $_getBF(3);
  @$pb.TagNumber(4)
  set hasMore($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasHasMore() => $_has(3);
  @$pb.TagNumber(4)
  void clearHasMore() => $_clearField(4);

  /// The requester's current pts, so a fresh client can start syncing from here.
  @$pb.TagNumber(5)
  $fixnum.Int64 get pts => $_getI64(4);
  @$pb.TagNumber(5)
  set pts($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPts() => $_has(4);
  @$pb.TagNumber(5)
  void clearPts() => $_clearField(5);
}

class UpdateDialogRequest extends $pb.GeneratedMessage {
  factory UpdateDialogRequest({
    $fixnum.Int64? chatId,
    $core.bool? pinned,
    $core.bool? archived,
    $fixnum.Int64? mutedUntil,
  }) {
    final result = UpdateDialogRequest._();
    if (chatId != null) result.chatId = chatId;
    if (pinned != null) result.pinned = pinned;
    if (archived != null) result.archived = archived;
    if (mutedUntil != null) result.mutedUntil = mutedUntil;
    return result;
  }

  UpdateDialogRequest._();

  factory UpdateDialogRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateDialogRequest()..mergeFromBuffer(data, registry);
  factory UpdateDialogRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateDialogRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDialogRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UpdateDialogRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aOB(2, _omitFieldNames ? '' : 'pinned')
    ..aOB(3, _omitFieldNames ? '' : 'archived')
    ..aInt64(4, _omitFieldNames ? '' : 'mutedUntil')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDialogRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDialogRequest copyWith(void Function(UpdateDialogRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateDialogRequest))
          as UpdateDialogRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use UpdateDialogRequest() / UpdateDialogRequest.new instead')
  static UpdateDialogRequest create() => UpdateDialogRequest._();
  static $pb.GeneratedMessage $_createMessage() => UpdateDialogRequest._();
  @$core.override
  UpdateDialogRequest createEmptyInstance() => UpdateDialogRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateDialogRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDialogRequest>(
          UpdateDialogRequest.$_createMessage);
  static UpdateDialogRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get pinned => $_getBF(1);
  @$pb.TagNumber(2)
  set pinned($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPinned() => $_has(1);
  @$pb.TagNumber(2)
  void clearPinned() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.bool get archived => $_getBF(2);
  @$pb.TagNumber(3)
  set archived($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasArchived() => $_has(2);
  @$pb.TagNumber(3)
  void clearArchived() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get mutedUntil => $_getI64(3);
  @$pb.TagNumber(4)
  set mutedUntil($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMutedUntil() => $_has(3);
  @$pb.TagNumber(4)
  void clearMutedUntil() => $_clearField(4);
}

class UpdateDialogResponse extends $pb.GeneratedMessage {
  factory UpdateDialogResponse({
    Dialog? dialog,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = UpdateDialogResponse._();
    if (dialog != null) result.dialog = dialog;
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  UpdateDialogResponse._();

  factory UpdateDialogResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateDialogResponse()..mergeFromBuffer(data, registry);
  factory UpdateDialogResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateDialogResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateDialogResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UpdateDialogResponse.$_createMessage)
    ..aOM<Dialog>(1, _omitFieldNames ? '' : 'dialog',
        subBuilder: Dialog.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDialogResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateDialogResponse copyWith(void Function(UpdateDialogResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateDialogResponse))
          as UpdateDialogResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateDialogResponse() / UpdateDialogResponse.new instead')
  static UpdateDialogResponse create() => UpdateDialogResponse._();
  static $pb.GeneratedMessage $_createMessage() => UpdateDialogResponse._();
  @$core.override
  UpdateDialogResponse createEmptyInstance() => UpdateDialogResponse._();
  @$core.pragma('dart2js:noInline')
  static UpdateDialogResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateDialogResponse>(
          UpdateDialogResponse.$_createMessage);
  static UpdateDialogResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Dialog get dialog => $_getN(0);
  @$pb.TagNumber(1)
  set dialog(Dialog value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDialog() => $_has(0);
  @$pb.TagNumber(1)
  void clearDialog() => $_clearField(1);
  @$pb.TagNumber(1)
  Dialog ensureDialog() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pts => $_getI64(1);
  @$pb.TagNumber(2)
  set pts($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPts() => $_has(1);
  @$pb.TagNumber(2)
  void clearPts() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ptsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set ptsCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPtsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearPtsCount() => $_clearField(3);
}

class ReorderPinnedDialogsRequest extends $pb.GeneratedMessage {
  factory ReorderPinnedDialogsRequest({
    $core.Iterable<$fixnum.Int64>? chatIds,
    $core.bool? archived,
  }) {
    final result = ReorderPinnedDialogsRequest._();
    if (chatIds != null) result.chatIds.addAll(chatIds);
    if (archived != null) result.archived = archived;
    return result;
  }

  ReorderPinnedDialogsRequest._();

  factory ReorderPinnedDialogsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReorderPinnedDialogsRequest()..mergeFromBuffer(data, registry);
  factory ReorderPinnedDialogsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReorderPinnedDialogsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReorderPinnedDialogsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReorderPinnedDialogsRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chatIds', $pb.PbFieldType.K6)
    ..aOB(2, _omitFieldNames ? '' : 'archived')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReorderPinnedDialogsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReorderPinnedDialogsRequest copyWith(
          void Function(ReorderPinnedDialogsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as ReorderPinnedDialogsRequest))
          as ReorderPinnedDialogsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReorderPinnedDialogsRequest() / ReorderPinnedDialogsRequest.new instead')
  static ReorderPinnedDialogsRequest create() =>
      ReorderPinnedDialogsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      ReorderPinnedDialogsRequest._();
  @$core.override
  ReorderPinnedDialogsRequest createEmptyInstance() =>
      ReorderPinnedDialogsRequest._();
  @$core.pragma('dart2js:noInline')
  static ReorderPinnedDialogsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReorderPinnedDialogsRequest>(
          ReorderPinnedDialogsRequest.$_createMessage);
  static ReorderPinnedDialogsRequest? _defaultInstance;

  /// The complete new order of pinned chats.
  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get chatIds => $_getList(0);

  @$pb.TagNumber(2)
  $core.bool get archived => $_getBF(1);
  @$pb.TagNumber(2)
  set archived($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasArchived() => $_has(1);
  @$pb.TagNumber(2)
  void clearArchived() => $_clearField(2);
}

class ReorderPinnedDialogsResponse extends $pb.GeneratedMessage {
  factory ReorderPinnedDialogsResponse({
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = ReorderPinnedDialogsResponse._();
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  ReorderPinnedDialogsResponse._();

  factory ReorderPinnedDialogsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReorderPinnedDialogsResponse()..mergeFromBuffer(data, registry);
  factory ReorderPinnedDialogsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReorderPinnedDialogsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReorderPinnedDialogsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReorderPinnedDialogsResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReorderPinnedDialogsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReorderPinnedDialogsResponse copyWith(
          void Function(ReorderPinnedDialogsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as ReorderPinnedDialogsResponse))
          as ReorderPinnedDialogsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ReorderPinnedDialogsResponse() / ReorderPinnedDialogsResponse.new instead')
  static ReorderPinnedDialogsResponse create() =>
      ReorderPinnedDialogsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      ReorderPinnedDialogsResponse._();
  @$core.override
  ReorderPinnedDialogsResponse createEmptyInstance() =>
      ReorderPinnedDialogsResponse._();
  @$core.pragma('dart2js:noInline')
  static ReorderPinnedDialogsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReorderPinnedDialogsResponse>(
          ReorderPinnedDialogsResponse.$_createMessage);
  static ReorderPinnedDialogsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get pts => $_getI64(0);
  @$pb.TagNumber(1)
  set pts($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPts() => $_has(0);
  @$pb.TagNumber(1)
  void clearPts() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get ptsCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set ptsCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPtsCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPtsCount() => $_clearField(2);
}

class ClearHistoryRequest extends $pb.GeneratedMessage {
  factory ClearHistoryRequest({
    $fixnum.Int64? chatId,
    $core.bool? forEveryone,
  }) {
    final result = ClearHistoryRequest._();
    if (chatId != null) result.chatId = chatId;
    if (forEveryone != null) result.forEveryone = forEveryone;
    return result;
  }

  ClearHistoryRequest._();

  factory ClearHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ClearHistoryRequest()..mergeFromBuffer(data, registry);
  factory ClearHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ClearHistoryRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClearHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ClearHistoryRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aOB(2, _omitFieldNames ? '' : 'forEveryone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClearHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClearHistoryRequest copyWith(void Function(ClearHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as ClearHistoryRequest))
          as ClearHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ClearHistoryRequest() / ClearHistoryRequest.new instead')
  static ClearHistoryRequest create() => ClearHistoryRequest._();
  static $pb.GeneratedMessage $_createMessage() => ClearHistoryRequest._();
  @$core.override
  ClearHistoryRequest createEmptyInstance() => ClearHistoryRequest._();
  @$core.pragma('dart2js:noInline')
  static ClearHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClearHistoryRequest>(
          ClearHistoryRequest.$_createMessage);
  static ClearHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  /// Private chats only: also clear it for the other person.
  @$pb.TagNumber(2)
  $core.bool get forEveryone => $_getBF(1);
  @$pb.TagNumber(2)
  set forEveryone($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasForEveryone() => $_has(1);
  @$pb.TagNumber(2)
  void clearForEveryone() => $_clearField(2);
}

class ClearHistoryResponse extends $pb.GeneratedMessage {
  factory ClearHistoryResponse({
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = ClearHistoryResponse._();
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  ClearHistoryResponse._();

  factory ClearHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ClearHistoryResponse()..mergeFromBuffer(data, registry);
  factory ClearHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ClearHistoryResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ClearHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ClearHistoryResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClearHistoryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ClearHistoryResponse copyWith(void Function(ClearHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as ClearHistoryResponse))
          as ClearHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ClearHistoryResponse() / ClearHistoryResponse.new instead')
  static ClearHistoryResponse create() => ClearHistoryResponse._();
  static $pb.GeneratedMessage $_createMessage() => ClearHistoryResponse._();
  @$core.override
  ClearHistoryResponse createEmptyInstance() => ClearHistoryResponse._();
  @$core.pragma('dart2js:noInline')
  static ClearHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ClearHistoryResponse>(
          ClearHistoryResponse.$_createMessage);
  static ClearHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get pts => $_getI64(0);
  @$pb.TagNumber(1)
  set pts($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPts() => $_has(0);
  @$pb.TagNumber(1)
  void clearPts() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get ptsCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set ptsCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPtsCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPtsCount() => $_clearField(2);
}

class GetChatsRequest extends $pb.GeneratedMessage {
  factory GetChatsRequest({
    $core.Iterable<$fixnum.Int64>? chatIds,
  }) {
    final result = GetChatsRequest._();
    if (chatIds != null) result.chatIds.addAll(chatIds);
    return result;
  }

  GetChatsRequest._();

  factory GetChatsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetChatsRequest()..mergeFromBuffer(data, registry);
  factory GetChatsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetChatsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChatsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetChatsRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chatIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChatsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChatsRequest copyWith(void Function(GetChatsRequest) updates) =>
      super.copyWith((message) => updates(message as GetChatsRequest))
          as GetChatsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetChatsRequest() / GetChatsRequest.new instead')
  static GetChatsRequest create() => GetChatsRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetChatsRequest._();
  @$core.override
  GetChatsRequest createEmptyInstance() => GetChatsRequest._();
  @$core.pragma('dart2js:noInline')
  static GetChatsRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChatsRequest>(
          GetChatsRequest.$_createMessage);
  static GetChatsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get chatIds => $_getList(0);
}

class GetChatsResponse extends $pb.GeneratedMessage {
  factory GetChatsResponse({
    $core.Iterable<Chat>? chats,
  }) {
    final result = GetChatsResponse._();
    if (chats != null) result.chats.addAll(chats);
    return result;
  }

  GetChatsResponse._();

  factory GetChatsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetChatsResponse()..mergeFromBuffer(data, registry);
  factory GetChatsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetChatsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetChatsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetChatsResponse.$_createMessage)
    ..pPM<Chat>(1, _omitFieldNames ? '' : 'chats',
        subBuilder: Chat.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChatsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetChatsResponse copyWith(void Function(GetChatsResponse) updates) =>
      super.copyWith((message) => updates(message as GetChatsResponse))
          as GetChatsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetChatsResponse() / GetChatsResponse.new instead')
  static GetChatsResponse create() => GetChatsResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetChatsResponse._();
  @$core.override
  GetChatsResponse createEmptyInstance() => GetChatsResponse._();
  @$core.pragma('dart2js:noInline')
  static GetChatsResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetChatsResponse>(
          GetChatsResponse.$_createMessage);
  static GetChatsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Chat> get chats => $_getList(0);
}

class GetPrivateChatRequest extends $pb.GeneratedMessage {
  factory GetPrivateChatRequest({
    $fixnum.Int64? userId,
  }) {
    final result = GetPrivateChatRequest._();
    if (userId != null) result.userId = userId;
    return result;
  }

  GetPrivateChatRequest._();

  factory GetPrivateChatRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetPrivateChatRequest()..mergeFromBuffer(data, registry);
  factory GetPrivateChatRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetPrivateChatRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPrivateChatRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetPrivateChatRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrivateChatRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrivateChatRequest copyWith(
          void Function(GetPrivateChatRequest) updates) =>
      super.copyWith((message) => updates(message as GetPrivateChatRequest))
          as GetPrivateChatRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetPrivateChatRequest() / GetPrivateChatRequest.new instead')
  static GetPrivateChatRequest create() => GetPrivateChatRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetPrivateChatRequest._();
  @$core.override
  GetPrivateChatRequest createEmptyInstance() => GetPrivateChatRequest._();
  @$core.pragma('dart2js:noInline')
  static GetPrivateChatRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPrivateChatRequest>(
          GetPrivateChatRequest.$_createMessage);
  static GetPrivateChatRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class GetPrivateChatResponse extends $pb.GeneratedMessage {
  factory GetPrivateChatResponse({
    Chat? chat,
    $2.User? user,
  }) {
    final result = GetPrivateChatResponse._();
    if (chat != null) result.chat = chat;
    if (user != null) result.user = user;
    return result;
  }

  GetPrivateChatResponse._();

  factory GetPrivateChatResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetPrivateChatResponse()..mergeFromBuffer(data, registry);
  factory GetPrivateChatResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetPrivateChatResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPrivateChatResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetPrivateChatResponse.$_createMessage)
    ..aOM<Chat>(1, _omitFieldNames ? '' : 'chat',
        subBuilder: Chat.$_createMessage)
    ..aOM<$2.User>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $2.User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrivateChatResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrivateChatResponse copyWith(
          void Function(GetPrivateChatResponse) updates) =>
      super.copyWith((message) => updates(message as GetPrivateChatResponse))
          as GetPrivateChatResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetPrivateChatResponse() / GetPrivateChatResponse.new instead')
  static GetPrivateChatResponse create() => GetPrivateChatResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetPrivateChatResponse._();
  @$core.override
  GetPrivateChatResponse createEmptyInstance() => GetPrivateChatResponse._();
  @$core.pragma('dart2js:noInline')
  static GetPrivateChatResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPrivateChatResponse>(
          GetPrivateChatResponse.$_createMessage);
  static GetPrivateChatResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat(Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  Chat ensureChat() => $_ensure(0);

  @$pb.TagNumber(2)
  $2.User get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($2.User value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $2.User ensureUser() => $_ensure(1);
}

class CreateGroupRequest extends $pb.GeneratedMessage {
  factory CreateGroupRequest({
    $core.String? title,
    $core.Iterable<$fixnum.Int64>? userIds,
    $fixnum.Int64? randomId,
  }) {
    final result = CreateGroupRequest._();
    if (title != null) result.title = title;
    if (userIds != null) result.userIds.addAll(userIds);
    if (randomId != null) result.randomId = randomId;
    return result;
  }

  CreateGroupRequest._();

  factory CreateGroupRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateGroupRequest()..mergeFromBuffer(data, registry);
  factory CreateGroupRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateGroupRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateGroupRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CreateGroupRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userIds', $pb.PbFieldType.K6)
    ..aInt64(3, _omitFieldNames ? '' : 'randomId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupRequest copyWith(void Function(CreateGroupRequest) updates) =>
      super.copyWith((message) => updates(message as CreateGroupRequest))
          as CreateGroupRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CreateGroupRequest() / CreateGroupRequest.new instead')
  static CreateGroupRequest create() => CreateGroupRequest._();
  static $pb.GeneratedMessage $_createMessage() => CreateGroupRequest._();
  @$core.override
  CreateGroupRequest createEmptyInstance() => CreateGroupRequest._();
  @$core.pragma('dart2js:noInline')
  static CreateGroupRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateGroupRequest>(
          CreateGroupRequest.$_createMessage);
  static CreateGroupRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get userIds => $_getList(1);

  /// Idempotency key for retries.
  @$pb.TagNumber(3)
  $fixnum.Int64 get randomId => $_getI64(2);
  @$pb.TagNumber(3)
  set randomId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRandomId() => $_has(2);
  @$pb.TagNumber(3)
  void clearRandomId() => $_clearField(3);
}

class CreateGroupResponse extends $pb.GeneratedMessage {
  factory CreateGroupResponse({
    Chat? chat,
    $core.Iterable<$fixnum.Int64>? privacyRestrictedUserIds,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = CreateGroupResponse._();
    if (chat != null) result.chat = chat;
    if (privacyRestrictedUserIds != null)
      result.privacyRestrictedUserIds.addAll(privacyRestrictedUserIds);
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  CreateGroupResponse._();

  factory CreateGroupResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateGroupResponse()..mergeFromBuffer(data, registry);
  factory CreateGroupResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateGroupResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateGroupResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CreateGroupResponse.$_createMessage)
    ..aOM<Chat>(1, _omitFieldNames ? '' : 'chat',
        subBuilder: Chat.$_createMessage)
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'privacyRestrictedUserIds',
        $pb.PbFieldType.K6)
    ..aInt64(3, _omitFieldNames ? '' : 'pts')
    ..aI(4, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateGroupResponse copyWith(void Function(CreateGroupResponse) updates) =>
      super.copyWith((message) => updates(message as CreateGroupResponse))
          as CreateGroupResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use CreateGroupResponse() / CreateGroupResponse.new instead')
  static CreateGroupResponse create() => CreateGroupResponse._();
  static $pb.GeneratedMessage $_createMessage() => CreateGroupResponse._();
  @$core.override
  CreateGroupResponse createEmptyInstance() => CreateGroupResponse._();
  @$core.pragma('dart2js:noInline')
  static CreateGroupResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateGroupResponse>(
          CreateGroupResponse.$_createMessage);
  static CreateGroupResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat(Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  Chat ensureChat() => $_ensure(0);

  /// Users who could not be added because of their GROUP_INVITES privacy;
  /// the client offers to send them an invite link instead.
  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get privacyRestrictedUserIds => $_getList(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get pts => $_getI64(2);
  @$pb.TagNumber(3)
  set pts($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPts() => $_has(2);
  @$pb.TagNumber(3)
  void clearPts() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get ptsCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set ptsCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPtsCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPtsCount() => $_clearField(4);
}

class UpdateChatInfoRequest extends $pb.GeneratedMessage {
  factory UpdateChatInfoRequest({
    $fixnum.Int64? chatId,
    $core.String? title,
    $core.String? about,
    $fixnum.Int64? photoMediaId,
  }) {
    final result = UpdateChatInfoRequest._();
    if (chatId != null) result.chatId = chatId;
    if (title != null) result.title = title;
    if (about != null) result.about = about;
    if (photoMediaId != null) result.photoMediaId = photoMediaId;
    return result;
  }

  UpdateChatInfoRequest._();

  factory UpdateChatInfoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateChatInfoRequest()..mergeFromBuffer(data, registry);
  factory UpdateChatInfoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateChatInfoRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateChatInfoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UpdateChatInfoRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOS(3, _omitFieldNames ? '' : 'about')
    ..aInt64(4, _omitFieldNames ? '' : 'photoMediaId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChatInfoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChatInfoRequest copyWith(
          void Function(UpdateChatInfoRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateChatInfoRequest))
          as UpdateChatInfoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateChatInfoRequest() / UpdateChatInfoRequest.new instead')
  static UpdateChatInfoRequest create() => UpdateChatInfoRequest._();
  static $pb.GeneratedMessage $_createMessage() => UpdateChatInfoRequest._();
  @$core.override
  UpdateChatInfoRequest createEmptyInstance() => UpdateChatInfoRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateChatInfoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateChatInfoRequest>(
          UpdateChatInfoRequest.$_createMessage);
  static UpdateChatInfoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get about => $_getSZ(2);
  @$pb.TagNumber(3)
  set about($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAbout() => $_has(2);
  @$pb.TagNumber(3)
  void clearAbout() => $_clearField(3);

  /// 0 removes the photo.
  @$pb.TagNumber(4)
  $fixnum.Int64 get photoMediaId => $_getI64(3);
  @$pb.TagNumber(4)
  set photoMediaId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPhotoMediaId() => $_has(3);
  @$pb.TagNumber(4)
  void clearPhotoMediaId() => $_clearField(4);
}

class UpdateChatInfoResponse extends $pb.GeneratedMessage {
  factory UpdateChatInfoResponse({
    Chat? chat,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = UpdateChatInfoResponse._();
    if (chat != null) result.chat = chat;
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  UpdateChatInfoResponse._();

  factory UpdateChatInfoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateChatInfoResponse()..mergeFromBuffer(data, registry);
  factory UpdateChatInfoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateChatInfoResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateChatInfoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UpdateChatInfoResponse.$_createMessage)
    ..aOM<Chat>(1, _omitFieldNames ? '' : 'chat',
        subBuilder: Chat.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChatInfoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateChatInfoResponse copyWith(
          void Function(UpdateChatInfoResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateChatInfoResponse))
          as UpdateChatInfoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateChatInfoResponse() / UpdateChatInfoResponse.new instead')
  static UpdateChatInfoResponse create() => UpdateChatInfoResponse._();
  static $pb.GeneratedMessage $_createMessage() => UpdateChatInfoResponse._();
  @$core.override
  UpdateChatInfoResponse createEmptyInstance() => UpdateChatInfoResponse._();
  @$core.pragma('dart2js:noInline')
  static UpdateChatInfoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateChatInfoResponse>(
          UpdateChatInfoResponse.$_createMessage);
  static UpdateChatInfoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat(Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  Chat ensureChat() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pts => $_getI64(1);
  @$pb.TagNumber(2)
  set pts($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPts() => $_has(1);
  @$pb.TagNumber(2)
  void clearPts() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ptsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set ptsCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPtsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearPtsCount() => $_clearField(3);
}

class SetDefaultPermissionsRequest extends $pb.GeneratedMessage {
  factory SetDefaultPermissionsRequest({
    $fixnum.Int64? chatId,
    $fixnum.Int64? permissions,
  }) {
    final result = SetDefaultPermissionsRequest._();
    if (chatId != null) result.chatId = chatId;
    if (permissions != null) result.permissions = permissions;
    return result;
  }

  SetDefaultPermissionsRequest._();

  factory SetDefaultPermissionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetDefaultPermissionsRequest()..mergeFromBuffer(data, registry);
  factory SetDefaultPermissionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetDefaultPermissionsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetDefaultPermissionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetDefaultPermissionsRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..a<$fixnum.Int64>(
        2, _omitFieldNames ? '' : 'permissions', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultPermissionsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultPermissionsRequest copyWith(
          void Function(SetDefaultPermissionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as SetDefaultPermissionsRequest))
          as SetDefaultPermissionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetDefaultPermissionsRequest() / SetDefaultPermissionsRequest.new instead')
  static SetDefaultPermissionsRequest create() =>
      SetDefaultPermissionsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      SetDefaultPermissionsRequest._();
  @$core.override
  SetDefaultPermissionsRequest createEmptyInstance() =>
      SetDefaultPermissionsRequest._();
  @$core.pragma('dart2js:noInline')
  static SetDefaultPermissionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetDefaultPermissionsRequest>(
          SetDefaultPermissionsRequest.$_createMessage);
  static SetDefaultPermissionsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get permissions => $_getI64(1);
  @$pb.TagNumber(2)
  set permissions($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPermissions() => $_has(1);
  @$pb.TagNumber(2)
  void clearPermissions() => $_clearField(2);
}

class SetDefaultPermissionsResponse extends $pb.GeneratedMessage {
  factory SetDefaultPermissionsResponse({
    Chat? chat,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = SetDefaultPermissionsResponse._();
    if (chat != null) result.chat = chat;
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  SetDefaultPermissionsResponse._();

  factory SetDefaultPermissionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetDefaultPermissionsResponse()..mergeFromBuffer(data, registry);
  factory SetDefaultPermissionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetDefaultPermissionsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetDefaultPermissionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetDefaultPermissionsResponse.$_createMessage)
    ..aOM<Chat>(1, _omitFieldNames ? '' : 'chat',
        subBuilder: Chat.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultPermissionsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetDefaultPermissionsResponse copyWith(
          void Function(SetDefaultPermissionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as SetDefaultPermissionsResponse))
          as SetDefaultPermissionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetDefaultPermissionsResponse() / SetDefaultPermissionsResponse.new instead')
  static SetDefaultPermissionsResponse create() =>
      SetDefaultPermissionsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      SetDefaultPermissionsResponse._();
  @$core.override
  SetDefaultPermissionsResponse createEmptyInstance() =>
      SetDefaultPermissionsResponse._();
  @$core.pragma('dart2js:noInline')
  static SetDefaultPermissionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetDefaultPermissionsResponse>(
          SetDefaultPermissionsResponse.$_createMessage);
  static SetDefaultPermissionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat(Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  Chat ensureChat() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pts => $_getI64(1);
  @$pb.TagNumber(2)
  set pts($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPts() => $_has(1);
  @$pb.TagNumber(2)
  void clearPts() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ptsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set ptsCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPtsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearPtsCount() => $_clearField(3);
}

class ListMembersRequest extends $pb.GeneratedMessage {
  factory ListMembersRequest({
    $fixnum.Int64? chatId,
    $core.int? offset,
    $core.int? limit,
  }) {
    final result = ListMembersRequest._();
    if (chatId != null) result.chatId = chatId;
    if (offset != null) result.offset = offset;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListMembersRequest._();

  factory ListMembersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMembersRequest()..mergeFromBuffer(data, registry);
  factory ListMembersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMembersRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMembersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListMembersRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aI(2, _omitFieldNames ? '' : 'offset')
    ..aI(3, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMembersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMembersRequest copyWith(void Function(ListMembersRequest) updates) =>
      super.copyWith((message) => updates(message as ListMembersRequest))
          as ListMembersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ListMembersRequest() / ListMembersRequest.new instead')
  static ListMembersRequest create() => ListMembersRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListMembersRequest._();
  @$core.override
  ListMembersRequest createEmptyInstance() => ListMembersRequest._();
  @$core.pragma('dart2js:noInline')
  static ListMembersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMembersRequest>(
          ListMembersRequest.$_createMessage);
  static ListMembersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get limit => $_getIZ(2);
  @$pb.TagNumber(3)
  set limit($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLimit() => $_has(2);
  @$pb.TagNumber(3)
  void clearLimit() => $_clearField(3);
}

class ListMembersResponse extends $pb.GeneratedMessage {
  factory ListMembersResponse({
    $core.Iterable<ChatMember>? members,
    $core.Iterable<$2.User>? users,
    $core.int? total,
  }) {
    final result = ListMembersResponse._();
    if (members != null) result.members.addAll(members);
    if (users != null) result.users.addAll(users);
    if (total != null) result.total = total;
    return result;
  }

  ListMembersResponse._();

  factory ListMembersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMembersResponse()..mergeFromBuffer(data, registry);
  factory ListMembersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListMembersResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListMembersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListMembersResponse.$_createMessage)
    ..pPM<ChatMember>(1, _omitFieldNames ? '' : 'members',
        subBuilder: ChatMember.$_createMessage)
    ..pPM<$2.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $2.User.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMembersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListMembersResponse copyWith(void Function(ListMembersResponse) updates) =>
      super.copyWith((message) => updates(message as ListMembersResponse))
          as ListMembersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ListMembersResponse() / ListMembersResponse.new instead')
  static ListMembersResponse create() => ListMembersResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListMembersResponse._();
  @$core.override
  ListMembersResponse createEmptyInstance() => ListMembersResponse._();
  @$core.pragma('dart2js:noInline')
  static ListMembersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListMembersResponse>(
          ListMembersResponse.$_createMessage);
  static ListMembersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ChatMember> get members => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$2.User> get users => $_getList(1);

  @$pb.TagNumber(3)
  $core.int get total => $_getIZ(2);
  @$pb.TagNumber(3)
  set total($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasTotal() => $_has(2);
  @$pb.TagNumber(3)
  void clearTotal() => $_clearField(3);
}

class AddMembersRequest extends $pb.GeneratedMessage {
  factory AddMembersRequest({
    $fixnum.Int64? chatId,
    $core.Iterable<$fixnum.Int64>? userIds,
  }) {
    final result = AddMembersRequest._();
    if (chatId != null) result.chatId = chatId;
    if (userIds != null) result.userIds.addAll(userIds);
    return result;
  }

  AddMembersRequest._();

  factory AddMembersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMembersRequest()..mergeFromBuffer(data, registry);
  factory AddMembersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMembersRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMembersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: AddMembersRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'userIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMembersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMembersRequest copyWith(void Function(AddMembersRequest) updates) =>
      super.copyWith((message) => updates(message as AddMembersRequest))
          as AddMembersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AddMembersRequest() / AddMembersRequest.new instead')
  static AddMembersRequest create() => AddMembersRequest._();
  static $pb.GeneratedMessage $_createMessage() => AddMembersRequest._();
  @$core.override
  AddMembersRequest createEmptyInstance() => AddMembersRequest._();
  @$core.pragma('dart2js:noInline')
  static AddMembersRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AddMembersRequest>(
          AddMembersRequest.$_createMessage);
  static AddMembersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get userIds => $_getList(1);
}

class AddMembersResponse extends $pb.GeneratedMessage {
  factory AddMembersResponse({
    $core.Iterable<$fixnum.Int64>? privacyRestrictedUserIds,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = AddMembersResponse._();
    if (privacyRestrictedUserIds != null)
      result.privacyRestrictedUserIds.addAll(privacyRestrictedUserIds);
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  AddMembersResponse._();

  factory AddMembersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMembersResponse()..mergeFromBuffer(data, registry);
  factory AddMembersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AddMembersResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AddMembersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: AddMembersResponse.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'privacyRestrictedUserIds',
        $pb.PbFieldType.K6)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMembersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AddMembersResponse copyWith(void Function(AddMembersResponse) updates) =>
      super.copyWith((message) => updates(message as AddMembersResponse))
          as AddMembersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AddMembersResponse() / AddMembersResponse.new instead')
  static AddMembersResponse create() => AddMembersResponse._();
  static $pb.GeneratedMessage $_createMessage() => AddMembersResponse._();
  @$core.override
  AddMembersResponse createEmptyInstance() => AddMembersResponse._();
  @$core.pragma('dart2js:noInline')
  static AddMembersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AddMembersResponse>(
          AddMembersResponse.$_createMessage);
  static AddMembersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get privacyRestrictedUserIds => $_getList(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pts => $_getI64(1);
  @$pb.TagNumber(2)
  set pts($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPts() => $_has(1);
  @$pb.TagNumber(2)
  void clearPts() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ptsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set ptsCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPtsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearPtsCount() => $_clearField(3);
}

class RemoveMemberRequest extends $pb.GeneratedMessage {
  factory RemoveMemberRequest({
    $fixnum.Int64? chatId,
    $fixnum.Int64? userId,
  }) {
    final result = RemoveMemberRequest._();
    if (chatId != null) result.chatId = chatId;
    if (userId != null) result.userId = userId;
    return result;
  }

  RemoveMemberRequest._();

  factory RemoveMemberRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RemoveMemberRequest()..mergeFromBuffer(data, registry);
  factory RemoveMemberRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RemoveMemberRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveMemberRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RemoveMemberRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberRequest copyWith(void Function(RemoveMemberRequest) updates) =>
      super.copyWith((message) => updates(message as RemoveMemberRequest))
          as RemoveMemberRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use RemoveMemberRequest() / RemoveMemberRequest.new instead')
  static RemoveMemberRequest create() => RemoveMemberRequest._();
  static $pb.GeneratedMessage $_createMessage() => RemoveMemberRequest._();
  @$core.override
  RemoveMemberRequest createEmptyInstance() => RemoveMemberRequest._();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveMemberRequest>(
          RemoveMemberRequest.$_createMessage);
  static RemoveMemberRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class RemoveMemberResponse extends $pb.GeneratedMessage {
  factory RemoveMemberResponse({
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = RemoveMemberResponse._();
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  RemoveMemberResponse._();

  factory RemoveMemberResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RemoveMemberResponse()..mergeFromBuffer(data, registry);
  factory RemoveMemberResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RemoveMemberResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RemoveMemberResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RemoveMemberResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RemoveMemberResponse copyWith(void Function(RemoveMemberResponse) updates) =>
      super.copyWith((message) => updates(message as RemoveMemberResponse))
          as RemoveMemberResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RemoveMemberResponse() / RemoveMemberResponse.new instead')
  static RemoveMemberResponse create() => RemoveMemberResponse._();
  static $pb.GeneratedMessage $_createMessage() => RemoveMemberResponse._();
  @$core.override
  RemoveMemberResponse createEmptyInstance() => RemoveMemberResponse._();
  @$core.pragma('dart2js:noInline')
  static RemoveMemberResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RemoveMemberResponse>(
          RemoveMemberResponse.$_createMessage);
  static RemoveMemberResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get pts => $_getI64(0);
  @$pb.TagNumber(1)
  set pts($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPts() => $_has(0);
  @$pb.TagNumber(1)
  void clearPts() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get ptsCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set ptsCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPtsCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPtsCount() => $_clearField(2);
}

class SetMemberRoleRequest extends $pb.GeneratedMessage {
  factory SetMemberRoleRequest({
    $fixnum.Int64? chatId,
    $fixnum.Int64? userId,
    ChatMemberRole? role,
    $fixnum.Int64? adminRights,
  }) {
    final result = SetMemberRoleRequest._();
    if (chatId != null) result.chatId = chatId;
    if (userId != null) result.userId = userId;
    if (role != null) result.role = role;
    if (adminRights != null) result.adminRights = adminRights;
    return result;
  }

  SetMemberRoleRequest._();

  factory SetMemberRoleRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetMemberRoleRequest()..mergeFromBuffer(data, registry);
  factory SetMemberRoleRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetMemberRoleRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetMemberRoleRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetMemberRoleRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'userId')
    ..aE<ChatMemberRole>(3, _omitFieldNames ? '' : 'role',
        enumValues: ChatMemberRole.values)
    ..a<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'adminRights', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetMemberRoleRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetMemberRoleRequest copyWith(void Function(SetMemberRoleRequest) updates) =>
      super.copyWith((message) => updates(message as SetMemberRoleRequest))
          as SetMemberRoleRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetMemberRoleRequest() / SetMemberRoleRequest.new instead')
  static SetMemberRoleRequest create() => SetMemberRoleRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetMemberRoleRequest._();
  @$core.override
  SetMemberRoleRequest createEmptyInstance() => SetMemberRoleRequest._();
  @$core.pragma('dart2js:noInline')
  static SetMemberRoleRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetMemberRoleRequest>(
          SetMemberRoleRequest.$_createMessage);
  static SetMemberRoleRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);

  @$pb.TagNumber(3)
  ChatMemberRole get role => $_getN(2);
  @$pb.TagNumber(3)
  set role(ChatMemberRole value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasRole() => $_has(2);
  @$pb.TagNumber(3)
  void clearRole() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get adminRights => $_getI64(3);
  @$pb.TagNumber(4)
  set adminRights($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAdminRights() => $_has(3);
  @$pb.TagNumber(4)
  void clearAdminRights() => $_clearField(4);
}

class SetMemberRoleResponse extends $pb.GeneratedMessage {
  factory SetMemberRoleResponse({
    ChatMember? member,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = SetMemberRoleResponse._();
    if (member != null) result.member = member;
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  SetMemberRoleResponse._();

  factory SetMemberRoleResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetMemberRoleResponse()..mergeFromBuffer(data, registry);
  factory SetMemberRoleResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetMemberRoleResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetMemberRoleResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetMemberRoleResponse.$_createMessage)
    ..aOM<ChatMember>(1, _omitFieldNames ? '' : 'member',
        subBuilder: ChatMember.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetMemberRoleResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetMemberRoleResponse copyWith(
          void Function(SetMemberRoleResponse) updates) =>
      super.copyWith((message) => updates(message as SetMemberRoleResponse))
          as SetMemberRoleResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetMemberRoleResponse() / SetMemberRoleResponse.new instead')
  static SetMemberRoleResponse create() => SetMemberRoleResponse._();
  static $pb.GeneratedMessage $_createMessage() => SetMemberRoleResponse._();
  @$core.override
  SetMemberRoleResponse createEmptyInstance() => SetMemberRoleResponse._();
  @$core.pragma('dart2js:noInline')
  static SetMemberRoleResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetMemberRoleResponse>(
          SetMemberRoleResponse.$_createMessage);
  static SetMemberRoleResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ChatMember get member => $_getN(0);
  @$pb.TagNumber(1)
  set member(ChatMember value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMember() => $_has(0);
  @$pb.TagNumber(1)
  void clearMember() => $_clearField(1);
  @$pb.TagNumber(1)
  ChatMember ensureMember() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pts => $_getI64(1);
  @$pb.TagNumber(2)
  set pts($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPts() => $_has(1);
  @$pb.TagNumber(2)
  void clearPts() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ptsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set ptsCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPtsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearPtsCount() => $_clearField(3);
}

class LeaveChatRequest extends $pb.GeneratedMessage {
  factory LeaveChatRequest({
    $fixnum.Int64? chatId,
  }) {
    final result = LeaveChatRequest._();
    if (chatId != null) result.chatId = chatId;
    return result;
  }

  LeaveChatRequest._();

  factory LeaveChatRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveChatRequest()..mergeFromBuffer(data, registry);
  factory LeaveChatRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveChatRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveChatRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: LeaveChatRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveChatRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveChatRequest copyWith(void Function(LeaveChatRequest) updates) =>
      super.copyWith((message) => updates(message as LeaveChatRequest))
          as LeaveChatRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LeaveChatRequest() / LeaveChatRequest.new instead')
  static LeaveChatRequest create() => LeaveChatRequest._();
  static $pb.GeneratedMessage $_createMessage() => LeaveChatRequest._();
  @$core.override
  LeaveChatRequest createEmptyInstance() => LeaveChatRequest._();
  @$core.pragma('dart2js:noInline')
  static LeaveChatRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveChatRequest>(
          LeaveChatRequest.$_createMessage);
  static LeaveChatRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);
}

class LeaveChatResponse extends $pb.GeneratedMessage {
  factory LeaveChatResponse({
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = LeaveChatResponse._();
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  LeaveChatResponse._();

  factory LeaveChatResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveChatResponse()..mergeFromBuffer(data, registry);
  factory LeaveChatResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LeaveChatResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LeaveChatResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: LeaveChatResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveChatResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LeaveChatResponse copyWith(void Function(LeaveChatResponse) updates) =>
      super.copyWith((message) => updates(message as LeaveChatResponse))
          as LeaveChatResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LeaveChatResponse() / LeaveChatResponse.new instead')
  static LeaveChatResponse create() => LeaveChatResponse._();
  static $pb.GeneratedMessage $_createMessage() => LeaveChatResponse._();
  @$core.override
  LeaveChatResponse createEmptyInstance() => LeaveChatResponse._();
  @$core.pragma('dart2js:noInline')
  static LeaveChatResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LeaveChatResponse>(
          LeaveChatResponse.$_createMessage);
  static LeaveChatResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get pts => $_getI64(0);
  @$pb.TagNumber(1)
  set pts($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPts() => $_has(0);
  @$pb.TagNumber(1)
  void clearPts() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get ptsCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set ptsCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPtsCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPtsCount() => $_clearField(2);
}

class CreateInviteLinkRequest extends $pb.GeneratedMessage {
  factory CreateInviteLinkRequest({
    $fixnum.Int64? chatId,
    $core.String? title,
    $fixnum.Int64? expiresAt,
    $core.int? usageLimit,
  }) {
    final result = CreateInviteLinkRequest._();
    if (chatId != null) result.chatId = chatId;
    if (title != null) result.title = title;
    if (expiresAt != null) result.expiresAt = expiresAt;
    if (usageLimit != null) result.usageLimit = usageLimit;
    return result;
  }

  CreateInviteLinkRequest._();

  factory CreateInviteLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateInviteLinkRequest()..mergeFromBuffer(data, registry);
  factory CreateInviteLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateInviteLinkRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInviteLinkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CreateInviteLinkRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresAt')
    ..aI(4, _omitFieldNames ? '' : 'usageLimit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInviteLinkRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInviteLinkRequest copyWith(
          void Function(CreateInviteLinkRequest) updates) =>
      super.copyWith((message) => updates(message as CreateInviteLinkRequest))
          as CreateInviteLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CreateInviteLinkRequest() / CreateInviteLinkRequest.new instead')
  static CreateInviteLinkRequest create() => CreateInviteLinkRequest._();
  static $pb.GeneratedMessage $_createMessage() => CreateInviteLinkRequest._();
  @$core.override
  CreateInviteLinkRequest createEmptyInstance() => CreateInviteLinkRequest._();
  @$core.pragma('dart2js:noInline')
  static CreateInviteLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInviteLinkRequest>(
          CreateInviteLinkRequest.$_createMessage);
  static CreateInviteLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresAt => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresAt($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get usageLimit => $_getIZ(3);
  @$pb.TagNumber(4)
  set usageLimit($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsageLimit() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsageLimit() => $_clearField(4);
}

class CreateInviteLinkResponse extends $pb.GeneratedMessage {
  factory CreateInviteLinkResponse({
    ChatInvite? invite,
  }) {
    final result = CreateInviteLinkResponse._();
    if (invite != null) result.invite = invite;
    return result;
  }

  CreateInviteLinkResponse._();

  factory CreateInviteLinkResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateInviteLinkResponse()..mergeFromBuffer(data, registry);
  factory CreateInviteLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateInviteLinkResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateInviteLinkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CreateInviteLinkResponse.$_createMessage)
    ..aOM<ChatInvite>(1, _omitFieldNames ? '' : 'invite',
        subBuilder: ChatInvite.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInviteLinkResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateInviteLinkResponse copyWith(
          void Function(CreateInviteLinkResponse) updates) =>
      super.copyWith((message) => updates(message as CreateInviteLinkResponse))
          as CreateInviteLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CreateInviteLinkResponse() / CreateInviteLinkResponse.new instead')
  static CreateInviteLinkResponse create() => CreateInviteLinkResponse._();
  static $pb.GeneratedMessage $_createMessage() => CreateInviteLinkResponse._();
  @$core.override
  CreateInviteLinkResponse createEmptyInstance() =>
      CreateInviteLinkResponse._();
  @$core.pragma('dart2js:noInline')
  static CreateInviteLinkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateInviteLinkResponse>(
          CreateInviteLinkResponse.$_createMessage);
  static CreateInviteLinkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  ChatInvite get invite => $_getN(0);
  @$pb.TagNumber(1)
  set invite(ChatInvite value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasInvite() => $_has(0);
  @$pb.TagNumber(1)
  void clearInvite() => $_clearField(1);
  @$pb.TagNumber(1)
  ChatInvite ensureInvite() => $_ensure(0);
}

class RevokeInviteLinkRequest extends $pb.GeneratedMessage {
  factory RevokeInviteLinkRequest({
    $fixnum.Int64? chatId,
    $core.String? code,
  }) {
    final result = RevokeInviteLinkRequest._();
    if (chatId != null) result.chatId = chatId;
    if (code != null) result.code = code;
    return result;
  }

  RevokeInviteLinkRequest._();

  factory RevokeInviteLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeInviteLinkRequest()..mergeFromBuffer(data, registry);
  factory RevokeInviteLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeInviteLinkRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevokeInviteLinkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RevokeInviteLinkRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aOS(2, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeInviteLinkRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeInviteLinkRequest copyWith(
          void Function(RevokeInviteLinkRequest) updates) =>
      super.copyWith((message) => updates(message as RevokeInviteLinkRequest))
          as RevokeInviteLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RevokeInviteLinkRequest() / RevokeInviteLinkRequest.new instead')
  static RevokeInviteLinkRequest create() => RevokeInviteLinkRequest._();
  static $pb.GeneratedMessage $_createMessage() => RevokeInviteLinkRequest._();
  @$core.override
  RevokeInviteLinkRequest createEmptyInstance() => RevokeInviteLinkRequest._();
  @$core.pragma('dart2js:noInline')
  static RevokeInviteLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevokeInviteLinkRequest>(
          RevokeInviteLinkRequest.$_createMessage);
  static RevokeInviteLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get code => $_getSZ(1);
  @$pb.TagNumber(2)
  set code($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => $_clearField(2);
}

class RevokeInviteLinkResponse extends $pb.GeneratedMessage {
  factory RevokeInviteLinkResponse() => RevokeInviteLinkResponse._();

  RevokeInviteLinkResponse._();

  factory RevokeInviteLinkResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeInviteLinkResponse()..mergeFromBuffer(data, registry);
  factory RevokeInviteLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeInviteLinkResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevokeInviteLinkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RevokeInviteLinkResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeInviteLinkResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeInviteLinkResponse copyWith(
          void Function(RevokeInviteLinkResponse) updates) =>
      super.copyWith((message) => updates(message as RevokeInviteLinkResponse))
          as RevokeInviteLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RevokeInviteLinkResponse() / RevokeInviteLinkResponse.new instead')
  static RevokeInviteLinkResponse create() => RevokeInviteLinkResponse._();
  static $pb.GeneratedMessage $_createMessage() => RevokeInviteLinkResponse._();
  @$core.override
  RevokeInviteLinkResponse createEmptyInstance() =>
      RevokeInviteLinkResponse._();
  @$core.pragma('dart2js:noInline')
  static RevokeInviteLinkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevokeInviteLinkResponse>(
          RevokeInviteLinkResponse.$_createMessage);
  static RevokeInviteLinkResponse? _defaultInstance;
}

class CheckInviteLinkRequest extends $pb.GeneratedMessage {
  factory CheckInviteLinkRequest({
    $core.String? code,
  }) {
    final result = CheckInviteLinkRequest._();
    if (code != null) result.code = code;
    return result;
  }

  CheckInviteLinkRequest._();

  factory CheckInviteLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckInviteLinkRequest()..mergeFromBuffer(data, registry);
  factory CheckInviteLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckInviteLinkRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckInviteLinkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CheckInviteLinkRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckInviteLinkRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckInviteLinkRequest copyWith(
          void Function(CheckInviteLinkRequest) updates) =>
      super.copyWith((message) => updates(message as CheckInviteLinkRequest))
          as CheckInviteLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckInviteLinkRequest() / CheckInviteLinkRequest.new instead')
  static CheckInviteLinkRequest create() => CheckInviteLinkRequest._();
  static $pb.GeneratedMessage $_createMessage() => CheckInviteLinkRequest._();
  @$core.override
  CheckInviteLinkRequest createEmptyInstance() => CheckInviteLinkRequest._();
  @$core.pragma('dart2js:noInline')
  static CheckInviteLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckInviteLinkRequest>(
          CheckInviteLinkRequest.$_createMessage);
  static CheckInviteLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);
}

class CheckInviteLinkResponse extends $pb.GeneratedMessage {
  factory CheckInviteLinkResponse({
    $core.String? title,
    $0.Avatar? photo,
    $core.int? memberCount,
    Chat? chat,
  }) {
    final result = CheckInviteLinkResponse._();
    if (title != null) result.title = title;
    if (photo != null) result.photo = photo;
    if (memberCount != null) result.memberCount = memberCount;
    if (chat != null) result.chat = chat;
    return result;
  }

  CheckInviteLinkResponse._();

  factory CheckInviteLinkResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckInviteLinkResponse()..mergeFromBuffer(data, registry);
  factory CheckInviteLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckInviteLinkResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckInviteLinkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CheckInviteLinkResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..aOM<$0.Avatar>(2, _omitFieldNames ? '' : 'photo',
        subBuilder: $0.Avatar.$_createMessage)
    ..aI(3, _omitFieldNames ? '' : 'memberCount')
    ..aOM<Chat>(4, _omitFieldNames ? '' : 'chat',
        subBuilder: Chat.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckInviteLinkResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckInviteLinkResponse copyWith(
          void Function(CheckInviteLinkResponse) updates) =>
      super.copyWith((message) => updates(message as CheckInviteLinkResponse))
          as CheckInviteLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckInviteLinkResponse() / CheckInviteLinkResponse.new instead')
  static CheckInviteLinkResponse create() => CheckInviteLinkResponse._();
  static $pb.GeneratedMessage $_createMessage() => CheckInviteLinkResponse._();
  @$core.override
  CheckInviteLinkResponse createEmptyInstance() => CheckInviteLinkResponse._();
  @$core.pragma('dart2js:noInline')
  static CheckInviteLinkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckInviteLinkResponse>(
          CheckInviteLinkResponse.$_createMessage);
  static CheckInviteLinkResponse? _defaultInstance;

  /// Preview shown before joining.
  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.Avatar get photo => $_getN(1);
  @$pb.TagNumber(2)
  set photo($0.Avatar value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPhoto() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhoto() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.Avatar ensurePhoto() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get memberCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set memberCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMemberCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearMemberCount() => $_clearField(3);

  /// Set if the requester is already a member.
  @$pb.TagNumber(4)
  Chat get chat => $_getN(3);
  @$pb.TagNumber(4)
  set chat(Chat value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasChat() => $_has(3);
  @$pb.TagNumber(4)
  void clearChat() => $_clearField(4);
  @$pb.TagNumber(4)
  Chat ensureChat() => $_ensure(3);
}

class JoinByInviteLinkRequest extends $pb.GeneratedMessage {
  factory JoinByInviteLinkRequest({
    $core.String? code,
  }) {
    final result = JoinByInviteLinkRequest._();
    if (code != null) result.code = code;
    return result;
  }

  JoinByInviteLinkRequest._();

  factory JoinByInviteLinkRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinByInviteLinkRequest()..mergeFromBuffer(data, registry);
  factory JoinByInviteLinkRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinByInviteLinkRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinByInviteLinkRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: JoinByInviteLinkRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinByInviteLinkRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinByInviteLinkRequest copyWith(
          void Function(JoinByInviteLinkRequest) updates) =>
      super.copyWith((message) => updates(message as JoinByInviteLinkRequest))
          as JoinByInviteLinkRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use JoinByInviteLinkRequest() / JoinByInviteLinkRequest.new instead')
  static JoinByInviteLinkRequest create() => JoinByInviteLinkRequest._();
  static $pb.GeneratedMessage $_createMessage() => JoinByInviteLinkRequest._();
  @$core.override
  JoinByInviteLinkRequest createEmptyInstance() => JoinByInviteLinkRequest._();
  @$core.pragma('dart2js:noInline')
  static JoinByInviteLinkRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JoinByInviteLinkRequest>(
          JoinByInviteLinkRequest.$_createMessage);
  static JoinByInviteLinkRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get code => $_getSZ(0);
  @$pb.TagNumber(1)
  set code($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);
}

class JoinByInviteLinkResponse extends $pb.GeneratedMessage {
  factory JoinByInviteLinkResponse({
    Chat? chat,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = JoinByInviteLinkResponse._();
    if (chat != null) result.chat = chat;
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  JoinByInviteLinkResponse._();

  factory JoinByInviteLinkResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinByInviteLinkResponse()..mergeFromBuffer(data, registry);
  factory JoinByInviteLinkResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      JoinByInviteLinkResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'JoinByInviteLinkResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: JoinByInviteLinkResponse.$_createMessage)
    ..aOM<Chat>(1, _omitFieldNames ? '' : 'chat',
        subBuilder: Chat.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinByInviteLinkResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  JoinByInviteLinkResponse copyWith(
          void Function(JoinByInviteLinkResponse) updates) =>
      super.copyWith((message) => updates(message as JoinByInviteLinkResponse))
          as JoinByInviteLinkResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use JoinByInviteLinkResponse() / JoinByInviteLinkResponse.new instead')
  static JoinByInviteLinkResponse create() => JoinByInviteLinkResponse._();
  static $pb.GeneratedMessage $_createMessage() => JoinByInviteLinkResponse._();
  @$core.override
  JoinByInviteLinkResponse createEmptyInstance() =>
      JoinByInviteLinkResponse._();
  @$core.pragma('dart2js:noInline')
  static JoinByInviteLinkResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<JoinByInviteLinkResponse>(
          JoinByInviteLinkResponse.$_createMessage);
  static JoinByInviteLinkResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat(Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  Chat ensureChat() => $_ensure(0);

  @$pb.TagNumber(2)
  $fixnum.Int64 get pts => $_getI64(1);
  @$pb.TagNumber(2)
  set pts($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPts() => $_has(1);
  @$pb.TagNumber(2)
  void clearPts() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get ptsCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set ptsCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPtsCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearPtsCount() => $_clearField(3);
}

/// ChatsService: the chat list (dialogs), groups and invite links.
class ChatsServiceApi {
  final $pb.RpcClient _client;

  ChatsServiceApi(this._client);

  $async.Future<ListDialogsResponse> listDialogs(
          $pb.ClientContext? ctx, ListDialogsRequest request) =>
      _client.invoke<ListDialogsResponse>(
          ctx, 'ChatsService', 'ListDialogs', request, ListDialogsResponse());
  $async.Future<UpdateDialogResponse> updateDialog(
          $pb.ClientContext? ctx, UpdateDialogRequest request) =>
      _client.invoke<UpdateDialogResponse>(
          ctx, 'ChatsService', 'UpdateDialog', request, UpdateDialogResponse());
  $async.Future<ReorderPinnedDialogsResponse> reorderPinnedDialogs(
          $pb.ClientContext? ctx, ReorderPinnedDialogsRequest request) =>
      _client.invoke<ReorderPinnedDialogsResponse>(ctx, 'ChatsService',
          'ReorderPinnedDialogs', request, ReorderPinnedDialogsResponse());
  $async.Future<ClearHistoryResponse> clearHistory(
          $pb.ClientContext? ctx, ClearHistoryRequest request) =>
      _client.invoke<ClearHistoryResponse>(
          ctx, 'ChatsService', 'ClearHistory', request, ClearHistoryResponse());
  $async.Future<GetChatsResponse> getChats(
          $pb.ClientContext? ctx, GetChatsRequest request) =>
      _client.invoke<GetChatsResponse>(
          ctx, 'ChatsService', 'GetChats', request, GetChatsResponse());

  /// Returns (creating it if needed) the private chat with a user. Empty
  /// private chats do not appear in ListDialogs.
  $async.Future<GetPrivateChatResponse> getPrivateChat(
          $pb.ClientContext? ctx, GetPrivateChatRequest request) =>
      _client.invoke<GetPrivateChatResponse>(ctx, 'ChatsService',
          'GetPrivateChat', request, GetPrivateChatResponse());
  $async.Future<CreateGroupResponse> createGroup(
          $pb.ClientContext? ctx, CreateGroupRequest request) =>
      _client.invoke<CreateGroupResponse>(
          ctx, 'ChatsService', 'CreateGroup', request, CreateGroupResponse());
  $async.Future<UpdateChatInfoResponse> updateChatInfo(
          $pb.ClientContext? ctx, UpdateChatInfoRequest request) =>
      _client.invoke<UpdateChatInfoResponse>(ctx, 'ChatsService',
          'UpdateChatInfo', request, UpdateChatInfoResponse());
  $async.Future<SetDefaultPermissionsResponse> setDefaultPermissions(
          $pb.ClientContext? ctx, SetDefaultPermissionsRequest request) =>
      _client.invoke<SetDefaultPermissionsResponse>(ctx, 'ChatsService',
          'SetDefaultPermissions', request, SetDefaultPermissionsResponse());
  $async.Future<ListMembersResponse> listMembers(
          $pb.ClientContext? ctx, ListMembersRequest request) =>
      _client.invoke<ListMembersResponse>(
          ctx, 'ChatsService', 'ListMembers', request, ListMembersResponse());
  $async.Future<AddMembersResponse> addMembers(
          $pb.ClientContext? ctx, AddMembersRequest request) =>
      _client.invoke<AddMembersResponse>(
          ctx, 'ChatsService', 'AddMembers', request, AddMembersResponse());
  $async.Future<RemoveMemberResponse> removeMember(
          $pb.ClientContext? ctx, RemoveMemberRequest request) =>
      _client.invoke<RemoveMemberResponse>(
          ctx, 'ChatsService', 'RemoveMember', request, RemoveMemberResponse());
  $async.Future<SetMemberRoleResponse> setMemberRole(
          $pb.ClientContext? ctx, SetMemberRoleRequest request) =>
      _client.invoke<SetMemberRoleResponse>(ctx, 'ChatsService',
          'SetMemberRole', request, SetMemberRoleResponse());
  $async.Future<LeaveChatResponse> leaveChat(
          $pb.ClientContext? ctx, LeaveChatRequest request) =>
      _client.invoke<LeaveChatResponse>(
          ctx, 'ChatsService', 'LeaveChat', request, LeaveChatResponse());
  $async.Future<CreateInviteLinkResponse> createInviteLink(
          $pb.ClientContext? ctx, CreateInviteLinkRequest request) =>
      _client.invoke<CreateInviteLinkResponse>(ctx, 'ChatsService',
          'CreateInviteLink', request, CreateInviteLinkResponse());
  $async.Future<RevokeInviteLinkResponse> revokeInviteLink(
          $pb.ClientContext? ctx, RevokeInviteLinkRequest request) =>
      _client.invoke<RevokeInviteLinkResponse>(ctx, 'ChatsService',
          'RevokeInviteLink', request, RevokeInviteLinkResponse());
  $async.Future<CheckInviteLinkResponse> checkInviteLink(
          $pb.ClientContext? ctx, CheckInviteLinkRequest request) =>
      _client.invoke<CheckInviteLinkResponse>(ctx, 'ChatsService',
          'CheckInviteLink', request, CheckInviteLinkResponse());
  $async.Future<JoinByInviteLinkResponse> joinByInviteLink(
          $pb.ClientContext? ctx, JoinByInviteLinkRequest request) =>
      _client.invoke<JoinByInviteLinkResponse>(ctx, 'ChatsService',
          'JoinByInviteLink', request, JoinByInviteLinkResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
