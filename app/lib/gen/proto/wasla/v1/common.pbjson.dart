// This is a generated file - do not edit.
//
// Generated from wasla/v1/common.proto.

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

@$core.Deprecated('Use platformDescriptor instead')
const Platform$json = {
  '1': 'Platform',
  '2': [
    {'1': 'PLATFORM_UNSPECIFIED', '2': 0},
    {'1': 'PLATFORM_ANDROID', '2': 1},
    {'1': 'PLATFORM_IOS', '2': 2},
    {'1': 'PLATFORM_WEB', '2': 3},
    {'1': 'PLATFORM_WINDOWS', '2': 4},
    {'1': 'PLATFORM_MACOS', '2': 5},
    {'1': 'PLATFORM_LINUX', '2': 6},
  ],
};

/// Descriptor for `Platform`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List platformDescriptor = $convert.base64Decode(
    'CghQbGF0Zm9ybRIYChRQTEFURk9STV9VTlNQRUNJRklFRBAAEhQKEFBMQVRGT1JNX0FORFJPSU'
    'QQARIQCgxQTEFURk9STV9JT1MQAhIQCgxQTEFURk9STV9XRUIQAxIUChBQTEFURk9STV9XSU5E'
    'T1dTEAQSEgoOUExBVEZPUk1fTUFDT1MQBRISCg5QTEFURk9STV9MSU5VWBAG');

@$core.Deprecated('Use peerDescriptor instead')
const Peer$json = {
  '1': 'Peer',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '9': 0, '10': 'userId'},
    {'1': 'chat_id', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'chatId'},
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `Peer`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List peerDescriptor = $convert.base64Decode(
    'CgRQZWVyEhkKB3VzZXJfaWQYASABKANIAFIGdXNlcklkEhkKB2NoYXRfaWQYAiABKANIAFIGY2'
    'hhdElkQgYKBGtpbmQ=');

@$core.Deprecated('Use messageRefDescriptor instead')
const MessageRef$json = {
  '1': 'MessageRef',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seq', '3': 2, '4': 1, '5': 3, '10': 'seq'},
  ],
};

/// Descriptor for `MessageRef`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List messageRefDescriptor = $convert.base64Decode(
    'CgpNZXNzYWdlUmVmEhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBIQCgNzZXEYAiABKANSA3NlcQ'
    '==');

@$core.Deprecated('Use avatarDescriptor instead')
const Avatar$json = {
  '1': 'Avatar',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 3, '10': 'mediaId'},
    {'1': 'thumbhash', '3': 2, '4': 1, '5': 12, '10': 'thumbhash'},
  ],
};

/// Descriptor for `Avatar`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List avatarDescriptor = $convert.base64Decode(
    'CgZBdmF0YXISGQoIbWVkaWFfaWQYASABKANSB21lZGlhSWQSHAoJdGh1bWJoYXNoGAIgASgMUg'
    'l0aHVtYmhhc2g=');
