// This is a generated file - do not edit.
//
// Generated from wasla/v1/messages.proto.

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

import 'common.pbjson.dart' as $1;
import 'media.pbjson.dart' as $0;
import 'users.pbjson.dart' as $2;

@$core.Deprecated('Use textEntityTypeDescriptor instead')
const TextEntityType$json = {
  '1': 'TextEntityType',
  '2': [
    {'1': 'TEXT_ENTITY_TYPE_UNSPECIFIED', '2': 0},
    {'1': 'TEXT_ENTITY_TYPE_BOLD', '2': 1},
    {'1': 'TEXT_ENTITY_TYPE_ITALIC', '2': 2},
    {'1': 'TEXT_ENTITY_TYPE_UNDERLINE', '2': 3},
    {'1': 'TEXT_ENTITY_TYPE_STRIKETHROUGH', '2': 4},
    {'1': 'TEXT_ENTITY_TYPE_CODE', '2': 5},
    {'1': 'TEXT_ENTITY_TYPE_PRE', '2': 6},
    {'1': 'TEXT_ENTITY_TYPE_TEXT_URL', '2': 7},
    {'1': 'TEXT_ENTITY_TYPE_URL', '2': 8},
    {'1': 'TEXT_ENTITY_TYPE_MENTION', '2': 9},
    {'1': 'TEXT_ENTITY_TYPE_MENTION_NAME', '2': 10},
    {'1': 'TEXT_ENTITY_TYPE_HASHTAG', '2': 11},
    {'1': 'TEXT_ENTITY_TYPE_PHONE', '2': 12},
    {'1': 'TEXT_ENTITY_TYPE_EMAIL', '2': 13},
    {'1': 'TEXT_ENTITY_TYPE_SPOILER', '2': 14},
  ],
};

/// Descriptor for `TextEntityType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List textEntityTypeDescriptor = $convert.base64Decode(
    'Cg5UZXh0RW50aXR5VHlwZRIgChxURVhUX0VOVElUWV9UWVBFX1VOU1BFQ0lGSUVEEAASGQoVVE'
    'VYVF9FTlRJVFlfVFlQRV9CT0xEEAESGwoXVEVYVF9FTlRJVFlfVFlQRV9JVEFMSUMQAhIeChpU'
    'RVhUX0VOVElUWV9UWVBFX1VOREVSTElORRADEiIKHlRFWFRfRU5USVRZX1RZUEVfU1RSSUtFVE'
    'hST1VHSBAEEhkKFVRFWFRfRU5USVRZX1RZUEVfQ09ERRAFEhgKFFRFWFRfRU5USVRZX1RZUEVf'
    'UFJFEAYSHQoZVEVYVF9FTlRJVFlfVFlQRV9URVhUX1VSTBAHEhgKFFRFWFRfRU5USVRZX1RZUE'
    'VfVVJMEAgSHAoYVEVYVF9FTlRJVFlfVFlQRV9NRU5USU9OEAkSIQodVEVYVF9FTlRJVFlfVFlQ'
    'RV9NRU5USU9OX05BTUUQChIcChhURVhUX0VOVElUWV9UWVBFX0hBU0hUQUcQCxIaChZURVhUX0'
    'VOVElUWV9UWVBFX1BIT05FEAwSGgoWVEVYVF9FTlRJVFlfVFlQRV9FTUFJTBANEhwKGFRFWFRf'
    'RU5USVRZX1RZUEVfU1BPSUxFUhAO');

@$core.Deprecated('Use historyDirectionDescriptor instead')
const HistoryDirection$json = {
  '1': 'HistoryDirection',
  '2': [
    {'1': 'HISTORY_DIRECTION_UNSPECIFIED', '2': 0},
    {'1': 'HISTORY_DIRECTION_OLDER', '2': 1},
    {'1': 'HISTORY_DIRECTION_NEWER', '2': 2},
    {'1': 'HISTORY_DIRECTION_AROUND', '2': 3},
  ],
};

/// Descriptor for `HistoryDirection`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List historyDirectionDescriptor = $convert.base64Decode(
    'ChBIaXN0b3J5RGlyZWN0aW9uEiEKHUhJU1RPUllfRElSRUNUSU9OX1VOU1BFQ0lGSUVEEAASGw'
    'oXSElTVE9SWV9ESVJFQ1RJT05fT0xERVIQARIbChdISVNUT1JZX0RJUkVDVElPTl9ORVdFUhAC'
    'EhwKGEhJU1RPUllfRElSRUNUSU9OX0FST1VORBAD');

@$core.Deprecated('Use typingActionDescriptor instead')
const TypingAction$json = {
  '1': 'TypingAction',
  '2': [
    {'1': 'TYPING_ACTION_UNSPECIFIED', '2': 0},
    {'1': 'TYPING_ACTION_TYPING', '2': 1},
    {'1': 'TYPING_ACTION_RECORDING_VOICE', '2': 2},
    {'1': 'TYPING_ACTION_UPLOADING_PHOTO', '2': 3},
    {'1': 'TYPING_ACTION_UPLOADING_VIDEO', '2': 4},
    {'1': 'TYPING_ACTION_UPLOADING_DOCUMENT', '2': 5},
    {'1': 'TYPING_ACTION_CANCEL', '2': 6},
  ],
};

/// Descriptor for `TypingAction`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List typingActionDescriptor = $convert.base64Decode(
    'CgxUeXBpbmdBY3Rpb24SHQoZVFlQSU5HX0FDVElPTl9VTlNQRUNJRklFRBAAEhgKFFRZUElOR1'
    '9BQ1RJT05fVFlQSU5HEAESIQodVFlQSU5HX0FDVElPTl9SRUNPUkRJTkdfVk9JQ0UQAhIhCh1U'
    'WVBJTkdfQUNUSU9OX1VQTE9BRElOR19QSE9UTxADEiEKHVRZUElOR19BQ1RJT05fVVBMT0FESU'
    '5HX1ZJREVPEAQSJAogVFlQSU5HX0FDVElPTl9VUExPQURJTkdfRE9DVU1FTlQQBRIYChRUWVBJ'
    'TkdfQUNUSU9OX0NBTkNFTBAG');

