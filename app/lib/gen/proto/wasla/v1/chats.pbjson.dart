// This is a generated file - do not edit.
//
// Generated from wasla/v1/chats.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports
// ignore_for_file: unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

import 'common.pbjson.dart' as $0;
import 'media.pbjson.dart' as $3;
import 'messages.pbjson.dart' as $1;
import 'users.pbjson.dart' as $2;

@$core.Deprecated('Use chatTypeDescriptor instead')
const ChatType$json = {
  '1': 'ChatType',
  '2': [
    {'1': 'CHAT_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'CHAT_TYPE_PRIVATE', '2': 1},
    {'1': 'CHAT_TYPE_SAVED', '2': 2},
    {'1': 'CHAT_TYPE_GROUP', '2': 3},
    {'1': 'CHAT_TYPE_SUPERGROUP', '2': 4},
    {'1': 'CHAT_TYPE_CHANNEL', '2': 5},
  ],
};

/// Descriptor for `ChatType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List chatTypeDescriptor = $convert.base64Decode(
    'CghDaGF0VHlwZRIZChVDSEFUX1RZUEVfVU5TUEVDSUZJRUQQABIVChFDSEFUX1RZUEVfUFJJVk'
    'FURRABEhMKD0NIQVRfVFlQRV9TQVZFRBACEhMKD0NIQVRfVFlQRV9HUk9VUBADEhgKFENIQVRf'
    'VFlQRV9TVVBFUkdST1VQEAQSFQoRQ0hBVF9UWVBFX0NIQU5ORUwQBQ==');

@$core.Deprecated('Use chatMemberRoleDescriptor instead')
const ChatMemberRole$json = {
  '1': 'ChatMemberRole',
  '2': [
    {'1': 'CHAT_MEMBER_ROLE_UNSPECIFIED', '2': 0},
    {'1': 'CHAT_MEMBER_ROLE_MEMBER', '2': 1},
    {'1': 'CHAT_MEMBER_ROLE_ADMIN', '2': 2},
    {'1': 'CHAT_MEMBER_ROLE_OWNER', '2': 3},
  ],
};

/// Descriptor for `ChatMemberRole`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List chatMemberRoleDescriptor = $convert.base64Decode(
    'Cg5DaGF0TWVtYmVyUm9sZRIgChxDSEFUX01FTUJFUl9ST0xFX1VOU1BFQ0lGSUVEEAASGwoXQ0'
    'hBVF9NRU1CRVJfUk9MRV9NRU1CRVIQARIaChZDSEFUX01FTUJFUl9ST0xFX0FETUlOEAISGgoW'
    'Q0hBVF9NRU1CRVJfUk9MRV9PV05FUhAD');

@$core.Deprecated('Use adminRightDescriptor instead')
const AdminRight$json = {
  '1': 'AdminRight',
  '2': [
    {'1': 'ADMIN_RIGHT_UNSPECIFIED', '2': 0},
    {'1': 'ADMIN_RIGHT_CHANGE_INFO', '2': 1},
    {'1': 'ADMIN_RIGHT_DELETE_MESSAGES', '2': 2},
    {'1': 'ADMIN_RIGHT_BAN_USERS', '2': 4},
    {'1': 'ADMIN_RIGHT_INVITE_USERS', '2': 8},
    {'1': 'ADMIN_RIGHT_PIN_MESSAGES', '2': 16},
    {'1': 'ADMIN_RIGHT_ADD_ADMINS', '2': 32},
  ],
};

/// Descriptor for `AdminRight`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List adminRightDescriptor = $convert.base64Decode(
    'CgpBZG1pblJpZ2h0EhsKF0FETUlOX1JJR0hUX1VOU1BFQ0lGSUVEEAASGwoXQURNSU5fUklHSF'
    'RfQ0hBTkdFX0lORk8QARIfChtBRE1JTl9SSUdIVF9ERUxFVEVfTUVTU0FHRVMQAhIZChVBRE1J'
    'Tl9SSUdIVF9CQU5fVVNFUlMQBBIcChhBRE1JTl9SSUdIVF9JTlZJVEVfVVNFUlMQCBIcChhBRE'
    '1JTl9SSUdIVF9QSU5fTUVTU0FHRVMQEBIaChZBRE1JTl9SSUdIVF9BRERfQURNSU5TECA=');

@$core.Deprecated('Use memberPermissionDescriptor instead')
const MemberPermission$json = {
  '1': 'MemberPermission',
  '2': [
    {'1': 'MEMBER_PERMISSION_UNSPECIFIED', '2': 0},
    {'1': 'MEMBER_PERMISSION_SEND_MESSAGES', '2': 1},
    {'1': 'MEMBER_PERMISSION_SEND_MEDIA', '2': 2},
    {'1': 'MEMBER_PERMISSION_ADD_MEMBERS', '2': 4},
    {'1': 'MEMBER_PERMISSION_PIN_MESSAGES', '2': 8},
    {'1': 'MEMBER_PERMISSION_CHANGE_INFO', '2': 16},
  ],
};

/// Descriptor for `MemberPermission`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List memberPermissionDescriptor = $convert.base64Decode(
    'ChBNZW1iZXJQZXJtaXNzaW9uEiEKHU1FTUJFUl9QRVJNSVNTSU9OX1VOU1BFQ0lGSUVEEAASIw'
    'ofTUVNQkVSX1BFUk1JU1NJT05fU0VORF9NRVNTQUdFUxABEiAKHE1FTUJFUl9QRVJNSVNTSU9O'
    'X1NFTkRfTUVESUEQAhIhCh1NRU1CRVJfUEVSTUlTU0lPTl9BRERfTUVNQkVSUxAEEiIKHk1FTU'
    'JFUl9QRVJNSVNTSU9OX1BJTl9NRVNTQUdFUxAIEiEKHU1FTUJFUl9QRVJNSVNTSU9OX0NIQU5H'
    'RV9JTkZPEBA=');

@$core.Deprecated('Use chatDescriptor instead')
const Chat$json = {
  '1': 'Chat',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {
      '1': 'type',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.ChatType',
      '10': 'type'
    },
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'about', '3': 4, '4': 1, '5': 9, '10': 'about'},
    {
      '1': 'photo',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Avatar',
      '10': 'photo'
    },
    {'1': 'peer_user_id', '3': 6, '4': 1, '5': 3, '10': 'peerUserId'},
    {'1': 'member_count', '3': 7, '4': 1, '5': 5, '10': 'memberCount'},
    {'1': 'creator_id', '3': 8, '4': 1, '5': 3, '10': 'creatorId'},
    {
      '1': 'default_permissions',
      '3': 9,
      '4': 1,
      '5': 4,
      '10': 'defaultPermissions'
    },
    {
      '1': 'my_role',
      '3': 10,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.ChatMemberRole',
      '10': 'myRole'
    },
    {'1': 'my_admin_rights', '3': 11, '4': 1, '5': 4, '10': 'myAdminRights'},
    {'1': 'last_seq', '3': 12, '4': 1, '5': 3, '10': 'lastSeq'},
    {'1': 'created_at', '3': 13, '4': 1, '5': 3, '10': 'createdAt'},
  ],
};

