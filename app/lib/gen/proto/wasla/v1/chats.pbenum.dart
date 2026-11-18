// This is a generated file - do not edit.
//
// Generated from wasla/v1/chats.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ChatType extends $pb.ProtobufEnum {
  static const ChatType CHAT_TYPE_UNSPECIFIED =
      ChatType._(0, _omitEnumNames ? '' : 'CHAT_TYPE_UNSPECIFIED');
  static const ChatType CHAT_TYPE_PRIVATE =
      ChatType._(1, _omitEnumNames ? '' : 'CHAT_TYPE_PRIVATE');
  static const ChatType CHAT_TYPE_SAVED =
      ChatType._(2, _omitEnumNames ? '' : 'CHAT_TYPE_SAVED');

  /// Small group, fan-out on write. Lean MVP limit: 200 members.
  static const ChatType CHAT_TYPE_GROUP =
      ChatType._(3, _omitEnumNames ? '' : 'CHAT_TYPE_GROUP');

  /// Phase 2: large groups (up to 200,000) and channels, fan-out on read.
  static const ChatType CHAT_TYPE_SUPERGROUP =
      ChatType._(4, _omitEnumNames ? '' : 'CHAT_TYPE_SUPERGROUP');
  static const ChatType CHAT_TYPE_CHANNEL =
      ChatType._(5, _omitEnumNames ? '' : 'CHAT_TYPE_CHANNEL');

  static const $core.List<ChatType> values = <ChatType>[
    CHAT_TYPE_UNSPECIFIED,
    CHAT_TYPE_PRIVATE,
    CHAT_TYPE_SAVED,
    CHAT_TYPE_GROUP,
    CHAT_TYPE_SUPERGROUP,
    CHAT_TYPE_CHANNEL,
  ];

  static final $core.List<ChatType?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 5);
  static ChatType? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ChatType._(super.value, super.name);
}

class ChatMemberRole extends $pb.ProtobufEnum {
  static const ChatMemberRole CHAT_MEMBER_ROLE_UNSPECIFIED =
      ChatMemberRole._(0, _omitEnumNames ? '' : 'CHAT_MEMBER_ROLE_UNSPECIFIED');
  static const ChatMemberRole CHAT_MEMBER_ROLE_MEMBER =
      ChatMemberRole._(1, _omitEnumNames ? '' : 'CHAT_MEMBER_ROLE_MEMBER');
  static const ChatMemberRole CHAT_MEMBER_ROLE_ADMIN =
      ChatMemberRole._(2, _omitEnumNames ? '' : 'CHAT_MEMBER_ROLE_ADMIN');
  static const ChatMemberRole CHAT_MEMBER_ROLE_OWNER =
      ChatMemberRole._(3, _omitEnumNames ? '' : 'CHAT_MEMBER_ROLE_OWNER');

  static const $core.List<ChatMemberRole> values = <ChatMemberRole>[
    CHAT_MEMBER_ROLE_UNSPECIFIED,
    CHAT_MEMBER_ROLE_MEMBER,
    CHAT_MEMBER_ROLE_ADMIN,
    CHAT_MEMBER_ROLE_OWNER,
  ];

  static final $core.List<ChatMemberRole?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static ChatMemberRole? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ChatMemberRole._(super.value, super.name);
}

/// AdminRight values are bit flags, combined in admin_rights.
class AdminRight extends $pb.ProtobufEnum {
  static const AdminRight ADMIN_RIGHT_UNSPECIFIED =
      AdminRight._(0, _omitEnumNames ? '' : 'ADMIN_RIGHT_UNSPECIFIED');
  static const AdminRight ADMIN_RIGHT_CHANGE_INFO =
      AdminRight._(1, _omitEnumNames ? '' : 'ADMIN_RIGHT_CHANGE_INFO');
  static const AdminRight ADMIN_RIGHT_DELETE_MESSAGES =
      AdminRight._(2, _omitEnumNames ? '' : 'ADMIN_RIGHT_DELETE_MESSAGES');
  static const AdminRight ADMIN_RIGHT_BAN_USERS =
      AdminRight._(4, _omitEnumNames ? '' : 'ADMIN_RIGHT_BAN_USERS');
  static const AdminRight ADMIN_RIGHT_INVITE_USERS =
      AdminRight._(8, _omitEnumNames ? '' : 'ADMIN_RIGHT_INVITE_USERS');
  static const AdminRight ADMIN_RIGHT_PIN_MESSAGES =
      AdminRight._(16, _omitEnumNames ? '' : 'ADMIN_RIGHT_PIN_MESSAGES');
  static const AdminRight ADMIN_RIGHT_ADD_ADMINS =
      AdminRight._(32, _omitEnumNames ? '' : 'ADMIN_RIGHT_ADD_ADMINS');

  static const $core.List<AdminRight> values = <AdminRight>[
    ADMIN_RIGHT_UNSPECIFIED,
    ADMIN_RIGHT_CHANGE_INFO,
    ADMIN_RIGHT_DELETE_MESSAGES,
    ADMIN_RIGHT_BAN_USERS,
    ADMIN_RIGHT_INVITE_USERS,
    ADMIN_RIGHT_PIN_MESSAGES,
    ADMIN_RIGHT_ADD_ADMINS,
  ];

  static final $core.Map<$core.int, AdminRight> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static AdminRight? valueOf($core.int value) => _byValue[value];

  const AdminRight._(super.value, super.name);
}

/// MemberPermission values are bit flags for what ordinary members may do,
/// combined in default_permissions.
class MemberPermission extends $pb.ProtobufEnum {
  static const MemberPermission MEMBER_PERMISSION_UNSPECIFIED =
      MemberPermission._(
          0, _omitEnumNames ? '' : 'MEMBER_PERMISSION_UNSPECIFIED');
  static const MemberPermission MEMBER_PERMISSION_SEND_MESSAGES =
      MemberPermission._(
          1, _omitEnumNames ? '' : 'MEMBER_PERMISSION_SEND_MESSAGES');
  static const MemberPermission MEMBER_PERMISSION_SEND_MEDIA =
      MemberPermission._(
          2, _omitEnumNames ? '' : 'MEMBER_PERMISSION_SEND_MEDIA');
  static const MemberPermission MEMBER_PERMISSION_ADD_MEMBERS =
      MemberPermission._(
          4, _omitEnumNames ? '' : 'MEMBER_PERMISSION_ADD_MEMBERS');
  static const MemberPermission MEMBER_PERMISSION_PIN_MESSAGES =
      MemberPermission._(
          8, _omitEnumNames ? '' : 'MEMBER_PERMISSION_PIN_MESSAGES');
  static const MemberPermission MEMBER_PERMISSION_CHANGE_INFO =
      MemberPermission._(
          16, _omitEnumNames ? '' : 'MEMBER_PERMISSION_CHANGE_INFO');

  static const $core.List<MemberPermission> values = <MemberPermission>[
    MEMBER_PERMISSION_UNSPECIFIED,
    MEMBER_PERMISSION_SEND_MESSAGES,
    MEMBER_PERMISSION_SEND_MEDIA,
    MEMBER_PERMISSION_ADD_MEMBERS,
    MEMBER_PERMISSION_PIN_MESSAGES,
    MEMBER_PERMISSION_CHANGE_INFO,
  ];

  static final $core.Map<$core.int, MemberPermission> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static MemberPermission? valueOf($core.int value) => _byValue[value];

  const MemberPermission._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
