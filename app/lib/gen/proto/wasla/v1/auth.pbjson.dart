// This is a generated file - do not edit.
//
// Generated from wasla/v1/auth.proto.

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
import 'users.pbjson.dart' as $0;

@$core.Deprecated('Use codeDeliveryDescriptor instead')
const CodeDelivery$json = {
  '1': 'CodeDelivery',
  '2': [
    {'1': 'CODE_DELIVERY_UNSPECIFIED', '2': 0},
    {'1': 'CODE_DELIVERY_SMS', '2': 1},
    {'1': 'CODE_DELIVERY_VOICE_CALL', '2': 2},
    {'1': 'CODE_DELIVERY_APP', '2': 3},
  ],
};

/// Descriptor for `CodeDelivery`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List codeDeliveryDescriptor = $convert.base64Decode(
    'CgxDb2RlRGVsaXZlcnkSHQoZQ09ERV9ERUxJVkVSWV9VTlNQRUNJRklFRBAAEhUKEUNPREVfRE'
    'VMSVZFUllfU01TEAESHAoYQ09ERV9ERUxJVkVSWV9WT0lDRV9DQUxMEAISFQoRQ09ERV9ERUxJ'
    'VkVSWV9BUFAQAw==');

@$core.Deprecated('Use pushProviderDescriptor instead')
const PushProvider$json = {
  '1': 'PushProvider',
  '2': [
    {'1': 'PUSH_PROVIDER_UNSPECIFIED', '2': 0},
    {'1': 'PUSH_PROVIDER_FCM', '2': 1},
    {'1': 'PUSH_PROVIDER_APNS', '2': 2},
    {'1': 'PUSH_PROVIDER_HMS', '2': 3},
  ],
};

/// Descriptor for `PushProvider`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List pushProviderDescriptor = $convert.base64Decode(
    'CgxQdXNoUHJvdmlkZXISHQoZUFVTSF9QUk9WSURFUl9VTlNQRUNJRklFRBAAEhUKEVBVU0hfUF'
    'JPVklERVJfRkNNEAESFgoSUFVTSF9QUk9WSURFUl9BUE5TEAISFQoRUFVTSF9QUk9WSURFUl9I'
    'TVMQAw==');

@$core.Deprecated('Use sendCodeRequestDescriptor instead')
const SendCodeRequest$json = {
  '1': 'SendCodeRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {
      '1': 'device_attestation',
      '3': 2,
      '4': 1,
      '5': 9,
      '10': 'deviceAttestation'
    },
  ],
};

/// Descriptor for `SendCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendCodeRequestDescriptor = $convert.base64Decode(
    'Cg9TZW5kQ29kZVJlcXVlc3QSFAoFcGhvbmUYASABKAlSBXBob25lEi0KEmRldmljZV9hdHRlc3'
    'RhdGlvbhgCIAEoCVIRZGV2aWNlQXR0ZXN0YXRpb24=');

@$core.Deprecated('Use sendCodeResponseDescriptor instead')
const SendCodeResponse$json = {
  '1': 'SendCodeResponse',
  '2': [
    {'1': 'code_hash', '3': 1, '4': 1, '5': 9, '10': 'codeHash'},
    {
      '1': 'delivery',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.CodeDelivery',
      '10': 'delivery'
    },
    {'1': 'code_length', '3': 3, '4': 1, '5': 5, '10': 'codeLength'},
    {
      '1': 'resend_after_seconds',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'resendAfterSeconds'
    },
    {
      '1': 'expires_in_seconds',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'expiresInSeconds'
    },
    {
      '1': 'next_delivery',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.CodeDelivery',
      '10': 'nextDelivery'
    },
    {'1': 'dev_code', '3': 7, '4': 1, '5': 9, '10': 'devCode'},
  ],
};

