// This is a generated file - do not edit.
//
// Generated from wasla/v1/updates.proto.

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

import 'chats.pbjson.dart' as $1;
import 'common.pbjson.dart' as $4;
import 'media.pbjson.dart' as $3;
import 'messages.pbjson.dart' as $2;
import 'users.pbjson.dart' as $0;

@$core.Deprecated('Use updatesPushDescriptor instead')
const UpdatesPush$json = {
  '1': 'UpdatesPush',
  '2': [
    {
      '1': 'updates',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Update',
      '10': 'updates'
    },
    {
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
    {
      '1': 'chats',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Chat',
      '10': 'chats'
    },
  ],
};

/// Descriptor for `UpdatesPush`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updatesPushDescriptor = $convert.base64Decode(
    'CgtVcGRhdGVzUHVzaBIqCgd1cGRhdGVzGAEgAygLMhAud2FzbGEudjEuVXBkYXRlUgd1cGRhdG'
    'VzEiQKBXVzZXJzGAIgAygLMg4ud2FzbGEudjEuVXNlclIFdXNlcnMSJAoFY2hhdHMYAyADKAsy'
    'Di53YXNsYS52MS5DaGF0UgVjaGF0cw==');

@$core.Deprecated('Use updateDescriptor instead')
const Update$json = {
  '1': 'Update',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 2, '4': 1, '5': 5, '10': 'ptsCount'},
    {'1': 'date', '3': 3, '4': 1, '5': 3, '10': 'date'},
    {
      '1': 'new_message',
      '3': 10,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.NewMessage',
      '9': 0,
      '10': 'newMessage'
    },
    {
      '1': 'message_edited',
      '3': 11,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MessageEdited',
      '9': 0,
      '10': 'messageEdited'
    },
    {
      '1': 'messages_deleted',
      '3': 12,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MessagesDeleted',
      '9': 0,
      '10': 'messagesDeleted'
    },
    {
      '1': 'read_inbox',
      '3': 13,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ReadInbox',
      '9': 0,
      '10': 'readInbox'
    },
    {
      '1': 'read_outbox',
      '3': 14,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ReadOutbox',
      '9': 0,
      '10': 'readOutbox'
    },
    {
      '1': 'chat_updated',
      '3': 15,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ChatUpdated',
      '9': 0,
      '10': 'chatUpdated'
    },
    {
      '1': 'chat_left',
      '3': 16,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ChatLeft',
      '9': 0,
      '10': 'chatLeft'
    },
    {
      '1': 'dialog_updated',
      '3': 17,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.DialogUpdated',
      '9': 0,
      '10': 'dialogUpdated'
    },
    {
      '1': 'pinned_dialogs_reordered',
      '3': 18,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.PinnedDialogsReordered',
      '9': 0,
      '10': 'pinnedDialogsReordered'
    },
    {
      '1': 'message_pinned',
      '3': 19,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MessagePinnedUpdate',
      '9': 0,
      '10': 'messagePinned'
    },
    {
      '1': 'history_cleared',
      '3': 20,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.HistoryCleared',
      '9': 0,
      '10': 'historyCleared'
    },
    {
      '1': 'contact_joined',
      '3': 21,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ContactJoined',
      '9': 0,
      '10': 'contactJoined'
    },
    {
      '1': 'user_updated',
      '3': 22,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.UserUpdated',
      '9': 0,
      '10': 'userUpdated'
    },
    {
      '1': 'typing',
      '3': 40,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Typing',
      '9': 0,
      '10': 'typing'
    },
    {
      '1': 'user_status',
      '3': 41,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.UserStatusChanged',
      '9': 0,
      '10': 'userStatus'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `Update`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDescriptor = $convert.base64Decode(
    'CgZVcGRhdGUSEAoDcHRzGAEgASgDUgNwdHMSGwoJcHRzX2NvdW50GAIgASgFUghwdHNDb3VudB'
    'ISCgRkYXRlGAMgASgDUgRkYXRlEjcKC25ld19tZXNzYWdlGAogASgLMhQud2FzbGEudjEuTmV3'
    'TWVzc2FnZUgAUgpuZXdNZXNzYWdlEkAKDm1lc3NhZ2VfZWRpdGVkGAsgASgLMhcud2FzbGEudj'
    'EuTWVzc2FnZUVkaXRlZEgAUg1tZXNzYWdlRWRpdGVkEkYKEG1lc3NhZ2VzX2RlbGV0ZWQYDCAB'
    'KAsyGS53YXNsYS52MS5NZXNzYWdlc0RlbGV0ZWRIAFIPbWVzc2FnZXNEZWxldGVkEjQKCnJlYW'
    'RfaW5ib3gYDSABKAsyEy53YXNsYS52MS5SZWFkSW5ib3hIAFIJcmVhZEluYm94EjcKC3JlYWRf'
    'b3V0Ym94GA4gASgLMhQud2FzbGEudjEuUmVhZE91dGJveEgAUgpyZWFkT3V0Ym94EjoKDGNoYX'
    'RfdXBkYXRlZBgPIAEoCzIVLndhc2xhLnYxLkNoYXRVcGRhdGVkSABSC2NoYXRVcGRhdGVkEjEK'
    'CWNoYXRfbGVmdBgQIAEoCzISLndhc2xhLnYxLkNoYXRMZWZ0SABSCGNoYXRMZWZ0EkAKDmRpYW'
    'xvZ191cGRhdGVkGBEgASgLMhcud2FzbGEudjEuRGlhbG9nVXBkYXRlZEgAUg1kaWFsb2dVcGRh'
    'dGVkElwKGHBpbm5lZF9kaWFsb2dzX3Jlb3JkZXJlZBgSIAEoCzIgLndhc2xhLnYxLlBpbm5lZE'
    'RpYWxvZ3NSZW9yZGVyZWRIAFIWcGlubmVkRGlhbG9nc1Jlb3JkZXJlZBJGCg5tZXNzYWdlX3Bp'
    'bm5lZBgTIAEoCzIdLndhc2xhLnYxLk1lc3NhZ2VQaW5uZWRVcGRhdGVIAFINbWVzc2FnZVBpbm'
    '5lZBJDCg9oaXN0b3J5X2NsZWFyZWQYFCABKAsyGC53YXNsYS52MS5IaXN0b3J5Q2xlYXJlZEgA'
    'Ug5oaXN0b3J5Q2xlYXJlZBJACg5jb250YWN0X2pvaW5lZBgVIAEoCzIXLndhc2xhLnYxLkNvbn'
    'RhY3RKb2luZWRIAFINY29udGFjdEpvaW5lZBI6Cgx1c2VyX3VwZGF0ZWQYFiABKAsyFS53YXNs'
    'YS52MS5Vc2VyVXBkYXRlZEgAUgt1c2VyVXBkYXRlZBIqCgZ0eXBpbmcYKCABKAsyEC53YXNsYS'
    '52MS5UeXBpbmdIAFIGdHlwaW5nEj4KC3VzZXJfc3RhdHVzGCkgASgLMhsud2FzbGEudjEuVXNl'
    'clN0YXR1c0NoYW5nZWRIAFIKdXNlclN0YXR1c0IGCgRraW5k');

@$core.Deprecated('Use newMessageDescriptor instead')
const NewMessage$json = {
  '1': 'NewMessage',
  '2': [
    {
      '1': 'message',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Message',
      '10': 'message'
    },
  ],
};

/// Descriptor for `NewMessage`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List newMessageDescriptor = $convert.base64Decode(
    'CgpOZXdNZXNzYWdlEisKB21lc3NhZ2UYASABKAsyES53YXNsYS52MS5NZXNzYWdlUgdtZXNzYW'
    'dl');

