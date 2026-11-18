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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $1;
import 'media.pb.dart' as $0;
import 'messages.pbenum.dart';
import 'users.pb.dart' as $2;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'messages.pbenum.dart';

class Message extends $pb.GeneratedMessage {
  factory Message({
    $fixnum.Int64? chatId,
    $fixnum.Int64? seq,
    $fixnum.Int64? senderId,
    $fixnum.Int64? date,
    $fixnum.Int64? editDate,
    MessageContent? content,
    $fixnum.Int64? replyToSeq,
    ForwardInfo? forward,
    $fixnum.Int64? randomId,
    $core.bool? pinned,
  }) {
    final result = Message._();
    if (chatId != null) result.chatId = chatId;
    if (seq != null) result.seq = seq;
    if (senderId != null) result.senderId = senderId;
    if (date != null) result.date = date;
    if (editDate != null) result.editDate = editDate;
    if (content != null) result.content = content;
    if (replyToSeq != null) result.replyToSeq = replyToSeq;
    if (forward != null) result.forward = forward;
    if (randomId != null) result.randomId = randomId;
    if (pinned != null) result.pinned = pinned;
    return result;
  }

  Message._();

  factory Message.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Message()..mergeFromBuffer(data, registry);
  factory Message.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Message()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Message',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Message.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'seq')
    ..aInt64(3, _omitFieldNames ? '' : 'senderId')
    ..aInt64(4, _omitFieldNames ? '' : 'date')
    ..aInt64(5, _omitFieldNames ? '' : 'editDate')
    ..aOM<MessageContent>(6, _omitFieldNames ? '' : 'content',
        subBuilder: MessageContent.$_createMessage)
    ..aInt64(7, _omitFieldNames ? '' : 'replyToSeq')
    ..aOM<ForwardInfo>(8, _omitFieldNames ? '' : 'forward',
        subBuilder: ForwardInfo.$_createMessage)
    ..aInt64(9, _omitFieldNames ? '' : 'randomId')
    ..aOB(10, _omitFieldNames ? '' : 'pinned')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Message copyWith(void Function(Message) updates) =>
      super.copyWith((message) => updates(message as Message)) as Message;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Message() / Message.new instead')
  static Message create() => Message._();
  static $pb.GeneratedMessage $_createMessage() => Message._();
  @$core.override
  Message createEmptyInstance() => Message._();
  @$core.pragma('dart2js:noInline')
  static Message getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Message>(Message.$_createMessage);
  static Message? _defaultInstance;

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
  $fixnum.Int64 get senderId => $_getI64(2);
  @$pb.TagNumber(3)
  set senderId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSenderId() => $_has(2);
  @$pb.TagNumber(3)
  void clearSenderId() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get date => $_getI64(3);
  @$pb.TagNumber(4)
  set date($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasDate() => $_has(3);
  @$pb.TagNumber(4)
  void clearDate() => $_clearField(4);

  /// 0 if never edited.
  @$pb.TagNumber(5)
  $fixnum.Int64 get editDate => $_getI64(4);
  @$pb.TagNumber(5)
  set editDate($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasEditDate() => $_has(4);
  @$pb.TagNumber(5)
  void clearEditDate() => $_clearField(5);

  @$pb.TagNumber(6)
  MessageContent get content => $_getN(5);
  @$pb.TagNumber(6)
  set content(MessageContent value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasContent() => $_has(5);
  @$pb.TagNumber(6)
  void clearContent() => $_clearField(6);
  @$pb.TagNumber(6)
  MessageContent ensureContent() => $_ensure(5);

  /// 0 if not a reply.
  @$pb.TagNumber(7)
  $fixnum.Int64 get replyToSeq => $_getI64(6);
  @$pb.TagNumber(7)
  set replyToSeq($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasReplyToSeq() => $_has(6);
  @$pb.TagNumber(7)
  void clearReplyToSeq() => $_clearField(7);

  @$pb.TagNumber(8)
  ForwardInfo get forward => $_getN(7);
  @$pb.TagNumber(8)
  set forward(ForwardInfo value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasForward() => $_has(7);
  @$pb.TagNumber(8)
  void clearForward() => $_clearField(8);
  @$pb.TagNumber(8)
  ForwardInfo ensureForward() => $_ensure(7);

  /// Only set on the sender's own messages (lets the outbox match its entry).
  @$pb.TagNumber(9)
  $fixnum.Int64 get randomId => $_getI64(8);
  @$pb.TagNumber(9)
  set randomId($fixnum.Int64 value) => $_setInt64(8, value);
  @$pb.TagNumber(9)
  $core.bool hasRandomId() => $_has(8);
  @$pb.TagNumber(9)
  void clearRandomId() => $_clearField(9);

  @$pb.TagNumber(10)
  $core.bool get pinned => $_getBF(9);
  @$pb.TagNumber(10)
  set pinned($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasPinned() => $_has(9);
  @$pb.TagNumber(10)
  void clearPinned() => $_clearField(10);
}

enum MessageContent_Kind {
  text,
  photo,
  video,
  document,
  voice,
  location,
  contact,
  service,
  notSet
}

/// The oneof field numbers are also stored in messages.kind in the database.
class MessageContent extends $pb.GeneratedMessage {
  factory MessageContent({
    TextContent? text,
    PhotoContent? photo,
    VideoContent? video,
    DocumentContent? document,
    VoiceContent? voice,
    LocationContent? location,
    ContactContent? contact,
    ServiceContent? service,
  }) {
    final result = MessageContent._();
    if (text != null) result.text = text;
    if (photo != null) result.photo = photo;
    if (video != null) result.video = video;
    if (document != null) result.document = document;
    if (voice != null) result.voice = voice;
    if (location != null) result.location = location;
    if (contact != null) result.contact = contact;
    if (service != null) result.service = service;
    return result;
  }

  MessageContent._();

  factory MessageContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageContent()..mergeFromBuffer(data, registry);
  factory MessageContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessageContent()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, MessageContent_Kind>
      _MessageContent_KindByTag = {
    1: MessageContent_Kind.text,
    2: MessageContent_Kind.photo,
    3: MessageContent_Kind.video,
    4: MessageContent_Kind.document,
    5: MessageContent_Kind.voice,
    6: MessageContent_Kind.location,
    7: MessageContent_Kind.contact,
    8: MessageContent_Kind.service,
    0: MessageContent_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessageContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MessageContent.$_createMessage)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8])
    ..aOM<TextContent>(1, _omitFieldNames ? '' : 'text',
        subBuilder: TextContent.$_createMessage)
    ..aOM<PhotoContent>(2, _omitFieldNames ? '' : 'photo',
        subBuilder: PhotoContent.$_createMessage)
    ..aOM<VideoContent>(3, _omitFieldNames ? '' : 'video',
        subBuilder: VideoContent.$_createMessage)
    ..aOM<DocumentContent>(4, _omitFieldNames ? '' : 'document',
        subBuilder: DocumentContent.$_createMessage)
    ..aOM<VoiceContent>(5, _omitFieldNames ? '' : 'voice',
        subBuilder: VoiceContent.$_createMessage)
    ..aOM<LocationContent>(6, _omitFieldNames ? '' : 'location',
        subBuilder: LocationContent.$_createMessage)
    ..aOM<ContactContent>(7, _omitFieldNames ? '' : 'contact',
        subBuilder: ContactContent.$_createMessage)
    ..aOM<ServiceContent>(8, _omitFieldNames ? '' : 'service',
        subBuilder: ServiceContent.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessageContent copyWith(void Function(MessageContent) updates) =>
      super.copyWith((message) => updates(message as MessageContent))
          as MessageContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MessageContent() / MessageContent.new instead')
  static MessageContent create() => MessageContent._();
  static $pb.GeneratedMessage $_createMessage() => MessageContent._();
  @$core.override
  MessageContent createEmptyInstance() => MessageContent._();
  @$core.pragma('dart2js:noInline')
  static MessageContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageContent>(
          MessageContent.$_createMessage);
  static MessageContent? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  MessageContent_Kind whichKind() =>
      _MessageContent_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  TextContent get text => $_getN(0);
  @$pb.TagNumber(1)
  set text(TextContent value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);
  @$pb.TagNumber(1)
  TextContent ensureText() => $_ensure(0);

  @$pb.TagNumber(2)
  PhotoContent get photo => $_getN(1);
  @$pb.TagNumber(2)
  set photo(PhotoContent value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPhoto() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhoto() => $_clearField(2);
  @$pb.TagNumber(2)
  PhotoContent ensurePhoto() => $_ensure(1);

  @$pb.TagNumber(3)
  VideoContent get video => $_getN(2);
  @$pb.TagNumber(3)
  set video(VideoContent value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasVideo() => $_has(2);
  @$pb.TagNumber(3)
  void clearVideo() => $_clearField(3);
  @$pb.TagNumber(3)
  VideoContent ensureVideo() => $_ensure(2);

  @$pb.TagNumber(4)
  DocumentContent get document => $_getN(3);
  @$pb.TagNumber(4)
  set document(DocumentContent value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasDocument() => $_has(3);
  @$pb.TagNumber(4)
  void clearDocument() => $_clearField(4);
  @$pb.TagNumber(4)
  DocumentContent ensureDocument() => $_ensure(3);

  @$pb.TagNumber(5)
  VoiceContent get voice => $_getN(4);
  @$pb.TagNumber(5)
  set voice(VoiceContent value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasVoice() => $_has(4);
  @$pb.TagNumber(5)
  void clearVoice() => $_clearField(5);
  @$pb.TagNumber(5)
  VoiceContent ensureVoice() => $_ensure(4);

  @$pb.TagNumber(6)
  LocationContent get location => $_getN(5);
  @$pb.TagNumber(6)
  set location(LocationContent value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasLocation() => $_has(5);
  @$pb.TagNumber(6)
  void clearLocation() => $_clearField(6);
  @$pb.TagNumber(6)
  LocationContent ensureLocation() => $_ensure(5);

  @$pb.TagNumber(7)
  ContactContent get contact => $_getN(6);
  @$pb.TagNumber(7)
  set contact(ContactContent value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasContact() => $_has(6);
  @$pb.TagNumber(7)
  void clearContact() => $_clearField(7);
  @$pb.TagNumber(7)
  ContactContent ensureContact() => $_ensure(6);

  @$pb.TagNumber(8)
  ServiceContent get service => $_getN(7);
  @$pb.TagNumber(8)
  set service(ServiceContent value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasService() => $_has(7);
  @$pb.TagNumber(8)
  void clearService() => $_clearField(8);
  @$pb.TagNumber(8)
  ServiceContent ensureService() => $_ensure(7);
}

class FormattedText extends $pb.GeneratedMessage {
  factory FormattedText({
    $core.String? text,
    $core.Iterable<TextEntity>? entities,
  }) {
    final result = FormattedText._();
    if (text != null) result.text = text;
    if (entities != null) result.entities.addAll(entities);
    return result;
  }

  FormattedText._();

  factory FormattedText.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FormattedText()..mergeFromBuffer(data, registry);
  factory FormattedText.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      FormattedText()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'FormattedText',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: FormattedText.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'text')
    ..pPM<TextEntity>(2, _omitFieldNames ? '' : 'entities',
        subBuilder: TextEntity.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FormattedText clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  FormattedText copyWith(void Function(FormattedText) updates) =>
      super.copyWith((message) => updates(message as FormattedText))
          as FormattedText;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use FormattedText() / FormattedText.new instead')
  static FormattedText create() => FormattedText._();
  static $pb.GeneratedMessage $_createMessage() => FormattedText._();
  @$core.override
  FormattedText createEmptyInstance() => FormattedText._();
  @$core.pragma('dart2js:noInline')
  static FormattedText getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<FormattedText>(
          FormattedText.$_createMessage);
  static FormattedText? _defaultInstance;

  /// At most 4096 characters (1024 for captions).
  @$pb.TagNumber(1)
  $core.String get text => $_getSZ(0);
  @$pb.TagNumber(1)
  set text($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<TextEntity> get entities => $_getList(1);
}

class TextEntity extends $pb.GeneratedMessage {
  factory TextEntity({
    TextEntityType? type,
    $core.int? offset,
    $core.int? length,
    $core.String? url,
    $fixnum.Int64? userId,
  }) {
    final result = TextEntity._();
    if (type != null) result.type = type;
    if (offset != null) result.offset = offset;
    if (length != null) result.length = length;
    if (url != null) result.url = url;
    if (userId != null) result.userId = userId;
    return result;
  }

  TextEntity._();

  factory TextEntity.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TextEntity()..mergeFromBuffer(data, registry);
  factory TextEntity.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TextEntity()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TextEntity',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: TextEntity.$_createMessage)
    ..aE<TextEntityType>(1, _omitFieldNames ? '' : 'type',
        enumValues: TextEntityType.values)
    ..aI(2, _omitFieldNames ? '' : 'offset')
    ..aI(3, _omitFieldNames ? '' : 'length')
    ..aOS(4, _omitFieldNames ? '' : 'url')
    ..aInt64(5, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextEntity clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextEntity copyWith(void Function(TextEntity) updates) =>
      super.copyWith((message) => updates(message as TextEntity)) as TextEntity;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TextEntity() / TextEntity.new instead')
  static TextEntity create() => TextEntity._();
  static $pb.GeneratedMessage $_createMessage() => TextEntity._();
  @$core.override
  TextEntity createEmptyInstance() => TextEntity._();
  @$core.pragma('dart2js:noInline')
  static TextEntity getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<TextEntity>(TextEntity.$_createMessage);
  static TextEntity? _defaultInstance;

  @$pb.TagNumber(1)
  TextEntityType get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(TextEntityType value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  /// UTF-16 code units.
  @$pb.TagNumber(2)
  $core.int get offset => $_getIZ(1);
  @$pb.TagNumber(2)
  set offset($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffset() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffset() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get length => $_getIZ(2);
  @$pb.TagNumber(3)
  set length($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLength() => $_has(2);
  @$pb.TagNumber(3)
  void clearLength() => $_clearField(3);

  /// TEXT_URL only.
  @$pb.TagNumber(4)
  $core.String get url => $_getSZ(3);
  @$pb.TagNumber(4)
  set url($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUrl() => $_has(3);
  @$pb.TagNumber(4)
  void clearUrl() => $_clearField(4);

  /// MENTION_NAME only.
  @$pb.TagNumber(5)
  $fixnum.Int64 get userId => $_getI64(4);
  @$pb.TagNumber(5)
  set userId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasUserId() => $_has(4);
  @$pb.TagNumber(5)
  void clearUserId() => $_clearField(5);
}

class TextContent extends $pb.GeneratedMessage {
  factory TextContent({
    FormattedText? text,
  }) {
    final result = TextContent._();
    if (text != null) result.text = text;
    return result;
  }

  TextContent._();

  factory TextContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TextContent()..mergeFromBuffer(data, registry);
  factory TextContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      TextContent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'TextContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: TextContent.$_createMessage)
    ..aOM<FormattedText>(1, _omitFieldNames ? '' : 'text',
        subBuilder: FormattedText.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  TextContent copyWith(void Function(TextContent) updates) =>
      super.copyWith((message) => updates(message as TextContent))
          as TextContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use TextContent() / TextContent.new instead')
  static TextContent create() => TextContent._();
  static $pb.GeneratedMessage $_createMessage() => TextContent._();
  @$core.override
  TextContent createEmptyInstance() => TextContent._();
  @$core.pragma('dart2js:noInline')
  static TextContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<TextContent>(
          TextContent.$_createMessage);
  static TextContent? _defaultInstance;

  @$pb.TagNumber(1)
  FormattedText get text => $_getN(0);
  @$pb.TagNumber(1)
  set text(FormattedText value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);
  @$pb.TagNumber(1)
  FormattedText ensureText() => $_ensure(0);
}

class PhotoContent extends $pb.GeneratedMessage {
  factory PhotoContent({
    $0.Media? media,
    FormattedText? caption,
  }) {
    final result = PhotoContent._();
    if (media != null) result.media = media;
    if (caption != null) result.caption = caption;
    return result;
  }

  PhotoContent._();

  factory PhotoContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PhotoContent()..mergeFromBuffer(data, registry);
  factory PhotoContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PhotoContent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PhotoContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: PhotoContent.$_createMessage)
    ..aOM<$0.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $0.Media.$_createMessage)
    ..aOM<FormattedText>(2, _omitFieldNames ? '' : 'caption',
        subBuilder: FormattedText.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PhotoContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PhotoContent copyWith(void Function(PhotoContent) updates) =>
      super.copyWith((message) => updates(message as PhotoContent))
          as PhotoContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PhotoContent() / PhotoContent.new instead')
  static PhotoContent create() => PhotoContent._();
  static $pb.GeneratedMessage $_createMessage() => PhotoContent._();
  @$core.override
  PhotoContent createEmptyInstance() => PhotoContent._();
  @$core.pragma('dart2js:noInline')
  static PhotoContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PhotoContent>(
          PhotoContent.$_createMessage);
  static PhotoContent? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($0.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Media ensureMedia() => $_ensure(0);

  @$pb.TagNumber(2)
  FormattedText get caption => $_getN(1);
  @$pb.TagNumber(2)
  set caption(FormattedText value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCaption() => $_has(1);
  @$pb.TagNumber(2)
  void clearCaption() => $_clearField(2);
  @$pb.TagNumber(2)
  FormattedText ensureCaption() => $_ensure(1);
}

class VideoContent extends $pb.GeneratedMessage {
  factory VideoContent({
    $0.Media? media,
    FormattedText? caption,
  }) {
    final result = VideoContent._();
    if (media != null) result.media = media;
    if (caption != null) result.caption = caption;
    return result;
  }

  VideoContent._();

  factory VideoContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VideoContent()..mergeFromBuffer(data, registry);
  factory VideoContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VideoContent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VideoContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: VideoContent.$_createMessage)
    ..aOM<$0.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $0.Media.$_createMessage)
    ..aOM<FormattedText>(2, _omitFieldNames ? '' : 'caption',
        subBuilder: FormattedText.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VideoContent copyWith(void Function(VideoContent) updates) =>
      super.copyWith((message) => updates(message as VideoContent))
          as VideoContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use VideoContent() / VideoContent.new instead')
  static VideoContent create() => VideoContent._();
  static $pb.GeneratedMessage $_createMessage() => VideoContent._();
  @$core.override
  VideoContent createEmptyInstance() => VideoContent._();
  @$core.pragma('dart2js:noInline')
  static VideoContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VideoContent>(
          VideoContent.$_createMessage);
  static VideoContent? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($0.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Media ensureMedia() => $_ensure(0);

  @$pb.TagNumber(2)
  FormattedText get caption => $_getN(1);
  @$pb.TagNumber(2)
  set caption(FormattedText value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCaption() => $_has(1);
  @$pb.TagNumber(2)
  void clearCaption() => $_clearField(2);
  @$pb.TagNumber(2)
  FormattedText ensureCaption() => $_ensure(1);
}

class DocumentContent extends $pb.GeneratedMessage {
  factory DocumentContent({
    $0.Media? media,
    FormattedText? caption,
  }) {
    final result = DocumentContent._();
    if (media != null) result.media = media;
    if (caption != null) result.caption = caption;
    return result;
  }

  DocumentContent._();

  factory DocumentContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DocumentContent()..mergeFromBuffer(data, registry);
  factory DocumentContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DocumentContent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DocumentContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DocumentContent.$_createMessage)
    ..aOM<$0.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $0.Media.$_createMessage)
    ..aOM<FormattedText>(2, _omitFieldNames ? '' : 'caption',
        subBuilder: FormattedText.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DocumentContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DocumentContent copyWith(void Function(DocumentContent) updates) =>
      super.copyWith((message) => updates(message as DocumentContent))
          as DocumentContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use DocumentContent() / DocumentContent.new instead')
  static DocumentContent create() => DocumentContent._();
  static $pb.GeneratedMessage $_createMessage() => DocumentContent._();
  @$core.override
  DocumentContent createEmptyInstance() => DocumentContent._();
  @$core.pragma('dart2js:noInline')
  static DocumentContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DocumentContent>(
          DocumentContent.$_createMessage);
  static DocumentContent? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($0.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Media ensureMedia() => $_ensure(0);

  @$pb.TagNumber(2)
  FormattedText get caption => $_getN(1);
  @$pb.TagNumber(2)
  set caption(FormattedText value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCaption() => $_has(1);
  @$pb.TagNumber(2)
  void clearCaption() => $_clearField(2);
  @$pb.TagNumber(2)
  FormattedText ensureCaption() => $_ensure(1);
}

class VoiceContent extends $pb.GeneratedMessage {
  factory VoiceContent({
    $0.Media? media,
  }) {
    final result = VoiceContent._();
    if (media != null) result.media = media;
    return result;
  }

  VoiceContent._();

  factory VoiceContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VoiceContent()..mergeFromBuffer(data, registry);
  factory VoiceContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      VoiceContent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'VoiceContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: VoiceContent.$_createMessage)
    ..aOM<$0.Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: $0.Media.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  VoiceContent copyWith(void Function(VoiceContent) updates) =>
      super.copyWith((message) => updates(message as VoiceContent))
          as VoiceContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use VoiceContent() / VoiceContent.new instead')
  static VoiceContent create() => VoiceContent._();
  static $pb.GeneratedMessage $_createMessage() => VoiceContent._();
  @$core.override
  VoiceContent createEmptyInstance() => VoiceContent._();
  @$core.pragma('dart2js:noInline')
  static VoiceContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VoiceContent>(
          VoiceContent.$_createMessage);
  static VoiceContent? _defaultInstance;

  @$pb.TagNumber(1)
  $0.Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media($0.Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  $0.Media ensureMedia() => $_ensure(0);
}

class LocationContent extends $pb.GeneratedMessage {
  factory LocationContent({
    $core.double? latitude,
    $core.double? longitude,
    $core.double? accuracyMeters,
  }) {
    final result = LocationContent._();
    if (latitude != null) result.latitude = latitude;
    if (longitude != null) result.longitude = longitude;
    if (accuracyMeters != null) result.accuracyMeters = accuracyMeters;
    return result;
  }

  LocationContent._();

  factory LocationContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LocationContent()..mergeFromBuffer(data, registry);
  factory LocationContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LocationContent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LocationContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: LocationContent.$_createMessage)
    ..aD(1, _omitFieldNames ? '' : 'latitude')
    ..aD(2, _omitFieldNames ? '' : 'longitude')
    ..aD(3, _omitFieldNames ? '' : 'accuracyMeters',
        fieldType: $pb.PbFieldType.OF)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LocationContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LocationContent copyWith(void Function(LocationContent) updates) =>
      super.copyWith((message) => updates(message as LocationContent))
          as LocationContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LocationContent() / LocationContent.new instead')
  static LocationContent create() => LocationContent._();
  static $pb.GeneratedMessage $_createMessage() => LocationContent._();
  @$core.override
  LocationContent createEmptyInstance() => LocationContent._();
  @$core.pragma('dart2js:noInline')
  static LocationContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LocationContent>(
          LocationContent.$_createMessage);
  static LocationContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get latitude => $_getN(0);
  @$pb.TagNumber(1)
  set latitude($core.double value) => $_setDouble(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLatitude() => $_has(0);
  @$pb.TagNumber(1)
  void clearLatitude() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.double get longitude => $_getN(1);
  @$pb.TagNumber(2)
  set longitude($core.double value) => $_setDouble(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLongitude() => $_has(1);
  @$pb.TagNumber(2)
  void clearLongitude() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.double get accuracyMeters => $_getN(2);
  @$pb.TagNumber(3)
  set accuracyMeters($core.double value) => $_setFloat(2, value);
  @$pb.TagNumber(3)
  $core.bool hasAccuracyMeters() => $_has(2);
  @$pb.TagNumber(3)
  void clearAccuracyMeters() => $_clearField(3);
}

class ContactContent extends $pb.GeneratedMessage {
  factory ContactContent({
    $core.String? phone,
    $core.String? firstName,
    $core.String? lastName,
    $fixnum.Int64? userId,
  }) {
    final result = ContactContent._();
    if (phone != null) result.phone = phone;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (userId != null) result.userId = userId;
    return result;
  }

  ContactContent._();

  factory ContactContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ContactContent()..mergeFromBuffer(data, registry);
  factory ContactContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ContactContent()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ContactContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ContactContent.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aInt64(4, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ContactContent copyWith(void Function(ContactContent) updates) =>
      super.copyWith((message) => updates(message as ContactContent))
          as ContactContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ContactContent() / ContactContent.new instead')
  static ContactContent create() => ContactContent._();
  static $pb.GeneratedMessage $_createMessage() => ContactContent._();
  @$core.override
  ContactContent createEmptyInstance() => ContactContent._();
  @$core.pragma('dart2js:noInline')
  static ContactContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ContactContent>(
          ContactContent.$_createMessage);
  static ContactContent? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => $_clearField(3);

  /// Set when the phone belongs to a Wasla user.
  @$pb.TagNumber(4)
  $fixnum.Int64 get userId => $_getI64(3);
  @$pb.TagNumber(4)
  set userId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);
}

enum ServiceContent_Action {
  chatCreated,
  membersAdded,
  memberRemoved,
  memberLeft,
  memberJoinedByLink,
  chatTitleChanged,
  chatPhotoChanged,
  messagePinned,
  notSet
}

/// ServiceContent is a system line in the chat ("Ali added Sara").
class ServiceContent extends $pb.GeneratedMessage {
  factory ServiceContent({
    ChatCreated? chatCreated,
    MembersAdded? membersAdded,
    MemberRemoved? memberRemoved,
    MemberLeft? memberLeft,
    MemberJoinedByLink? memberJoinedByLink,
    ChatTitleChanged? chatTitleChanged,
    ChatPhotoChanged? chatPhotoChanged,
    MessagePinned? messagePinned,
  }) {
    final result = ServiceContent._();
    if (chatCreated != null) result.chatCreated = chatCreated;
    if (membersAdded != null) result.membersAdded = membersAdded;
    if (memberRemoved != null) result.memberRemoved = memberRemoved;
    if (memberLeft != null) result.memberLeft = memberLeft;
    if (memberJoinedByLink != null)
      result.memberJoinedByLink = memberJoinedByLink;
    if (chatTitleChanged != null) result.chatTitleChanged = chatTitleChanged;
    if (chatPhotoChanged != null) result.chatPhotoChanged = chatPhotoChanged;
    if (messagePinned != null) result.messagePinned = messagePinned;
    return result;
  }

  ServiceContent._();

  factory ServiceContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ServiceContent()..mergeFromBuffer(data, registry);
  factory ServiceContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ServiceContent()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, ServiceContent_Action>
      _ServiceContent_ActionByTag = {
    1: ServiceContent_Action.chatCreated,
    2: ServiceContent_Action.membersAdded,
    3: ServiceContent_Action.memberRemoved,
    4: ServiceContent_Action.memberLeft,
    5: ServiceContent_Action.memberJoinedByLink,
    6: ServiceContent_Action.chatTitleChanged,
    7: ServiceContent_Action.chatPhotoChanged,
    8: ServiceContent_Action.messagePinned,
    0: ServiceContent_Action.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ServiceContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ServiceContent.$_createMessage)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7, 8])
    ..aOM<ChatCreated>(1, _omitFieldNames ? '' : 'chatCreated',
        subBuilder: ChatCreated.$_createMessage)
    ..aOM<MembersAdded>(2, _omitFieldNames ? '' : 'membersAdded',
        subBuilder: MembersAdded.$_createMessage)
    ..aOM<MemberRemoved>(3, _omitFieldNames ? '' : 'memberRemoved',
        subBuilder: MemberRemoved.$_createMessage)
    ..aOM<MemberLeft>(4, _omitFieldNames ? '' : 'memberLeft',
        subBuilder: MemberLeft.$_createMessage)
    ..aOM<MemberJoinedByLink>(5, _omitFieldNames ? '' : 'memberJoinedByLink',
        subBuilder: MemberJoinedByLink.$_createMessage)
    ..aOM<ChatTitleChanged>(6, _omitFieldNames ? '' : 'chatTitleChanged',
        subBuilder: ChatTitleChanged.$_createMessage)
    ..aOM<ChatPhotoChanged>(7, _omitFieldNames ? '' : 'chatPhotoChanged',
        subBuilder: ChatPhotoChanged.$_createMessage)
    ..aOM<MessagePinned>(8, _omitFieldNames ? '' : 'messagePinned',
        subBuilder: MessagePinned.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ServiceContent copyWith(void Function(ServiceContent) updates) =>
      super.copyWith((message) => updates(message as ServiceContent))
          as ServiceContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ServiceContent() / ServiceContent.new instead')
  static ServiceContent create() => ServiceContent._();
  static $pb.GeneratedMessage $_createMessage() => ServiceContent._();
  @$core.override
  ServiceContent createEmptyInstance() => ServiceContent._();
  @$core.pragma('dart2js:noInline')
  static ServiceContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServiceContent>(
          ServiceContent.$_createMessage);
  static ServiceContent? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  ServiceContent_Action whichAction() =>
      _ServiceContent_ActionByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  @$pb.TagNumber(8)
  void clearAction() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  ChatCreated get chatCreated => $_getN(0);
  @$pb.TagNumber(1)
  set chatCreated(ChatCreated value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasChatCreated() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatCreated() => $_clearField(1);
  @$pb.TagNumber(1)
  ChatCreated ensureChatCreated() => $_ensure(0);

  @$pb.TagNumber(2)
  MembersAdded get membersAdded => $_getN(1);
  @$pb.TagNumber(2)
  set membersAdded(MembersAdded value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMembersAdded() => $_has(1);
  @$pb.TagNumber(2)
  void clearMembersAdded() => $_clearField(2);
  @$pb.TagNumber(2)
  MembersAdded ensureMembersAdded() => $_ensure(1);

  @$pb.TagNumber(3)
  MemberRemoved get memberRemoved => $_getN(2);
  @$pb.TagNumber(3)
  set memberRemoved(MemberRemoved value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMemberRemoved() => $_has(2);
  @$pb.TagNumber(3)
  void clearMemberRemoved() => $_clearField(3);
  @$pb.TagNumber(3)
  MemberRemoved ensureMemberRemoved() => $_ensure(2);

  @$pb.TagNumber(4)
  MemberLeft get memberLeft => $_getN(3);
  @$pb.TagNumber(4)
  set memberLeft(MemberLeft value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasMemberLeft() => $_has(3);
  @$pb.TagNumber(4)
  void clearMemberLeft() => $_clearField(4);
  @$pb.TagNumber(4)
  MemberLeft ensureMemberLeft() => $_ensure(3);

  @$pb.TagNumber(5)
  MemberJoinedByLink get memberJoinedByLink => $_getN(4);
  @$pb.TagNumber(5)
  set memberJoinedByLink(MemberJoinedByLink value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasMemberJoinedByLink() => $_has(4);
  @$pb.TagNumber(5)
  void clearMemberJoinedByLink() => $_clearField(5);
  @$pb.TagNumber(5)
  MemberJoinedByLink ensureMemberJoinedByLink() => $_ensure(4);

  @$pb.TagNumber(6)
  ChatTitleChanged get chatTitleChanged => $_getN(5);
  @$pb.TagNumber(6)
  set chatTitleChanged(ChatTitleChanged value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasChatTitleChanged() => $_has(5);
  @$pb.TagNumber(6)
  void clearChatTitleChanged() => $_clearField(6);
  @$pb.TagNumber(6)
  ChatTitleChanged ensureChatTitleChanged() => $_ensure(5);

  @$pb.TagNumber(7)
  ChatPhotoChanged get chatPhotoChanged => $_getN(6);
  @$pb.TagNumber(7)
  set chatPhotoChanged(ChatPhotoChanged value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasChatPhotoChanged() => $_has(6);
  @$pb.TagNumber(7)
  void clearChatPhotoChanged() => $_clearField(7);
  @$pb.TagNumber(7)
  ChatPhotoChanged ensureChatPhotoChanged() => $_ensure(6);

  @$pb.TagNumber(8)
  MessagePinned get messagePinned => $_getN(7);
  @$pb.TagNumber(8)
  set messagePinned(MessagePinned value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasMessagePinned() => $_has(7);
  @$pb.TagNumber(8)
  void clearMessagePinned() => $_clearField(8);
  @$pb.TagNumber(8)
  MessagePinned ensureMessagePinned() => $_ensure(7);
}

class ChatCreated extends $pb.GeneratedMessage {
  factory ChatCreated({
    $core.String? title,
  }) {
    final result = ChatCreated._();
    if (title != null) result.title = title;
    return result;
  }

  ChatCreated._();

  factory ChatCreated.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatCreated()..mergeFromBuffer(data, registry);
  factory ChatCreated.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatCreated()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatCreated',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ChatCreated.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCreated clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatCreated copyWith(void Function(ChatCreated) updates) =>
      super.copyWith((message) => updates(message as ChatCreated))
          as ChatCreated;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatCreated() / ChatCreated.new instead')
  static ChatCreated create() => ChatCreated._();
  static $pb.GeneratedMessage $_createMessage() => ChatCreated._();
  @$core.override
  ChatCreated createEmptyInstance() => ChatCreated._();
  @$core.pragma('dart2js:noInline')
  static ChatCreated getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatCreated>(
          ChatCreated.$_createMessage);
  static ChatCreated? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);
}

class MembersAdded extends $pb.GeneratedMessage {
  factory MembersAdded({
    $core.Iterable<$fixnum.Int64>? userIds,
  }) {
    final result = MembersAdded._();
    if (userIds != null) result.userIds.addAll(userIds);
    return result;
  }

  MembersAdded._();

  factory MembersAdded.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MembersAdded()..mergeFromBuffer(data, registry);
  factory MembersAdded.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MembersAdded()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MembersAdded',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MembersAdded.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembersAdded clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MembersAdded copyWith(void Function(MembersAdded) updates) =>
      super.copyWith((message) => updates(message as MembersAdded))
          as MembersAdded;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MembersAdded() / MembersAdded.new instead')
  static MembersAdded create() => MembersAdded._();
  static $pb.GeneratedMessage $_createMessage() => MembersAdded._();
  @$core.override
  MembersAdded createEmptyInstance() => MembersAdded._();
  @$core.pragma('dart2js:noInline')
  static MembersAdded getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MembersAdded>(
          MembersAdded.$_createMessage);
  static MembersAdded? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get userIds => $_getList(0);
}

class MemberRemoved extends $pb.GeneratedMessage {
  factory MemberRemoved({
    $fixnum.Int64? userId,
  }) {
    final result = MemberRemoved._();
    if (userId != null) result.userId = userId;
    return result;
  }

  MemberRemoved._();

  factory MemberRemoved.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MemberRemoved()..mergeFromBuffer(data, registry);
  factory MemberRemoved.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MemberRemoved()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MemberRemoved',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MemberRemoved.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberRemoved clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberRemoved copyWith(void Function(MemberRemoved) updates) =>
      super.copyWith((message) => updates(message as MemberRemoved))
          as MemberRemoved;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MemberRemoved() / MemberRemoved.new instead')
  static MemberRemoved create() => MemberRemoved._();
  static $pb.GeneratedMessage $_createMessage() => MemberRemoved._();
  @$core.override
  MemberRemoved createEmptyInstance() => MemberRemoved._();
  @$core.pragma('dart2js:noInline')
  static MemberRemoved getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MemberRemoved>(
          MemberRemoved.$_createMessage);
  static MemberRemoved? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class MemberLeft extends $pb.GeneratedMessage {
  factory MemberLeft() => MemberLeft._();

  MemberLeft._();

  factory MemberLeft.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MemberLeft()..mergeFromBuffer(data, registry);
  factory MemberLeft.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MemberLeft()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MemberLeft',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MemberLeft.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberLeft clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberLeft copyWith(void Function(MemberLeft) updates) =>
      super.copyWith((message) => updates(message as MemberLeft)) as MemberLeft;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MemberLeft() / MemberLeft.new instead')
  static MemberLeft create() => MemberLeft._();
  static $pb.GeneratedMessage $_createMessage() => MemberLeft._();
  @$core.override
  MemberLeft createEmptyInstance() => MemberLeft._();
  @$core.pragma('dart2js:noInline')
  static MemberLeft getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MemberLeft>(MemberLeft.$_createMessage);
  static MemberLeft? _defaultInstance;
}

class MemberJoinedByLink extends $pb.GeneratedMessage {
  factory MemberJoinedByLink() => MemberJoinedByLink._();

  MemberJoinedByLink._();

  factory MemberJoinedByLink.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MemberJoinedByLink()..mergeFromBuffer(data, registry);
  factory MemberJoinedByLink.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MemberJoinedByLink()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MemberJoinedByLink',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MemberJoinedByLink.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberJoinedByLink clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MemberJoinedByLink copyWith(void Function(MemberJoinedByLink) updates) =>
      super.copyWith((message) => updates(message as MemberJoinedByLink))
          as MemberJoinedByLink;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MemberJoinedByLink() / MemberJoinedByLink.new instead')
  static MemberJoinedByLink create() => MemberJoinedByLink._();
  static $pb.GeneratedMessage $_createMessage() => MemberJoinedByLink._();
  @$core.override
  MemberJoinedByLink createEmptyInstance() => MemberJoinedByLink._();
  @$core.pragma('dart2js:noInline')
  static MemberJoinedByLink getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<MemberJoinedByLink>(
          MemberJoinedByLink.$_createMessage);
  static MemberJoinedByLink? _defaultInstance;
}

class ChatTitleChanged extends $pb.GeneratedMessage {
  factory ChatTitleChanged({
    $core.String? title,
  }) {
    final result = ChatTitleChanged._();
    if (title != null) result.title = title;
    return result;
  }

  ChatTitleChanged._();

  factory ChatTitleChanged.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatTitleChanged()..mergeFromBuffer(data, registry);
  factory ChatTitleChanged.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatTitleChanged()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatTitleChanged',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ChatTitleChanged.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'title')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatTitleChanged clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatTitleChanged copyWith(void Function(ChatTitleChanged) updates) =>
      super.copyWith((message) => updates(message as ChatTitleChanged))
          as ChatTitleChanged;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatTitleChanged() / ChatTitleChanged.new instead')
  static ChatTitleChanged create() => ChatTitleChanged._();
  static $pb.GeneratedMessage $_createMessage() => ChatTitleChanged._();
  @$core.override
  ChatTitleChanged createEmptyInstance() => ChatTitleChanged._();
  @$core.pragma('dart2js:noInline')
  static ChatTitleChanged getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatTitleChanged>(
          ChatTitleChanged.$_createMessage);
  static ChatTitleChanged? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => $_clearField(1);
}

class ChatPhotoChanged extends $pb.GeneratedMessage {
  factory ChatPhotoChanged({
    $fixnum.Int64? mediaId,
  }) {
    final result = ChatPhotoChanged._();
    if (mediaId != null) result.mediaId = mediaId;
    return result;
  }

  ChatPhotoChanged._();

  factory ChatPhotoChanged.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatPhotoChanged()..mergeFromBuffer(data, registry);
  factory ChatPhotoChanged.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ChatPhotoChanged()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ChatPhotoChanged',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ChatPhotoChanged.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'mediaId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatPhotoChanged clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ChatPhotoChanged copyWith(void Function(ChatPhotoChanged) updates) =>
      super.copyWith((message) => updates(message as ChatPhotoChanged))
          as ChatPhotoChanged;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ChatPhotoChanged() / ChatPhotoChanged.new instead')
  static ChatPhotoChanged create() => ChatPhotoChanged._();
  static $pb.GeneratedMessage $_createMessage() => ChatPhotoChanged._();
  @$core.override
  ChatPhotoChanged createEmptyInstance() => ChatPhotoChanged._();
  @$core.pragma('dart2js:noInline')
  static ChatPhotoChanged getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ChatPhotoChanged>(
          ChatPhotoChanged.$_createMessage);
  static ChatPhotoChanged? _defaultInstance;

  /// 0 when the photo was removed.
  @$pb.TagNumber(1)
  $fixnum.Int64 get mediaId => $_getI64(0);
  @$pb.TagNumber(1)
  set mediaId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);
}

class MessagePinned extends $pb.GeneratedMessage {
  factory MessagePinned({
    $fixnum.Int64? seq,
  }) {
    final result = MessagePinned._();
    if (seq != null) result.seq = seq;
    return result;
  }

  MessagePinned._();

  factory MessagePinned.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessagePinned()..mergeFromBuffer(data, registry);
  factory MessagePinned.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MessagePinned()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MessagePinned',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MessagePinned.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'seq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessagePinned clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MessagePinned copyWith(void Function(MessagePinned) updates) =>
      super.copyWith((message) => updates(message as MessagePinned))
          as MessagePinned;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MessagePinned() / MessagePinned.new instead')
  static MessagePinned create() => MessagePinned._();
  static $pb.GeneratedMessage $_createMessage() => MessagePinned._();
  @$core.override
  MessagePinned createEmptyInstance() => MessagePinned._();
  @$core.pragma('dart2js:noInline')
  static MessagePinned getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessagePinned>(
          MessagePinned.$_createMessage);
  static MessagePinned? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get seq => $_getI64(0);
  @$pb.TagNumber(1)
  set seq($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSeq() => $_has(0);
  @$pb.TagNumber(1)
  void clearSeq() => $_clearField(1);
}

class ForwardInfo extends $pb.GeneratedMessage {
  factory ForwardInfo({
    $fixnum.Int64? fromUserId,
    $core.String? fromName,
    $fixnum.Int64? originalDate,
    $fixnum.Int64? fromChatId,
    $fixnum.Int64? fromSeq,
  }) {
    final result = ForwardInfo._();
    if (fromUserId != null) result.fromUserId = fromUserId;
    if (fromName != null) result.fromName = fromName;
    if (originalDate != null) result.originalDate = originalDate;
    if (fromChatId != null) result.fromChatId = fromChatId;
    if (fromSeq != null) result.fromSeq = fromSeq;
    return result;
  }

  ForwardInfo._();

  factory ForwardInfo.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ForwardInfo()..mergeFromBuffer(data, registry);
  factory ForwardInfo.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ForwardInfo()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ForwardInfo',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ForwardInfo.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'fromUserId')
    ..aOS(2, _omitFieldNames ? '' : 'fromName')
    ..aInt64(3, _omitFieldNames ? '' : 'originalDate')
    ..aInt64(4, _omitFieldNames ? '' : 'fromChatId')
    ..aInt64(5, _omitFieldNames ? '' : 'fromSeq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForwardInfo clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForwardInfo copyWith(void Function(ForwardInfo) updates) =>
      super.copyWith((message) => updates(message as ForwardInfo))
          as ForwardInfo;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ForwardInfo() / ForwardInfo.new instead')
  static ForwardInfo create() => ForwardInfo._();
  static $pb.GeneratedMessage $_createMessage() => ForwardInfo._();
  @$core.override
  ForwardInfo createEmptyInstance() => ForwardInfo._();
  @$core.pragma('dart2js:noInline')
  static ForwardInfo getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ForwardInfo>(
          ForwardInfo.$_createMessage);
  static ForwardInfo? _defaultInstance;

  /// 0 when the author's FORWARDS privacy hides the link.
  @$pb.TagNumber(1)
  $fixnum.Int64 get fromUserId => $_getI64(0);
  @$pb.TagNumber(1)
  set fromUserId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromUserId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get fromName => $_getSZ(1);
  @$pb.TagNumber(2)
  set fromName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFromName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFromName() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get originalDate => $_getI64(2);
  @$pb.TagNumber(3)
  set originalDate($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasOriginalDate() => $_has(2);
  @$pb.TagNumber(3)
  void clearOriginalDate() => $_clearField(3);

  /// Set only if the requester can still access the original.
  @$pb.TagNumber(4)
  $fixnum.Int64 get fromChatId => $_getI64(3);
  @$pb.TagNumber(4)
  set fromChatId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFromChatId() => $_has(3);
  @$pb.TagNumber(4)
  void clearFromChatId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get fromSeq => $_getI64(4);
  @$pb.TagNumber(5)
  set fromSeq($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFromSeq() => $_has(4);
  @$pb.TagNumber(5)
  void clearFromSeq() => $_clearField(5);
}

enum InputContent_Kind { text, media, location, contact, notSet }

/// InputContent is what the client sends; media is referenced by ID after
/// MediaService.CompleteUpload.
class InputContent extends $pb.GeneratedMessage {
  factory InputContent({
    FormattedText? text,
    InputMedia? media,
    LocationContent? location,
    ContactContent? contact,
  }) {
    final result = InputContent._();
    if (text != null) result.text = text;
    if (media != null) result.media = media;
    if (location != null) result.location = location;
    if (contact != null) result.contact = contact;
    return result;
  }

  InputContent._();

  factory InputContent.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InputContent()..mergeFromBuffer(data, registry);
  factory InputContent.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InputContent()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, InputContent_Kind> _InputContent_KindByTag =
      {
    1: InputContent_Kind.text,
    2: InputContent_Kind.media,
    3: InputContent_Kind.location,
    4: InputContent_Kind.contact,
    0: InputContent_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InputContent',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: InputContent.$_createMessage)
    ..oo(0, [1, 2, 3, 4])
    ..aOM<FormattedText>(1, _omitFieldNames ? '' : 'text',
        subBuilder: FormattedText.$_createMessage)
    ..aOM<InputMedia>(2, _omitFieldNames ? '' : 'media',
        subBuilder: InputMedia.$_createMessage)
    ..aOM<LocationContent>(3, _omitFieldNames ? '' : 'location',
        subBuilder: LocationContent.$_createMessage)
    ..aOM<ContactContent>(4, _omitFieldNames ? '' : 'contact',
        subBuilder: ContactContent.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputContent clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputContent copyWith(void Function(InputContent) updates) =>
      super.copyWith((message) => updates(message as InputContent))
          as InputContent;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use InputContent() / InputContent.new instead')
  static InputContent create() => InputContent._();
  static $pb.GeneratedMessage $_createMessage() => InputContent._();
  @$core.override
  InputContent createEmptyInstance() => InputContent._();
  @$core.pragma('dart2js:noInline')
  static InputContent getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InputContent>(
          InputContent.$_createMessage);
  static InputContent? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  InputContent_Kind whichKind() => _InputContent_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  FormattedText get text => $_getN(0);
  @$pb.TagNumber(1)
  set text(FormattedText value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasText() => $_has(0);
  @$pb.TagNumber(1)
  void clearText() => $_clearField(1);
  @$pb.TagNumber(1)
  FormattedText ensureText() => $_ensure(0);

  @$pb.TagNumber(2)
  InputMedia get media => $_getN(1);
  @$pb.TagNumber(2)
  set media(InputMedia value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasMedia() => $_has(1);
  @$pb.TagNumber(2)
  void clearMedia() => $_clearField(2);
  @$pb.TagNumber(2)
  InputMedia ensureMedia() => $_ensure(1);

  @$pb.TagNumber(3)
  LocationContent get location => $_getN(2);
  @$pb.TagNumber(3)
  set location(LocationContent value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasLocation() => $_has(2);
  @$pb.TagNumber(3)
  void clearLocation() => $_clearField(3);
  @$pb.TagNumber(3)
  LocationContent ensureLocation() => $_ensure(2);

  @$pb.TagNumber(4)
  ContactContent get contact => $_getN(3);
  @$pb.TagNumber(4)
  set contact(ContactContent value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasContact() => $_has(3);
  @$pb.TagNumber(4)
  void clearContact() => $_clearField(4);
  @$pb.TagNumber(4)
  ContactContent ensureContact() => $_ensure(3);
}

class InputMedia extends $pb.GeneratedMessage {
  factory InputMedia({
    $fixnum.Int64? mediaId,
    FormattedText? caption,
  }) {
    final result = InputMedia._();
    if (mediaId != null) result.mediaId = mediaId;
    if (caption != null) result.caption = caption;
    return result;
  }

  InputMedia._();

  factory InputMedia.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InputMedia()..mergeFromBuffer(data, registry);
  factory InputMedia.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InputMedia()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InputMedia',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: InputMedia.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'mediaId')
    ..aOM<FormattedText>(2, _omitFieldNames ? '' : 'caption',
        subBuilder: FormattedText.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputMedia clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputMedia copyWith(void Function(InputMedia) updates) =>
      super.copyWith((message) => updates(message as InputMedia)) as InputMedia;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use InputMedia() / InputMedia.new instead')
  static InputMedia create() => InputMedia._();
  static $pb.GeneratedMessage $_createMessage() => InputMedia._();
  @$core.override
  InputMedia createEmptyInstance() => InputMedia._();
  @$core.pragma('dart2js:noInline')
  static InputMedia getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<InputMedia>(InputMedia.$_createMessage);
  static InputMedia? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get mediaId => $_getI64(0);
  @$pb.TagNumber(1)
  set mediaId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);

  @$pb.TagNumber(2)
  FormattedText get caption => $_getN(1);
  @$pb.TagNumber(2)
  set caption(FormattedText value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasCaption() => $_has(1);
  @$pb.TagNumber(2)
  void clearCaption() => $_clearField(2);
  @$pb.TagNumber(2)
  FormattedText ensureCaption() => $_ensure(1);
}

class SendMessageRequest extends $pb.GeneratedMessage {
  factory SendMessageRequest({
    $1.Peer? peer,
    $fixnum.Int64? randomId,
    InputContent? content,
    $fixnum.Int64? replyToSeq,
    $core.bool? silent,
  }) {
    final result = SendMessageRequest._();
    if (peer != null) result.peer = peer;
    if (randomId != null) result.randomId = randomId;
    if (content != null) result.content = content;
    if (replyToSeq != null) result.replyToSeq = replyToSeq;
    if (silent != null) result.silent = silent;
    return result;
  }

  SendMessageRequest._();

  factory SendMessageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendMessageRequest()..mergeFromBuffer(data, registry);
  factory SendMessageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendMessageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMessageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SendMessageRequest.$_createMessage)
    ..aOM<$1.Peer>(1, _omitFieldNames ? '' : 'peer',
        subBuilder: $1.Peer.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'randomId')
    ..aOM<InputContent>(3, _omitFieldNames ? '' : 'content',
        subBuilder: InputContent.$_createMessage)
    ..aInt64(4, _omitFieldNames ? '' : 'replyToSeq')
    ..aOB(5, _omitFieldNames ? '' : 'silent')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageRequest copyWith(void Function(SendMessageRequest) updates) =>
      super.copyWith((message) => updates(message as SendMessageRequest))
          as SendMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SendMessageRequest() / SendMessageRequest.new instead')
  static SendMessageRequest create() => SendMessageRequest._();
  static $pb.GeneratedMessage $_createMessage() => SendMessageRequest._();
  @$core.override
  SendMessageRequest createEmptyInstance() => SendMessageRequest._();
  @$core.pragma('dart2js:noInline')
  static SendMessageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageRequest>(
          SendMessageRequest.$_createMessage);
  static SendMessageRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $1.Peer get peer => $_getN(0);
  @$pb.TagNumber(1)
  set peer($1.Peer value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasPeer() => $_has(0);
  @$pb.TagNumber(1)
  void clearPeer() => $_clearField(1);
  @$pb.TagNumber(1)
  $1.Peer ensurePeer() => $_ensure(0);

  /// Random 64-bit value from the client. Retrying with the same random_id
  /// returns the already-stored message instead of creating a duplicate.
  @$pb.TagNumber(2)
  $fixnum.Int64 get randomId => $_getI64(1);
  @$pb.TagNumber(2)
  set randomId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasRandomId() => $_has(1);
  @$pb.TagNumber(2)
  void clearRandomId() => $_clearField(2);

  @$pb.TagNumber(3)
  InputContent get content => $_getN(2);
  @$pb.TagNumber(3)
  set content(InputContent value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasContent() => $_has(2);
  @$pb.TagNumber(3)
  void clearContent() => $_clearField(3);
  @$pb.TagNumber(3)
  InputContent ensureContent() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get replyToSeq => $_getI64(3);
  @$pb.TagNumber(4)
  set replyToSeq($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasReplyToSeq() => $_has(3);
  @$pb.TagNumber(4)
  void clearReplyToSeq() => $_clearField(4);

  /// Deliver without sound (push sent with silent flag). Phase 2 in the UI.
  @$pb.TagNumber(5)
  $core.bool get silent => $_getBF(4);
  @$pb.TagNumber(5)
  set silent($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasSilent() => $_has(4);
  @$pb.TagNumber(5)
  void clearSilent() => $_clearField(5);
}

class SendMessageResponse extends $pb.GeneratedMessage {
  factory SendMessageResponse({
    Message? message,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = SendMessageResponse._();
    if (message != null) result.message = message;
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  SendMessageResponse._();

  factory SendMessageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendMessageResponse()..mergeFromBuffer(data, registry);
  factory SendMessageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendMessageResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendMessageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SendMessageResponse.$_createMessage)
    ..aOM<Message>(1, _omitFieldNames ? '' : 'message',
        subBuilder: Message.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendMessageResponse copyWith(void Function(SendMessageResponse) updates) =>
      super.copyWith((message) => updates(message as SendMessageResponse))
          as SendMessageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use SendMessageResponse() / SendMessageResponse.new instead')
  static SendMessageResponse create() => SendMessageResponse._();
  static $pb.GeneratedMessage $_createMessage() => SendMessageResponse._();
  @$core.override
  SendMessageResponse createEmptyInstance() => SendMessageResponse._();
  @$core.pragma('dart2js:noInline')
  static SendMessageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SendMessageResponse>(
          SendMessageResponse.$_createMessage);
  static SendMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Message get message => $_getN(0);
  @$pb.TagNumber(1)
  set message(Message value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  Message ensureMessage() => $_ensure(0);

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

class EditMessageRequest extends $pb.GeneratedMessage {
  factory EditMessageRequest({
    $fixnum.Int64? chatId,
    $fixnum.Int64? seq,
    FormattedText? text,
  }) {
    final result = EditMessageRequest._();
    if (chatId != null) result.chatId = chatId;
    if (seq != null) result.seq = seq;
    if (text != null) result.text = text;
    return result;
  }

  EditMessageRequest._();

  factory EditMessageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EditMessageRequest()..mergeFromBuffer(data, registry);
  factory EditMessageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EditMessageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EditMessageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: EditMessageRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'seq')
    ..aOM<FormattedText>(3, _omitFieldNames ? '' : 'text',
        subBuilder: FormattedText.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditMessageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditMessageRequest copyWith(void Function(EditMessageRequest) updates) =>
      super.copyWith((message) => updates(message as EditMessageRequest))
          as EditMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use EditMessageRequest() / EditMessageRequest.new instead')
  static EditMessageRequest create() => EditMessageRequest._();
  static $pb.GeneratedMessage $_createMessage() => EditMessageRequest._();
  @$core.override
  EditMessageRequest createEmptyInstance() => EditMessageRequest._();
  @$core.pragma('dart2js:noInline')
  static EditMessageRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EditMessageRequest>(
          EditMessageRequest.$_createMessage);
  static EditMessageRequest? _defaultInstance;

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

  /// Replaces the text or caption. Allowed for 48 hours after sending.
  @$pb.TagNumber(3)
  FormattedText get text => $_getN(2);
  @$pb.TagNumber(3)
  set text(FormattedText value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasText() => $_has(2);
  @$pb.TagNumber(3)
  void clearText() => $_clearField(3);
  @$pb.TagNumber(3)
  FormattedText ensureText() => $_ensure(2);
}

class EditMessageResponse extends $pb.GeneratedMessage {
  factory EditMessageResponse({
    Message? message,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = EditMessageResponse._();
    if (message != null) result.message = message;
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  EditMessageResponse._();

  factory EditMessageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EditMessageResponse()..mergeFromBuffer(data, registry);
  factory EditMessageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      EditMessageResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'EditMessageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: EditMessageResponse.$_createMessage)
    ..aOM<Message>(1, _omitFieldNames ? '' : 'message',
        subBuilder: Message.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditMessageResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  EditMessageResponse copyWith(void Function(EditMessageResponse) updates) =>
      super.copyWith((message) => updates(message as EditMessageResponse))
          as EditMessageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use EditMessageResponse() / EditMessageResponse.new instead')
  static EditMessageResponse create() => EditMessageResponse._();
  static $pb.GeneratedMessage $_createMessage() => EditMessageResponse._();
  @$core.override
  EditMessageResponse createEmptyInstance() => EditMessageResponse._();
  @$core.pragma('dart2js:noInline')
  static EditMessageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<EditMessageResponse>(
          EditMessageResponse.$_createMessage);
  static EditMessageResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Message get message => $_getN(0);
  @$pb.TagNumber(1)
  set message(Message value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => $_clearField(1);
  @$pb.TagNumber(1)
  Message ensureMessage() => $_ensure(0);

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

class DeleteMessagesRequest extends $pb.GeneratedMessage {
  factory DeleteMessagesRequest({
    $fixnum.Int64? chatId,
    $core.Iterable<$fixnum.Int64>? seqs,
    $core.bool? forEveryone,
  }) {
    final result = DeleteMessagesRequest._();
    if (chatId != null) result.chatId = chatId;
    if (seqs != null) result.seqs.addAll(seqs);
    if (forEveryone != null) result.forEveryone = forEveryone;
    return result;
  }

  DeleteMessagesRequest._();

  factory DeleteMessagesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteMessagesRequest()..mergeFromBuffer(data, registry);
  factory DeleteMessagesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteMessagesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteMessagesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DeleteMessagesRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'seqs', $pb.PbFieldType.K6)
    ..aOB(3, _omitFieldNames ? '' : 'forEveryone')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMessagesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMessagesRequest copyWith(
          void Function(DeleteMessagesRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteMessagesRequest))
          as DeleteMessagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteMessagesRequest() / DeleteMessagesRequest.new instead')
  static DeleteMessagesRequest create() => DeleteMessagesRequest._();
  static $pb.GeneratedMessage $_createMessage() => DeleteMessagesRequest._();
  @$core.override
  DeleteMessagesRequest createEmptyInstance() => DeleteMessagesRequest._();
  @$core.pragma('dart2js:noInline')
  static DeleteMessagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteMessagesRequest>(
          DeleteMessagesRequest.$_createMessage);
  static DeleteMessagesRequest? _defaultInstance;

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

  /// false: delete for me only. true: delete for everyone (own messages,
  /// or any message for group admins with DELETE_MESSAGES).
  @$pb.TagNumber(3)
  $core.bool get forEveryone => $_getBF(2);
  @$pb.TagNumber(3)
  set forEveryone($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasForEveryone() => $_has(2);
  @$pb.TagNumber(3)
  void clearForEveryone() => $_clearField(3);
}

class DeleteMessagesResponse extends $pb.GeneratedMessage {
  factory DeleteMessagesResponse({
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = DeleteMessagesResponse._();
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  DeleteMessagesResponse._();

  factory DeleteMessagesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteMessagesResponse()..mergeFromBuffer(data, registry);
  factory DeleteMessagesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteMessagesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteMessagesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DeleteMessagesResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMessagesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteMessagesResponse copyWith(
          void Function(DeleteMessagesResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteMessagesResponse))
          as DeleteMessagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteMessagesResponse() / DeleteMessagesResponse.new instead')
  static DeleteMessagesResponse create() => DeleteMessagesResponse._();
  static $pb.GeneratedMessage $_createMessage() => DeleteMessagesResponse._();
  @$core.override
  DeleteMessagesResponse createEmptyInstance() => DeleteMessagesResponse._();
  @$core.pragma('dart2js:noInline')
  static DeleteMessagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteMessagesResponse>(
          DeleteMessagesResponse.$_createMessage);
  static DeleteMessagesResponse? _defaultInstance;

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

class ForwardMessagesRequest extends $pb.GeneratedMessage {
  factory ForwardMessagesRequest({
    $fixnum.Int64? fromChatId,
    $core.Iterable<$fixnum.Int64>? seqs,
    $1.Peer? toPeer,
    $core.Iterable<$fixnum.Int64>? randomIds,
    $core.bool? hideSender,
    $core.bool? silent,
  }) {
    final result = ForwardMessagesRequest._();
    if (fromChatId != null) result.fromChatId = fromChatId;
    if (seqs != null) result.seqs.addAll(seqs);
    if (toPeer != null) result.toPeer = toPeer;
    if (randomIds != null) result.randomIds.addAll(randomIds);
    if (hideSender != null) result.hideSender = hideSender;
    if (silent != null) result.silent = silent;
    return result;
  }

  ForwardMessagesRequest._();

  factory ForwardMessagesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ForwardMessagesRequest()..mergeFromBuffer(data, registry);
  factory ForwardMessagesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ForwardMessagesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ForwardMessagesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ForwardMessagesRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'fromChatId')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'seqs', $pb.PbFieldType.K6)
    ..aOM<$1.Peer>(3, _omitFieldNames ? '' : 'toPeer',
        subBuilder: $1.Peer.$_createMessage)
    ..p<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'randomIds', $pb.PbFieldType.K6)
    ..aOB(5, _omitFieldNames ? '' : 'hideSender')
    ..aOB(6, _omitFieldNames ? '' : 'silent')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForwardMessagesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForwardMessagesRequest copyWith(
          void Function(ForwardMessagesRequest) updates) =>
      super.copyWith((message) => updates(message as ForwardMessagesRequest))
          as ForwardMessagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ForwardMessagesRequest() / ForwardMessagesRequest.new instead')
  static ForwardMessagesRequest create() => ForwardMessagesRequest._();
  static $pb.GeneratedMessage $_createMessage() => ForwardMessagesRequest._();
  @$core.override
  ForwardMessagesRequest createEmptyInstance() => ForwardMessagesRequest._();
  @$core.pragma('dart2js:noInline')
  static ForwardMessagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ForwardMessagesRequest>(
          ForwardMessagesRequest.$_createMessage);
  static ForwardMessagesRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get fromChatId => $_getI64(0);
  @$pb.TagNumber(1)
  set fromChatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFromChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearFromChatId() => $_clearField(1);

  /// At most 100, in the order they should appear.
  @$pb.TagNumber(2)
  $pb.PbList<$fixnum.Int64> get seqs => $_getList(1);

  @$pb.TagNumber(3)
  $1.Peer get toPeer => $_getN(2);
  @$pb.TagNumber(3)
  set toPeer($1.Peer value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasToPeer() => $_has(2);
  @$pb.TagNumber(3)
  void clearToPeer() => $_clearField(3);
  @$pb.TagNumber(3)
  $1.Peer ensureToPeer() => $_ensure(2);

  /// One per message, same order as seqs.
  @$pb.TagNumber(4)
  $pb.PbList<$fixnum.Int64> get randomIds => $_getList(3);

  /// Forward as a copy, without the "Forwarded from" header.
  @$pb.TagNumber(5)
  $core.bool get hideSender => $_getBF(4);
  @$pb.TagNumber(5)
  set hideSender($core.bool value) => $_setBool(4, value);
  @$pb.TagNumber(5)
  $core.bool hasHideSender() => $_has(4);
  @$pb.TagNumber(5)
  void clearHideSender() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.bool get silent => $_getBF(5);
  @$pb.TagNumber(6)
  set silent($core.bool value) => $_setBool(5, value);
  @$pb.TagNumber(6)
  $core.bool hasSilent() => $_has(5);
  @$pb.TagNumber(6)
  void clearSilent() => $_clearField(6);
}

class ForwardMessagesResponse extends $pb.GeneratedMessage {
  factory ForwardMessagesResponse({
    $core.Iterable<Message>? messages,
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = ForwardMessagesResponse._();
    if (messages != null) result.messages.addAll(messages);
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  ForwardMessagesResponse._();

  factory ForwardMessagesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ForwardMessagesResponse()..mergeFromBuffer(data, registry);
  factory ForwardMessagesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ForwardMessagesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ForwardMessagesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ForwardMessagesResponse.$_createMessage)
    ..pPM<Message>(1, _omitFieldNames ? '' : 'messages',
        subBuilder: Message.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'pts')
    ..aI(3, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForwardMessagesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ForwardMessagesResponse copyWith(
          void Function(ForwardMessagesResponse) updates) =>
      super.copyWith((message) => updates(message as ForwardMessagesResponse))
          as ForwardMessagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ForwardMessagesResponse() / ForwardMessagesResponse.new instead')
  static ForwardMessagesResponse create() => ForwardMessagesResponse._();
  static $pb.GeneratedMessage $_createMessage() => ForwardMessagesResponse._();
  @$core.override
  ForwardMessagesResponse createEmptyInstance() => ForwardMessagesResponse._();
  @$core.pragma('dart2js:noInline')
  static ForwardMessagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ForwardMessagesResponse>(
          ForwardMessagesResponse.$_createMessage);
  static ForwardMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Message> get messages => $_getList(0);

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

class GetHistoryRequest extends $pb.GeneratedMessage {
  factory GetHistoryRequest({
    $fixnum.Int64? chatId,
    $fixnum.Int64? offsetSeq,
    HistoryDirection? direction,
    $core.int? limit,
  }) {
    final result = GetHistoryRequest._();
    if (chatId != null) result.chatId = chatId;
    if (offsetSeq != null) result.offsetSeq = offsetSeq;
    if (direction != null) result.direction = direction;
    if (limit != null) result.limit = limit;
    return result;
  }

  GetHistoryRequest._();

  factory GetHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetHistoryRequest()..mergeFromBuffer(data, registry);
  factory GetHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetHistoryRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetHistoryRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'offsetSeq')
    ..aE<HistoryDirection>(3, _omitFieldNames ? '' : 'direction',
        enumValues: HistoryDirection.values)
    ..aI(4, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoryRequest copyWith(void Function(GetHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as GetHistoryRequest))
          as GetHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetHistoryRequest() / GetHistoryRequest.new instead')
  static GetHistoryRequest create() => GetHistoryRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetHistoryRequest._();
  @$core.override
  GetHistoryRequest createEmptyInstance() => GetHistoryRequest._();
  @$core.pragma('dart2js:noInline')
  static GetHistoryRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetHistoryRequest>(
          GetHistoryRequest.$_createMessage);
  static GetHistoryRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  /// 0 with OLDER means "from the latest message".
  @$pb.TagNumber(2)
  $fixnum.Int64 get offsetSeq => $_getI64(1);
  @$pb.TagNumber(2)
  set offsetSeq($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasOffsetSeq() => $_has(1);
  @$pb.TagNumber(2)
  void clearOffsetSeq() => $_clearField(2);

  @$pb.TagNumber(3)
  HistoryDirection get direction => $_getN(2);
  @$pb.TagNumber(3)
  set direction(HistoryDirection value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasDirection() => $_has(2);
  @$pb.TagNumber(3)
  void clearDirection() => $_clearField(3);

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

class GetHistoryResponse extends $pb.GeneratedMessage {
  factory GetHistoryResponse({
    $core.Iterable<Message>? messages,
    $core.Iterable<$2.User>? users,
    $core.bool? hasMore,
  }) {
    final result = GetHistoryResponse._();
    if (messages != null) result.messages.addAll(messages);
    if (users != null) result.users.addAll(users);
    if (hasMore != null) result.hasMore = hasMore;
    return result;
  }

  GetHistoryResponse._();

  factory GetHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetHistoryResponse()..mergeFromBuffer(data, registry);
  factory GetHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetHistoryResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetHistoryResponse.$_createMessage)
    ..pPM<Message>(1, _omitFieldNames ? '' : 'messages',
        subBuilder: Message.$_createMessage)
    ..pPM<$2.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $2.User.$_createMessage)
    ..aOB(3, _omitFieldNames ? '' : 'hasMore')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetHistoryResponse copyWith(void Function(GetHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as GetHistoryResponse))
          as GetHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetHistoryResponse() / GetHistoryResponse.new instead')
  static GetHistoryResponse create() => GetHistoryResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetHistoryResponse._();
  @$core.override
  GetHistoryResponse createEmptyInstance() => GetHistoryResponse._();
  @$core.pragma('dart2js:noInline')
  static GetHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetHistoryResponse>(
          GetHistoryResponse.$_createMessage);
  static GetHistoryResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Message> get messages => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$2.User> get users => $_getList(1);

  @$pb.TagNumber(3)
  $core.bool get hasMore => $_getBF(2);
  @$pb.TagNumber(3)
  set hasMore($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHasMore() => $_has(2);
  @$pb.TagNumber(3)
  void clearHasMore() => $_clearField(3);
}

class GetMessagesRequest extends $pb.GeneratedMessage {
  factory GetMessagesRequest({
    $fixnum.Int64? chatId,
    $core.Iterable<$fixnum.Int64>? seqs,
  }) {
    final result = GetMessagesRequest._();
    if (chatId != null) result.chatId = chatId;
    if (seqs != null) result.seqs.addAll(seqs);
    return result;
  }

  GetMessagesRequest._();

  factory GetMessagesRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetMessagesRequest()..mergeFromBuffer(data, registry);
  factory GetMessagesRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetMessagesRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMessagesRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetMessagesRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..p<$fixnum.Int64>(2, _omitFieldNames ? '' : 'seqs', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMessagesRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMessagesRequest copyWith(void Function(GetMessagesRequest) updates) =>
      super.copyWith((message) => updates(message as GetMessagesRequest))
          as GetMessagesRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetMessagesRequest() / GetMessagesRequest.new instead')
  static GetMessagesRequest create() => GetMessagesRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetMessagesRequest._();
  @$core.override
  GetMessagesRequest createEmptyInstance() => GetMessagesRequest._();
  @$core.pragma('dart2js:noInline')
  static GetMessagesRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMessagesRequest>(
          GetMessagesRequest.$_createMessage);
  static GetMessagesRequest? _defaultInstance;

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

class GetMessagesResponse extends $pb.GeneratedMessage {
  factory GetMessagesResponse({
    $core.Iterable<Message>? messages,
    $core.Iterable<$2.User>? users,
  }) {
    final result = GetMessagesResponse._();
    if (messages != null) result.messages.addAll(messages);
    if (users != null) result.users.addAll(users);
    return result;
  }

  GetMessagesResponse._();

  factory GetMessagesResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetMessagesResponse()..mergeFromBuffer(data, registry);
  factory GetMessagesResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetMessagesResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMessagesResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetMessagesResponse.$_createMessage)
    ..pPM<Message>(1, _omitFieldNames ? '' : 'messages',
        subBuilder: Message.$_createMessage)
    ..pPM<$2.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $2.User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMessagesResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMessagesResponse copyWith(void Function(GetMessagesResponse) updates) =>
      super.copyWith((message) => updates(message as GetMessagesResponse))
          as GetMessagesResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use GetMessagesResponse() / GetMessagesResponse.new instead')
  static GetMessagesResponse create() => GetMessagesResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetMessagesResponse._();
  @$core.override
  GetMessagesResponse createEmptyInstance() => GetMessagesResponse._();
  @$core.pragma('dart2js:noInline')
  static GetMessagesResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetMessagesResponse>(
          GetMessagesResponse.$_createMessage);
  static GetMessagesResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Message> get messages => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$2.User> get users => $_getList(1);
}

class ReadHistoryRequest extends $pb.GeneratedMessage {
  factory ReadHistoryRequest({
    $fixnum.Int64? chatId,
    $fixnum.Int64? maxSeq,
  }) {
    final result = ReadHistoryRequest._();
    if (chatId != null) result.chatId = chatId;
    if (maxSeq != null) result.maxSeq = maxSeq;
    return result;
  }

  ReadHistoryRequest._();

  factory ReadHistoryRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadHistoryRequest()..mergeFromBuffer(data, registry);
  factory ReadHistoryRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadHistoryRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadHistoryRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReadHistoryRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'maxSeq')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadHistoryRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadHistoryRequest copyWith(void Function(ReadHistoryRequest) updates) =>
      super.copyWith((message) => updates(message as ReadHistoryRequest))
          as ReadHistoryRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ReadHistoryRequest() / ReadHistoryRequest.new instead')
  static ReadHistoryRequest create() => ReadHistoryRequest._();
  static $pb.GeneratedMessage $_createMessage() => ReadHistoryRequest._();
  @$core.override
  ReadHistoryRequest createEmptyInstance() => ReadHistoryRequest._();
  @$core.pragma('dart2js:noInline')
  static ReadHistoryRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadHistoryRequest>(
          ReadHistoryRequest.$_createMessage);
  static ReadHistoryRequest? _defaultInstance;

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

class ReadHistoryResponse extends $pb.GeneratedMessage {
  factory ReadHistoryResponse({
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = ReadHistoryResponse._();
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  ReadHistoryResponse._();

  factory ReadHistoryResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadHistoryResponse()..mergeFromBuffer(data, registry);
  factory ReadHistoryResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ReadHistoryResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ReadHistoryResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ReadHistoryResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadHistoryResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ReadHistoryResponse copyWith(void Function(ReadHistoryResponse) updates) =>
      super.copyWith((message) => updates(message as ReadHistoryResponse))
          as ReadHistoryResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ReadHistoryResponse() / ReadHistoryResponse.new instead')
  static ReadHistoryResponse create() => ReadHistoryResponse._();
  static $pb.GeneratedMessage $_createMessage() => ReadHistoryResponse._();
  @$core.override
  ReadHistoryResponse createEmptyInstance() => ReadHistoryResponse._();
  @$core.pragma('dart2js:noInline')
  static ReadHistoryResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ReadHistoryResponse>(
          ReadHistoryResponse.$_createMessage);
  static ReadHistoryResponse? _defaultInstance;

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

class SetTypingRequest extends $pb.GeneratedMessage {
  factory SetTypingRequest({
    $fixnum.Int64? chatId,
    TypingAction? action,
  }) {
    final result = SetTypingRequest._();
    if (chatId != null) result.chatId = chatId;
    if (action != null) result.action = action;
    return result;
  }

  SetTypingRequest._();

  factory SetTypingRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetTypingRequest()..mergeFromBuffer(data, registry);
  factory SetTypingRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetTypingRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetTypingRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetTypingRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aE<TypingAction>(2, _omitFieldNames ? '' : 'action',
        enumValues: TypingAction.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetTypingRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetTypingRequest copyWith(void Function(SetTypingRequest) updates) =>
      super.copyWith((message) => updates(message as SetTypingRequest))
          as SetTypingRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetTypingRequest() / SetTypingRequest.new instead')
  static SetTypingRequest create() => SetTypingRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetTypingRequest._();
  @$core.override
  SetTypingRequest createEmptyInstance() => SetTypingRequest._();
  @$core.pragma('dart2js:noInline')
  static SetTypingRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetTypingRequest>(
          SetTypingRequest.$_createMessage);
  static SetTypingRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get chatId => $_getI64(0);
  @$pb.TagNumber(1)
  set chatId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasChatId() => $_has(0);
  @$pb.TagNumber(1)
  void clearChatId() => $_clearField(1);

  @$pb.TagNumber(2)
  TypingAction get action => $_getN(1);
  @$pb.TagNumber(2)
  set action(TypingAction value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasAction() => $_has(1);
  @$pb.TagNumber(2)
  void clearAction() => $_clearField(2);
}

class SetTypingResponse extends $pb.GeneratedMessage {
  factory SetTypingResponse() => SetTypingResponse._();

  SetTypingResponse._();

  factory SetTypingResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetTypingResponse()..mergeFromBuffer(data, registry);
  factory SetTypingResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetTypingResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetTypingResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetTypingResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetTypingResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetTypingResponse copyWith(void Function(SetTypingResponse) updates) =>
      super.copyWith((message) => updates(message as SetTypingResponse))
          as SetTypingResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetTypingResponse() / SetTypingResponse.new instead')
  static SetTypingResponse create() => SetTypingResponse._();
  static $pb.GeneratedMessage $_createMessage() => SetTypingResponse._();
  @$core.override
  SetTypingResponse createEmptyInstance() => SetTypingResponse._();
  @$core.pragma('dart2js:noInline')
  static SetTypingResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetTypingResponse>(
          SetTypingResponse.$_createMessage);
  static SetTypingResponse? _defaultInstance;
}

class PinMessageRequest extends $pb.GeneratedMessage {
  factory PinMessageRequest({
    $fixnum.Int64? chatId,
    $fixnum.Int64? seq,
    $core.bool? unpin,
    $core.bool? silent,
  }) {
    final result = PinMessageRequest._();
    if (chatId != null) result.chatId = chatId;
    if (seq != null) result.seq = seq;
    if (unpin != null) result.unpin = unpin;
    if (silent != null) result.silent = silent;
    return result;
  }

  PinMessageRequest._();

  factory PinMessageRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PinMessageRequest()..mergeFromBuffer(data, registry);
  factory PinMessageRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PinMessageRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PinMessageRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: PinMessageRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'chatId')
    ..aInt64(2, _omitFieldNames ? '' : 'seq')
    ..aOB(3, _omitFieldNames ? '' : 'unpin')
    ..aOB(4, _omitFieldNames ? '' : 'silent')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PinMessageRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PinMessageRequest copyWith(void Function(PinMessageRequest) updates) =>
      super.copyWith((message) => updates(message as PinMessageRequest))
          as PinMessageRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PinMessageRequest() / PinMessageRequest.new instead')
  static PinMessageRequest create() => PinMessageRequest._();
  static $pb.GeneratedMessage $_createMessage() => PinMessageRequest._();
  @$core.override
  PinMessageRequest createEmptyInstance() => PinMessageRequest._();
  @$core.pragma('dart2js:noInline')
  static PinMessageRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PinMessageRequest>(
          PinMessageRequest.$_createMessage);
  static PinMessageRequest? _defaultInstance;

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
  $core.bool get unpin => $_getBF(2);
  @$pb.TagNumber(3)
  set unpin($core.bool value) => $_setBool(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUnpin() => $_has(2);
  @$pb.TagNumber(3)
  void clearUnpin() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.bool get silent => $_getBF(3);
  @$pb.TagNumber(4)
  set silent($core.bool value) => $_setBool(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSilent() => $_has(3);
  @$pb.TagNumber(4)
  void clearSilent() => $_clearField(4);
}

class PinMessageResponse extends $pb.GeneratedMessage {
  factory PinMessageResponse({
    $fixnum.Int64? pts,
    $core.int? ptsCount,
  }) {
    final result = PinMessageResponse._();
    if (pts != null) result.pts = pts;
    if (ptsCount != null) result.ptsCount = ptsCount;
    return result;
  }

  PinMessageResponse._();

  factory PinMessageResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PinMessageResponse()..mergeFromBuffer(data, registry);
  factory PinMessageResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PinMessageResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PinMessageResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: PinMessageResponse.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'pts')
    ..aI(2, _omitFieldNames ? '' : 'ptsCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PinMessageResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PinMessageResponse copyWith(void Function(PinMessageResponse) updates) =>
      super.copyWith((message) => updates(message as PinMessageResponse))
          as PinMessageResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PinMessageResponse() / PinMessageResponse.new instead')
  static PinMessageResponse create() => PinMessageResponse._();
  static $pb.GeneratedMessage $_createMessage() => PinMessageResponse._();
  @$core.override
  PinMessageResponse createEmptyInstance() => PinMessageResponse._();
  @$core.pragma('dart2js:noInline')
  static PinMessageResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<PinMessageResponse>(
          PinMessageResponse.$_createMessage);
  static PinMessageResponse? _defaultInstance;

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

/// MessagesService: sending, editing, deleting and reading messages.
///
/// Every state-changing call returns (pts, pts_count) for the caller's own
/// update sequence. The client applies the change locally and advances its
/// pts only if local_pts + pts_count == pts; otherwise it calls
/// UpdatesService.GetDifference. See docs/03-protocol.md §5.
class MessagesServiceApi {
  final $pb.RpcClient _client;

  MessagesServiceApi(this._client);

  $async.Future<SendMessageResponse> sendMessage(
          $pb.ClientContext? ctx, SendMessageRequest request) =>
      _client.invoke<SendMessageResponse>(ctx, 'MessagesService', 'SendMessage',
          request, SendMessageResponse());
  $async.Future<EditMessageResponse> editMessage(
          $pb.ClientContext? ctx, EditMessageRequest request) =>
      _client.invoke<EditMessageResponse>(ctx, 'MessagesService', 'EditMessage',
          request, EditMessageResponse());
  $async.Future<DeleteMessagesResponse> deleteMessages(
          $pb.ClientContext? ctx, DeleteMessagesRequest request) =>
      _client.invoke<DeleteMessagesResponse>(ctx, 'MessagesService',
          'DeleteMessages', request, DeleteMessagesResponse());
  $async.Future<ForwardMessagesResponse> forwardMessages(
          $pb.ClientContext? ctx, ForwardMessagesRequest request) =>
      _client.invoke<ForwardMessagesResponse>(ctx, 'MessagesService',
          'ForwardMessages', request, ForwardMessagesResponse());
  $async.Future<GetHistoryResponse> getHistory(
          $pb.ClientContext? ctx, GetHistoryRequest request) =>
      _client.invoke<GetHistoryResponse>(
          ctx, 'MessagesService', 'GetHistory', request, GetHistoryResponse());
  $async.Future<GetMessagesResponse> getMessages(
          $pb.ClientContext? ctx, GetMessagesRequest request) =>
      _client.invoke<GetMessagesResponse>(ctx, 'MessagesService', 'GetMessages',
          request, GetMessagesResponse());
  $async.Future<ReadHistoryResponse> readHistory(
          $pb.ClientContext? ctx, ReadHistoryRequest request) =>
      _client.invoke<ReadHistoryResponse>(ctx, 'MessagesService', 'ReadHistory',
          request, ReadHistoryResponse());
  $async.Future<SetTypingResponse> setTyping(
          $pb.ClientContext? ctx, SetTypingRequest request) =>
      _client.invoke<SetTypingResponse>(
          ctx, 'MessagesService', 'SetTyping', request, SetTypingResponse());
  $async.Future<PinMessageResponse> pinMessage(
          $pb.ClientContext? ctx, PinMessageRequest request) =>
      _client.invoke<PinMessageResponse>(
          ctx, 'MessagesService', 'PinMessage', request, PinMessageResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