@$core.Deprecated('Use messageDescriptor instead')
const Message$json = {
  '1': 'Message',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seq', '3': 2, '4': 1, '5': 3, '10': 'seq'},
    {'1': 'sender_id', '3': 3, '4': 1, '5': 3, '10': 'senderId'},
    {'1': 'date', '3': 4, '4': 1, '5': 3, '10': 'date'},
    {'1': 'edit_date', '3': 5, '4': 1, '5': 3, '10': 'editDate'},
    {
      '1': 'content',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MessageContent',
      '10': 'content'
    },
    {'1': 'reply_to_seq', '3': 7, '4': 1, '5': 3, '10': 'replyToSeq'},
    {
      '1': 'forward',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ForwardInfo',
      '10': 'forward'
    },
    {'1': 'random_id', '3': 9, '4': 1, '5': 3, '10': 'randomId'},
    {'1': 'pinned', '3': 10, '4': 1, '5': 8, '10': 'pinned'},
  ],
};

/// Descriptor for `Message`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageDescriptor = $convert.base64Decode(
    'CgdNZXNzYWdlEhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBIQCgNzZXEYAiABKANSA3NlcRIbCg'
    'lzZW5kZXJfaWQYAyABKANSCHNlbmRlcklkEhIKBGRhdGUYBCABKANSBGRhdGUSGwoJZWRpdF9k'
    'YXRlGAUgASgDUghlZGl0RGF0ZRIyCgdjb250ZW50GAYgASgLMhgud2FzbGEudjEuTWVzc2FnZU'
    'NvbnRlbnRSB2NvbnRlbnQSIAoMcmVwbHlfdG9fc2VxGAcgASgDUgpyZXBseVRvU2VxEi8KB2Zv'
    'cndhcmQYCCABKAsyFS53YXNsYS52MS5Gb3J3YXJkSW5mb1IHZm9yd2FyZBIbCglyYW5kb21faW'
    'QYCSABKANSCHJhbmRvbUlkEhYKBnBpbm5lZBgKIAEoCFIGcGlubmVk');

@$core.Deprecated('Use messageContentDescriptor instead')
const MessageContent$json = {
  '1': 'MessageContent',
  '2': [
    {
      '1': 'text',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.TextContent',
      '9': 0,
      '10': 'text'
    },
    {
      '1': 'photo',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.PhotoContent',
      '9': 0,
      '10': 'photo'
    },
    {
      '1': 'video',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.VideoContent',
      '9': 0,
      '10': 'video'
    },
    {
      '1': 'document',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.DocumentContent',
      '9': 0,
      '10': 'document'
    },
    {
      '1': 'voice',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.VoiceContent',
      '9': 0,
      '10': 'voice'
    },
    {
      '1': 'location',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.LocationContent',
      '9': 0,
      '10': 'location'
    },
    {
      '1': 'contact',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ContactContent',
      '9': 0,
      '10': 'contact'
    },
    {
      '1': 'service',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ServiceContent',
      '9': 0,
      '10': 'service'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `MessageContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageContentDescriptor = $convert.base64Decode(
    'Cg5NZXNzYWdlQ29udGVudBIrCgR0ZXh0GAEgASgLMhUud2FzbGEudjEuVGV4dENvbnRlbnRIAF'
    'IEdGV4dBIuCgVwaG90bxgCIAEoCzIWLndhc2xhLnYxLlBob3RvQ29udGVudEgAUgVwaG90bxIu'
    'CgV2aWRlbxgDIAEoCzIWLndhc2xhLnYxLlZpZGVvQ29udGVudEgAUgV2aWRlbxI3Cghkb2N1bW'
    'VudBgEIAEoCzIZLndhc2xhLnYxLkRvY3VtZW50Q29udGVudEgAUghkb2N1bWVudBIuCgV2b2lj'
    'ZRgFIAEoCzIWLndhc2xhLnYxLlZvaWNlQ29udGVudEgAUgV2b2ljZRI3Cghsb2NhdGlvbhgGIA'
    'EoCzIZLndhc2xhLnYxLkxvY2F0aW9uQ29udGVudEgAUghsb2NhdGlvbhI0Cgdjb250YWN0GAcg'
    'ASgLMhgud2FzbGEudjEuQ29udGFjdENvbnRlbnRIAFIHY29udGFjdBI0CgdzZXJ2aWNlGAggAS'
    'gLMhgud2FzbGEudjEuU2VydmljZUNvbnRlbnRIAFIHc2VydmljZUIGCgRraW5k');

@$core.Deprecated('Use formattedTextDescriptor instead')
const FormattedText$json = {
  '1': 'FormattedText',
  '2': [
    {'1': 'text', '3': 1, '4': 1, '5': 9, '10': 'text'},
    {
      '1': 'entities',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.TextEntity',
      '10': 'entities'
    },
  ],
};

/// Descriptor for `FormattedText`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List formattedTextDescriptor = $convert.base64Decode(
    'Cg1Gb3JtYXR0ZWRUZXh0EhIKBHRleHQYASABKAlSBHRleHQSMAoIZW50aXRpZXMYAiADKAsyFC'
    '53YXNsYS52MS5UZXh0RW50aXR5UghlbnRpdGllcw==');

@$core.Deprecated('Use textEntityDescriptor instead')
const TextEntity$json = {
  '1': 'TextEntity',
  '2': [
    {
      '1': 'type',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.TextEntityType',
      '10': 'type'
    },
    {'1': 'offset', '3': 2, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'length', '3': 3, '4': 1, '5': 5, '10': 'length'},
    {'1': 'url', '3': 4, '4': 1, '5': 9, '10': 'url'},
    {'1': 'user_id', '3': 5, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `TextEntity`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textEntityDescriptor = $convert.base64Decode(
    'CgpUZXh0RW50aXR5EiwKBHR5cGUYASABKA4yGC53YXNsYS52MS5UZXh0RW50aXR5VHlwZVIEdH'
    'lwZRIWCgZvZmZzZXQYAiABKAVSBm9mZnNldBIWCgZsZW5ndGgYAyABKAVSBmxlbmd0aBIQCgN1'
    'cmwYBCABKAlSA3VybBIXCgd1c2VyX2lkGAUgASgDUgZ1c2VySWQ=');

@$core.Deprecated('Use textContentDescriptor instead')
const TextContent$json = {
  '1': 'TextContent',
  '2': [
    {
      '1': 'text',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.FormattedText',
      '10': 'text'
    },
  ],
};

/// Descriptor for `TextContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List textContentDescriptor = $convert.base64Decode(
    'CgtUZXh0Q29udGVudBIrCgR0ZXh0GAEgASgLMhcud2FzbGEudjEuRm9ybWF0dGVkVGV4dFIEdG'
    'V4dA==');

@$core.Deprecated('Use photoContentDescriptor instead')
const PhotoContent$json = {
  '1': 'PhotoContent',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Media',
      '10': 'media'
    },
    {
      '1': 'caption',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.FormattedText',
      '10': 'caption'
    },
  ],
};

/// Descriptor for `PhotoContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List photoContentDescriptor = $convert.base64Decode(
    'CgxQaG90b0NvbnRlbnQSJQoFbWVkaWEYASABKAsyDy53YXNsYS52MS5NZWRpYVIFbWVkaWESMQ'
    'oHY2FwdGlvbhgCIAEoCzIXLndhc2xhLnYxLkZvcm1hdHRlZFRleHRSB2NhcHRpb24=');