/// Descriptor for `Chat`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatDescriptor = $convert.base64Decode(
    'CgRDaGF0Eg4KAmlkGAEgASgDUgJpZBImCgR0eXBlGAIgASgOMhIud2FzbGEudjEuQ2hhdFR5cG'
    'VSBHR5cGUSFAoFdGl0bGUYAyABKAlSBXRpdGxlEhQKBWFib3V0GAQgASgJUgVhYm91dBImCgVw'
    'aG90bxgFIAEoCzIQLndhc2xhLnYxLkF2YXRhclIFcGhvdG8SIAoMcGVlcl91c2VyX2lkGAYgAS'
    'gDUgpwZWVyVXNlcklkEiEKDG1lbWJlcl9jb3VudBgHIAEoBVILbWVtYmVyQ291bnQSHQoKY3Jl'
    'YXRvcl9pZBgIIAEoA1IJY3JlYXRvcklkEi8KE2RlZmF1bHRfcGVybWlzc2lvbnMYCSABKARSEm'
    'RlZmF1bHRQZXJtaXNzaW9ucxIxCgdteV9yb2xlGAogASgOMhgud2FzbGEudjEuQ2hhdE1lbWJl'
    'clJvbGVSBm15Um9sZRImCg9teV9hZG1pbl9yaWdodHMYCyABKARSDW15QWRtaW5SaWdodHMSGQ'
    'oIbGFzdF9zZXEYDCABKANSB2xhc3RTZXESHQoKY3JlYXRlZF9hdBgNIAEoA1IJY3JlYXRlZEF0');

@$core.Deprecated('Use dialogDescriptor instead')
const Dialog$json = {
  '1': 'Dialog',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {
      '1': 'top_message',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Message',
      '10': 'topMessage'
    },
    {'1': 'unread_count', '3': 3, '4': 1, '5': 5, '10': 'unreadCount'},
    {'1': 'read_inbox_seq', '3': 4, '4': 1, '5': 3, '10': 'readInboxSeq'},
    {'1': 'read_outbox_seq', '3': 5, '4': 1, '5': 3, '10': 'readOutboxSeq'},
    {'1': 'pinned_rank', '3': 6, '4': 1, '5': 5, '10': 'pinnedRank'},
    {'1': 'archived', '3': 7, '4': 1, '5': 8, '10': 'archived'},
    {'1': 'muted_until', '3': 8, '4': 1, '5': 3, '10': 'mutedUntil'},
  ],
};

/// Descriptor for `Dialog`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dialogDescriptor = $convert.base64Decode(
    'CgZEaWFsb2cSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEjIKC3RvcF9tZXNzYWdlGAIgASgLMh'
    'Eud2FzbGEudjEuTWVzc2FnZVIKdG9wTWVzc2FnZRIhCgx1bnJlYWRfY291bnQYAyABKAVSC3Vu'
    'cmVhZENvdW50EiQKDnJlYWRfaW5ib3hfc2VxGAQgASgDUgxyZWFkSW5ib3hTZXESJgoPcmVhZF'
    '9vdXRib3hfc2VxGAUgASgDUg1yZWFkT3V0Ym94U2VxEh8KC3Bpbm5lZF9yYW5rGAYgASgFUgpw'
    'aW5uZWRSYW5rEhoKCGFyY2hpdmVkGAcgASgIUghhcmNoaXZlZBIfCgttdXRlZF91bnRpbBgIIA'
    'EoA1IKbXV0ZWRVbnRpbA==');

@$core.Deprecated('Use chatMemberDescriptor instead')
const ChatMember$json = {
  '1': 'ChatMember',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
    {
      '1': 'role',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.ChatMemberRole',
      '10': 'role'
    },
    {'1': 'admin_rights', '3': 3, '4': 1, '5': 4, '10': 'adminRights'},
    {'1': 'joined_at', '3': 4, '4': 1, '5': 3, '10': 'joinedAt'},
    {'1': 'invited_by', '3': 5, '4': 1, '5': 3, '10': 'invitedBy'},
  ],
};

/// Descriptor for `ChatMember`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatMemberDescriptor = $convert.base64Decode(
    'CgpDaGF0TWVtYmVyEhcKB3VzZXJfaWQYASABKANSBnVzZXJJZBIsCgRyb2xlGAIgASgOMhgud2'
    'FzbGEudjEuQ2hhdE1lbWJlclJvbGVSBHJvbGUSIQoMYWRtaW5fcmlnaHRzGAMgASgEUgthZG1p'
    'blJpZ2h0cxIbCglqb2luZWRfYXQYBCABKANSCGpvaW5lZEF0Eh0KCmludml0ZWRfYnkYBSABKA'
    'NSCWludml0ZWRCeQ==');

@$core.Deprecated('Use chatInviteDescriptor instead')
const ChatInvite$json = {
  '1': 'ChatInvite',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'created_by', '3': 4, '4': 1, '5': 3, '10': 'createdBy'},
    {'1': 'expires_at', '3': 5, '4': 1, '5': 3, '10': 'expiresAt'},
    {'1': 'usage_limit', '3': 6, '4': 1, '5': 5, '10': 'usageLimit'},
    {'1': 'usage_count', '3': 7, '4': 1, '5': 5, '10': 'usageCount'},
    {'1': 'revoked', '3': 8, '4': 1, '5': 8, '10': 'revoked'},
  ],
};

/// Descriptor for `ChatInvite`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatInviteDescriptor = $convert.base64Decode(
    'CgpDaGF0SW52aXRlEhIKBGNvZGUYASABKAlSBGNvZGUSEAoDdXJsGAIgASgJUgN1cmwSFAoFdG'
    'l0bGUYAyABKAlSBXRpdGxlEh0KCmNyZWF0ZWRfYnkYBCABKANSCWNyZWF0ZWRCeRIdCgpleHBp'
    'cmVzX2F0GAUgASgDUglleHBpcmVzQXQSHwoLdXNhZ2VfbGltaXQYBiABKAVSCnVzYWdlTGltaX'
    'QSHwoLdXNhZ2VfY291bnQYByABKAVSCnVzYWdlQ291bnQSGAoHcmV2b2tlZBgIIAEoCFIHcmV2'
    'b2tlZA==');

