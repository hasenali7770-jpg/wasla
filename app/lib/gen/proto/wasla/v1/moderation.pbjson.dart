// This is a generated file - do not edit.
//
// Generated from wasla/v1/moderation.proto.

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

@$core.Deprecated('Use reportReasonDescriptor instead')
const ReportReason$json = {
  '1': 'ReportReason',
  '2': [
    {'1': 'REPORT_REASON_UNSPECIFIED', '2': 0},
    {'1': 'REPORT_REASON_SPAM', '2': 1},
    {'1': 'REPORT_REASON_SCAM', '2': 2},
    {'1': 'REPORT_REASON_VIOLENCE', '2': 3},
    {'1': 'REPORT_REASON_TERRORISM', '2': 4},
    {'1': 'REPORT_REASON_CHILD_ABUSE', '2': 5},
    {'1': 'REPORT_REASON_PORNOGRAPHY', '2': 6},
    {'1': 'REPORT_REASON_ILLEGAL_GOODS', '2': 7},
    {'1': 'REPORT_REASON_PERSONAL_DATA', '2': 8},
    {'1': 'REPORT_REASON_HARASSMENT', '2': 9},
    {'1': 'REPORT_REASON_FAKE_ACCOUNT', '2': 10},
    {'1': 'REPORT_REASON_COPYRIGHT', '2': 11},
    {'1': 'REPORT_REASON_OTHER', '2': 12},
  ],
};

/// Descriptor for `ReportReason`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List reportReasonDescriptor = $convert.base64Decode(
    'CgxSZXBvcnRSZWFzb24SHQoZUkVQT1JUX1JFQVNPTl9VTlNQRUNJRklFRBAAEhYKElJFUE9SVF'
    '9SRUFTT05fU1BBTRABEhYKElJFUE9SVF9SRUFTT05fU0NBTRACEhoKFlJFUE9SVF9SRUFTT05f'
    'VklPTEVOQ0UQAxIbChdSRVBPUlRfUkVBU09OX1RFUlJPUklTTRAEEh0KGVJFUE9SVF9SRUFTT0'
    '5fQ0hJTERfQUJVU0UQBRIdChlSRVBPUlRfUkVBU09OX1BPUk5PR1JBUEhZEAYSHwobUkVQT1JU'
    'X1JFQVNPTl9JTExFR0FMX0dPT0RTEAcSHwobUkVQT1JUX1JFQVNPTl9QRVJTT05BTF9EQVRBEA'
    'gSHAoYUkVQT1JUX1JFQVNPTl9IQVJBU1NNRU5UEAkSHgoaUkVQT1JUX1JFQVNPTl9GQUtFX0FD'
    'Q09VTlQQChIbChdSRVBPUlRfUkVBU09OX0NPUFlSSUdIVBALEhcKE1JFUE9SVF9SRUFTT05fT1'
    'RIRVIQDA==');

@$core.Deprecated('Use reportedMessagesDescriptor instead')
const ReportedMessages$json = {
  '1': 'ReportedMessages',
  '2': [
    {'1': 'chat_id', '3': 1, '4': 1, '5': 3, '10': 'chatId'},
    {'1': 'seqs', '3': 2, '4': 3, '5': 3, '10': 'seqs'},
  ],
};

/// Descriptor for `ReportedMessages`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportedMessagesDescriptor = $convert.base64Decode(
    'ChBSZXBvcnRlZE1lc3NhZ2VzEhcKB2NoYXRfaWQYASABKANSBmNoYXRJZBISCgRzZXFzGAIgAy'
    'gDUgRzZXFz');

@$core.Deprecated('Use reportRequestDescriptor instead')
const ReportRequest$json = {
  '1': 'ReportRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '9': 0, '10': 'userId'},
    {'1': 'chat_id', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'chatId'},
    {
      '1': 'messages',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.ReportedMessages',
      '9': 0,
      '10': 'messages'
    },
    {
      '1': 'reason',
      '3': 4,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.ReportReason',
      '10': 'reason'
    },
    {'1': 'comment', '3': 5, '4': 1, '5': 9, '10': 'comment'},
    {'1': 'block', '3': 6, '4': 1, '5': 8, '10': 'block'},
  ],
  '8': [
    {'1': 'target'},
  ],
};

/// Descriptor for `ReportRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportRequestDescriptor = $convert.base64Decode(
    'Cg1SZXBvcnRSZXF1ZXN0EhkKB3VzZXJfaWQYASABKANIAFIGdXNlcklkEhkKB2NoYXRfaWQYAi'
    'ABKANIAFIGY2hhdElkEjgKCG1lc3NhZ2VzGAMgASgLMhoud2FzbGEudjEuUmVwb3J0ZWRNZXNz'
    'YWdlc0gAUghtZXNzYWdlcxIuCgZyZWFzb24YBCABKA4yFi53YXNsYS52MS5SZXBvcnRSZWFzb2'
    '5SBnJlYXNvbhIYCgdjb21tZW50GAUgASgJUgdjb21tZW50EhQKBWJsb2NrGAYgASgIUgVibG9j'
    'a0IICgZ0YXJnZXQ=');

@$core.Deprecated('Use reportResponseDescriptor instead')
const ReportResponse$json = {
  '1': 'ReportResponse',
  '2': [
    {'1': 'report_id', '3': 1, '4': 1, '5': 3, '10': 'reportId'},
  ],
};

/// Descriptor for `ReportResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List reportResponseDescriptor = $convert.base64Decode(
    'Cg5SZXBvcnRSZXNwb25zZRIbCglyZXBvcnRfaWQYASABKANSCHJlcG9ydElk');

const $core.Map<$core.String, $core.dynamic> ModerationServiceBase$json = {
  '1': 'ModerationService',
  '2': [
    {
      '1': 'Report',
      '2': '.wasla.v1.ReportRequest',
      '3': '.wasla.v1.ReportResponse'
    },
  ],
};

@$core.Deprecated('Use moderationServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    ModerationServiceBase$messageJson = {
  '.wasla.v1.ReportRequest': ReportRequest$json,
  '.wasla.v1.ReportedMessages': ReportedMessages$json,
  '.wasla.v1.ReportResponse': ReportResponse$json,
};

/// Descriptor for `ModerationService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List moderationServiceDescriptor = $convert.base64Decode(
    'ChFNb2RlcmF0aW9uU2VydmljZRI7CgZSZXBvcnQSFy53YXNsYS52MS5SZXBvcnRSZXF1ZXN0Gh'
    'gud2FzbGEudjEuUmVwb3J0UmVzcG9uc2U=');