/// Descriptor for `SendCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sendCodeResponseDescriptor = $convert.base64Decode(
    'ChBTZW5kQ29kZVJlc3BvbnNlEhsKCWNvZGVfaGFzaBgBIAEoCVIIY29kZUhhc2gSMgoIZGVsaX'
    'ZlcnkYAiABKA4yFi53YXNsYS52MS5Db2RlRGVsaXZlcnlSCGRlbGl2ZXJ5Eh8KC2NvZGVfbGVu'
    'Z3RoGAMgASgFUgpjb2RlTGVuZ3RoEjAKFHJlc2VuZF9hZnRlcl9zZWNvbmRzGAQgASgFUhJyZX'
    'NlbmRBZnRlclNlY29uZHMSLAoSZXhwaXJlc19pbl9zZWNvbmRzGAUgASgFUhBleHBpcmVzSW5T'
    'ZWNvbmRzEjsKDW5leHRfZGVsaXZlcnkYBiABKA4yFi53YXNsYS52MS5Db2RlRGVsaXZlcnlSDG'
    '5leHREZWxpdmVyeRIZCghkZXZfY29kZRgHIAEoCVIHZGV2Q29kZQ==');

@$core.Deprecated('Use resendCodeRequestDescriptor instead')
const ResendCodeRequest$json = {
  '1': 'ResendCodeRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'code_hash', '3': 2, '4': 1, '5': 9, '10': 'codeHash'},
  ],
};

/// Descriptor for `ResendCodeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendCodeRequestDescriptor = $convert.base64Decode(
    'ChFSZXNlbmRDb2RlUmVxdWVzdBIUCgVwaG9uZRgBIAEoCVIFcGhvbmUSGwoJY29kZV9oYXNoGA'
    'IgASgJUghjb2RlSGFzaA==');

@$core.Deprecated('Use resendCodeResponseDescriptor instead')
const ResendCodeResponse$json = {
  '1': 'ResendCodeResponse',
  '2': [
    {'1': 'code_hash', '3': 1, '4': 1, '5': 9, '10': 'codeHash'},
    {
      '1': 'delivery',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.CodeDelivery',
      '10': 'delivery'
    },
    {'1': 'code_length', '3': 3, '4': 1, '5': 5, '10': 'codeLength'},
    {
      '1': 'resend_after_seconds',
      '3': 4,
      '4': 1,
      '5': 5,
      '10': 'resendAfterSeconds'
    },
    {
      '1': 'expires_in_seconds',
      '3': 5,
      '4': 1,
      '5': 5,
      '10': 'expiresInSeconds'
    },
    {
      '1': 'next_delivery',
      '3': 6,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.CodeDelivery',
      '10': 'nextDelivery'
    },
    {'1': 'dev_code', '3': 7, '4': 1, '5': 9, '10': 'devCode'},
  ],
};

/// Descriptor for `ResendCodeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resendCodeResponseDescriptor = $convert.base64Decode(
    'ChJSZXNlbmRDb2RlUmVzcG9uc2USGwoJY29kZV9oYXNoGAEgASgJUghjb2RlSGFzaBIyCghkZW'
    'xpdmVyeRgCIAEoDjIWLndhc2xhLnYxLkNvZGVEZWxpdmVyeVIIZGVsaXZlcnkSHwoLY29kZV9s'
    'ZW5ndGgYAyABKAVSCmNvZGVMZW5ndGgSMAoUcmVzZW5kX2FmdGVyX3NlY29uZHMYBCABKAVSEn'
    'Jlc2VuZEFmdGVyU2Vjb25kcxIsChJleHBpcmVzX2luX3NlY29uZHMYBSABKAVSEGV4cGlyZXNJ'
    'blNlY29uZHMSOwoNbmV4dF9kZWxpdmVyeRgGIAEoDjIWLndhc2xhLnYxLkNvZGVEZWxpdmVyeV'
    'IMbmV4dERlbGl2ZXJ5EhkKCGRldl9jb2RlGAcgASgJUgdkZXZDb2Rl');

@$core.Deprecated('Use signInRequestDescriptor instead')
const SignInRequest$json = {
  '1': 'SignInRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'code_hash', '3': 2, '4': 1, '5': 9, '10': 'codeHash'},
    {'1': 'code', '3': 3, '4': 1, '5': 9, '10': 'code'},
  ],
};