@$core.Deprecated('Use listDialogsRequestDescriptor instead')
const ListDialogsRequest$json = {
  '1': 'ListDialogsRequest',
  '2': [
    {'1': 'archived', '3': 1, '4': 1, '5': 8, '10': 'archived'},
    {'1': 'offset_date', '3': 2, '4': 1, '5': 3, '10': 'offsetDate'},
    {'1': 'offset_chat_id', '3': 3, '4': 1, '5': 3, '10': 'offsetChatId'},
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListDialogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDialogsRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0RGlhbG9nc1JlcXVlc3QSGgoIYXJjaGl2ZWQYASABKAhSCGFyY2hpdmVkEh8KC29mZn'
    'NldF9kYXRlGAIgASgDUgpvZmZzZXREYXRlEiQKDm9mZnNldF9jaGF0X2lkGAMgASgDUgxvZmZz'
    'ZXRDaGF0SWQSFAoFbGltaXQYBCABKAVSBWxpbWl0');

@$core.Deprecated('Use listDialogsResponseDescriptor instead')
const ListDialogsResponse$json = {
  '1': 'ListDialogsResponse',
  '2': [
    {
      '1': 'dialogs',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Dialog',
      '10': 'dialogs'
    },
    {
      '1': 'chats',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Chat',
      '10': 'chats'
    },
    {
      '1': 'users',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
    {'1': 'has_more', '3': 4, '4': 1, '5': 8, '10': 'hasMore'},
    {'1': 'pts', '3': 5, '4': 1, '5': 3, '10': 'pts'},
  ],
};

/// Descriptor for `ListDialogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listDialogsResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0RGlhbG9nc1Jlc3BvbnNlEioKB2RpYWxvZ3MYASADKAsyEC53YXNsYS52MS5EaWFsb2'
    'dSB2RpYWxvZ3MSJAoFY2hhdHMYAiADKAsyDi53YXNsYS52MS5DaGF0UgVjaGF0cxIkCgV1c2Vy'
    'cxgDIAMoCzIOLndhc2xhLnYxLlVzZXJSBXVzZXJzEhkKCGhhc19tb3JlGAQgASgIUgdoYXNNb3'
    'JlEhAKA3B0cxgFIAEoA1IDcHRz');

@$core.Deprecated('Use updateDialogRequestDescriptor instead')
const UpdateDialogRequest$json = {
  '1': 'UpdateDialogRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'pinned', '3': 2, '4': 1, '5': 8, '9': 0, '10': 'pinned', '17': true},
    {
      '1': 'archived',
      '3': 3,
      '4': 1,
      '5': 8,
      '9': 1,
      '10': 'archived',
      '17': true
    },
    {
      '1': 'muted_until',
      '3': 4,
      '4': 1,
      '5': 3,
      '9': 2,
      '10': 'mutedUntil',
      '17': true
    },
  ],
  '8': [
    {'1': '_pinned'},
    {'1': '_archived'},
    {'1': '_muted_until'},
  ],
};

/// Descriptor for `UpdateDialogRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDialogRequestDescriptor = $convert.base64Decode(
    'ChNVcGRhdGVEaWFsb2dSZXF1ZXN0EhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBIbCgZwaW5uZW'
    'QYAiABKAhIAFIGcGlubmVkiAEBEh8KCGFyY2hpdmVkGAMgASgISAFSCGFyY2hpdmVkiAEBEiQK'
    'C211dGVkX3VudGlsGAQgASgDSAJSCm11dGVkVW50aWyIAQFCCQoHX3Bpbm5lZEILCglfYXJjaG'
    'l2ZWRCDgoMX211dGVkX3VudGls');

