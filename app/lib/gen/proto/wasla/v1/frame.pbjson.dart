// This is a generated file - do not edit.
//
// Generated from wasla/v1/frame.proto.

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

@$core.Deprecated('Use errorCodeDescriptor instead')
const ErrorCode$json = {
  '1': 'ErrorCode',
  '2': [
    {'1': 'ERROR_CODE_UNSPECIFIED', '2': 0},
    {'1': 'ERROR_CODE_INVALID_ARGUMENT', '2': 1},
    {'1': 'ERROR_CODE_UNAUTHENTICATED', '2': 2},
    {'1': 'ERROR_CODE_PERMISSION_DENIED', '2': 3},
    {'1': 'ERROR_CODE_NOT_FOUND', '2': 4},
    {'1': 'ERROR_CODE_ALREADY_EXISTS', '2': 5},
    {'1': 'ERROR_CODE_RATE_LIMITED', '2': 6},
    {'1': 'ERROR_CODE_INTERNAL', '2': 7},
    {'1': 'ERROR_CODE_UNAVAILABLE', '2': 8},
    {'1': 'ERROR_CODE_UNIMPLEMENTED', '2': 9},
    {'1': 'ERROR_CODE_UPDATE_REQUIRED', '2': 10},
    {'1': 'ERROR_CODE_PHONE_INVALID', '2': 20},
    {'1': 'ERROR_CODE_PHONE_CODE_INVALID', '2': 21},
    {'1': 'ERROR_CODE_PHONE_CODE_EXPIRED', '2': 22},
    {'1': 'ERROR_CODE_PHONE_BANNED', '2': 23},
    {'1': 'ERROR_CODE_PASSWORD_INVALID', '2': 24},
    {'1': 'ERROR_CODE_SESSION_REVOKED', '2': 25},
    {'1': 'ERROR_CODE_USERNAME_INVALID', '2': 30},
    {'1': 'ERROR_CODE_USERNAME_TAKEN', '2': 31},
    {'1': 'ERROR_CODE_PEER_BLOCKED', '2': 32},
    {'1': 'ERROR_CODE_PRIVACY_RESTRICTED', '2': 33},
    {'1': 'ERROR_CODE_MESSAGE_TOO_LONG', '2': 40},
    {'1': 'ERROR_CODE_MESSAGE_EDIT_EXPIRED', '2': 41},
    {'1': 'ERROR_CODE_CHAT_MEMBER_LIMIT', '2': 42},
    {'1': 'ERROR_CODE_CHAT_WRITE_FORBIDDEN', '2': 43},
    {'1': 'ERROR_CODE_INVITE_INVALID', '2': 44},
    {'1': 'ERROR_CODE_FILE_TOO_LARGE', '2': 50},
    {'1': 'ERROR_CODE_UPLOAD_INCOMPLETE', '2': 51},
  ],
};

/// Descriptor for `ErrorCode`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List errorCodeDescriptor = $convert.base64Decode(
    'CglFcnJvckNvZGUSGgoWRVJST1JfQ09ERV9VTlNQRUNJRklFRBAAEh8KG0VSUk9SX0NPREVfSU'
    '5WQUxJRF9BUkdVTUVOVBABEh4KGkVSUk9SX0NPREVfVU5BVVRIRU5USUNBVEVEEAISIAocRVJS'
    'T1JfQ09ERV9QRVJNSVNTSU9OX0RFTklFRBADEhgKFEVSUk9SX0NPREVfTk9UX0ZPVU5EEAQSHQ'
    'oZRVJST1JfQ09ERV9BTFJFQURZX0VYSVNUUxAFEhsKF0VSUk9SX0NPREVfUkFURV9MSU1JVEVE'
    'EAYSFwoTRVJST1JfQ09ERV9JTlRFUk5BTBAHEhoKFkVSUk9SX0NPREVfVU5BVkFJTEFCTEUQCB'
    'IcChhFUlJPUl9DT0RFX1VOSU1QTEVNRU5URUQQCRIeChpFUlJPUl9DT0RFX1VQREFURV9SRVFV'
    'SVJFRBAKEhwKGEVSUk9SX0NPREVfUEhPTkVfSU5WQUxJRBAUEiEKHUVSUk9SX0NPREVfUEhPTk'
    'VfQ09ERV9JTlZBTElEEBUSIQodRVJST1JfQ09ERV9QSE9ORV9DT0RFX0VYUElSRUQQFhIbChdF'
    'UlJPUl9DT0RFX1BIT05FX0JBTk5FRBAXEh8KG0VSUk9SX0NPREVfUEFTU1dPUkRfSU5WQUxJRB'
    'AYEh4KGkVSUk9SX0NPREVfU0VTU0lPTl9SRVZPS0VEEBkSHwobRVJST1JfQ09ERV9VU0VSTkFN'
    'RV9JTlZBTElEEB4SHQoZRVJST1JfQ09ERV9VU0VSTkFNRV9UQUtFThAfEhsKF0VSUk9SX0NPRE'
    'VfUEVFUl9CTE9DS0VEECASIQodRVJST1JfQ09ERV9QUklWQUNZX1JFU1RSSUNURUQQIRIfChtF'
    'UlJPUl9DT0RFX01FU1NBR0VfVE9PX0xPTkcQKBIjCh9FUlJPUl9DT0RFX01FU1NBR0VfRURJVF'
    '9FWFBJUkVEECkSIAocRVJST1JfQ09ERV9DSEFUX01FTUJFUl9MSU1JVBAqEiMKH0VSUk9SX0NP'
    'REVfQ0hBVF9XUklURV9GT1JCSURERU4QKxIdChlFUlJPUl9DT0RFX0lOVklURV9JTlZBTElEEC'
    'wSHQoZRVJST1JfQ09ERV9GSUxFX1RPT19MQVJHRRAyEiAKHEVSUk9SX0NPREVfVVBMT0FEX0lO'
    'Q09NUExFVEUQMw==');