/// Descriptor for `SignInRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signInRequestDescriptor = $convert.base64Decode(
    'Cg1TaWduSW5SZXF1ZXN0EhQKBXBob25lGAEgASgJUgVwaG9uZRIbCgljb2RlX2hhc2gYAiABKA'
    'lSCGNvZGVIYXNoEhIKBGNvZGUYAyABKAlSBGNvZGU=');

@$core.Deprecated('Use signInResponseDescriptor instead')
const SignInResponse$json = {
  '1': 'SignInResponse',
  '2': [
    {
      '1': 'authorization',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Authorization',
      '9': 0,
      '10': 'authorization'
    },
    {
      '1': 'sign_up_required',
      '3': 2,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.SignUpRequired',
      '9': 0,
      '10': 'signUpRequired'
    },
    {
      '1': 'password_required',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.PasswordRequired',
      '9': 0,
      '10': 'passwordRequired'
    },
  ],
  '8': [
    {'1': 'result'},
  ],
};

/// Descriptor for `SignInResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signInResponseDescriptor = $convert.base64Decode(
    'Cg5TaWduSW5SZXNwb25zZRI/Cg1hdXRob3JpemF0aW9uGAEgASgLMhcud2FzbGEudjEuQXV0aG'
    '9yaXphdGlvbkgAUg1hdXRob3JpemF0aW9uEkQKEHNpZ25fdXBfcmVxdWlyZWQYAiABKAsyGC53'
    'YXNsYS52MS5TaWduVXBSZXF1aXJlZEgAUg5zaWduVXBSZXF1aXJlZBJJChFwYXNzd29yZF9yZX'
    'F1aXJlZBgDIAEoCzIaLndhc2xhLnYxLlBhc3N3b3JkUmVxdWlyZWRIAFIQcGFzc3dvcmRSZXF1'
    'aXJlZEIICgZyZXN1bHQ=');

@$core.Deprecated('Use authorizationDescriptor instead')
const Authorization$json = {
  '1': 'Authorization',
  '2': [
    {'1': 'session_token', '3': 1, '4': 1, '5': 9, '10': 'sessionToken'},
    {'1': 'user', '3': 2, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `Authorization`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List authorizationDescriptor = $convert.base64Decode(
    'Cg1BdXRob3JpemF0aW9uEiMKDXNlc3Npb25fdG9rZW4YASABKAlSDHNlc3Npb25Ub2tlbhIiCg'
    'R1c2VyGAIgASgLMg4ud2FzbGEudjEuVXNlclIEdXNlcg==');

@$core.Deprecated('Use signUpRequiredDescriptor instead')
const SignUpRequired$json = {
  '1': 'SignUpRequired',
  '2': [
    {'1': 'terms_version', '3': 1, '4': 1, '5': 9, '10': 'termsVersion'},
  ],
};

/// Descriptor for `SignUpRequired`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpRequiredDescriptor = $convert.base64Decode(
    'Cg5TaWduVXBSZXF1aXJlZBIjCg10ZXJtc192ZXJzaW9uGAEgASgJUgx0ZXJtc1ZlcnNpb24=');

@$core.Deprecated('Use passwordRequiredDescriptor instead')
const PasswordRequired$json = {
  '1': 'PasswordRequired',
  '2': [
    {'1': 'hint', '3': 1, '4': 1, '5': 9, '10': 'hint'},
    {'1': 'login_token', '3': 2, '4': 1, '5': 9, '10': 'loginToken'},
  ],
};

/// Descriptor for `PasswordRequired`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List passwordRequiredDescriptor = $convert.base64Decode(
    'ChBQYXNzd29yZFJlcXVpcmVkEhIKBGhpbnQYASABKAlSBGhpbnQSHwoLbG9naW5fdG9rZW4YAi'
    'ABKAlSCmxvZ2luVG9rZW4=');

@$core.Deprecated('Use signUpRequestDescriptor instead')
const SignUpRequest$json = {
  '1': 'SignUpRequest',
  '2': [
    {'1': 'phone', '3': 1, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'code_hash', '3': 2, '4': 1, '5': 9, '10': 'codeHash'},
    {'1': 'first_name', '3': 3, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 4, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'terms_version', '3': 5, '4': 1, '5': 9, '10': 'termsVersion'},
  ],
};

/// Descriptor for `SignUpRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpRequestDescriptor = $convert.base64Decode(
    'Cg1TaWduVXBSZXF1ZXN0EhQKBXBob25lGAEgASgJUgVwaG9uZRIbCgljb2RlX2hhc2gYAiABKA'
    'lSCGNvZGVIYXNoEh0KCmZpcnN0X25hbWUYAyABKAlSCWZpcnN0TmFtZRIbCglsYXN0X25hbWUY'
    'BCABKAlSCGxhc3ROYW1lEiMKDXRlcm1zX3ZlcnNpb24YBSABKAlSDHRlcm1zVmVyc2lvbg==');

