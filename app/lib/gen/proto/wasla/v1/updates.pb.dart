// This is a generated file - do not edit.
//
// Generated from wasla/v1/updates.proto.

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

import 'chats.pb.dart' as $1;
import 'messages.pb.dart' as $2;
import 'users.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

/// UpdatesPush is the server-to-client push frame. users/chats carry any
/// entities the updates reference that the client may not have cached.
class UpdatesPush extends $pb.GeneratedMessage {
  factory UpdatesPush({
    $core.Iterable<Update>? updates,
    $core.Iterable<$0.User>? users,
    $core.Iterable<$1.Chat>? chats,
  }) {
    final result = UpdatesPush._();
    if (updates != null) result.updates.addAll(updates);
    if (users != null) result.users.addAll(users);
    if (chats != null) result.chats.addAll(chats);
    return result;
  }

  UpdatesPush._();

  factory UpdatesPush.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdatesPush()..mergeFromBuffer(data, registry);
  factory UpdatesPush.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdatesPush()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdatesPush',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UpdatesPush.$_createMessage)
    ..pPM<Update>(1, _omitFieldNames ? '' : 'updates',
        subBuilder: Update.$_createMessage)
    ..pPM<$0.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $0.User.$_createMessage)
    ..pPM<$1.Chat>(3, _omitFieldNames ? '' : 'chats',
        subBuilder: $1.Chat.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatesPush clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdatesPush copyWith(void Function(UpdatesPush) updates) =>
      super.copyWith((message) => updates(message as UpdatesPush))
          as UpdatesPush;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UpdatesPush() / UpdatesPush.new instead')
  static UpdatesPush create() => UpdatesPush._();
  static $pb.GeneratedMessage $_createMessage() => UpdatesPush._();
  @$core.override
  UpdatesPush createEmptyInstance() => UpdatesPush._();
  @$core.pragma('dart2js:noInline')
  static UpdatesPush getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdatesPush>(
          UpdatesPush.$_createMessage);
  static UpdatesPush? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Update> get updates => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.User> get users => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$1.Chat> get chats => $_getList(2);
}

enum Update_Kind {
  newMessage,
  messageEdited,
  messagesDeleted,
  readInbox,
  readOutbox,
  chatUpdated,
  chatLeft,
  dialogUpdated,
  pinnedDialogsReordered,
  messagePinned,
  historyCleared,
  contactJoined,
  userUpdated,
  typing,
  userStatus,
  notSet
}

class Update extends $pb.GeneratedMessage {
  factory Update({
    $fixnum.Int64? pts,
    $core.int? ptsCount,
    $fixnum.Int64? date,
    NewMessage? newMessage,
    MessageEdited? messageEdited,
    MessagesDeleted? messagesDeleted,
    ReadInbox? readInbox,
    ReadOutbox? readOutbox,
    ChatUpdated? chatUpdated,
    ChatLeft? chatLeft,
    DialogUpdated? dialogUpdated,
    PinnedDialogsReordered? pinnedDialogsReordered,
    MessagePinnedUpdate? messagePinned,
    HistoryCleared? historyCleared,
    ContactJoined? contactJoined,
    UserUpdated? userUpdated,
    Typing? typing,
    UserStatusChanged? userStatus,
  }) {
    final result = Update._();
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    if (date != null) result.date = date;
    if (newMessage != null) result.newMessage = newMessage;
    if (messageEdited != null) result.messageEdited = messageEdited;
    if (messagesDeleted != null) result.messagesDeleted = messagesDeleted;
    if (readInbox != null) result.readInbox = readInbox;
    if (readOutbox != null) result.readOutbox = readOutbox;
    if (chatUpdated != null) result.chatUpdated = chatUpdated;
    if (chatLeft != null) result.chatLeft = chatLeft;
    if (dialogUpdated != null) result.dialogUpdated = dialogUpdated;
    if (pinnedDialogsReordered != null)
      result.pinnedDialogsReordered = pinnedDialogsReordered;
    if (messagePinned != null) result.messagePinned = messagePinned;
    if (historyCleared != null) result.historyCleared = historyCleared;
    if (contactJoined != null) result.contactJoined = contactJoined;
    if (userUpdated != null) result.userUpdated = userUpdated;
    if (typing != null) result.typing = typing;
    if (userStatus != null) result.userStatus = userStatus;
    return result;
  }

  Update._();