@$core.Deprecated('Use messageEditedDescriptor instead')
const MessageEdited$json = {
  '1': 'MessageEdited',
  '2': [
    {
      '1': 'message',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Message',
      '10': 'message'
    },
  ],
};

/// Descriptor for `MessageEdited`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageEditedDescriptor = $convert.base64Decode(
    'Cg1NZXNzYWdlRWRpdGVkEisKB21lc3NhZ2UYASABKAsyES53YXNsYS52MS5NZXNzYWdlUgdtZX'
    'NzYWdl');

@$core.Deprecated('Use messagesDeletedDescriptor instead')
const MessagesDeleted$json = {
  '1': 'MessagesDeleted',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seqs', '3': 2, '4': 3, '5': 3, '10': 'seqs'},
  ],
};

/// Descriptor for `MessagesDeleted`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messagesDeletedDescriptor = $convert.base64Decode(
    'Cg9NZXNzYWdlc0RlbGV0ZWQSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhIKBHNlcXMYAiADKA'
    'NSBHNlcXM=');

@$core.Deprecated('Use readInboxDescriptor instead')
const ReadInbox$json = {
  '1': 'ReadInbox',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'max_seq', '3': 2, '4': 1, '5': 3, '10': 'maxSeq'},
    {
      '1': 'still_unread_count',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'stillUnreadCount'
    },
  ],
};