@$core.Deprecated('Use videoContentDescriptor instead')
const VideoContent$json = {
  '1': 'VideoContent',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Media',
      '10': 'media'
    },
    {
      '1': 'caption',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.FormattedText',
      '10': 'caption'
    },
  ],
};

/// Descriptor for `VideoContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List videoContentDescriptor = $convert.base64Decode(
    'CgxWaWRlb0NvbnRlbnQSJQoFbWVkaWEYASABKAsyDy53YXNsYS52MS5NZWRpYVIFbWVkaWESMQ'
    'oHY2FwdGlvbhgCIAEoCzIXLndhc2xhLnYxLkZvcm1hdHRlZFRleHRSB2NhcHRpb24=');

@$core.Deprecated('Use documentContentDescriptor instead')
const DocumentContent$json = {
  '1': 'DocumentContent',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Media',
      '10': 'media'
    },
    {
      '1': 'caption',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.FormattedText',
      '10': 'caption'
    },
  ],
};

/// Descriptor for `DocumentContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List documentContentDescriptor = $convert.base64Decode(
    'Cg9Eb2N1bWVudENvbnRlbnQSJQoFbWVkaWEYASABKAsyDy53YXNsYS52MS5NZWRpYVIFbWVkaW'
    'ESMQoHY2FwdGlvbhgCIAEoCzIXLndhc2xhLnYxLkZvcm1hdHRlZFRleHRSB2NhcHRpb24=');

@$core.Deprecated('Use voiceContentDescriptor instead')
const VoiceContent$json = {
  '1': 'VoiceContent',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Media',
      '10': 'media'
    },
  ],
};

/// Descriptor for `VoiceContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List voiceContentDescriptor = $convert.base64Decode(
    'CgxWb2ljZUNvbnRlbnQSJQoFbWVkaWEYASABKAsyDy53YXNsYS52MS5NZWRpYVIFbWVkaWE=');

@$core.Deprecated('Use locationContentDescriptor instead')
const LocationContent$json = {
  '1': 'LocationContent',
  '2': [
    {'1': 'latitude', '3': 1, '4': 1, '5': 1, '10': 'latitude'},
    {'1': 'longitude', '3': 2, '4': 1, '5': 1, '10': 'longitude'},
    {'1': 'accuracy_meters', '3': 3, '4': 1, '5': 2, '10': 'accuracyMeters'},
  ],
};

/// Descriptor for `LocationContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List locationContentDescriptor = $convert.base64Decode(
    'Cg9Mb2NhdGlvbkNvbnRlbnQSGgoIbGF0aXR1ZGUYASABKAFSCGxhdGl0dWRlEhwKCWxvbmdpdH'
    'VkZRgCIAEoAVIJbG9uZ2l0dWRlEicKD2FjY3VyYWN5X21ldGVycxgDIAEoAlIOYWNjdXJhY3lN'
    'ZXRlcnM=');