@$core.Deprecated('Use frameDescriptor instead')
const Frame$json = {
  '1': 'Frame',
  '2': [
    {
      '1': 'request',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.RpcRequest',
      '9': 0,
      '10': 'request'
    },
    {
      '1': 'response',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.RpcResponse',
      '9': 0,
      '10': 'response'
    },
    {
      '1': 'updates',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.UpdatesPush',
      '9': 0,
      '10': 'updates'
    },
    {
      '1': 'ping',
      '3': 4,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Ping',
      '9': 0,
      '10': 'ping'
    },
    {
      '1': 'pong',
      '3': 5,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Pong',
      '9': 0,
      '10': 'pong'
    },
    {
      '1': 'hello',
      '3': 6,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Hello',
      '9': 0,
      '10': 'hello'
    },
    {
      '1': 'hello_ack',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.HelloAck',
      '9': 0,
      '10': 'helloAck'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `Frame`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List frameDescriptor = $convert.base64Decode(
    'CgVGcmFtZRIwCgdyZXF1ZXN0GAEgASgLMhQud2FzbGEudjEuUnBjUmVxdWVzdEgAUgdyZXF1ZX'
    'N0EjMKCHJlc3BvbnNlGAIgASgLMhUud2FzbGEudjEuUnBjUmVzcG9uc2VIAFIIcmVzcG9uc2US'
    'MQoHdXBkYXRlcxgDIAEoCzIVLndhc2xhLnYxLlVwZGF0ZXNQdXNoSABSB3VwZGF0ZXMSJAoEcG'
    'luZxgEIAEoCzIOLndhc2xhLnYxLlBpbmdIAFIEcGluZxIkCgRwb25nGAUgASgLMg4ud2FzbGEu'
    'djEuUG9uZ0gAUgRwb25nEicKBWhlbGxvGAYgASgLMg8ud2FzbGEudjEuSGVsbG9IAFIFaGVsbG'
    '8SMQoJaGVsbG9fYWNrGAcgASgLMhIud2FzbGEudjEuSGVsbG9BY2tIAFIIaGVsbG9BY2tCBgoE'
    'a2luZA==');

@$core.Deprecated('Use helloDescriptor instead')
const Hello$json = {
  '1': 'Hello',
  '2': [
    {'1': 'protocol_version', '3': 1, '4': 1, '5': 5, '10': 'protocolVersion'},
    {'1': 'session_token', '3': 2, '4': 1, '5': 9, '10': 'sessionToken'},
    {
      '1': 'platform',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.Platform',
      '10': 'platform'
    },
    {'1': 'app_version', '3': 4, '4': 1, '5': 9, '10': 'appVersion'},
    {'1': 'device_model', '3': 5, '4': 1, '5': 9, '10': 'deviceModel'},
    {'1': 'os_version', '3': 6, '4': 1, '5': 9, '10': 'osVersion'},
    {'1': 'lang_code', '3': 7, '4': 1, '5': 9, '10': 'langCode'},
  ],
};

/// Descriptor for `Hello`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloDescriptor = $convert.base64Decode(
    'CgVIZWxsbxIpChBwcm90b2NvbF92ZXJzaW9uGAEgASgFUg9wcm90b2NvbFZlcnNpb24SIwoNc2'
    'Vzc2lvbl90b2tlbhgCIAEoCVIMc2Vzc2lvblRva2VuEi4KCHBsYXRmb3JtGAMgASgOMhIud2Fz'
    'bGEudjEuUGxhdGZvcm1SCHBsYXRmb3JtEh8KC2FwcF92ZXJzaW9uGAQgASgJUgphcHBWZXJzaW'
    '9uEiEKDGRldmljZV9tb2RlbBgFIAEoCVILZGV2aWNlTW9kZWwSHQoKb3NfdmVyc2lvbhgGIAEo'
    'CVIJb3NWZXJzaW9uEhsKCWxhbmdfY29kZRgHIAEoCVIIbGFuZ0NvZGU=');

@$core.Deprecated('Use helloAckDescriptor instead')
const HelloAck$json = {
  '1': 'HelloAck',
  '2': [
    {'1': 'server_time', '3': 1, '4': 1, '5': 3, '10': 'serverTime'},
    {'1': 'authenticated', '3': 2, '4': 1, '5': 8, '10': 'authenticated'},
    {'1': 'user_id', '3': 3, '4': 1, '5': 3, '10': 'userId'},
    {'1': 'min_app_version', '3': 4, '4': 1, '5': 9, '10': 'minAppVersion'},
  ],
};

/// Descriptor for `HelloAck`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List helloAckDescriptor = $convert.base64Decode(
    'CghIZWxsb0FjaxIfCgtzZXJ2ZXJfdGltZRgBIAEoA1IKc2VydmVyVGltZRIkCg1hdXRoZW50aW'
    'NhdGVkGAIgASgIUg1hdXRoZW50aWNhdGVkEhcKB3VzZXJfaWQYAyABKANSBnVzZXJJZBImCg9t'
    'aW5fYXBwX3ZlcnNpb24YBCABKAlSDW1pbkFwcFZlcnNpb24=');

@$core.Deprecated('Use rpcRequestDescriptor instead')
const RpcRequest$json = {
  '1': 'RpcRequest',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'method', '3': 2, '4': 1, '5': 9, '10': 'method'},
    {'1': 'payload', '3': 3, '4': 1, '5': 12, '10': 'payload'},
  ],
};