/// Descriptor for `ReadInbox`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readInboxDescriptor = $convert.base64Decode(
    'CglSZWFkSW5ib3gSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhcKB21heF9zZXEYAiABKANSBm'
    '1heFNlcRIsChJzdGlsbF91bnJlYWRfY291bnQYAyABKAVSEHN0aWxsVW5yZWFkQ291bnQ=');

@$core.Deprecated('Use readOutboxDescriptor instead')
const ReadOutbox$json = {
  '1': 'ReadOutbox',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'max_seq', '3': 2, '4': 1, '5': 3, '10': 'maxSeq'},
  ],
};

/// Descriptor for `ReadOutbox`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readOutboxDescriptor = $convert.base64Decode(
    'CgpSZWFkT3V0Ym94EhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBIXCgdtYXhfc2VxGAIgASgDUg'
    'ZtYXhTZXE=');

@$core.Deprecated('Use chatUpdatedDescriptor instead')
const ChatUpdated$json = {
  '1': 'ChatUpdated',
  '2': [
    {'1': 'chat', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.Chat', '10': 'chat'},
  ],
};

/// Descriptor for `ChatUpdated`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatUpdatedDescriptor = $convert.base64Decode(
    'CgtDaGF0VXBkYXRlZBIiCgRjaGF0GAEgASgLMg4ud2FzbGEudjEuQ2hhdFIEY2hhdA==');

@$core.Deprecated('Use chatLeftDescriptor instead')
const ChatLeft$json = {
  '1': 'ChatLeft',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'kicked', '3': 2, '4': 1, '5': 8, '10': 'kicked'},
  ],
};

/// Descriptor for `ChatLeft`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatLeftDescriptor = $convert.base64Decode(
    'CghDaGF0TGVmdBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSFgoGa2lja2VkGAIgASgIUgZraW'
    'NrZWQ=');

@$core.Deprecated('Use dialogUpdatedDescriptor instead')
const DialogUpdated$json = {
  '1': 'DialogUpdated',
  '2': [
    {
      '1': 'dialog',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Dialog',
      '10': 'dialog'
    },
  ],
};

/// Descriptor for `DialogUpdated`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dialogUpdatedDescriptor = $convert.base64Decode(
    'Cg1EaWFsb2dVcGRhdGVkEigKBmRpYWxvZxgBIAEoCzIQLndhc2xhLnYxLkRpYWxvZ1IGZGlhbG'
    '9n');

@$core.Deprecated('Use pinnedDialogsReorderedDescriptor instead')
const PinnedDialogsReordered$json = {
  '1': 'PinnedDialogsReordered',
  '2': [
    {'1': 'chat_ids', '3': 1, '4': 3, '5': 3, '10': 'chatIds'},
    {'1': 'archived', '3': 2, '4': 1, '5': 8, '10': 'archived'},
  ],
};

/// Descriptor for `PinnedDialogsReordered`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pinnedDialogsReorderedDescriptor =
    $convert.base64Decode(
        'ChZQaW5uZWREaWFsb2dzUmVvcmRlcmVkEhkKCGNoYXRfaWRzGAEgAygDUgdjaGF0SWRzEhoKCG'
        'FyY2hpdmVkGAIgASgIUghhcmNoaXZlZA==');

@$core.Deprecated('Use messagePinnedUpdateDescriptor instead')
const MessagePinnedUpdate$json = {
  '1': 'MessagePinnedUpdate',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seq', '3': 2, '4': 1, '5': 3, '10': 'seq'},
    {'1': 'pinned', '3': 3, '4': 1, '5': 8, '10': 'pinned'},
  ],
};

/// Descriptor for `MessagePinnedUpdate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messagePinnedUpdateDescriptor = $convert.base64Decode(
    'ChNNZXNzYWdlUGlubmVkVXBkYXRlEhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBIQCgNzZXEYAi'
    'ABKANSA3NlcRIWCgZwaW5uZWQYAyABKAhSBnBpbm5lZA==');

@$core.Deprecated('Use historyClearedDescriptor instead')
const HistoryCleared$json = {
  '1': 'HistoryCleared',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'max_seq', '3': 2, '4': 1, '5': 3, '10': 'maxSeq'},
  ],
};

/// Descriptor for `HistoryCleared`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List historyClearedDescriptor = $convert.base64Decode(
    'Cg5IaXN0b3J5Q2xlYXJlZBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSFwoHbWF4X3NlcRgCIA'
    'EoA1IGbWF4U2Vx');