@$core.Deprecated('Use contactContentDescriptor instead')
const ContactContent$json = {
  '1': 'ContactContent',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'user_id', '3': 4, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `ContactContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactContentDescriptor = $convert.base64Decode(
    'Cg5Db250YWN0Q29udGVudBIUCgVwaG9uZRgBIAEoCVIFcGhvbmUSHQoKZmlyc3RfbmFtZRgCIA'
    'EoCVIJZmlyc3ROYW1lEhsKCWxhc3RfbmFtZRgDIAEoCVIIbGFzdE5hbWUSFwoHdXNlcl9pZBgE'
    'IAEoA1IGdXNlcklk');

@$core.Deprecated('Use serviceContentDescriptor instead')
const ServiceContent$json = {
  '1': 'ServiceContent',
  '2': [
    {
      '1': 'chat_created',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ChatCreated',
      '9': 0,
      '10': 'chatCreated'
    },
    {
      '1': 'members_added',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MembersAdded',
      '9': 0,
      '10': 'membersAdded'
    },
    {
      '1': 'member_removed',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MemberRemoved',
      '9': 0,
      '10': 'memberRemoved'
    },
    {
      '1': 'member_left',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MemberLeft',
      '9': 0,
      '10': 'memberLeft'
    },
    {
      '1': 'member_joined_by_link',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MemberJoinedByLink',
      '9': 0,
      '10': 'memberJoinedByLink'
    },
    {
      '1': 'chat_title_changed',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ChatTitleChanged',
      '9': 0,
      '10': 'chatTitleChanged'
    },
    {
      '1': 'chat_photo_changed',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ChatPhotoChanged',
      '9': 0,
      '10': 'chatPhotoChanged'
    },
    {
      '1': 'message_pinned',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MessagePinned',
      '9': 0,
      '10': 'messagePinned'
    },
  ],
  '8': [
    {'1': 'action'},
  ],
};

/// Descriptor for `ServiceContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List serviceContentDescriptor = $convert.base64Decode(
    'Cg5TZXJ2aWNlQ29udGVudBI6CgxjaGF0X2NyZWF0ZWQYASABKAsyFS53YXNsYS52MS5DaGF0Q3'
    'JlYXRlZEgAUgtjaGF0Q3JlYXRlZBI9Cg1tZW1iZXJzX2FkZGVkGAIgASgLMhYud2FzbGEudjEu'
    'TWVtYmVyc0FkZGVkSABSDG1lbWJlcnNBZGRlZBJACg5tZW1iZXJfcmVtb3ZlZBgDIAEoCzIXLn'
    'dhc2xhLnYxLk1lbWJlclJlbW92ZWRIAFINbWVtYmVyUmVtb3ZlZBI3CgttZW1iZXJfbGVmdBgE'
    'IAEoCzIULndhc2xhLnYxLk1lbWJlckxlZnRIAFIKbWVtYmVyTGVmdBJRChVtZW1iZXJfam9pbm'
    'VkX2J5X2xpbmsYBSABKAsyHC53YXNsYS52MS5NZW1iZXJKb2luZWRCeUxpbmtIAFISbWVtYmVy'
    'Sm9pbmVkQnlMaW5rEkoKEmNoYXRfdGl0bGVfY2hhbmdlZBgGIAEoCzIaLndhc2xhLnYxLkNoYX'
    'RUaXRsZUNoYW5nZWRIAFIQY2hhdFRpdGxlQ2hhbmdlZBJKChJjaGF0X3Bob3RvX2NoYW5nZWQY'
    'ByABKAsyGi53YXNsYS52MS5DaGF0UGhvdG9DaGFuZ2VkSABSEGNoYXRQaG90b0NoYW5nZWQSQA'
    'oObWVzc2FnZV9waW5uZWQYCCABKAsyFy53YXNsYS52MS5NZXNzYWdlUGlubmVkSABSDW1lc3Nh'
    'Z2VQaW5uZWRCCAoGYWN0aW9u');

@$core.Deprecated('Use chatCreatedDescriptor instead')
const ChatCreated$json = {
  '1': 'ChatCreated',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
  ],
};

/// Descriptor for `ChatCreated`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatCreatedDescriptor =
    $convert.base64Decode('CgtDaGF0Q3JlYXRlZBIUCgV0aXRsZRgBIAEoCVIFdGl0bGU=');

@$core.Deprecated('Use membersAddedDescriptor instead')
const MembersAdded$json = {
  '1': 'MembersAdded',
  '2': [
    {'1': 'user_ids', '3': 1, '4': 3, '5': 3, '10': 'userIds'},
  ],
};

/// Descriptor for `MembersAdded`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List membersAddedDescriptor = $convert
    .base64Decode('CgxNZW1iZXJzQWRkZWQSGQoIdXNlcl9pZHMYASADKANSB3VzZXJJZHM=');

@$core.Deprecated('Use memberRemovedDescriptor instead')
const MemberRemoved$json = {
  '1': 'MemberRemoved',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `MemberRemoved`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberRemovedDescriptor = $convert
    .base64Decode('Cg1NZW1iZXJSZW1vdmVkEhcKB3VzZXJfaWQYASABKANSBnVzZXJJZA==');

@$core.Deprecated('Use memberLeftDescriptor instead')
const MemberLeft$json = {
  '1': 'MemberLeft',
};

/// Descriptor for `MemberLeft`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberLeftDescriptor =
    $convert.base64Decode('CgpNZW1iZXJMZWZ0');

@$core.Deprecated('Use memberJoinedByLinkDescriptor instead')
const MemberJoinedByLink$json = {
  '1': 'MemberJoinedByLink',
};

/// Descriptor for `MemberJoinedByLink`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List memberJoinedByLinkDescriptor =
    $convert.base64Decode('ChJNZW1iZXJKb2luZWRCeUxpbms=');

@$core.Deprecated('Use chatTitleChangedDescriptor instead')
const ChatTitleChanged$json = {
  '1': 'ChatTitleChanged',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
  ],
};

/// Descriptor for `ChatTitleChanged`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatTitleChangedDescriptor = $convert
    .base64Decode('ChBDaGF0VGl0bGVDaGFuZ2VkEhQKBXRpdGxlGAEgASgJUgV0aXRsZQ==');

@$core.Deprecated('Use chatPhotoChangedDescriptor instead')
const ChatPhotoChanged$json = {
  '1': 'ChatPhotoChanged',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 3, '10': 'mediaId'},
  ],
};

/// Descriptor for `ChatPhotoChanged`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List chatPhotoChangedDescriptor = $convert.base64Decode(
    'ChBDaGF0UGhvdG9DaGFuZ2VkEhkKCG1lZGlhX2lkGAEgASgDUgdtZWRpYUlk');

@$core.Deprecated('Use messagePinnedDescriptor instead')
const MessagePinned$json = {
  '1': 'MessagePinned',
  '2': [
    {'1': 'seq', '3': 1, '4': 1, '5': 3, '10': 'seq'},
  ],
};

/// Descriptor for `MessagePinned`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messagePinnedDescriptor =
    $convert.base64Decode('Cg1NZXNzYWdlUGlubmVkEhAKA3NlcRgBIAEoA1IDc2Vx');

@$core.Deprecated('Use forwardInfoDescriptor instead')
const ForwardInfo$json = {
  '1': 'ForwardInfo',
  '2': [
    {'1': 'from_user_id', '3': 1, '4': 1, '5': 3, '10': 'fromUserId'},
    {'1': 'from_name', '3': 2, '4': 1, '5': 9, '10': 'fromName'},
    {'1': 'original_date', '3': 3, '4': 1, '5': 3, '10': 'originalDate'},
    {'1': 'from_chat_id', '3': 4, '4': 1, '5': 3, '10': 'fromChatId'},
    {'1': 'from_seq', '3': 5, '4': 1, '5': 3, '10': 'fromSeq'},
  ],
};

