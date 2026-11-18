// This is a generated file - do not edit.
//
// Generated from wasla/v1/messages.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class TextEntityType extends $pb.ProtobufEnum {
  static const TextEntityType TEXT_ENTITY_TYPE_UNSPECIFIED =
      TextEntityType._(0, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_UNSPECIFIED');
  static const TextEntityType TEXT_ENTITY_TYPE_BOLD =
      TextEntityType._(1, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_BOLD');
  static const TextEntityType TEXT_ENTITY_TYPE_ITALIC =
      TextEntityType._(2, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_ITALIC');
  static const TextEntityType TEXT_ENTITY_TYPE_UNDERLINE =
      TextEntityType._(3, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_UNDERLINE');
  static const TextEntityType TEXT_ENTITY_TYPE_STRIKETHROUGH = TextEntityType._(
      4, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_STRIKETHROUGH');
  static const TextEntityType TEXT_ENTITY_TYPE_CODE =
      TextEntityType._(5, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_CODE');
  static const TextEntityType TEXT_ENTITY_TYPE_PRE =
      TextEntityType._(6, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_PRE');
  static const TextEntityType TEXT_ENTITY_TYPE_TEXT_URL =
      TextEntityType._(7, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_TEXT_URL');
  static const TextEntityType TEXT_ENTITY_TYPE_URL =
      TextEntityType._(8, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_URL');
  static const TextEntityType TEXT_ENTITY_TYPE_MENTION =
      TextEntityType._(9, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_MENTION');
  static const TextEntityType TEXT_ENTITY_TYPE_MENTION_NAME = TextEntityType._(
      10, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_MENTION_NAME');
  static const TextEntityType TEXT_ENTITY_TYPE_HASHTAG =
      TextEntityType._(11, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_HASHTAG');
  static const TextEntityType TEXT_ENTITY_TYPE_PHONE =
      TextEntityType._(12, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_PHONE');
  static const TextEntityType TEXT_ENTITY_TYPE_EMAIL =
      TextEntityType._(13, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_EMAIL');
  static const TextEntityType TEXT_ENTITY_TYPE_SPOILER =
      TextEntityType._(14, _omitEnumNames ? '' : 'TEXT_ENTITY_TYPE_SPOILER');

  static const $core.List<TextEntityType> values = <TextEntityType>[
    TEXT_ENTITY_TYPE_UNSPECIFIED,
    TEXT_ENTITY_TYPE_BOLD,
    TEXT_ENTITY_TYPE_ITALIC,
    TEXT_ENTITY_TYPE_UNDERLINE,
    TEXT_ENTITY_TYPE_STRIKETHROUGH,
    TEXT_ENTITY_TYPE_CODE,
    TEXT_ENTITY_TYPE_PRE,
    TEXT_ENTITY_TYPE_TEXT_URL,
    TEXT_ENTITY_TYPE_URL,
    TEXT_ENTITY_TYPE_MENTION,
    TEXT_ENTITY_TYPE_MENTION_NAME,
    TEXT_ENTITY_TYPE_HASHTAG,
    TEXT_ENTITY_TYPE_PHONE,
    TEXT_ENTITY_TYPE_EMAIL,
    TEXT_ENTITY_TYPE_SPOILER,
  ];

  static final $core.List<TextEntityType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 14);
  static TextEntityType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TextEntityType._(super.value, super.name);
}

class HistoryDirection extends $pb.ProtobufEnum {
  static const HistoryDirection HISTORY_DIRECTION_UNSPECIFIED =
      HistoryDirection._(
          0, _omitEnumNames ? '' : 'HISTORY_DIRECTION_UNSPECIFIED');

  /// Messages with seq < offset_seq, newest first.
  static const HistoryDirection HISTORY_DIRECTION_OLDER =
      HistoryDirection._(1, _omitEnumNames ? '' : 'HISTORY_DIRECTION_OLDER');

  /// Messages with seq > offset_seq, oldest first.
  static const HistoryDirection HISTORY_DIRECTION_NEWER =
      HistoryDirection._(2, _omitEnumNames ? '' : 'HISTORY_DIRECTION_NEWER');

  /// limit/2 on each side of offset_seq (jump to a reply or search hit).
  static const HistoryDirection HISTORY_DIRECTION_AROUND =
      HistoryDirection._(3, _omitEnumNames ? '' : 'HISTORY_DIRECTION_AROUND');

  static const $core.List<HistoryDirection> values = <HistoryDirection>[
    HISTORY_DIRECTION_UNSPECIFIED,
    HISTORY_DIRECTION_OLDER,
    HISTORY_DIRECTION_NEWER,
    HISTORY_DIRECTION_AROUND,
  ];

  static final $core.List<HistoryDirection?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static HistoryDirection? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const HistoryDirection._(super.value, super.name);
}

class TypingAction extends $pb.ProtobufEnum {
  static const TypingAction TYPING_ACTION_UNSPECIFIED =
      TypingAction._(0, _omitEnumNames ? '' : 'TYPING_ACTION_UNSPECIFIED');
  static const TypingAction TYPING_ACTION_TYPING =
      TypingAction._(1, _omitEnumNames ? '' : 'TYPING_ACTION_TYPING');
  static const TypingAction TYPING_ACTION_RECORDING_VOICE =
      TypingAction._(2, _omitEnumNames ? '' : 'TYPING_ACTION_RECORDING_VOICE');
  static const TypingAction TYPING_ACTION_UPLOADING_PHOTO =
      TypingAction._(3, _omitEnumNames ? '' : 'TYPING_ACTION_UPLOADING_PHOTO');
  static const TypingAction TYPING_ACTION_UPLOADING_VIDEO =
      TypingAction._(4, _omitEnumNames ? '' : 'TYPING_ACTION_UPLOADING_VIDEO');
  static const TypingAction TYPING_ACTION_UPLOADING_DOCUMENT = TypingAction._(
      5, _omitEnumNames ? '' : 'TYPING_ACTION_UPLOADING_DOCUMENT');
  static const TypingAction TYPING_ACTION_CANCEL =
      TypingAction._(6, _omitEnumNames ? '' : 'TYPING_ACTION_CANCEL');

  static const $core.List<TypingAction> values = <TypingAction>[
    TYPING_ACTION_UNSPECIFIED,
    TYPING_ACTION_TYPING,
    TYPING_ACTION_RECORDING_VOICE,
    TYPING_ACTION_UPLOADING_PHOTO,
    TYPING_ACTION_UPLOADING_VIDEO,
    TYPING_ACTION_UPLOADING_DOCUMENT,
    TYPING_ACTION_CANCEL,
  ];

  static final $core.List<TypingAction?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static TypingAction? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const TypingAction._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