@$core.Deprecated('Use contactJoinedDescriptor instead')
const ContactJoined$json = {
  '1': 'ContactJoined',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `ContactJoined`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactJoinedDescriptor = $convert
    .base64Decode('Cg1Db250YWN0Sm9pbmVkEhcKB3VzZXJfaWQYASABKANSBnVzZXJJZA==');

@$core.Deprecated('Use userUpdatedDescriptor instead')
const UserUpdated$json = {
  '1': 'UserUpdated',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `UserUpdated`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userUpdatedDescriptor = $convert.base64Decode(
    'CgtVc2VyVXBkYXRlZBIiCgR1c2VyGAEgASgLMg4ud2FzbGEudjEuVXNlclIEdXNlcg==');

@$core.Deprecated('Use typingDescriptor instead')
const Typing$json = {
  '1': 'Typing',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'user_id', '3': 2, '4': 1, '5': 3, '10': 'userId'},
    {
      '1': 'action',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.TypingAction',
      '10': 'action'
    },
  ],
};

/// Descriptor for `Typing`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List typingDescriptor = $convert.base64Decode(
    'CgZUeXBpbmcSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhcKB3VzZXJfaWQYAiABKANSBnVzZX'
    'JJZBIuCgZhY3Rpb24YAyABKA4yFi53YXNsYS52MS5UeXBpbmdBY3Rpb25SBmFjdGlvbg==');

@$core.Deprecated('Use userStatusChangedDescriptor instead')
const UserStatusChanged$json = {
  '1': 'UserStatusChanged',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
    {
      '1': 'status',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.UserStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `UserStatusChanged`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userStatusChangedDescriptor = $convert.base64Decode(
    'ChFVc2VyU3RhdHVzQ2hhbmdlZBIXCgd1c2VyX2lkGAEgASgDUgZ1c2VySWQSLAoGc3RhdHVzGA'
    'IgASgLMhQud2FzbGEudjEuVXNlclN0YXR1c1IGc3RhdHVz');

@$core.Deprecated('Use getStateRequestDescriptor instead')
const GetStateRequest$json = {
  '1': 'GetStateRequest',
};

/// Descriptor for `GetStateRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStateRequestDescriptor =
    $convert.base64Decode('Cg9HZXRTdGF0ZVJlcXVlc3Q=');

@$core.Deprecated('Use getStateResponseDescriptor instead')
const GetStateResponse$json = {
  '1': 'GetStateResponse',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'date', '3': 2, '4': 1, '5': 3, '10': 'date'},
  ],
};

/// Descriptor for `GetStateResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getStateResponseDescriptor = $convert.base64Decode(
    'ChBHZXRTdGF0ZVJlc3BvbnNlEhAKA3B0cxgBIAEoA1IDcHRzEhIKBGRhdGUYAiABKANSBGRhdG'
    'U=');