@$core.Deprecated('Use signUpResponseDescriptor instead')
const SignUpResponse$json = {
  '1': 'SignUpResponse',
  '2': [
    {
      '1': 'authorization',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Authorization',
      '10': 'authorization'
    },
  ],
};

/// Descriptor for `SignUpResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List signUpResponseDescriptor = $convert.base64Decode(
    'Cg5TaWduVXBSZXNwb25zZRI9Cg1hdXRob3JpemF0aW9uGAEgASgLMhcud2FzbGEudjEuQXV0aG'
    '9yaXphdGlvblINYXV0aG9yaXphdGlvbg==');

@$core.Deprecated('Use checkPasswordRequestDescriptor instead')
const CheckPasswordRequest$json = {
  '1': 'CheckPasswordRequest',
  '2': [
    {'1': 'login_token', '3': 1, '4': 1, '5': 9, '10': 'loginToken'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `CheckPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkPasswordRequestDescriptor = $convert.base64Decode(
    'ChRDaGVja1Bhc3N3b3JkUmVxdWVzdBIfCgtsb2dpbl90b2tlbhgBIAEoCVIKbG9naW5Ub2tlbh'
    'IaCghwYXNzd29yZBgCIAEoCVIIcGFzc3dvcmQ=');

@$core.Deprecated('Use checkPasswordResponseDescriptor instead')
const CheckPasswordResponse$json = {
  '1': 'CheckPasswordResponse',
  '2': [
    {
      '1': 'authorization',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Authorization',
      '10': 'authorization'
    },
  ],
};

/// Descriptor for `CheckPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkPasswordResponseDescriptor = $convert.base64Decode(
    'ChVDaGVja1Bhc3N3b3JkUmVzcG9uc2USPQoNYXV0aG9yaXphdGlvbhgBIAEoCzIXLndhc2xhLn'
    'YxLkF1dGhvcml6YXRpb25SDWF1dGhvcml6YXRpb24=');

@$core.Deprecated('Use logOutRequestDescriptor instead')
const LogOutRequest$json = {
  '1': 'LogOutRequest',
};

/// Descriptor for `LogOutRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logOutRequestDescriptor =
    $convert.base64Decode('Cg1Mb2dPdXRSZXF1ZXN0');

@$core.Deprecated('Use logOutResponseDescriptor instead')
const LogOutResponse$json = {
  '1': 'LogOutResponse',
};

/// Descriptor for `LogOutResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logOutResponseDescriptor =
    $convert.base64Decode('Cg5Mb2dPdXRSZXNwb25zZQ==');

@$core.Deprecated('Use sessionDescriptor instead')
const Session$json = {
  '1': 'Session',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {
      '1': 'platform',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.Platform',
      '10': 'platform'
    },
    {'1': 'device_model', '3': 3, '4': 1, '5': 9, '10': 'deviceModel'},
    {'1': 'os_version', '3': 4, '4': 1, '5': 9, '10': 'osVersion'},
    {'1': 'app_version', '3': 5, '4': 1, '5': 9, '10': 'appVersion'},
    {'1': 'country_code', '3': 6, '4': 1, '5': 9, '10': 'countryCode'},
    {'1': 'created_at', '3': 7, '4': 1, '5': 3, '10': 'createdAt'},
    {'1': 'last_active_at', '3': 8, '4': 1, '5': 3, '10': 'lastActiveAt'},
    {'1': 'current', '3': 9, '4': 1, '5': 8, '10': 'current'},
  ],
};

/// Descriptor for `Session`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List sessionDescriptor = $convert.base64Decode(
    'CgdTZXNzaW9uEg4KAmlkGAEgASgDUgJpZBIuCghwbGF0Zm9ybRgCIAEoDjISLndhc2xhLnYxLl'
    'BsYXRmb3JtUghwbGF0Zm9ybRIhCgxkZXZpY2VfbW9kZWwYAyABKAlSC2RldmljZU1vZGVsEh0K'
    'Cm9zX3ZlcnNpb24YBCABKAlSCW9zVmVyc2lvbhIfCgthcHBfdmVyc2lvbhgFIAEoCVIKYXBwVm'
    'Vyc2lvbhIhCgxjb3VudHJ5X2NvZGUYBiABKAlSC2NvdW50cnlDb2RlEh0KCmNyZWF0ZWRfYXQY'
    'ByABKANSCWNyZWF0ZWRBdBIkCg5sYXN0X2FjdGl2ZV9hdBgIIAEoA1IMbGFzdEFjdGl2ZUF0Eh'
    'gKB2N1cnJlbnQYCSABKAhSB2N1cnJlbnQ=');

@$core.Deprecated('Use listSessionsRequestDescriptor instead')
const ListSessionsRequest$json = {
  '1': 'ListSessionsRequest',
};

/// Descriptor for `ListSessionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSessionsRequestDescriptor =
    $convert.base64Decode('ChNMaXN0U2Vzc2lvbnNSZXF1ZXN0');

@$core.Deprecated('Use listSessionsResponseDescriptor instead')
const ListSessionsResponse$json = {
  '1': 'ListSessionsResponse',
  '2': [
    {
      '1': 'sessions',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.Session',
      '10': 'sessions'
    },
  ],
};

/// Descriptor for `ListSessionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listSessionsResponseDescriptor = $convert.base64Decode(
    'ChRMaXN0U2Vzc2lvbnNSZXNwb25zZRItCghzZXNzaW9ucxgBIAMoCzIRLndhc2xhLnYxLlNlc3'
    'Npb25SCHNlc3Npb25z');