/// Descriptor for `RpcRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcRequestDescriptor = $convert.base64Decode(
    'CgpScGNSZXF1ZXN0Eg4KAmlkGAEgASgEUgJpZBIWCgZtZXRob2QYAiABKAlSBm1ldGhvZBIYCg'
    'dwYXlsb2FkGAMgASgMUgdwYXlsb2Fk');

@$core.Deprecated('Use rpcResponseDescriptor instead')
const RpcResponse$json = {
  '1': 'RpcResponse',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    {'1': 'payload', '3': 2, '4': 1, '5': 12, '9': 0, '10': 'payload'},
    {
      '1': 'error',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Error',
      '9': 0,
      '10': 'error'
    },
  ],
  '8': [
    {'1': 'result'},
  ],
};

/// Descriptor for `RpcResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List rpcResponseDescriptor = $convert.base64Decode(
    'CgtScGNSZXNwb25zZRIOCgJpZBgBIAEoBFICaWQSGgoHcGF5bG9hZBgCIAEoDEgAUgdwYXlsb2'
    'FkEicKBWVycm9yGAMgASgLMg8ud2FzbGEudjEuRXJyb3JIAFIFZXJyb3JCCAoGcmVzdWx0');

@$core.Deprecated('Use errorDescriptor instead')
const Error$json = {
  '1': 'Error',
  '2': [
    {
      '1': 'code',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.ErrorCode',
      '10': 'code'
    },
    {'1': 'message', '3': 2, '4': 1, '5': 9, '10': 'message'},
    {
      '1': 'retry_after_seconds',
      '3': 3,
      '4': 1,
      '5': 5,
      '10': 'retryAfterSeconds'
    },
    {
      '1': 'details',
      '3': 4,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Error.DetailsEntry',
      '10': 'details'
    },
  ],
  '3': [Error_DetailsEntry$json],
};

@$core.Deprecated('Use errorDescriptor instead')
const Error_DetailsEntry$json = {
  '1': 'DetailsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `Error`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List errorDescriptor = $convert.base64Decode(
    'CgVFcnJvchInCgRjb2RlGAEgASgOMhMud2FzbGEudjEuRXJyb3JDb2RlUgRjb2RlEhgKB21lc3'
    'NhZ2UYAiABKAlSB21lc3NhZ2USLgoTcmV0cnlfYWZ0ZXJfc2Vjb25kcxgDIAEoBVIRcmV0cnlB'
    'ZnRlclNlY29uZHMSNgoHZGV0YWlscxgEIAMoCzIcLndhc2xhLnYxLkVycm9yLkRldGFpbHNFbn'
    'RyeVIHZGV0YWlscxo6CgxEZXRhaWxzRW50cnkSEAoDa2V5GAEgASgJUgNrZXkSFAoFdmFsdWUY'
    'AiABKAlSBXZhbHVlOgI4AQ==');

@$core.Deprecated('Use pingDescriptor instead')
const Ping$json = {
  '1': 'Ping',
  '2': [
    {'1': 'nonce', '3': 1, '4': 1, '5': 4, '10': 'nonce'},
  ],
};

/// Descriptor for `Ping`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pingDescriptor =
    $convert.base64Decode('CgRQaW5nEhQKBW5vbmNlGAEgASgEUgVub25jZQ==');

@$core.Deprecated('Use pongDescriptor instead')
const Pong$json = {
  '1': 'Pong',
  '2': [
    {'1': 'nonce', '3': 1, '4': 1, '5': 4, '10': 'nonce'},
  ],
};

/// Descriptor for `Pong`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List pongDescriptor =
    $convert.base64Decode('CgRQb25nEhQKBW5vbmNlGAEgASgEUgVub25jZQ==');