@$core.Deprecated('Use getDifferenceRequestDescriptor instead')
const GetDifferenceRequest$json = {
  '1': 'GetDifferenceRequest',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetDifferenceRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDifferenceRequestDescriptor = $convert.base64Decode(
    'ChRHZXREaWZmZXJlbmNlUmVxdWVzdBIQCgNwdHMYASABKANSA3B0cxIUCgVsaW1pdBgCIAEoBV'
    'IFbGltaXQ=');

@$core.Deprecated('Use getDifferenceResponseDescriptor instead')
const GetDifferenceResponse$json = {
  '1': 'GetDifferenceResponse',
  '2': [
    {
      '1': 'updates',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Update',
      '10': 'updates'
    },
    {
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
    {
      '1': 'chats',
      '3': 3,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Chat',
      '10': 'chats'
    },
    {'1': 'pts', '3': 4, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'has_more', '3': 5, '4': 1, '5': 8, '10': 'hasMore'},
    {'1': 'too_long', '3': 6, '4': 1, '5': 8, '10': 'tooLong'},
  ],
};

/// Descriptor for `GetDifferenceResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDifferenceResponseDescriptor = $convert.base64Decode(
    'ChVHZXREaWZmZXJlbmNlUmVzcG9uc2USKgoHdXBkYXRlcxgBIAMoCzIQLndhc2xhLnYxLlVwZG'
    'F0ZVIHdXBkYXRlcxIkCgV1c2VycxgCIAMoCzIOLndhc2xhLnYxLlVzZXJSBXVzZXJzEiQKBWNo'
    'YXRzGAMgAygLMg4ud2FzbGEudjEuQ2hhdFIFY2hhdHMSEAoDcHRzGAQgASgDUgNwdHMSGQoIaG'
    'FzX21vcmUYBSABKAhSB2hhc01vcmUSGQoIdG9vX2xvbmcYBiABKAhSB3Rvb0xvbmc=');

const $core.Map<$core.String, $core.dynamic> UpdatesServiceBase$json = {
  '1': 'UpdatesService',
  '2': [
    {
      '1': 'GetState',
      '2': '.wasla.v1.GetStateRequest',
      '3': '.wasla.v1.GetStateResponse'
    },
    {
      '1': 'GetDifference',
      '2': '.wasla.v1.GetDifferenceRequest',
      '3': '.wasla.v1.GetDifferenceResponse'
    },
  ],
};

@$core.Deprecated('Use updatesServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    UpdatesServiceBase$messageJson = {
  '.wasla.v1.GetStateRequest': GetStateRequest$json,
  '.wasla.v1.GetStateResponse': GetStateResponse$json,
  '.wasla.v1.GetDifferenceRequest': GetDifferenceRequest$json,
  '.wasla.v1.GetDifferenceResponse': GetDifferenceResponse$json,
  '.wasla.v1.Update': Update$json,
  '.wasla.v1.NewMessage': NewMessage$json,
  '.wasla.v1.Message': $2.Message$json,
  '.wasla.v1.MessageContent': $2.MessageContent$json,
  '.wasla.v1.TextContent': $2.TextContent$json,
  '.wasla.v1.FormattedText': $2.FormattedText$json,
  '.wasla.v1.TextEntity': $2.TextEntity$json,
  '.wasla.v1.PhotoContent': $2.PhotoContent$json,
  '.wasla.v1.Media': $3.Media$json,
  '.wasla.v1.MediaVariant': $3.MediaVariant$json,
  '.wasla.v1.VideoContent': $2.VideoContent$json,
  '.wasla.v1.DocumentContent': $2.DocumentContent$json,
  '.wasla.v1.VoiceContent': $2.VoiceContent$json,
  '.wasla.v1.LocationContent': $2.LocationContent$json,
  '.wasla.v1.ContactContent': $2.ContactContent$json,
  '.wasla.v1.ServiceContent': $2.ServiceContent$json,
  '.wasla.v1.ChatCreated': $2.ChatCreated$json,
  '.wasla.v1.MembersAdded': $2.MembersAdded$json,
  '.wasla.v1.MemberRemoved': $2.MemberRemoved$json,
  '.wasla.v1.MemberLeft': $2.MemberLeft$json,
  '.wasla.v1.MemberJoinedByLink': $2.MemberJoinedByLink$json,
  '.wasla.v1.ChatTitleChanged': $2.ChatTitleChanged$json,
  '.wasla.v1.ChatPhotoChanged': $2.ChatPhotoChanged$json,
  '.wasla.v1.MessagePinned': $2.MessagePinned$json,
  '.wasla.v1.ForwardInfo': $2.ForwardInfo$json,
  '.wasla.v1.MessageEdited': MessageEdited$json,
  '.wasla.v1.MessagesDeleted': MessagesDeleted$json,
  '.wasla.v1.ReadInbox': ReadInbox$json,
  '.wasla.v1.ReadOutbox': ReadOutbox$json,
  '.wasla.v1.ChatUpdated': ChatUpdated$json,
  '.wasla.v1.Chat': $1.Chat$json,
  '.wasla.v1.Avatar': $4.Avatar$json,
  '.wasla.v1.ChatLeft': ChatLeft$json,
  '.wasla.v1.DialogUpdated': DialogUpdated$json,
  '.wasla.v1.Dialog': $1.Dialog$json,
  '.wasla.v1.PinnedDialogsReordered': PinnedDialogsReordered$json,
  '.wasla.v1.MessagePinnedUpdate': MessagePinnedUpdate$json,
  '.wasla.v1.HistoryCleared': HistoryCleared$json,
  '.wasla.v1.ContactJoined': ContactJoined$json,
  '.wasla.v1.UserUpdated': UserUpdated$json,
  '.wasla.v1.User': $0.User$json,
  '.wasla.v1.UserStatus': $0.UserStatus$json,
  '.wasla.v1.Online': $0.Online$json,
  '.wasla.v1.Typing': Typing$json,
  '.wasla.v1.UserStatusChanged': UserStatusChanged$json,
};

/// Descriptor for `UpdatesService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List updatesServiceDescriptor = $convert.base64Decode(
    'Cg5VcGRhdGVzU2VydmljZRJBCghHZXRTdGF0ZRIZLndhc2xhLnYxLkdldFN0YXRlUmVxdWVzdB'
    'oaLndhc2xhLnYxLkdldFN0YXRlUmVzcG9uc2USUAoNR2V0RGlmZmVyZW5jZRIeLndhc2xhLnYx'
    'LkdldERpZmZlcmVuY2VSZXF1ZXN0Gh8ud2FzbGEudjEuR2V0RGlmZmVyZW5jZVJlc3BvbnNl');