@$core.Deprecated('Use revokeSessionRequestDescriptor instead')
const RevokeSessionRequest$json = {
  '1': 'RevokeSessionRequest',
  '2': [
    {'1': 'session_id', '3': 1, '4': 1, '5': 3, '10': 'sessionId'},
  ],
};

/// Descriptor for `RevokeSessionRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revokeSessionRequestDescriptor = $convert.base64Decode(
    'ChRSZXZva2VTZXNzaW9uUmVxdWVzdBIdCgpzZXNzaW9uX2lkGAEgASgDUglzZXNzaW9uSWQ=');

@$core.Deprecated('Use revokeSessionResponseDescriptor instead')
const RevokeSessionResponse$json = {
  '1': 'RevokeSessionResponse',
};

/// Descriptor for `RevokeSessionResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revokeSessionResponseDescriptor =
    $convert.base64Decode('ChVSZXZva2VTZXNzaW9uUmVzcG9uc2U=');

@$core.Deprecated('Use revokeOtherSessionsRequestDescriptor instead')
const RevokeOtherSessionsRequest$json = {
  '1': 'RevokeOtherSessionsRequest',
};

/// Descriptor for `RevokeOtherSessionsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revokeOtherSessionsRequestDescriptor =
    $convert.base64Decode('ChpSZXZva2VPdGhlclNlc3Npb25zUmVxdWVzdA==');

@$core.Deprecated('Use revokeOtherSessionsResponseDescriptor instead')
const RevokeOtherSessionsResponse$json = {
  '1': 'RevokeOtherSessionsResponse',
  '2': [
    {'1': 'revoked_count', '3': 1, '4': 1, '5': 5, '10': 'revokedCount'},
  ],
};