  factory Update.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Update()..mergeFromBuffer(data, registry);
  factory Update.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Update()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Update_Kind> _Update_KindByTag = {
    10: Update_Kind.newMessage,
    11: Update_Kind.messageEdited,
    12: Update_Kind.messagesDeleted,
    13: Update_Kind.readInbox,
    14: Update_Kind.readOutbox,
    15: Update_Kind.chatUpdated,
    16: Update_Kind.chatLeft,
    17: Update_Kind.dialogUpdated,
    18: Update_Kind.pinnedDialogsReordered,
    19: Update_Kind.messagePinned,
    20: Update_Kind.historyCleared,
    21: Update_Kind.contactJoined,
    22: Update_Kind.userUpdated,
    40: Update_Kind.typing,
    41: Update_Kind.userStatus,
    0: Update_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Update',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Update.$_createMessage)
    ..oo(0, [10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 40, 41])
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'ptsCount')
    ..aInt64(3, _omitFieldNames ? '' : 'date')
    ..aOM<NewMessage>(10, _omitFieldNames ? '' : 'newMessage',
        subBuilder: NewMessage.$_createMessage)
    ..aOM<MessageEdited>(11, _omitFieldNames ? '' : 'messageEdited',
        subBuilder: MessageEdited.$_createMessage)
    ..aOM<MessagesDeleted>(12, _omitFieldNames ? '' : 'messagesDeleted',
        subBuilder: MessagesDeleted.$_createMessage)
    ..aOM<ReadInbox>(13, _omitFieldNames ? '' : 'readInbox',
        subBuilder: ReadInbox.$_createMessage)
    ..aOM<ReadOutbox>(14, _omitFieldNames ? '' : 'readOutbox',
        subBuilder: ReadOutbox.$_createMessage)
    ..aOM<ChatUpdated>(15, _omitFieldNames ? '' : 'chatUpdated',
        subBuilder: ChatUpdated.$_createMessage)
    ..aOM<ChatLeft>(16, _omitFieldNames ? '' : 'chatLeft',
        subBuilder: ChatLeft.$_createMessage)
    ..aOM<DialogUpdated>(17, _omitFieldNames ? '' : 'dialogUpdated',
        subBuilder: DialogUpdated.$_createMessage)
    ..aOM<PinnedDialogsReordered>(
        18, _omitFieldNames ? '' : 'pinnedDialogsReordered',
        subBuilder: PinnedDialogsReordered.$_createMessage)
    ..aOM<MessagePinnedUpdate>(19, _omitFieldNames ? '' : 'messagePinned',
        subBuilder: MessagePinnedUpdate.$_createMessage)
    ..aOM<HistoryCleared>(20, _omitFieldNames ? '' : 'historyCleared',
        subBuilder: HistoryCleared.$_createMessage)
    ..aOM<ContactJoined>(21, _omitFieldNames ? '' : 'contactJoined',
        subBuilder: ContactJoined.$_createMessage)
    ..aOM<UserUpdated>(22, _omitFieldNames ? '' : 'userUpdated',
        subBuilder: UserUpdated.$_createMessage)
    ..aOM<Typing>(40, _omitFieldNames ? '' : 'typing',
        subBuilder: Typing.$_createMessage)
    ..aOM<UserStatusChanged>(41, _omitFieldNames ? '' : 'userStatus',
        subBuilder: UserStatusChanged.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Update clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Update copyWith(void Function(Update) updates) =>
      super.copyWith((message) => updates(message as Update)) as Update;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Update() / Update.new instead')
  static Update create() => Update._();
  static $pb.GeneratedMessage $_createMessage() => Update._();
  @$core.override
  Update createEmptyInstance() => Update._();
  @$core.pragma('dart2js:noInline')
  static Update getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Update>(Update.$_createMessage);
  static Update? _defaultInstance;

  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(17)
  @$pb.TagNumber(18)
  @$pb.TagNumber(19)
  @$pb.TagNumber(20)
  @$pb.TagNumber(21)
  @$pb.TagNumber(22)
  @$pb.TagNumber(40)
  @$pb.TagNumber(41)
  Update_Kind whichKind() => _Update_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(10)
  @$pb.TagNumber(11)
  @$pb.TagNumber(12)
  @$pb.TagNumber(13)
  @$pb.TagNumber(14)
  @$pb.TagNumber(15)
  @$pb.TagNumber(16)
  @$pb.TagNumber(17)
  @$pb.TagNumber(18)
  @$pb.TagNumber(19)
  @$pb.TagNumber(20)
  @$pb.TagNumber(21)
  @$pb.TagNumber(22)
  @$pb.TagNumber(40)
  @$pb.TagNumber(41)
  void clearKind() => $_clearField($_whichOneof(0));

  /// 0 for ephemeral updates.
  @$pb.TagNumber(1)
  $fixnum.Int64 get pts => $_getI64(0);
  @$pb.TagNumber(1)
  set pts($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPts() => $_has(0);
  @$pb.TagNumber(1)
  void clearPts() => $_clearField(1);

  /// How many pts values this update consumes (normally 1).
  @$pb.TagNumber(2)
  $core.int get ptsCount => $_getIZ(1);
  @$pb.TagNumber(2)
  set ptsCount($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPtsCount() => $_has(1);
  @$pb.TagNumber(2)
  void clearPtsCount() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get date => $_getI64(2);
  @$pb.TagNumber(3)
  set date($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearDate() => $_clearField(3);

  @$pb.TagNumber(10)
  NewMessage get newMessage => $_getN(3);
  @$pb.TagNumber(10)
  set newMessage(NewMessage value) => $_setField(10, value);
  @$pb.TagNumber(10)
  $core.bool hasNewMessage() => $_has(3);
  @$pb.TagNumber(10)
  void clearNewMessage() => $_clearField(10);
  @$pb.TagNumber(10)
  NewMessage ensureNewMessage() => $_ensure(3);

  @$pb.TagNumber(11)
  MessageEdited get messageEdited => $_getN(4);
  @$pb.TagNumber(11)
  set messageEdited(MessageEdited value) => $_setField(11, value);
  @$pb.TagNumber(11)
  $core.bool hasMessageEdited() => $_has(4);
  @$pb.TagNumber(11)
  void clearMessageEdited() => $_clearField(11);
  @$pb.TagNumber(11)
  MessageEdited ensureMessageEdited() => $_ensure(4);

  @$pb.TagNumber(12)
  MessagesDeleted get messagesDeleted => $_getN(5);
  @$pb.TagNumber(12)
  set messagesDeleted(MessagesDeleted value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasMessagesDeleted() => $_has(5);
  @$pb.TagNumber(12)
  void clearMessagesDeleted() => $_clearField(12);
  @$pb.TagNumber(12)
  MessagesDeleted ensureMessagesDeleted() => $_ensure(5);

  @$pb.TagNumber(13)
  ReadInbox get readInbox => $_getN(6);
  @$pb.TagNumber(13)
  set readInbox(ReadInbox value) => $_setField(13, value);
  @$pb.TagNumber(13)
  $core.bool hasReadInbox() => $_has(6);
  @$pb.TagNumber(13)
  void clearReadInbox() => $_clearField(13);
  @$pb.TagNumber(13)
  ReadInbox ensureReadInbox() => $_ensure(6);

  @$pb.TagNumber(14)
  ReadOutbox get readOutbox => $_getN(7);
  @$pb.TagNumber(14)
  set readOutbox(ReadOutbox value) => $_setField(14, value);
  @$pb.TagNumber(14)
  $core.bool hasReadOutbox() => $_has(7);
  @$pb.TagNumber(14)
  void clearReadOutbox() => $_clearField(14);
  @$pb.TagNumber(14)
  ReadOutbox ensureReadOutbox() => $_ensure(7);

  @$pb.TagNumber(15)
  ChatUpdated get chatUpdated => $_getN(8);
  @$pb.TagNumber(15)
  set chatUpdated(ChatUpdated value) => $_setField(15, value);
  @$pb.TagNumber(15)
  $core.bool hasChatUpdated() => $_has(8);
  @$pb.TagNumber(15)
  void clearChatUpdated() => $_clearField(15);
  @$pb.TagNumber(15)
  ChatUpdated ensureChatUpdated() => $_ensure(8);

  @$pb.TagNumber(16)
  ChatLeft get chatLeft => $_getN(9);
  @$pb.TagNumber(16)
  set chatLeft(ChatLeft value) => $_setField(16, value);
  @$pb.TagNumber(16)
  $core.bool hasChatLeft() => $_has(9);
  @$pb.TagNumber(16)
  void clearChatLeft() => $_clearField(16);
  @$pb.TagNumber(16)
  ChatLeft ensureChatLeft() => $_ensure(9);

  @$pb.TagNumber(17)
  DialogUpdated get dialogUpdated => $_getN(10);
  @$pb.TagNumber(17)
  set dialogUpdated(DialogUpdated value) => $_setField(17, value);
  @$pb.TagNumber(17)
  $core.bool hasDialogUpdated() => $_has(10);
  @$pb.TagNumber(17)
  void clearDialogUpdated() => $_clearField(17);
  @$pb.TagNumber(17)
  DialogUpdated ensureDialogUpdated() => $_ensure(10);

  @$pb.TagNumber(18)
  PinnedDialogsReordered get pinnedDialogsReordered => $_getN(11);
  @$pb.TagNumber(18)
  set pinnedDialogsReordered(PinnedDialogsReordered value) =>
      $_setField(18, value);
  @$pb.TagNumber(18)
  $core.bool hasPinnedDialogsReordered() => $_has(11);
  @$pb.TagNumber(18)
  void clearPinnedDialogsReordered() => $_clearField(18);
  @$pb.TagNumber(18)
  PinnedDialogsReordered ensurePinnedDialogsReordered() => $_ensure(11);

  @$pb.TagNumber(19)
  MessagePinnedUpdate get messagePinned => $_getN(12);
  @$pb.TagNumber(19)
  set messagePinned(MessagePinnedUpdate value) => $_setField(19, value);
  @$pb.TagNumber(19)
  $core.bool hasMessagePinned() => $_has(12);
  @$pb.TagNumber(19)
  void clearMessagePinned() => $_clearField(19);
  @$pb.TagNumber(19)
  MessagePinnedUpdate ensureMessagePinned() => $_ensure(12);

  @$pb.TagNumber(20)
  HistoryCleared get historyCleared => $_getN(13);
  @$pb.TagNumber(20)
  set historyCleared(HistoryCleared value) => $_setField(20, value);
  @$pb.TagNumber(20)
  $core.bool hasHistoryCleared() => $_has(13);
  @$pb.TagNumber(20)
  void clearHistoryCleared() => $_clearField(20);
  @$pb.TagNumber(20)
  HistoryCleared ensureHistoryCleared() => $_ensure(13);

  @$pb.TagNumber(21)
  ContactJoined get contactJoined => $_getN(14);
  @$pb.TagNumber(21)
  set contactJoined(ContactJoined value) => $_setField(21, value);
  @$pb.TagNumber(21)
  $core.bool hasContactJoined() => $_has(14);
  @$pb.TagNumber(21)
  void clearContactJoined() => $_clearField(21);
  @$pb.TagNumber(21)
  ContactJoined ensureContactJoined() => $_ensure(14);

  @$pb.TagNumber(22)
  UserUpdated get userUpdated => $_getN(15);
  @$pb.TagNumber(22)
  set userUpdated(UserUpdated value) => $_setField(22, value);
  @$pb.TagNumber(22)
  $core.bool hasUserUpdated() => $_has(15);
  @$pb.TagNumber(22)
  void clearUserUpdated() => $_clearField(22);
  @$pb.TagNumber(22)
  UserUpdated ensureUserUpdated() => $_ensure(15);

  /// Ephemeral (pts = 0).
  @$pb.TagNumber(40)
  Typing get typing => $_getN(16);
  @$pb.TagNumber(40)
  set typing(Typing value) => $_setField(40, value);
  @$pb.TagNumber(40)
  $core.bool hasTyping() => $_has(16);
  @$pb.TagNumber(40)
  void clearTyping() => $_clearField(40);
  @$pb.TagNumber(40)
  Typing ensureTyping() => $_ensure(16);

  @$pb.TagNumber(41)
  UserStatusChanged get userStatus => $_getN(17);
  @$pb.TagNumber(41)
  set userStatus(UserStatusChanged value) => $_setField(41, value);
  @$pb.TagNumber(41)
  $core.bool hasUserStatus() => $_has(17);
  @$pb.TagNumber(41)
  void clearUserStatus() => $_clearField(41);
  @$pb.TagNumber(41)
  UserStatusChanged ensureUserStatus() => $_ensure(17);
}

class NewMessage extends $pb.GeneratedMessage {
  factory NewMessage({
    $2.Message? message,
  }) {
    final result = NewMessage._();
    if (message != null) result.message = message;
    return result;
  }

  NewMessage._();

  factory NewMessage.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NewMessage()..mergeFromBuffer(data, registry);
  factory NewMessage.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      NewMessage()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'NewMessage',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: NewMessage.$_createMessage)
    ..aOM<$2.Message>(1, _omitFieldNames ? '' : 'message',
        subBuilder: $2.Message.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewMessage clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  NewMessage copyWith(void Function(NewMessage) updates) =>
      super.copyWith((message) => updates(message as NewMessage)) as NewMessage;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use NewMessage() / NewMessage.new instead')
  static NewMessage create() => NewMessage._();
  static $pb.GeneratedMessage $_createMessage() => NewMessage._();
  @$core.override
  NewMessage createEmptyInstance() => NewMessage._();
  @$core.pragma('dart2js:noInline')
  static NewMessage getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<NewMessage>(NewMessage.$_createMessage);
  static NewMessage? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Message get message => $_getN(0);
  @$pb.TagNumber(1)
  set message($2.Message value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Message ensureMessage() => $_ensure(0);
}

class MessageEdited extends $pb.GeneratedMessage {
  factory MessageEdited({
    $2.Message? message,
  }) {
    final result = MessageEdited._();
    if (message != null) result.message = message;
    return result;
  }

  MessageEdited._();

  factory MessageEdited.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageEdited()..mergeFromBuffer(data, registry);
  factory MessageEdited.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageEdited()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessageEdited',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MessageEdited.$_createMessage)
    ..aOM<$2.Message>(1, _omitFieldNames ? '' : 'message',
        subBuilder: $2.Message.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageEdited clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageEdited copyWith(void Function(MessageEdited) updates) =>
      super.copyWith((message) => updates(message as MessageEdited))
          as MessageEdited;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MessageEdited() / MessageEdited.new instead')
  static MessageEdited create() => MessageEdited._();
  static $pb.GeneratedMessage $_createMessage() => MessageEdited._();
  @$core.override
  MessageEdited createEmptyInstance() => MessageEdited._();
  @$core.pragma('dart2js:noInline')
  static MessageEdited getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageEdited>(
          MessageEdited.$_createMessage);
  static MessageEdited? _defaultInstance;

  @$pb.TagNumber(1)
  $2.Message get message => $_getN(0);
  @$pb.TagNumber(1)
  set message($2.Message value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  $2.Message ensureMessage() => $_ensure(0);
}

class MessagesDeleted extends $pb.GeneratedMessage {
  factory MessagesDeleted({
    $fixnum.Int64? chatId,
    $core.Iterable<$fixnum.Int64>? seqs,
  }) {
    final result = MessagesDeleted._();
    if (chatId != null) result.chatId = chatId;
    if (seqs != null) result.seqs.addAll(seqs);
    return result;
  }

  MessagesDeleted._();

  factory MessagesDeleted.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessagesDeleted()..mergeFromBuffer(data, registry);
  factory MessagesDeleted.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessagesDeleted()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessagesDeleted',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MessagesDeleted.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'seqs', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessagesDeleted clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessagesDeleted copyWith(void Function(MessagesDeleted) updates) =>
      super.copyWith((message) => updates(message as MessagesDeleted))
          as MessagesDeleted;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MessagesDeleted() / MessagesDeleted.new instead')
  static MessagesDeleted create() => MessagesDeleted._();
  static $pb.GeneratedMessage $_createMessage() => MessagesDeleted._();
  @$core.override
  MessagesDeleted createEmptyInstance() => MessagesDeleted._();
  @$core.pragma('dart2js:noInline')
  static MessagesDeleted getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessagesDeleted>(
          MessagesDeleted.$_createMessage);
  static MessagesDeleted? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get seqs => $_getList(1);
}

/// ReadInbox: the user read a chat on another device.
class ReadInbox extends $pb.GeneratedMessage {
  factory ReadInbox({
    $fixnum.Int64? chatId,
    $fixnum.Int64? maxSeq,
    $core.int? stillUnreadCount,
  }) {
    final result = ReadInbox._();
    if (chatId != null) result.chatId = chatId;
    if (maxSeq != null) result.maxSeq = maxSeq;
    if (stillUnreadCount != null) result.stillUnreadCount = stillUnreadCount;
    return result;
  }

  ReadInbox._();

  factory ReadInbox.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadInbox()..mergeFromBuffer(data, registry);
  factory ReadInbox.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadInbox()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadInbox',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReadInbox.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'maxSeq')
    ..aI(3, _omitFieldNames ? '' : 'stillUnreadCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadInbox clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadInbox copyWith(void Function(ReadInbox) updates) =>
      super.copyWith((message) => updates(message as ReadInbox)) as ReadInbox;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReadInbox() / ReadInbox.new instead')
  static ReadInbox create() => ReadInbox._();
  static $pb.GeneratedMessage $_createMessage() => ReadInbox._();
  @$core.override
  ReadInbox createEmptyInstance() => ReadInbox._();
  @$core.pragma('dart2js:noInline')
  static ReadInbox getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadInbox>(ReadInbox.$_createMessage);
  static ReadInbox? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get maxSeq => $_getI64(1);
  @$pb.TagNumber(2)
  set maxSeq($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxSeq() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxSeq() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get stillUnreadCount => $_getIZ(2);
  @$pb.TagNumber(3)
  set stillUnreadCount($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasStillUnreadCount() => $_has(2);
  @$pb.TagNumber(3)
  void clearStillUnreadCount() => $_clearField(3);
}

/// ReadOutbox: someone read the user's messages up to max_seq (✓✓).
class ReadOutbox extends $pb.GeneratedMessage {
  factory ReadOutbox({
    $fixnum.Int64? chatId,
    $fixnum.Int64? maxSeq,
  }) {
    final result = ReadOutbox._();
    if (chatId != null) result.chatId = chatId;
    if (maxSeq != null) result.maxSeq = maxSeq;
    return result;
  }

  ReadOutbox._();

  factory ReadOutbox.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadOutbox()..mergeFromBuffer(data, registry);
  factory ReadOutbox.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadOutbox()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadOutbox',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReadOutbox.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'maxSeq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadOutbox clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadOutbox copyWith(void Function(ReadOutbox) updates) =>
      super.copyWith((message) => updates(message as ReadOutbox)) as ReadOutbox;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReadOutbox() / ReadOutbox.new instead')
  static ReadOutbox create() => ReadOutbox._();
  static $pb.GeneratedMessage $_createMessage() => ReadOutbox._();
  @$core.override
  ReadOutbox createEmptyInstance() => ReadOutbox._();
  @$core.pragma('dart2js:noInline')
  static ReadOutbox getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadOutbox>(ReadOutbox.$_createMessage);
  static ReadOutbox? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get maxSeq => $_getI64(1);
  @$pb.TagNumber(2)
  set maxSeq($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxSeq() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxSeq() => $_clearField(2);
}

class ChatUpdated extends $pb.GeneratedMessage {
  factory ChatUpdated({
    $1.Chat? chat,
  }) {
    final result = ChatUpdated._();
    if (chat != null) result.chat = chat;
    return result;
  }

  ChatUpdated._();

  factory ChatUpdated.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatUpdated()..mergeFromBuffer(data, registry);
  factory ChatUpdated.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatUpdated()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatUpdated',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ChatUpdated.$_createMessage)
    ..aOM<$1.Chat>(1, _omitFieldNames ? '' : 'chat',
        subBuilder: $1.Chat.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatUpdated clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatUpdated copyWith(void Function(ChatUpdated) updates) =>
      super.copyWith((message) => updates(message as ChatUpdated))
          as ChatUpdated;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatUpdated() / ChatUpdated.new instead')
  static ChatUpdated create() => ChatUpdated._();
  static $pb.GeneratedMessage $_createMessage() => ChatUpdated._();
  @$core.override
  ChatUpdated createEmptyInstance() => ChatUpdated._();
  @$core.pragma('dart2js:noInline')
  static ChatUpdated getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatUpdated>(
          ChatUpdated.$_createMessage);
  static ChatUpdated? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Chat get chat => $_getN(0);
  @$pb.TagNumber(1)
  set chat($1.Chat value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChat() => $_has(0);
  @$pb.TagNumber(1)
  void clearChat() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Chat ensureChat() => $_ensure(0);
}

/// ChatLeft: the user left or was removed. The client keeps the history
/// read-only until the user deletes the dialog.
class ChatLeft extends $pb.GeneratedMessage {
  factory ChatLeft({
    $fixnum.Int64? chatId,
    $core.bool? kicked,
  }) {
    final result = ChatLeft._();
    if (chatId != null) result.chatId = chatId;
    if (kicked != null) result.kicked = kicked;
    return result;
  }

  ChatLeft._();

  factory ChatLeft.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatLeft()..mergeFromBuffer(data, registry);
  factory ChatLeft.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatLeft()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatLeft',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ChatLeft.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aOB(2, _omitFieldNames ? '' : 'kicked')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatLeft clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatLeft copyWith(void Function(ChatLeft) updates) =>
      super.copyWith((message) => updates(message as ChatLeft)) as ChatLeft;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatLeft() / ChatLeft.new instead')
  static ChatLeft create() => ChatLeft._();
  static $pb.GeneratedMessage $_createMessage() => ChatLeft._();
  @$core.override
  ChatLeft createEmptyInstance() => ChatLeft._();
  @$core.pragma('dart2js:noInline')
  static ChatLeft getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ChatLeft>(ChatLeft.$_createMessage);
  static ChatLeft? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get kicked => $_getBF(1);
  @$pb.TagNumber(2)
  set kicked($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasKicked() => $_has(1);
  @$pb.TagNumber(2)
  void clearKicked() => $_clearField(2);
}

class DialogUpdated extends $pb.GeneratedMessage {
  factory DialogUpdated({
    $1.Dialog? dialog,
  }) {
    final result = DialogUpdated._();
    if (dialog != null) result.dialog = dialog;
    return result;
  }

  DialogUpdated._();

  factory DialogUpdated.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DialogUpdated()..mergeFromBuffer(data, registry);
  factory DialogUpdated.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DialogUpdated()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DialogUpdated',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DialogUpdated.$_createMessage)
    ..aOM<$1.Dialog>(1, _omitFieldNames ? '' : 'dialog',
        subBuilder: $1.Dialog.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DialogUpdated clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DialogUpdated copyWith(void Function(DialogUpdated) updates) =>
      super.copyWith((message) => updates(message as DialogUpdated))
          as DialogUpdated;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DialogUpdated() / DialogUpdated.new instead')
  static DialogUpdated create() => DialogUpdated._();
  static $pb.GeneratedMessage $_createMessage() => DialogUpdated._();
  @$core.override
  DialogUpdated createEmptyInstance() => DialogUpdated._();
  @$core.pragma('dart2js:noInline')
  static DialogUpdated getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DialogUpdated>(
          DialogUpdated.$_createMessage);
  static DialogUpdated? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Dialog get dialog => $_getN(0);
  @$pb.TagNumber(1)
  set dialog($1.Dialog value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasDialog() => $_has(0);
  @$pb.TagNumber(1)
  void clearDialog() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Dialog ensureDialog() => $_ensure(0);
}

class PinnedDialogsReordered extends $pb.GeneratedMessage {
  factory PinnedDialogsReordered({
    $core.Iterable<$fixnum.Int64>? chatIds,
    $core.bool? archived,
  }) {
    final result = PinnedDialogsReordered._();
    if (chatIds != null) result.chatIds.addAll(chatIds);
    if (archived != null) result.archived = archived;
    return result;
  }

  PinnedDialogsReordered._();

  factory PinnedDialogsReordered.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PinnedDialogsReordered()..mergeFromBuffer(data, registry);
  factory PinnedDialogsReordered.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PinnedDialogsReordered()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PinnedDialogsReordered',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: PinnedDialogsReordered.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'chatIds', $pb.PbFieldType.K6)
    ..aOB(2, _omitFieldNames ? '' : 'archived')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PinnedDialogsReordered clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PinnedDialogsReordered copyWith(
          void Function(PinnedDialogsReordered) updates) =>
      super.copyWith((message) => updates(message as PinnedDialogsReordered))
          as PinnedDialogsReordered;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use PinnedDialogsReordered() / PinnedDialogsReordered.new instead')
  static PinnedDialogsReordered create() => PinnedDialogsReordered._();
  static $pb.GeneratedMessage $_createMessage() => PinnedDialogsReordered._();
  @$core.override
  PinnedDialogsReordered createEmptyInstance() => PinnedDialogsReordered._();
  @$core.pragma('dart2js:noInline')
  static PinnedDialogsReordered getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PinnedDialogsReordered>(
          PinnedDialogsReordered.$_createMessage);
  static PinnedDialogsReordered? _defaultInstance;

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

class MessagePinnedUpdate extends $pb.GeneratedMessage {
  factory MessagePinnedUpdate({
    $fixnum.Int64? chatId,
    $fixnum.Int64? seq,
    $core.bool? pinned,
  }) {
    final result = MessagePinnedUpdate._();
    if (chatId != null) result.chatId = chatId;
    if (seq != null) result.seq = seq;
    if (pinned != null) result.pinned = pinned;
    return result;
  }

  MessagePinnedUpdate._();

  factory MessagePinnedUpdate.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessagePinnedUpdate()..mergeFromBuffer(data, registry);
  factory MessagePinnedUpdate.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessagePinnedUpdate()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessagePinnedUpdate',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MessagePinnedUpdate.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'seq')
    ..aOB(3, _omitFieldNames ? '' : 'pinned')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessagePinnedUpdate clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessagePinnedUpdate copyWith(void Function(MessagePinnedUpdate) updates) =>
      super.copyWith((message) => updates(message as MessagePinnedUpdate))
          as MessagePinnedUpdate;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use MessagePinnedUpdate() / MessagePinnedUpdate.new instead')
  static MessagePinnedUpdate create() => MessagePinnedUpdate._();
  static $pb.GeneratedMessage $_createMessage() => MessagePinnedUpdate._();
  @$core.override
  MessagePinnedUpdate createEmptyInstance() => MessagePinnedUpdate._();
  @$core.pragma('dart2js:noInline')
  static MessagePinnedUpdate getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MessagePinnedUpdate>(
          MessagePinnedUpdate.$_createMessage);
  static MessagePinnedUpdate? _defaultInstance;

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

  @$pb.TagNumber(3)
  $core.bool get pinned => $_getBF(2);
  @$pb.TagNumber(3)
  set pinned($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPinned() => $_has(2);
  @$pb.TagNumber(3)
  void clearPinned() => $_clearField(3);
}

class HistoryCleared extends $pb.GeneratedMessage {
  factory HistoryCleared({
    $fixnum.Int64? chatId,
    $fixnum.Int64? maxSeq,
  }) {
    final result = HistoryCleared._();
    if (chatId != null) result.chatId = chatId;
    if (maxSeq != null) result.maxSeq = maxSeq;
    return result;
  }

  HistoryCleared._();

  factory HistoryCleared.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HistoryCleared()..mergeFromBuffer(data, registry);
  factory HistoryCleared.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HistoryCleared()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HistoryCleared',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: HistoryCleared.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'maxSeq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HistoryCleared clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HistoryCleared copyWith(void Function(HistoryCleared) updates) =>
      super.copyWith((message) => updates(message as HistoryCleared))
          as HistoryCleared;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use HistoryCleared() / HistoryCleared.new instead')
  static HistoryCleared create() => HistoryCleared._();
  static $pb.GeneratedMessage $_createMessage() => HistoryCleared._();
  @$core.override
  HistoryCleared createEmptyInstance() => HistoryCleared._();
  @$core.pragma('dart2js:noInline')
  static HistoryCleared getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HistoryCleared>(
          HistoryCleared.$_createMessage);
  static HistoryCleared? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get maxSeq => $_getI64(1);
  @$pb.TagNumber(2)
  set maxSeq($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMaxSeq() => $_has(1);
  @$pb.TagNumber(2)
  void clearMaxSeq() => $_clearField(2);
}

class ContactJoined extends $pb.GeneratedMessage {
  factory ContactJoined({
    $fixnum.Int64? userId,
  }) {
    final result = ContactJoined._();
    if (userId != null) result.userId = userId;
    return result;
  }

  ContactJoined._();

  factory ContactJoined.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ContactJoined()..mergeFromBuffer(data, registry);
  factory ContactJoined.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ContactJoined()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContactJoined',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ContactJoined.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactJoined clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactJoined copyWith(void Function(ContactJoined) updates) =>
      super.copyWith((message) => updates(message as ContactJoined))
          as ContactJoined;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ContactJoined() / ContactJoined.new instead')
  static ContactJoined create() => ContactJoined._();
  static $pb.GeneratedMessage $_createMessage() => ContactJoined._();
  @$core.override
  ContactJoined createEmptyInstance() => ContactJoined._();
  @$core.pragma('dart2js:noInline')
  static ContactJoined getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContactJoined>(
          ContactJoined.$_createMessage);
  static ContactJoined? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class UserUpdated extends $pb.GeneratedMessage {
  factory UserUpdated({
    $0.User? user,
  }) {
    final result = UserUpdated._();
    if (user != null) result.user = user;
    return result;
  }

  UserUpdated._();

  factory UserUpdated.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserUpdated()..mergeFromBuffer(data, registry);
  factory UserUpdated.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserUpdated()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserUpdated',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UserUpdated.$_createMessage)
    ..aOM<$0.User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: $0.User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserUpdated clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserUpdated copyWith(void Function(UserUpdated) updates) =>
      super.copyWith((message) => updates(message as UserUpdated))
          as UserUpdated;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserUpdated() / UserUpdated.new instead')
  static UserUpdated create() => UserUpdated._();
  static $pb.GeneratedMessage $_createMessage() => UserUpdated._();
  @$core.override
  UserUpdated createEmptyInstance() => UserUpdated._();
  @$core.pragma('dart2js:noInline')
  static UserUpdated getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserUpdated>(
          UserUpdated.$_createMessage);
  static UserUpdated? _defaultInstance;

  @$pb.TagNumber(1)
  $0.User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user($0.User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.User ensureUser() => $_ensure(0);
}

class Typing extends $pb.GeneratedMessage {
  factory Typing({
    $fixnum.Int64? chatId,
    $fixnum.Int64? userId,
    $2.TypingAction? action,
  }) {
    final result = Typing._();
    if (chatId != null) result.chatId = chatId;
    if (userId != null) result.userId = userId;
    if (action != null) result.action = action;
    return result;
  }

  Typing._();

  factory Typing.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Typing()..mergeFromBuffer(data, registry);
  factory Typing.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Typing()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Typing',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Typing.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'userId')
    ..aE<$2.TypingAction>(3, _omitFieldNames ? '' : 'action',
        enumValues: $2.TypingAction.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Typing clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Typing copyWith(void Function(Typing) updates) =>
      super.copyWith((message) => updates(message as Typing)) as Typing;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Typing() / Typing.new instead')
  static Typing create() => Typing._();
  static $pb.GeneratedMessage $_createMessage() => Typing._();
  @$core.override
  Typing createEmptyInstance() => Typing._();
  @$core.pragma('dart2js:noInline')
  static Typing getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Typing>(Typing.$_createMessage);
  static Typing? _defaultInstance;

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
  $2.TypingAction get action => $_getN(2);
  @$pb.TagNumber(3)
  set action($2.TypingAction value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasAction() => $_has(2);
  @$pb.TagNumber(3)
  void clearAction() => $_clearField(3);
}

class UserStatusChanged extends $pb.GeneratedMessage {
  factory UserStatusChanged({
    $fixnum.Int64? userId,
    $0.UserStatus? status,
  }) {
    final result = UserStatusChanged._();
    if (userId != null) result.userId = userId;
    if (status != null) result.status = status;
    return result;
  }

  UserStatusChanged._();

  factory UserStatusChanged.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStatusChanged()..mergeFromBuffer(data, registry);
  factory UserStatusChanged.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStatusChanged()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserStatusChanged',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UserStatusChanged.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..aOM<$0.UserStatus>(2, _omitFieldNames ? '' : 'status',
        subBuilder: $0.UserStatus.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStatusChanged clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStatusChanged copyWith(void Function(UserStatusChanged) updates) =>
      super.copyWith((message) => updates(message as UserStatusChanged))
          as UserStatusChanged;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserStatusChanged() / UserStatusChanged.new instead')
  static UserStatusChanged create() => UserStatusChanged._();
  static $pb.GeneratedMessage $_createMessage() => UserStatusChanged._();
  @$core.override
  UserStatusChanged createEmptyInstance() => UserStatusChanged._();
  @$core.pragma('dart2js:noInline')
  static UserStatusChanged getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UserStatusChanged>(
          UserStatusChanged.$_createMessage);
  static UserStatusChanged? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.UserStatus get status => $_getN(1);
  @$pb.TagNumber(2)
  set status($0.UserStatus value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasStatus() => $_has(1);
  @$pb.TagNumber(2)
  void clearStatus() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.UserStatus ensureStatus() => $_ensure(1);
}

class GetStateRequest extends $pb.GeneratedMessage {
  factory GetStateRequest() => GetStateRequest._();

  GetStateRequest._();

  factory GetStateRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetStateRequest()..mergeFromBuffer(data, registry);
  factory GetStateRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetStateRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStateRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetStateRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStateRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStateRequest copyWith(void Function(GetStateRequest) updates) =>
      super.copyWith((message) => updates(message as GetStateRequest))
          as GetStateRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetStateRequest() / GetStateRequest.new instead')
  static GetStateRequest create() => GetStateRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetStateRequest._();
  @$core.override
  GetStateRequest createEmptyInstance() => GetStateRequest._();
  @$core.pragma('dart2js:noInline')
  static GetStateRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStateRequest>(
          GetStateRequest.$_createMessage);
  static GetStateRequest? _defaultInstance;
}

class GetStateResponse extends $pb.GeneratedMessage {
  factory GetStateResponse({
    $fixnum.Int64? pts,
    $fixnum.Int64? date,
  }) {
    final result = GetStateResponse._();
    if (pts != null) result.pts = pts;
    if (date != null) result.date = date;
    return result;
  }

  GetStateResponse._();

  factory GetStateResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetStateResponse()..mergeFromBuffer(data, registry);
  factory GetStateResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetStateResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetStateResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetStateResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aInt64(2, _omitFieldNames ? '' : 'date')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStateResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetStateResponse copyWith(void Function(GetStateResponse) updates) =>
      super.copyWith((message) => updates(message as GetStateResponse))
          as GetStateResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetStateResponse() / GetStateResponse.new instead')
  static GetStateResponse create() => GetStateResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetStateResponse._();
  @$core.override
  GetStateResponse createEmptyInstance() => GetStateResponse._();
  @$core.pragma('dart2js:noInline')
  static GetStateResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetStateResponse>(
          GetStateResponse.$_createMessage);
  static GetStateResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get pts => $_getI64(0);
  @$pb.TagNumber(1)
  set pts($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPts() => $_has(0);
  @$pb.TagNumber(1)
  void clearPts() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get date => $_getI64(1);
  @$pb.TagNumber(2)
  set date($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDate() => $_has(1);
  @$pb.TagNumber(2)
  void clearDate() => $_clearField(2);
}

class GetDifferenceRequest extends $pb.GeneratedMessage {
  factory GetDifferenceRequest({
    $fixnum.Int64? pts,
    $core.int? limit,
  }) {
    final result = GetDifferenceRequest._();
    if (pts != null) result.pts = pts;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetDifferenceRequest._();

  factory GetDifferenceRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDifferenceRequest()..mergeFromBuffer(data, registry);
  factory GetDifferenceRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDifferenceRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDifferenceRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetDifferenceRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDifferenceRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDifferenceRequest copyWith(void Function(GetDifferenceRequest) updates) =>
      super.copyWith((message) => updates(message as GetDifferenceRequest))
          as GetDifferenceRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetDifferenceRequest() / GetDifferenceRequest.new instead')
  static GetDifferenceRequest create() => GetDifferenceRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetDifferenceRequest._();
  @$core.override
  GetDifferenceRequest createEmptyInstance() => GetDifferenceRequest._();
  @$core.pragma('dart2js:noInline')
  static GetDifferenceRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDifferenceRequest>(
          GetDifferenceRequest.$_createMessage);
  static GetDifferenceRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get pts => $_getI64(0);
  @$pb.TagNumber(1)
  set pts($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPts() => $_has(0);
  @$pb.TagNumber(1)
  void clearPts() => $_clearField(1);

  /// At most 1000; default 500.
  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class GetDifferenceResponse extends $pb.GeneratedMessage {
  factory GetDifferenceResponse({
    $core.Iterable<Update>? updates,
    $core.Iterable<$0.User>? users,
    $core.Iterable<$1.Chat>? chats,
    $fixnum.Int64? pts,
    $core.bool? hasMore,
    $core.bool? tooLong,
  }) {
    final result = GetDifferenceResponse._();
    if (updates != null) result.updates.addAll(updates);
    if (users != null) result.users.addAll(users);
    if (chats != null) result.chats.addAll(chats);
    if (pts != null) result.pts = pts;
    if (hasMore != null) result.hasMore = hasMore;
    if (tooLong != null) result.tooLong = tooLong;
    return result;
  }

  GetDifferenceResponse._();

  factory GetDifferenceResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDifferenceResponse()..mergeFromBuffer(data, registry);
  factory GetDifferenceResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDifferenceResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDifferenceResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetDifferenceResponse.$_createMessage)
    ..pPM<Update>(1, _omitFieldNames ? '' : 'updates',
        subBuilder: Update.$_createMessage)
    ..pPM<$0.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $0.User.$_createMessage)
    ..pPM<$1.Chat>(3, _omitFieldNames ? '' : 'chats',
        subBuilder: $1.Chat.$_createMessage)
    ..aInt64(4, _omitFieldNames ? '' : 'pts')
    ..aOB(5, _omitFieldNames ? '' : 'hasMore')
    ..aOB(6, _omitFieldNames ? '' : 'tooLong')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDifferenceResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDifferenceResponse copyWith(
          void Function(GetDifferenceResponse) updates) =>
      super.copyWith((message) => updates(message as GetDifferenceResponse))
          as GetDifferenceResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetDifferenceResponse() / GetDifferenceResponse.new instead')
  static GetDifferenceResponse create() => GetDifferenceResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetDifferenceResponse._();
  @$core.override
  GetDifferenceResponse createEmptyInstance() => GetDifferenceResponse._();
  @$core.pragma('dart2js:noInline')
  static GetDifferenceResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDifferenceResponse>(
          GetDifferenceResponse.$_createMessage);
  static GetDifferenceResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Update> get updates => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.User> get users => $_getList(1);

  @$pb.TagNumber(3)
  $pb.PbList<$1.Chat> get chats => $_getList(2);

  /// The pts after applying these updates.
  @$pb.TagNumber(4)
  $fixnum.Int64 get pts => $_getI64(3);
  @$pb.TagNumber(4)
  set pts($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPts() => $_has(3);
  @$pb.TagNumber(4)
  void clearPts() => $_clearField(4);

  /// More updates are waiting: call again with the new pts.
  @$pb.TagNumber(5)
  $core.bool get hasMore => $_getBF(4);
  @$pb.TagNumber(5)
  set hasMore($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHasMore() => $_has(4);
  @$pb.TagNumber(5)
  void clearHasMore() => $_clearField(5);

  /// The requested pts is older than the log keeps. Drop local dialog state,
  /// reload with ChatsService.ListDialogs, and continue from its pts.
  @$pb.TagNumber(6)
  $core.bool get tooLong => $_getBF(5);
  @$pb.TagNumber(6)
  set tooLong($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasTooLong() => $_has(5);
  @$pb.TagNumber(6)
  void clearTooLong() => $_clearField(6);
}

/// UpdatesService: multi-device sync.
///
/// Every user has one update sequence number, pts. Each persistent change the
/// user must see (new message in any chat, edit, delete, read receipt, chat or
/// dialog change) gets the next pts and is stored in the user's update log.
/// Live updates arrive as UpdatesPush frames. After a reconnect, or when a gap
/// is detected, the client calls GetDifference(local_pts) and receives exactly
/// what it missed. Ephemeral updates (typing, online status) have pts = 0 and
/// are never replayed.
class UpdatesServiceApi {
  final $pb.RpcClient _client;

  UpdatesServiceApi(this._client);

  $async.Future<GetStateResponse> getState(
          $pb.ClientContext? ctx, GetStateRequest request) =>
      _client.invoke<GetStateResponse>(
          ctx, 'UpdatesService', 'GetState', request, GetStateResponse());
  $async.Future<GetDifferenceResponse> getDifference(
          $pb.ClientContext? ctx, GetDifferenceRequest request) =>
      _client.invoke<GetDifferenceResponse>(ctx, 'UpdatesService',
          'GetDifference', request, GetDifferenceResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