@$core.Deprecated('Use updateDialogResponseDescriptor instead')
const UpdateDialogResponse$json = {
  '1': 'UpdateDialogResponse',
  '2': [
    {
      '1': 'dialog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Dialog',
      '10': 'dialog'
    },
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `UpdateDialogResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDialogResponseDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVEaWFsb2dSZXNwb25zZRIoCgZkaWFsb2cYASABKAsyEC53YXNsYS52MS5EaWFsb2'
    'dSBmRpYWxvZxIQCgNwdHMYAiABKANSA3B0cxIbCglwdHNfY291bnQYAyABKAVSCHB0c0NvdW50');

@$core.Deprecated('Use reorderPinnedDialogsRequestDescriptor instead')
const ReorderPinnedDialogsRequest$json = {
  '1': 'ReorderPinnedDialogsRequest',
  '2': [
    {'1': 'chat_ids', '3': 1, '4': 3, '5': 3, '10': 'chatIds'},
    {'1': 'archived', '3': 2, '4': 1, '5': 8, '10': 'archived'},
  ],
};

/// Descriptor for `ReorderPinnedDialogsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reorderPinnedDialogsRequestDescriptor =
    $convert.base64Decode(
        'ChtSZW9yZGVyUGlubmVkRGlhbG9nc1JlcXVlc3QSGQoIY2hhdF9pZHMYASADKANSB2NoYXRJZH'
        'MSGgoIYXJjaGl2ZWQYAiABKAhSCGFyY2hpdmVk');

@$core.Deprecated('Use reorderPinnedDialogsResponseDescriptor instead')
const ReorderPinnedDialogsResponse$json = {
  '1': 'ReorderPinnedDialogsResponse',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 2, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `ReorderPinnedDialogsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reorderPinnedDialogsResponseDescriptor =
    $convert.base64Decode(
        'ChxSZW9yZGVyUGlubmVkRGlhbG9nc1Jlc3BvbnNlEhAKA3B0cxgBIAEoA1IDcHRzEhsKCXB0c1'
        '9jb3VudBgCIAEoBVIIcHRzQ291bnQ=');

@$core.Deprecated('Use clearHistoryRequestDescriptor instead')
const ClearHistoryRequest$json = {
  '1': 'ClearHistoryRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'for_everyone', '3': 2, '4': 1, '5': 8, '10': 'forEveryone'},
  ],
};

/// Descriptor for `ClearHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearHistoryRequestDescriptor = $convert.base64Decode(
    'ChNDbGVhckhpc3RvcnlSZXF1ZXN0EhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBIhCgxmb3JfZX'
    'ZlcnlvbmUYAiABKAhSC2ZvckV2ZXJ5b25l');

@$core.Deprecated('Use clearHistoryResponseDescriptor instead')
const ClearHistoryResponse$json = {
  '1': 'ClearHistoryResponse',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 2, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `ClearHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List clearHistoryResponseDescriptor = $convert.base64Decode(
    'ChRDbGVhckhpc3RvcnlSZXNwb25zZRIQCgNwdHMYASABKANSA3B0cxIbCglwdHNfY291bnQYAi'
    'ABKAVSCHB0c0NvdW50');

@$core.Deprecated('Use getChatsRequestDescriptor instead')
const GetChatsRequest$json = {
  '1': 'GetChatsRequest',
  '2': [
    {'1': 'chat_ids', '3': 1, '4': 3, '5': 3, '10': 'chatIds'},
  ],
};

/// Descriptor for `GetChatsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChatsRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRDaGF0c1JlcXVlc3QSGQoIY2hhdF9pZHMYASADKANSB2NoYXRJZHM=');

@$core.Deprecated('Use getChatsResponseDescriptor instead')
const GetChatsResponse$json = {
  '1': 'GetChatsResponse',
  '2': [
    {
      '1': 'chats',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Chat',
      '10': 'chats'
    },
  ],
};

/// Descriptor for `GetChatsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getChatsResponseDescriptor = $convert.base64Decode(
    'ChBHZXRDaGF0c1Jlc3BvbnNlEiQKBWNoYXRzGAEgAygLMg4ud2FzbGEudjEuQ2hhdFIFY2hhdH'
    'M=');

@$core.Deprecated('Use getPrivateChatRequestDescriptor instead')
const GetPrivateChatRequest$json = {
  '1': 'GetPrivateChatRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `GetPrivateChatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPrivateChatRequestDescriptor =
    $convert.base64Decode(
        'ChVHZXRQcml2YXRlQ2hhdFJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoA1IGdXNlcklk');

@$core.Deprecated('Use getPrivateChatResponseDescriptor instead')
const GetPrivateChatResponse$json = {
  '1': 'GetPrivateChatResponse',
  '2': [
    {'1': 'chat', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.Chat', '10': 'chat'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `GetPrivateChatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPrivateChatResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXRQcml2YXRlQ2hhdFJlc3BvbnNlEiIKBGNoYXQYASABKAsyDi53YXNsYS52MS5DaGF0Ug'
        'RjaGF0EiIKBHVzZXIYAiABKAsyDi53YXNsYS52MS5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use createGroupRequestDescriptor instead')
const CreateGroupRequest$json = {
  '1': 'CreateGroupRequest',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'user_ids', '3': 2, '4': 3, '5': 3, '10': 'userIds'},
    {'1': 'random_id', '3': 3, '4': 1, '5': 3, '10': 'randomId'},
  ],
};

/// Descriptor for `CreateGroupRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupRequestDescriptor = $convert.base64Decode(
    'ChJDcmVhdGVHcm91cFJlcXVlc3QSFAoFdGl0bGUYASABKAlSBXRpdGxlEhkKCHVzZXJfaWRzGA'
    'IgAygDUgd1c2VySWRzEhsKCXJhbmRvbV9pZBgDIAEoA1IIcmFuZG9tSWQ=');

@$core.Deprecated('Use createGroupResponseDescriptor instead')
const CreateGroupResponse$json = {
  '1': 'CreateGroupResponse',
  '2': [
    {'1': 'chat', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.Chat', '10': 'chat'},
    {
      '1': 'privacy_restricted_user_ids',
      '3': 2,
      '4': 3,
      '5': 3,
      '10': 'privacyRestrictedUserIds'
    },
    {'1': 'pts', '3': 3, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 4, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `CreateGroupResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createGroupResponseDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVHcm91cFJlc3BvbnNlEiIKBGNoYXQYASABKAsyDi53YXNsYS52MS5DaGF0UgRjaG'
    'F0Ej0KG3ByaXZhY3lfcmVzdHJpY3RlZF91c2VyX2lkcxgCIAMoA1IYcHJpdmFjeVJlc3RyaWN0'
    'ZWRVc2VySWRzEhAKA3B0cxgDIAEoA1IDcHRzEhsKCXB0c19jb3VudBgEIAEoBVIIcHRzQ291bn'
    'Q=');

@$core.Deprecated('Use updateChatInfoRequestDescriptor instead')
const UpdateChatInfoRequest$json = {
  '1': 'UpdateChatInfoRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '9': 0, '10': 'title', '17': true},
    {'1': 'about', '3': 3, '4': 1, '5': 9, '9': 1, '10': 'about', '17': true},
    {
      '1': 'photo_media_id',
      '3': 4,
      '4': 1,
      '5': 3,
      '9': 2,
      '10': 'photoMediaId',
      '17': true
    },
  ],
  '8': [
    {'1': '_title'},
    {'1': '_about'},
    {'1': '_photo_media_id'},
  ],
};

/// Descriptor for `UpdateChatInfoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChatInfoRequestDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVDaGF0SW5mb1JlcXVlc3QSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhkKBXRpdG'
    'xlGAIgASgJSABSBXRpdGxliAEBEhkKBWFib3V0GAMgASgJSAFSBWFib3V0iAEBEikKDnBob3Rv'
    'X21lZGlhX2lkGAQgASgDSAJSDHBob3RvTWVkaWFJZIgBAUIICgZfdGl0bGVCCAoGX2Fib3V0Qh'
    'EKD19waG90b19tZWRpYV9pZA==');

@$core.Deprecated('Use updateChatInfoResponseDescriptor instead')
const UpdateChatInfoResponse$json = {
  '1': 'UpdateChatInfoResponse',
  '2': [
    {'1': 'chat', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.Chat', '10': 'chat'},
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `UpdateChatInfoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateChatInfoResponseDescriptor = $convert.base64Decode(
    'ChZVcGRhdGVDaGF0SW5mb1Jlc3BvbnNlEiIKBGNoYXQYASABKAsyDi53YXNsYS52MS5DaGF0Ug'
    'RjaGF0EhAKA3B0cxgCIAEoA1IDcHRzEhsKCXB0c19jb3VudBgDIAEoBVIIcHRzQ291bnQ=');

@$core.Deprecated('Use setDefaultPermissionsRequestDescriptor instead')
const SetDefaultPermissionsRequest$json = {
  '1': 'SetDefaultPermissionsRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'permissions', '3': 2, '4': 1, '5': 4, '10': 'permissions'},
  ],
};

/// Descriptor for `SetDefaultPermissionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultPermissionsRequestDescriptor =
    $convert.base64Decode(
        'ChxTZXREZWZhdWx0UGVybWlzc2lvbnNSZXF1ZXN0EhcKB2NoYXRfaWQYASABKANSBmNoYXRJZB'
        'IgCgtwZXJtaXNzaW9ucxgCIAEoBFILcGVybWlzc2lvbnM=');

@$core.Deprecated('Use setDefaultPermissionsResponseDescriptor instead')
const SetDefaultPermissionsResponse$json = {
  '1': 'SetDefaultPermissionsResponse',
  '2': [
    {'1': 'chat', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.Chat', '10': 'chat'},
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `SetDefaultPermissionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setDefaultPermissionsResponseDescriptor =
    $convert.base64Decode(
        'Ch1TZXREZWZhdWx0UGVybWlzc2lvbnNSZXNwb25zZRIiCgRjaGF0GAEgASgLMg4ud2FzbGEudj'
        'EuQ2hhdFIEY2hhdBIQCgNwdHMYAiABKANSA3B0cxIbCglwdHNfY291bnQYAyABKAVSCHB0c0Nv'
        'dW50');

@$core.Deprecated('Use listMembersRequestDescriptor instead')
const ListMembersRequest$json = {
  '1': 'ListMembersRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'limit', '3': 3, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListMembersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMembersRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0TWVtYmVyc1JlcXVlc3QSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhYKBm9mZnNldB'
    'gCIAEoBVIGb2Zmc2V0EhQKBWxpbWl0GAMgASgFUgVsaW1pdA==');

@$core.Deprecated('Use listMembersResponseDescriptor instead')
const ListMembersResponse$json = {
  '1': 'ListMembersResponse',
  '2': [
    {
      '1': 'members',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.ChatMember',
      '10': 'members'
    },
    {
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
    {'1': 'total', '3': 3, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListMembersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listMembersResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0TWVtYmVyc1Jlc3BvbnNlEi4KB21lbWJlcnMYASADKAsyFC53YXNsYS52MS5DaGF0TW'
    'VtYmVyUgdtZW1iZXJzEiQKBXVzZXJzGAIgAygLMg4ud2FzbGEudjEuVXNlclIFdXNlcnMSFAoF'
    'dG90YWwYAyABKAVSBXRvdGFs');

@$core.Deprecated('Use addMembersRequestDescriptor instead')
const AddMembersRequest$json = {
  '1': 'AddMembersRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'user_ids', '3': 2, '4': 3, '5': 3, '10': 'userIds'},
  ],
};

/// Descriptor for `AddMembersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMembersRequestDescriptor = $convert.base64Decode(
    'ChFBZGRNZW1iZXJzUmVxdWVzdBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSGQoIdXNlcl9pZH'
    'MYAiADKANSB3VzZXJJZHM=');

@$core.Deprecated('Use addMembersResponseDescriptor instead')
const AddMembersResponse$json = {
  '1': 'AddMembersResponse',
  '2': [
    {
      '1': 'privacy_restricted_user_ids',
      '3': 1,
      '4': 3,
      '5': 3,
      '10': 'privacyRestrictedUserIds'
    },
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `AddMembersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List addMembersResponseDescriptor = $convert.base64Decode(
    'ChJBZGRNZW1iZXJzUmVzcG9uc2USPQobcHJpdmFjeV9yZXN0cmljdGVkX3VzZXJfaWRzGAEgAy'
    'gDUhhwcml2YWN5UmVzdHJpY3RlZFVzZXJJZHMSEAoDcHRzGAIgASgDUgNwdHMSGwoJcHRzX2Nv'
    'dW50GAMgASgFUghwdHNDb3VudA==');

@$core.Deprecated('Use removeMemberRequestDescriptor instead')
const RemoveMemberRequest$json = {
  '1': 'RemoveMemberRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `RemoveMemberRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberRequestDescriptor = $convert.base64Decode(
    'ChNSZW1vdmVNZW1iZXJSZXF1ZXN0EhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBIXCgd1c2VyX2'
    'lkGAIgASgDUgZ1c2VySWQ=');

@$core.Deprecated('Use removeMemberResponseDescriptor instead')
const RemoveMemberResponse$json = {
  '1': 'RemoveMemberResponse',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 2, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `RemoveMemberResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List removeMemberResponseDescriptor = $convert.base64Decode(
    'ChRSZW1vdmVNZW1iZXJSZXNwb25zZRIQCgNwdHMYASABKANSA3B0cxIbCglwdHNfY291bnQYAi'
    'ABKAVSCHB0c0NvdW50');

@$core.Deprecated('Use setMemberRoleRequestDescriptor instead')
const SetMemberRoleRequest$json = {
  '1': 'SetMemberRoleRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 3, '10': 'userId'},
    {
      '1': 'role',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.ChatMemberRole',
      '10': 'role'
    },
    {'1': 'admin_rights', '3': 4, '4': 1, '5': 4, '10': 'adminRights'},
  ],
};

/// Descriptor for `SetMemberRoleRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setMemberRoleRequestDescriptor = $convert.base64Decode(
    'ChRTZXRNZW1iZXJSb2xlUmVxdWVzdBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSFwoHdXNlcl'
    '9pZBgCIAEoA1IGdXNlcklkEiwKBHJvbGUYAyABKA4yGC53YXNsYS52MS5DaGF0TWVtYmVyUm9s'
    'ZVIEcm9sZRIhCgxhZG1pbl9yaWdodHMYBCABKARSC2FkbWluUmlnaHRz');

@$core.Deprecated('Use setMemberRoleResponseDescriptor instead')
const SetMemberRoleResponse$json = {
  '1': 'SetMemberRoleResponse',
  '2': [
    {
      '1': 'member',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ChatMember',
      '10': 'member'
    },
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `SetMemberRoleResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setMemberRoleResponseDescriptor = $convert.base64Decode(
    'ChVTZXRNZW1iZXJSb2xlUmVzcG9uc2USLAoGbWVtYmVyGAEgASgLMhQud2FzbGEudjEuQ2hhdE'
    '1lbWJlclIGbWVtYmVyEhAKA3B0cxgCIAEoA1IDcHRzEhsKCXB0c19jb3VudBgDIAEoBVIIcHRz'
    'Q291bnQ=');

@$core.Deprecated('Use leaveChatRequestDescriptor instead')
const LeaveChatRequest$json = {
  '1': 'LeaveChatRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
  ],
};

/// Descriptor for `LeaveChatRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveChatRequestDescriptor = $convert.base64Decode(
    'ChBMZWF2ZUNoYXRSZXF1ZXN0EhcKB2NoYXRfaWQYASABKANSBmNoYXRJZA==');

@$core.Deprecated('Use leaveChatResponseDescriptor instead')
const LeaveChatResponse$json = {
  '1': 'LeaveChatResponse',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 2, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `LeaveChatResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List leaveChatResponseDescriptor = $convert.base64Decode(
    'ChFMZWF2ZUNoYXRSZXNwb25zZRIQCgNwdHMYASABKANSA3B0cxIbCglwdHNfY291bnQYAiABKA'
    'VSCHB0c0NvdW50');

@$core.Deprecated('Use createInviteLinkRequestDescriptor instead')
const CreateInviteLinkRequest$json = {
  '1': 'CreateInviteLinkRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'expires_at', '3': 3, '4': 1, '5': 3, '10': 'expiresAt'},
    {'1': 'usage_limit', '3': 4, '4': 1, '5': 5, '10': 'usageLimit'},
  ],
};

/// Descriptor for `CreateInviteLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInviteLinkRequestDescriptor = $convert.base64Decode(
    'ChdDcmVhdGVJbnZpdGVMaW5rUmVxdWVzdBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSFAoFdG'
    'l0bGUYAiABKAlSBXRpdGxlEh0KCmV4cGlyZXNfYXQYAyABKANSCWV4cGlyZXNBdBIfCgt1c2Fn'
    'ZV9saW1pdBgEIAEoBVIKdXNhZ2VMaW1pdA==');

@$core.Deprecated('Use createInviteLinkResponseDescriptor instead')
const CreateInviteLinkResponse$json = {
  '1': 'CreateInviteLinkResponse',
  '2': [
    {
      '1': 'invite',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ChatInvite',
      '10': 'invite'
    },
  ],
};

/// Descriptor for `CreateInviteLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createInviteLinkResponseDescriptor =
    $convert.base64Decode(
        'ChhDcmVhdGVJbnZpdGVMaW5rUmVzcG9uc2USLAoGaW52aXRlGAEgASgLMhQud2FzbGEudjEuQ2'
        'hhdEludml0ZVIGaW52aXRl');

@$core.Deprecated('Use revokeInviteLinkRequestDescriptor instead')
const RevokeInviteLinkRequest$json = {
  '1': 'RevokeInviteLinkRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'code', '3': 2, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `RevokeInviteLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revokeInviteLinkRequestDescriptor =
    $convert.base64Decode(
        'ChdSZXZva2VJbnZpdGVMaW5rUmVxdWVzdBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSEgoEY2'
        '9kZRgCIAEoCVIEY29kZQ==');

@$core.Deprecated('Use revokeInviteLinkResponseDescriptor instead')
const RevokeInviteLinkResponse$json = {
  '1': 'RevokeInviteLinkResponse',
};

/// Descriptor for `RevokeInviteLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revokeInviteLinkResponseDescriptor =
    $convert.base64Decode('ChhSZXZva2VJbnZpdGVMaW5rUmVzcG9uc2U=');

@$core.Deprecated('Use checkInviteLinkRequestDescriptor instead')
const CheckInviteLinkRequest$json = {
  '1': 'CheckInviteLinkRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `CheckInviteLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkInviteLinkRequestDescriptor =
    $convert.base64Decode(
        'ChZDaGVja0ludml0ZUxpbmtSZXF1ZXN0EhIKBGNvZGUYASABKAlSBGNvZGU=');

@$core.Deprecated('Use checkInviteLinkResponseDescriptor instead')
const CheckInviteLinkResponse$json = {
  '1': 'CheckInviteLinkResponse',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {
      '1': 'photo',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Avatar',
      '10': 'photo'
    },
    {'1': 'member_count', '3': 3, '4': 1, '5': 5, '10': 'memberCount'},
    {'1': 'chat', '3': 4, '4': 1, '5': 11, '6': '.wasla.v1.Chat', '10': 'chat'},
  ],
};

/// Descriptor for `CheckInviteLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkInviteLinkResponseDescriptor = $convert.base64Decode(
    'ChdDaGVja0ludml0ZUxpbmtSZXNwb25zZRIUCgV0aXRsZRgBIAEoCVIFdGl0bGUSJgoFcGhvdG'
    '8YAiABKAsyEC53YXNsYS52MS5BdmF0YXJSBXBob3RvEiEKDG1lbWJlcl9jb3VudBgDIAEoBVIL'
    'bWVtYmVyQ291bnQSIgoEY2hhdBgEIAEoCzIOLndhc2xhLnYxLkNoYXRSBGNoYXQ=');

@$core.Deprecated('Use joinByInviteLinkRequestDescriptor instead')
const JoinByInviteLinkRequest$json = {
  '1': 'JoinByInviteLinkRequest',
  '2': [
    {'1': 'code', '3': 1, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `JoinByInviteLinkRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinByInviteLinkRequestDescriptor =
    $convert.base64Decode(
        'ChdKb2luQnlJbnZpdGVMaW5rUmVxdWVzdBISCgRjb2RlGAEgASgJUgRjb2Rl');

@$core.Deprecated('Use joinByInviteLinkResponseDescriptor instead')
const JoinByInviteLinkResponse$json = {
  '1': 'JoinByInviteLinkResponse',
  '2': [
    {'1': 'chat', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.Chat', '10': 'chat'},
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `JoinByInviteLinkResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List joinByInviteLinkResponseDescriptor = $convert.base64Decode(
    'ChhKb2luQnlJbnZpdGVMaW5rUmVzcG9uc2USIgoEY2hhdBgBIAEoCzIOLndhc2xhLnYxLkNoYX'
    'RSBGNoYXQSEAoDcHRzGAIgASgDUgNwdHMSGwoJcHRzX2NvdW50GAMgASgFUghwdHNDb3VudA==');

const $core.Map<$core.String, $core.dynamic> ChatsServiceBase$json = {
  '1': 'ChatsService',
  '2': [
    {
      '1': 'ListDialogs',
      '2': '.wasla.v1.ListDialogsRequest',
      '3': '.wasla.v1.ListDialogsResponse'
    },
    {
      '1': 'UpdateDialog',
      '2': '.wasla.v1.UpdateDialogRequest',
      '3': '.wasla.v1.UpdateDialogResponse'
    },
    {
      '1': 'ReorderPinnedDialogs',
      '2': '.wasla.v1.ReorderPinnedDialogsRequest',
      '3': '.wasla.v1.ReorderPinnedDialogsResponse'
    },
    {
      '1': 'ClearHistory',
      '2': '.wasla.v1.ClearHistoryRequest',
      '3': '.wasla.v1.ClearHistoryResponse'
    },
    {
      '1': 'GetChats',
      '2': '.wasla.v1.GetChatsRequest',
      '3': '.wasla.v1.GetChatsResponse'
    },
    {
      '1': 'GetPrivateChat',
      '2': '.wasla.v1.GetPrivateChatRequest',
      '3': '.wasla.v1.GetPrivateChatResponse'
    },
    {
      '1': 'CreateGroup',
      '2': '.wasla.v1.CreateGroupRequest',
      '3': '.wasla.v1.CreateGroupResponse'
    },
    {
      '1': 'UpdateChatInfo',
      '2': '.wasla.v1.UpdateChatInfoRequest',
      '3': '.wasla.v1.UpdateChatInfoResponse'
    },
    {
      '1': 'SetDefaultPermissions',
      '2': '.wasla.v1.SetDefaultPermissionsRequest',
      '3': '.wasla.v1.SetDefaultPermissionsResponse'
    },
    {
      '1': 'ListMembers',
      '2': '.wasla.v1.ListMembersRequest',
      '3': '.wasla.v1.ListMembersResponse'
    },
    {
      '1': 'AddMembers',
      '2': '.wasla.v1.AddMembersRequest',
      '3': '.wasla.v1.AddMembersResponse'
    },
    {
      '1': 'RemoveMember',
      '2': '.wasla.v1.RemoveMemberRequest',
      '3': '.wasla.v1.RemoveMemberResponse'
    },
    {
      '1': 'SetMemberRole',
      '2': '.wasla.v1.SetMemberRoleRequest',
      '3': '.wasla.v1.SetMemberRoleResponse'
    },
    {
      '1': 'LeaveChat',
      '2': '.wasla.v1.LeaveChatRequest',
      '3': '.wasla.v1.LeaveChatResponse'
    },
    {
      '1': 'CreateInviteLink',
      '2': '.wasla.v1.CreateInviteLinkRequest',
      '3': '.wasla.v1.CreateInviteLinkResponse'
    },
    {
      '1': 'RevokeInviteLink',
      '2': '.wasla.v1.RevokeInviteLinkRequest',
      '3': '.wasla.v1.RevokeInviteLinkResponse'
    },
    {
      '1': 'CheckInviteLink',
      '2': '.wasla.v1.CheckInviteLinkRequest',
      '3': '.wasla.v1.CheckInviteLinkResponse'
    },
    {
      '1': 'JoinByInviteLink',
      '2': '.wasla.v1.JoinByInviteLinkRequest',
      '3': '.wasla.v1.JoinByInviteLinkResponse'
    },
  ],
};

@$core.Deprecated('Use chatsServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ChatsServiceBase$messageJson = {
  '.wasla.v1.ListDialogsRequest': ListDialogsRequest$json,
  '.wasla.v1.ListDialogsResponse': ListDialogsResponse$json,
  '.wasla.v1.Dialog': Dialog$json,
  '.wasla.v1.Message': $1.Message$json,
  '.wasla.v1.MessageContent': $1.MessageContent$json,
  '.wasla.v1.TextContent': $1.TextContent$json,
  '.wasla.v1.FormattedText': $1.FormattedText$json,
  '.wasla.v1.TextEntity': $1.TextEntity$json,
  '.wasla.v1.PhotoContent': $1.PhotoContent$json,
  '.wasla.v1.Media': $3.Media$json,
  '.wasla.v1.MediaVariant': $3.MediaVariant$json,
  '.wasla.v1.VideoContent': $1.VideoContent$json,
  '.wasla.v1.DocumentContent': $1.DocumentContent$json,
  '.wasla.v1.VoiceContent': $1.VoiceContent$json,
  '.wasla.v1.LocationContent': $1.LocationContent$json,
  '.wasla.v1.ContactContent': $1.ContactContent$json,
  '.wasla.v1.ServiceContent': $1.ServiceContent$json,
  '.wasla.v1.ChatCreated': $1.ChatCreated$json,
  '.wasla.v1.MembersAdded': $1.MembersAdded$json,
  '.wasla.v1.MemberRemoved': $1.MemberRemoved$json,
  '.wasla.v1.MemberLeft': $1.MemberLeft$json,
  '.wasla.v1.MemberJoinedByLink': $1.MemberJoinedByLink$json,
  '.wasla.v1.ChatTitleChanged': $1.ChatTitleChanged$json,
  '.wasla.v1.ChatPhotoChanged': $1.ChatPhotoChanged$json,
  '.wasla.v1.MessagePinned': $1.MessagePinned$json,
  '.wasla.v1.ForwardInfo': $1.ForwardInfo$json,
  '.wasla.v1.Chat': Chat$json,
  '.wasla.v1.Avatar': $0.Avatar$json,
  '.wasla.v1.User': $2.User$json,
  '.wasla.v1.UserStatus': $2.UserStatus$json,
  '.wasla.v1.Online': $2.Online$json,
  '.wasla.v1.UpdateDialogRequest': UpdateDialogRequest$json,
  '.wasla.v1.UpdateDialogResponse': UpdateDialogResponse$json,
  '.wasla.v1.ReorderPinnedDialogsRequest': ReorderPinnedDialogsRequest$json,
  '.wasla.v1.ReorderPinnedDialogsResponse': ReorderPinnedDialogsResponse$json,
  '.wasla.v1.ClearHistoryRequest': ClearHistoryRequest$json,
  '.wasla.v1.ClearHistoryResponse': ClearHistoryResponse$json,
  '.wasla.v1.GetChatsRequest': GetChatsRequest$json,
  '.wasla.v1.GetChatsResponse': GetChatsResponse$json,
  '.wasla.v1.GetPrivateChatRequest': GetPrivateChatRequest$json,
  '.wasla.v1.GetPrivateChatResponse': GetPrivateChatResponse$json,
  '.wasla.v1.CreateGroupRequest': CreateGroupRequest$json,
  '.wasla.v1.CreateGroupResponse': CreateGroupResponse$json,
  '.wasla.v1.UpdateChatInfoRequest': UpdateChatInfoRequest$json,
  '.wasla.v1.UpdateChatInfoResponse': UpdateChatInfoResponse$json,
  '.wasla.v1.SetDefaultPermissionsRequest': SetDefaultPermissionsRequest$json,
  '.wasla.v1.SetDefaultPermissionsResponse': SetDefaultPermissionsResponse$json,
  '.wasla.v1.ListMembersRequest': ListMembersRequest$json,
  '.wasla.v1.ListMembersResponse': ListMembersResponse$json,
  '.wasla.v1.ChatMember': ChatMember$json,
  '.wasla.v1.AddMembersRequest': AddMembersRequest$json,
  '.wasla.v1.AddMembersResponse': AddMembersResponse$json,
  '.wasla.v1.RemoveMemberRequest': RemoveMemberRequest$json,
  '.wasla.v1.RemoveMemberResponse': RemoveMemberResponse$json,
  '.wasla.v1.SetMemberRoleRequest': SetMemberRoleRequest$json,
  '.wasla.v1.SetMemberRoleResponse': SetMemberRoleResponse$json,
  '.wasla.v1.LeaveChatRequest': LeaveChatRequest$json,
  '.wasla.v1.LeaveChatResponse': LeaveChatResponse$json,
  '.wasla.v1.CreateInviteLinkRequest': CreateInviteLinkRequest$json,
  '.wasla.v1.CreateInviteLinkResponse': CreateInviteLinkResponse$json,
  '.wasla.v1.ChatInvite': ChatInvite$json,
  '.wasla.v1.RevokeInviteLinkRequest': RevokeInviteLinkRequest$json,
  '.wasla.v1.RevokeInviteLinkResponse': RevokeInviteLinkResponse$json,
  '.wasla.v1.CheckInviteLinkRequest': CheckInviteLinkRequest$json,
  '.wasla.v1.CheckInviteLinkResponse': CheckInviteLinkResponse$json,
  '.wasla.v1.JoinByInviteLinkRequest': JoinByInviteLinkRequest$json,
  '.wasla.v1.JoinByInviteLinkResponse': JoinByInviteLinkResponse$json,
};

/// Descriptor for `ChatsService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List chatsServiceDescriptor = $convert.base64Decode(
    'CgxDaGF0c1NlcnZpY2USSgoLTGlzdERpYWxvZ3MSHC53YXNsYS52MS5MaXN0RGlhbG9nc1JlcX'
    'Vlc3QaHS53YXNsYS52MS5MaXN0RGlhbG9nc1Jlc3BvbnNlEk0KDFVwZGF0ZURpYWxvZxIdLndh'
    'c2xhLnYxLlVwZGF0ZURpYWxvZ1JlcXVlc3QaHi53YXNsYS52MS5VcGRhdGVEaWFsb2dSZXNwb2'
    '5zZRJlChRSZW9yZGVyUGlubmVkRGlhbG9ncxIlLndhc2xhLnYxLlJlb3JkZXJQaW5uZWREaWFs'
    'b2dzUmVxdWVzdBomLndhc2xhLnYxLlJlb3JkZXJQaW5uZWREaWFsb2dzUmVzcG9uc2USTQoMQ2'
    'xlYXJIaXN0b3J5Eh0ud2FzbGEudjEuQ2xlYXJIaXN0b3J5UmVxdWVzdBoeLndhc2xhLnYxLkNs'
    'ZWFySGlzdG9yeVJlc3BvbnNlEkEKCEdldENoYXRzEhkud2FzbGEudjEuR2V0Q2hhdHNSZXF1ZX'
    'N0Ghoud2FzbGEudjEuR2V0Q2hhdHNSZXNwb25zZRJTCg5HZXRQcml2YXRlQ2hhdBIfLndhc2xh'
    'LnYxLkdldFByaXZhdGVDaGF0UmVxdWVzdBogLndhc2xhLnYxLkdldFByaXZhdGVDaGF0UmVzcG'
    '9uc2USSgoLQ3JlYXRlR3JvdXASHC53YXNsYS52MS5DcmVhdGVHcm91cFJlcXVlc3QaHS53YXNs'
    'YS52MS5DcmVhdGVHcm91cFJlc3BvbnNlElMKDlVwZGF0ZUNoYXRJbmZvEh8ud2FzbGEudjEuVX'
    'BkYXRlQ2hhdEluZm9SZXF1ZXN0GiAud2FzbGEudjEuVXBkYXRlQ2hhdEluZm9SZXNwb25zZRJo'
    'ChVTZXREZWZhdWx0UGVybWlzc2lvbnMSJi53YXNsYS52MS5TZXREZWZhdWx0UGVybWlzc2lvbn'
    'NSZXF1ZXN0Gicud2FzbGEudjEuU2V0RGVmYXVsdFBlcm1pc3Npb25zUmVzcG9uc2USSgoLTGlz'
    'dE1lbWJlcnMSHC53YXNsYS52MS5MaXN0TWVtYmVyc1JlcXVlc3QaHS53YXNsYS52MS5MaXN0TW'
    'VtYmVyc1Jlc3BvbnNlEkcKCkFkZE1lbWJlcnMSGy53YXNsYS52MS5BZGRNZW1iZXJzUmVxdWVz'
    'dBocLndhc2xhLnYxLkFkZE1lbWJlcnNSZXNwb25zZRJNCgxSZW1vdmVNZW1iZXISHS53YXNsYS'
    '52MS5SZW1vdmVNZW1iZXJSZXF1ZXN0Gh4ud2FzbGEudjEuUmVtb3ZlTWVtYmVyUmVzcG9uc2US'
    'UAoNU2V0TWVtYmVyUm9sZRIeLndhc2xhLnYxLlNldE1lbWJlclJvbGVSZXF1ZXN0Gh8ud2FzbG'
    'EudjEuU2V0TWVtYmVyUm9sZVJlc3BvbnNlEkQKCUxlYXZlQ2hhdBIaLndhc2xhLnYxLkxlYXZl'
    'Q2hhdFJlcXVlc3QaGy53YXNsYS52MS5MZWF2ZUNoYXRSZXNwb25zZRJZChBDcmVhdGVJbnZpdG'
    'VMaW5rEiEud2FzbGEudjEuQ3JlYXRlSW52aXRlTGlua1JlcXVlc3QaIi53YXNsYS52MS5DcmVh'
    'dGVJbnZpdGVMaW5rUmVzcG9uc2USWQoQUmV2b2tlSW52aXRlTGluaxIhLndhc2xhLnYxLlJldm'
    '9rZUludml0ZUxpbmtSZXF1ZXN0GiIud2FzbGEudjEuUmV2b2tlSW52aXRlTGlua1Jlc3BvbnNl'
    'ElYKD0NoZWNrSW52aXRlTGluaxIgLndhc2xhLnYxLkNoZWNrSW52aXRlTGlua1JlcXVlc3QaIS'
    '53YXNsYS52MS5DaGVja0ludml0ZUxpbmtSZXNwb25zZRJZChBKb2luQnlJbnZpdGVMaW5rEiEu'
    'd2FzbGEudjEuSm9pbkJ5SW52aXRlTGlua1JlcXVlc3QaIi53YXNsYS52MS5Kb2luQnlJbnZpdG'
    'VMaW5rUmVzcG9uc2U=');