/// Descriptor for `RevokeOtherSessionsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List revokeOtherSessionsResponseDescriptor =
    $convert.base64Decode(
        'ChtSZXZva2VPdGhlclNlc3Npb25zUmVzcG9uc2USIwoNcmV2b2tlZF9jb3VudBgBIAEoBVIMcm'
        'V2b2tlZENvdW50');

@$core.Deprecated('Use registerPushTokenRequestDescriptor instead')
const RegisterPushTokenRequest$json = {
  '1': 'RegisterPushTokenRequest',
  '2': [
    {
      '1': 'provider',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.PushProvider',
      '10': 'provider'
    },
    {'1': 'token', '3': 2, '4': 1, '5': 9, '10': 'token'},
  ],
};

/// Descriptor for `RegisterPushTokenRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPushTokenRequestDescriptor =
    $convert.base64Decode(
        'ChhSZWdpc3RlclB1c2hUb2tlblJlcXVlc3QSMgoIcHJvdmlkZXIYASABKA4yFi53YXNsYS52MS'
        '5QdXNoUHJvdmlkZXJSCHByb3ZpZGVyEhQKBXRva2VuGAIgASgJUgV0b2tlbg==');

@$core.Deprecated('Use registerPushTokenResponseDescriptor instead')
const RegisterPushTokenResponse$json = {
  '1': 'RegisterPushTokenResponse',
};

/// Descriptor for `RegisterPushTokenResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List registerPushTokenResponseDescriptor =
    $convert.base64Decode('ChlSZWdpc3RlclB1c2hUb2tlblJlc3BvbnNl');

@$core.Deprecated('Use setPasswordRequestDescriptor instead')
const SetPasswordRequest$json = {
  '1': 'SetPasswordRequest',
  '2': [
    {'1': 'current_password', '3': 1, '4': 1, '5': 9, '10': 'currentPassword'},
    {'1': 'new_password', '3': 2, '4': 1, '5': 9, '10': 'newPassword'},
    {'1': 'hint', '3': 3, '4': 1, '5': 9, '10': 'hint'},
    {'1': 'recovery_email', '3': 4, '4': 1, '5': 9, '10': 'recoveryEmail'},
  ],
};

/// Descriptor for `SetPasswordRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasswordRequestDescriptor = $convert.base64Decode(
    'ChJTZXRQYXNzd29yZFJlcXVlc3QSKQoQY3VycmVudF9wYXNzd29yZBgBIAEoCVIPY3VycmVudF'
    'Bhc3N3b3JkEiEKDG5ld19wYXNzd29yZBgCIAEoCVILbmV3UGFzc3dvcmQSEgoEaGludBgDIAEo'
    'CVIEaGludBIlCg5yZWNvdmVyeV9lbWFpbBgEIAEoCVINcmVjb3ZlcnlFbWFpbA==');

@$core.Deprecated('Use setPasswordResponseDescriptor instead')
const SetPasswordResponse$json = {
  '1': 'SetPasswordResponse',
};

/// Descriptor for `SetPasswordResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPasswordResponseDescriptor =
    $convert.base64Decode('ChNTZXRQYXNzd29yZFJlc3BvbnNl');

@$core.Deprecated('Use deleteAccountRequestDescriptor instead')
const DeleteAccountRequest$json = {
  '1': 'DeleteAccountRequest',
  '2': [
    {'1': 'reason', '3': 1, '4': 1, '5': 9, '10': 'reason'},
    {'1': 'password', '3': 2, '4': 1, '5': 9, '10': 'password'},
  ],
};

/// Descriptor for `DeleteAccountRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAccountRequestDescriptor = $convert.base64Decode(
    'ChREZWxldGVBY2NvdW50UmVxdWVzdBIWCgZyZWFzb24YASABKAlSBnJlYXNvbhIaCghwYXNzd2'
    '9yZBgCIAEoCVIIcGFzc3dvcmQ=');

@$core.Deprecated('Use deleteAccountResponseDescriptor instead')
const DeleteAccountResponse$json = {
  '1': 'DeleteAccountResponse',
};