/// Descriptor for `ForwardInfo`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardInfoDescriptor = $convert.base64Decode(
    'CgtGb3J3YXJkSW5mbxIgCgxmcm9tX3VzZXJfaWQYASABKANSCmZyb21Vc2VySWQSGwoJZnJvbV'
    '9uYW1lGAIgASgJUghmcm9tTmFtZRIjCg1vcmlnaW5hbF9kYXRlGAMgASgDUgxvcmlnaW5hbERh'
    'dGUSIAoMZnJvbV9jaGF0X2lkGAQgASgDUgpmcm9tQ2hhdElkEhkKCGZyb21fc2VxGAUgASgDUg'
    'dmcm9tU2Vx');

@$core.Deprecated('Use inputContentDescriptor instead')
const InputContent$json = {
  '1': 'InputContent',
  '2': [
    {
      '1': 'text',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.FormattedText',
      '9': 0,
      '10': 'text'
    },
    {
      '1': 'media',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.InputMedia',
      '9': 0,
      '10': 'media'
    },
    {
      '1': 'location',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.LocationContent',
      '9': 0,
      '10': 'location'
    },
    {
      '1': 'contact',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ContactContent',
      '9': 0,
      '10': 'contact'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `InputContent`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputContentDescriptor = $convert.base64Decode(
    'CgxJbnB1dENvbnRlbnQSLQoEdGV4dBgBIAEoCzIXLndhc2xhLnYxLkZvcm1hdHRlZFRleHRIAF'
    'IEdGV4dBIsCgVtZWRpYRgCIAEoCzIULndhc2xhLnYxLklucHV0TWVkaWFIAFIFbWVkaWESNwoI'
    'bG9jYXRpb24YAyABKAsyGS53YXNsYS52MS5Mb2NhdGlvbkNvbnRlbnRIAFIIbG9jYXRpb24SNA'
    'oHY29udGFjdBgEIAEoCzIYLndhc2xhLnYxLkNvbnRhY3RDb250ZW50SABSB2NvbnRhY3RCBgoE'
    'a2luZA==');

@$core.Deprecated('Use inputMediaDescriptor instead')
const InputMedia$json = {
  '1': 'InputMedia',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 3, '10': 'mediaId'},
    {
      '1': 'caption',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.FormattedText',
      '10': 'caption'
    },
  ],
};

/// Descriptor for `InputMedia`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inputMediaDescriptor = $convert.base64Decode(
    'CgpJbnB1dE1lZGlhEhkKCG1lZGlhX2lkGAEgASgDUgdtZWRpYUlkEjEKB2NhcHRpb24YAiABKA'
    'syFy53YXNsYS52MS5Gb3JtYXR0ZWRUZXh0UgdjYXB0aW9u');

@$core.Deprecated('Use sendMessageRequestDescriptor instead')
const SendMessageRequest$json = {
  '1': 'SendMessageRequest',
  '2': [
    {'1': 'peer', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.Peer', '10': 'peer'},
    {'1': 'random_id', '3': 2, '4': 1, '5': 3, '10': 'randomId'},
    {
      '1': 'content',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.InputContent',
      '10': 'content'
    },
    {'1': 'reply_to_seq', '3': 4, '4': 1, '5': 3, '10': 'replyToSeq'},
    {'1': 'silent', '3': 5, '4': 1, '5': 8, '10': 'silent'},
  ],
};

/// Descriptor for `SendMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageRequestDescriptor = $convert.base64Decode(
    'ChJTZW5kTWVzc2FnZVJlcXVlc3QSIgoEcGVlchgBIAEoCzIOLndhc2xhLnYxLlBlZXJSBHBlZX'
    'ISGwoJcmFuZG9tX2lkGAIgASgDUghyYW5kb21JZBIwCgdjb250ZW50GAMgASgLMhYud2FzbGEu'
    'djEuSW5wdXRDb250ZW50Ugdjb250ZW50EiAKDHJlcGx5X3RvX3NlcRgEIAEoA1IKcmVwbHlUb1'
    'NlcRIWCgZzaWxlbnQYBSABKAhSBnNpbGVudA==');