/// Descriptor for `DeleteAccountResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteAccountResponseDescriptor =
    $convert.base64Decode('ChVEZWxldGVBY2NvdW50UmVzcG9uc2U=');

const $core.Map<$core.String, $core.dynamic> AuthServiceBase$json = {
  '1': 'AuthService',
  '2': [
    {
      '1': 'SendCode',
      '2': '.wasla.v1.SendCodeRequest',
      '3': '.wasla.v1.SendCodeResponse'
    },
    {
      '1': 'ResendCode',
      '2': '.wasla.v1.ResendCodeRequest',
      '3': '.wasla.v1.ResendCodeResponse'
    },
    {
      '1': 'SignIn',
      '2': '.wasla.v1.SignInRequest',
      '3': '.wasla.v1.SignInResponse'
    },
    {
      '1': 'SignUp',
      '2': '.wasla.v1.SignUpRequest',
      '3': '.wasla.v1.SignUpResponse'
    },
    {
      '1': 'CheckPassword',
      '2': '.wasla.v1.CheckPasswordRequest',
      '3': '.wasla.v1.CheckPasswordResponse'
    },
    {
      '1': 'LogOut',
      '2': '.wasla.v1.LogOutRequest',
      '3': '.wasla.v1.LogOutResponse'
    },
    {
      '1': 'ListSessions',
      '2': '.wasla.v1.ListSessionsRequest',
      '3': '.wasla.v1.ListSessionsResponse'
    },
    {
      '1': 'RevokeSession',
      '2': '.wasla.v1.RevokeSessionRequest',
      '3': '.wasla.v1.RevokeSessionResponse'
    },
    {
      '1': 'RevokeOtherSessions',
      '2': '.wasla.v1.RevokeOtherSessionsRequest',
      '3': '.wasla.v1.RevokeOtherSessionsResponse'
    },
    {
      '1': 'RegisterPushToken',
      '2': '.wasla.v1.RegisterPushTokenRequest',
      '3': '.wasla.v1.RegisterPushTokenResponse'
    },
    {
      '1': 'SetPassword',
      '2': '.wasla.v1.SetPasswordRequest',
      '3': '.wasla.v1.SetPasswordResponse'
    },
    {
      '1': 'DeleteAccount',
      '2': '.wasla.v1.DeleteAccountRequest',
      '3': '.wasla.v1.DeleteAccountResponse'
    },
  ],
};

@$core.Deprecated('Use authServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    AuthServiceBase$messageJson = {
  '.wasla.v1.SendCodeRequest': SendCodeRequest$json,
  '.wasla.v1.SendCodeResponse': SendCodeResponse$json,
  '.wasla.v1.ResendCodeRequest': ResendCodeRequest$json,
  '.wasla.v1.ResendCodeResponse': ResendCodeResponse$json,
  '.wasla.v1.SignInRequest': SignInRequest$json,
  '.wasla.v1.SignInResponse': SignInResponse$json,
  '.wasla.v1.Authorization': Authorization$json,
  '.wasla.v1.User': $0.User$json,
  '.wasla.v1.Avatar': $1.Avatar$json,
  '.wasla.v1.UserStatus': $0.UserStatus$json,
  '.wasla.v1.Online': $0.Online$json,
  '.wasla.v1.SignUpRequired': SignUpRequired$json,
  '.wasla.v1.PasswordRequired': PasswordRequired$json,
  '.wasla.v1.SignUpRequest': SignUpRequest$json,
  '.wasla.v1.SignUpResponse': SignUpResponse$json,
  '.wasla.v1.CheckPasswordRequest': CheckPasswordRequest$json,
  '.wasla.v1.CheckPasswordResponse': CheckPasswordResponse$json,
  '.wasla.v1.LogOutRequest': LogOutRequest$json,
  '.wasla.v1.LogOutResponse': LogOutResponse$json,
  '.wasla.v1.ListSessionsRequest': ListSessionsRequest$json,
  '.wasla.v1.ListSessionsResponse': ListSessionsResponse$json,
  '.wasla.v1.Session': Session$json,
  '.wasla.v1.RevokeSessionRequest': RevokeSessionRequest$json,
  '.wasla.v1.RevokeSessionResponse': RevokeSessionResponse$json,
  '.wasla.v1.RevokeOtherSessionsRequest': RevokeOtherSessionsRequest$json,
  '.wasla.v1.RevokeOtherSessionsResponse': RevokeOtherSessionsResponse$json,
  '.wasla.v1.RegisterPushTokenRequest': RegisterPushTokenRequest$json,
  '.wasla.v1.RegisterPushTokenResponse': RegisterPushTokenResponse$json,
  '.wasla.v1.SetPasswordRequest': SetPasswordRequest$json,
  '.wasla.v1.SetPasswordResponse': SetPasswordResponse$json,
  '.wasla.v1.DeleteAccountRequest': DeleteAccountRequest$json,
  '.wasla.v1.DeleteAccountResponse': DeleteAccountResponse$json,
};