@$core.Deprecated('Use sendMessageResponseDescriptor instead')
const SendMessageResponse$json = {
  '1': 'SendMessageResponse',
  '2': [
    {
      '1': 'message',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Message',
      '10': 'message'
    },
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `SendMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendMessageResponseDescriptor = $convert.base64Decode(
    'ChNTZW5kTWVzc2FnZVJlc3BvbnNlEisKB21lc3NhZ2UYASABKAsyES53YXNsYS52MS5NZXNzYW'
    'dlUgdtZXNzYWdlEhAKA3B0cxgCIAEoA1IDcHRzEhsKCXB0c19jb3VudBgDIAEoBVIIcHRzQ291'
    'bnQ=');

@$core.Deprecated('Use editMessageRequestDescriptor instead')
const EditMessageRequest$json = {
  '1': 'EditMessageRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seq', '3': 2, '4': 1, '5': 3, '10': 'seq'},
    {
      '1': 'text',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.FormattedText',
      '10': 'text'
    },
  ],
};

/// Descriptor for `EditMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editMessageRequestDescriptor = $convert.base64Decode(
    'ChJFZGl0TWVzc2FnZVJlcXVlc3QSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhAKA3NlcRgCIA'
    'EoA1IDc2VxEisKBHRleHQYAyABKAsyFy53YXNsYS52MS5Gb3JtYXR0ZWRUZXh0UgR0ZXh0');

@$core.Deprecated('Use editMessageResponseDescriptor instead')
const EditMessageResponse$json = {
  '1': 'EditMessageResponse',
  '2': [
    {
      '1': 'message',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Message',
      '10': 'message'
    },
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `EditMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List editMessageResponseDescriptor = $convert.base64Decode(
    'ChNFZGl0TWVzc2FnZVJlc3BvbnNlEisKB21lc3NhZ2UYASABKAsyES53YXNsYS52MS5NZXNzYW'
    'dlUgdtZXNzYWdlEhAKA3B0cxgCIAEoA1IDcHRzEhsKCXB0c19jb3VudBgDIAEoBVIIcHRzQ291'
    'bnQ=');

@$core.Deprecated('Use deleteMessagesRequestDescriptor instead')
const DeleteMessagesRequest$json = {
  '1': 'DeleteMessagesRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seqs', '3': 2, '4': 3, '5': 3, '10': 'seqs'},
    {'1': 'for_everyone', '3': 3, '4': 1, '5': 8, '10': 'forEveryone'},
  ],
};

/// Descriptor for `DeleteMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMessagesRequestDescriptor = $convert.base64Decode(
    'ChVEZWxldGVNZXNzYWdlc1JlcXVlc3QSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhIKBHNlcX'
    'MYAiADKANSBHNlcXMSIQoMZm9yX2V2ZXJ5b25lGAMgASgIUgtmb3JFdmVyeW9uZQ==');

@$core.Deprecated('Use deleteMessagesResponseDescriptor instead')
const DeleteMessagesResponse$json = {
  '1': 'DeleteMessagesResponse',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 2, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `DeleteMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteMessagesResponseDescriptor =
    $convert.base64Decode(
        'ChZEZWxldGVNZXNzYWdlc1Jlc3BvbnNlEhAKA3B0cxgBIAEoA1IDcHRzEhsKCXB0c19jb3VudB'
        'gCIAEoBVIIcHRzQ291bnQ=');

@$core.Deprecated('Use forwardMessagesRequestDescriptor instead')
const ForwardMessagesRequest$json = {
  '1': 'ForwardMessagesRequest',
  '2': [
    {'1': 'from_chat_id', '3': 1, '4': 1, '5': 3, '10': 'fromChatId'},
    {'1': 'seqs', '3': 2, '4': 3, '5': 3, '10': 'seqs'},
    {
      '1': 'to_peer',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Peer',
      '10': 'toPeer'
    },
    {'1': 'random_ids', '3': 4, '4': 3, '5': 3, '10': 'randomIds'},
    {'1': 'hide_sender', '3': 5, '4': 1, '5': 8, '10': 'hideSender'},
    {'1': 'silent', '3': 6, '4': 1, '5': 8, '10': 'silent'},
  ],
};

/// Descriptor for `ForwardMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardMessagesRequestDescriptor = $convert.base64Decode(
    'ChZGb3J3YXJkTWVzc2FnZXNSZXF1ZXN0EiAKDGZyb21fY2hhdF9pZBgBIAEoA1IKZnJvbUNoYX'
    'RJZBISCgRzZXFzGAIgAygDUgRzZXFzEicKB3RvX3BlZXIYAyABKAsyDi53YXNsYS52MS5QZWVy'
    'UgZ0b1BlZXISHQoKcmFuZG9tX2lkcxgEIAMoA1IJcmFuZG9tSWRzEh8KC2hpZGVfc2VuZGVyGA'
    'UgASgIUgpoaWRlU2VuZGVyEhYKBnNpbGVudBgGIAEoCFIGc2lsZW50');

@$core.Deprecated('Use forwardMessagesResponseDescriptor instead')
const ForwardMessagesResponse$json = {
  '1': 'ForwardMessagesResponse',
  '2': [
    {
      '1': 'messages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Message',
      '10': 'messages'
    },
    {'1': 'pts', '3': 2, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 3, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `ForwardMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List forwardMessagesResponseDescriptor = $convert.base64Decode(
    'ChdGb3J3YXJkTWVzc2FnZXNSZXNwb25zZRItCghtZXNzYWdlcxgBIAMoCzIRLndhc2xhLnYxLk'
    '1lc3NhZ2VSCG1lc3NhZ2VzEhAKA3B0cxgCIAEoA1IDcHRzEhsKCXB0c19jb3VudBgDIAEoBVII'
    'cHRzQ291bnQ=');

@$core.Deprecated('Use getHistoryRequestDescriptor instead')
const GetHistoryRequest$json = {
  '1': 'GetHistoryRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'offset_seq', '3': 2, '4': 1, '5': 3, '10': 'offsetSeq'},
    {
      '1': 'direction',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.HistoryDirection',
      '10': 'direction'
    },
    {'1': 'limit', '3': 4, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `GetHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoryRequestDescriptor = $convert.base64Decode(
    'ChFHZXRIaXN0b3J5UmVxdWVzdBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSHQoKb2Zmc2V0X3'
    'NlcRgCIAEoA1IJb2Zmc2V0U2VxEjgKCWRpcmVjdGlvbhgDIAEoDjIaLndhc2xhLnYxLkhpc3Rv'
    'cnlEaXJlY3Rpb25SCWRpcmVjdGlvbhIUCgVsaW1pdBgEIAEoBVIFbGltaXQ=');

@$core.Deprecated('Use getHistoryResponseDescriptor instead')
const GetHistoryResponse$json = {
  '1': 'GetHistoryResponse',
  '2': [
    {
      '1': 'messages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Message',
      '10': 'messages'
    },
    {
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
    {'1': 'has_more', '3': 3, '4': 1, '5': 8, '10': 'hasMore'},
  ],
};

/// Descriptor for `GetHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getHistoryResponseDescriptor = $convert.base64Decode(
    'ChJHZXRIaXN0b3J5UmVzcG9uc2USLQoIbWVzc2FnZXMYASADKAsyES53YXNsYS52MS5NZXNzYW'
    'dlUghtZXNzYWdlcxIkCgV1c2VycxgCIAMoCzIOLndhc2xhLnYxLlVzZXJSBXVzZXJzEhkKCGhh'
    'c19tb3JlGAMgASgIUgdoYXNNb3Jl');

@$core.Deprecated('Use getMessagesRequestDescriptor instead')
const GetMessagesRequest$json = {
  '1': 'GetMessagesRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seqs', '3': 2, '4': 3, '5': 3, '10': 'seqs'},
  ],
};

/// Descriptor for `GetMessagesRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesRequestDescriptor = $convert.base64Decode(
    'ChJHZXRNZXNzYWdlc1JlcXVlc3QSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhIKBHNlcXMYAi'
    'ADKANSBHNlcXM=');

@$core.Deprecated('Use getMessagesResponseDescriptor instead')
const GetMessagesResponse$json = {
  '1': 'GetMessagesResponse',
  '2': [
    {
      '1': 'messages',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Message',
      '10': 'messages'
    },
    {
      '1': 'users',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
  ],
};

/// Descriptor for `GetMessagesResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMessagesResponseDescriptor = $convert.base64Decode(
    'ChNHZXRNZXNzYWdlc1Jlc3BvbnNlEi0KCG1lc3NhZ2VzGAEgAygLMhEud2FzbGEudjEuTWVzc2'
    'FnZVIIbWVzc2FnZXMSJAoFdXNlcnMYAiADKAsyDi53YXNsYS52MS5Vc2VyUgV1c2Vycw==');

@$core.Deprecated('Use readHistoryRequestDescriptor instead')
const ReadHistoryRequest$json = {
  '1': 'ReadHistoryRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'max_seq', '3': 2, '4': 1, '5': 3, '10': 'maxSeq'},
  ],
};

/// Descriptor for `ReadHistoryRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readHistoryRequestDescriptor = $convert.base64Decode(
    'ChJSZWFkSGlzdG9yeVJlcXVlc3QSFwoHY2hhdF9pZBgBIAEoA1IGY2hhdElkEhcKB21heF9zZX'
    'EYAiABKANSBm1heFNlcQ==');

@$core.Deprecated('Use readHistoryResponseDescriptor instead')
const ReadHistoryResponse$json = {
  '1': 'ReadHistoryResponse',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 2, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `ReadHistoryResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List readHistoryResponseDescriptor = $convert.base64Decode(
    'ChNSZWFkSGlzdG9yeVJlc3BvbnNlEhAKA3B0cxgBIAEoA1IDcHRzEhsKCXB0c19jb3VudBgCIA'
    'EoBVIIcHRzQ291bnQ=');

@$core.Deprecated('Use setTypingRequestDescriptor instead')
const SetTypingRequest$json = {
  '1': 'SetTypingRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {
      '1': 'action',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.TypingAction',
      '10': 'action'
    },
  ],
};

/// Descriptor for `SetTypingRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setTypingRequestDescriptor = $convert.base64Decode(
    'ChBTZXRUeXBpbmdSZXF1ZXN0EhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBIuCgZhY3Rpb24YAi'
    'ABKA4yFi53YXNsYS52MS5UeXBpbmdBY3Rpb25SBmFjdGlvbg==');

@$core.Deprecated('Use setTypingResponseDescriptor instead')
const SetTypingResponse$json = {
  '1': 'SetTypingResponse',
};

/// Descriptor for `SetTypingResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setTypingResponseDescriptor =
    $convert.base64Decode('ChFTZXRUeXBpbmdSZXNwb25zZQ==');

@$core.Deprecated('Use pinMessageRequestDescriptor instead')
const PinMessageRequest$json = {
  '1': 'PinMessageRequest',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seq', '3': 2, '4': 1, '5': 3, '10': 'seq'},
    {'1': 'unpin', '3': 3, '4': 1, '5': 8, '10': 'unpin'},
    {'1': 'silent', '3': 4, '4': 1, '5': 8, '10': 'silent'},
  ],
};

/// Descriptor for `PinMessageRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pinMessageRequestDescriptor = $convert.base64Decode(
    'ChFQaW5NZXNzYWdlUmVxdWVzdBIXCgdjaGF0X2lkGAEgASgDUgZjaGF0SWQSEAoDc2VxGAIgAS'
    'gDUgNzZXESFAoFdW5waW4YAyABKAhSBXVucGluEhYKBnNpbGVudBgEIAEoCFIGc2lsZW50');

@$core.Deprecated('Use pinMessageResponseDescriptor instead')
const PinMessageResponse$json = {
  '1': 'PinMessageResponse',
  '2': [
    {'1': 'pts', '3': 1, '4': 1, '5': 3, '10': 'pts'},
    {'1': 'pts_count', '3': 2, '4': 1, '5': 5, '10': 'ptsCount'},
  ],
};

/// Descriptor for `PinMessageResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pinMessageResponseDescriptor = $convert.base64Decode(
    'ChJQaW5NZXNzYWdlUmVzcG9uc2USEAoDcHRzGAEgASgDUgNwdHMSGwoJcHRzX2NvdW50GAIgAS'
    'gFUghwdHNDb3VudA==');

const $core.Map<$core.String, $core.dynamic> MessagesServiceBase$json = {
  '1': 'MessagesService',
  '2': [
    {
      '1': 'SendMessage',
      '2': '.wasla.v1.SendMessageRequest',
      '3': '.wasla.v1.SendMessageResponse'
    },
    {
      '1': 'EditMessage',
      '2': '.wasla.v1.EditMessageRequest',
      '3': '.wasla.v1.EditMessageResponse'
    },
    {
      '1': 'DeleteMessages',
      '2': '.wasla.v1.DeleteMessagesRequest',
      '3': '.wasla.v1.DeleteMessagesResponse'
    },
    {
      '1': 'ForwardMessages',
      '2': '.wasla.v1.ForwardMessagesRequest',
      '3': '.wasla.v1.ForwardMessagesResponse'
    },
    {
      '1': 'GetHistory',
      '2': '.wasla.v1.GetHistoryRequest',
      '3': '.wasla.v1.GetHistoryResponse'
    },
    {
      '1': 'GetMessages',
      '2': '.wasla.v1.GetMessagesRequest',
      '3': '.wasla.v1.GetMessagesResponse'
    },
    {
      '1': 'ReadHistory',
      '2': '.wasla.v1.ReadHistoryRequest',
      '3': '.wasla.v1.ReadHistoryResponse'
    },
    {
      '1': 'SetTyping',
      '2': '.wasla.v1.SetTypingRequest',
      '3': '.wasla.v1.SetTypingResponse'
    },
    {
      '1': 'PinMessage',
      '2': '.wasla.v1.PinMessageRequest',
      '3': '.wasla.v1.PinMessageResponse'
    },
  ],
};

@$core.Deprecated('Use messagesServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    MessagesServiceBase$messageJson = {
  '.wasla.v1.SendMessageRequest': SendMessageRequest$json,
  '.wasla.v1.Peer': $1.Peer$json,
  '.wasla.v1.InputContent': InputContent$json,
  '.wasla.v1.FormattedText': FormattedText$json,
  '.wasla.v1.TextEntity': TextEntity$json,
  '.wasla.v1.InputMedia': InputMedia$json,
  '.wasla.v1.LocationContent': LocationContent$json,
  '.wasla.v1.ContactContent': ContactContent$json,
  '.wasla.v1.SendMessageResponse': SendMessageResponse$json,
  '.wasla.v1.Message': Message$json,
  '.wasla.v1.MessageContent': MessageContent$json,
  '.wasla.v1.TextContent': TextContent$json,
  '.wasla.v1.PhotoContent': PhotoContent$json,
  '.wasla.v1.Media': $0.Media$json,
  '.wasla.v1.MediaVariant': $0.MediaVariant$json,
  '.wasla.v1.VideoContent': VideoContent$json,
  '.wasla.v1.DocumentContent': DocumentContent$json,
  '.wasla.v1.VoiceContent': VoiceContent$json,
  '.wasla.v1.ServiceContent': ServiceContent$json,
  '.wasla.v1.ChatCreated': ChatCreated$json,
  '.wasla.v1.MembersAdded': MembersAdded$json,
  '.wasla.v1.MemberRemoved': MemberRemoved$json,
  '.wasla.v1.MemberLeft': MemberLeft$json,
  '.wasla.v1.MemberJoinedByLink': MemberJoinedByLink$json,
  '.wasla.v1.ChatTitleChanged': ChatTitleChanged$json,
  '.wasla.v1.ChatPhotoChanged': ChatPhotoChanged$json,
  '.wasla.v1.MessagePinned': MessagePinned$json,
  '.wasla.v1.ForwardInfo': ForwardInfo$json,
  '.wasla.v1.EditMessageRequest': EditMessageRequest$json,
  '.wasla.v1.EditMessageResponse': EditMessageResponse$json,
  '.wasla.v1.DeleteMessagesRequest': DeleteMessagesRequest$json,
  '.wasla.v1.DeleteMessagesResponse': DeleteMessagesResponse$json,
  '.wasla.v1.ForwardMessagesRequest': ForwardMessagesRequest$json,
  '.wasla.v1.ForwardMessagesResponse': ForwardMessagesResponse$json,
  '.wasla.v1.GetHistoryRequest': GetHistoryRequest$json,
  '.wasla.v1.GetHistoryResponse': GetHistoryResponse$json,
  '.wasla.v1.User': $2.User$json,
  '.wasla.v1.Avatar': $1.Avatar$json,
  '.wasla.v1.UserStatus': $2.UserStatus$json,
  '.wasla.v1.Online': $2.Online$json,
  '.wasla.v1.GetMessagesRequest': GetMessagesRequest$json,
  '.wasla.v1.GetMessagesResponse': GetMessagesResponse$json,
  '.wasla.v1.ReadHistoryRequest': ReadHistoryRequest$json,
  '.wasla.v1.ReadHistoryResponse': ReadHistoryResponse$json,
  '.wasla.v1.SetTypingRequest': SetTypingRequest$json,
  '.wasla.v1.SetTypingResponse': SetTypingResponse$json,
  '.wasla.v1.PinMessageRequest': PinMessageRequest$json,
  '.wasla.v1.PinMessageResponse': PinMessageResponse$json,
};

/// Descriptor for `MessagesService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List messagesServiceDescriptor = $convert.base64Decode(
    'Cg9NZXNzYWdlc1NlcnZpY2USSgoLU2VuZE1lc3NhZ2USHC53YXNsYS52MS5TZW5kTWVzc2FnZV'
    'JlcXVlc3QaHS53YXNsYS52MS5TZW5kTWVzc2FnZVJlc3BvbnNlEkoKC0VkaXRNZXNzYWdlEhwu'
    'd2FzbGEudjEuRWRpdE1lc3NhZ2VSZXF1ZXN0Gh0ud2FzbGEudjEuRWRpdE1lc3NhZ2VSZXNwb2'
    '5zZRJTCg5EZWxldGVNZXNzYWdlcxIfLndhc2xhLnYxLkRlbGV0ZU1lc3NhZ2VzUmVxdWVzdBog'
    'Lndhc2xhLnYxLkRlbGV0ZU1lc3NhZ2VzUmVzcG9uc2USVgoPRm9yd2FyZE1lc3NhZ2VzEiAud2'
    'FzbGEudjEuRm9yd2FyZE1lc3NhZ2VzUmVxdWVzdBohLndhc2xhLnYxLkZvcndhcmRNZXNzYWdl'
    'c1Jlc3BvbnNlEkcKCkdldEhpc3RvcnkSGy53YXNsYS52MS5HZXRIaXN0b3J5UmVxdWVzdBocLn'
    'dhc2xhLnYxLkdldEhpc3RvcnlSZXNwb25zZRJKCgtHZXRNZXNzYWdlcxIcLndhc2xhLnYxLkdl'
    'dE1lc3NhZ2VzUmVxdWVzdBodLndhc2xhLnYxLkdldE1lc3NhZ2VzUmVzcG9uc2USSgoLUmVhZE'
    'hpc3RvcnkSHC53YXNsYS52MS5SZWFkSGlzdG9yeVJlcXVlc3QaHS53YXNsYS52MS5SZWFkSGlz'
    'dG9yeVJlc3BvbnNlEkQKCVNldFR5cGluZxIaLndhc2xhLnYxLlNldFR5cGluZ1JlcXVlc3QaGy'
    '53YXNsYS52MS5TZXRUeXBpbmdSZXNwb25zZRJHCgpQaW5NZXNzYWdlEhsud2FzbGEudjEuUGlu'
    'TWVzc2FnZVJlcXVlc3QaHC53YXNsYS52MS5QaW5NZXNzYWdlUmVzcG9uc2U=');