/// Descriptor for `AuthService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List authServiceDescriptor = $convert.base64Decode(
    'CgtBdXRoU2VydmljZRJBCghTZW5kQ29kZRIZLndhc2xhLnYxLlNlbmRDb2RlUmVxdWVzdBoaLn'
    'dhc2xhLnYxLlNlbmRDb2RlUmVzcG9uc2USRwoKUmVzZW5kQ29kZRIbLndhc2xhLnYxLlJlc2Vu'
    'ZENvZGVSZXF1ZXN0Ghwud2FzbGEudjEuUmVzZW5kQ29kZVJlc3BvbnNlEjsKBlNpZ25JbhIXLn'
    'dhc2xhLnYxLlNpZ25JblJlcXVlc3QaGC53YXNsYS52MS5TaWduSW5SZXNwb25zZRI7CgZTaWdu'
    'VXASFy53YXNsYS52MS5TaWduVXBSZXF1ZXN0Ghgud2FzbGEudjEuU2lnblVwUmVzcG9uc2USUA'
    'oNQ2hlY2tQYXNzd29yZBIeLndhc2xhLnYxLkNoZWNrUGFzc3dvcmRSZXF1ZXN0Gh8ud2FzbGEu'
    'djEuQ2hlY2tQYXNzd29yZFJlc3BvbnNlEjsKBkxvZ091dBIXLndhc2xhLnYxLkxvZ091dFJlcX'
    'Vlc3QaGC53YXNsYS52MS5Mb2dPdXRSZXNwb25zZRJNCgxMaXN0U2Vzc2lvbnMSHS53YXNsYS52'
    'MS5MaXN0U2Vzc2lvbnNSZXF1ZXN0Gh4ud2FzbGEudjEuTGlzdFNlc3Npb25zUmVzcG9uc2USUA'
    'oNUmV2b2tlU2Vzc2lvbhIeLndhc2xhLnYxLlJldm9rZVNlc3Npb25SZXF1ZXN0Gh8ud2FzbGEu'
    'djEuUmV2b2tlU2Vzc2lvblJlc3BvbnNlEmIKE1Jldm9rZU90aGVyU2Vzc2lvbnMSJC53YXNsYS'
    '52MS5SZXZva2VPdGhlclNlc3Npb25zUmVxdWVzdBolLndhc2xhLnYxLlJldm9rZU90aGVyU2Vz'
    'c2lvbnNSZXNwb25zZRJcChFSZWdpc3RlclB1c2hUb2tlbhIiLndhc2xhLnYxLlJlZ2lzdGVyUH'
    'VzaFRva2VuUmVxdWVzdBojLndhc2xhLnYxLlJlZ2lzdGVyUHVzaFRva2VuUmVzcG9uc2USSgoL'
    'U2V0UGFzc3dvcmQSHC53YXNsYS52MS5TZXRQYXNzd29yZFJlcXVlc3QaHS53YXNsYS52MS5TZX'
    'RQYXNzd29yZFJlc3BvbnNlElAKDURlbGV0ZUFjY291bnQSHi53YXNsYS52MS5EZWxldGVBY2Nv'
    'dW50UmVxdWVzdBofLndhc2xhLnYxLkRlbGV0ZUFjY291bnRSZXNwb25zZQ==');
