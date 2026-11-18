// This is a generated file - do not edit.
//
// Generated from wasla/v1/users.proto.

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

@$core.Deprecated('Use lastSeenApproxDescriptor instead')
const LastSeenApprox$json = {
  '1': 'LastSeenApprox',
  '2': [
    {'1': 'LAST_SEEN_APPROX_UNSPECIFIED', '2': 0},
    {'1': 'LAST_SEEN_APPROX_RECENTLY', '2': 1},
    {'1': 'LAST_SEEN_APPROX_WITHIN_WEEK', '2': 2},
    {'1': 'LAST_SEEN_APPROX_WITHIN_MONTH', '2': 3},
    {'1': 'LAST_SEEN_APPROX_LONG_AGO', '2': 4},
  ],
};

/// Descriptor for `LastSeenApprox`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List lastSeenApproxDescriptor = $convert.base64Decode(
    'Cg5MYXN0U2VlbkFwcHJveBIgChxMQVNUX1NFRU5fQVBQUk9YX1VOU1BFQ0lGSUVEEAASHQoZTE'
    'FTVF9TRUVOX0FQUFJPWF9SRUNFTlRMWRABEiAKHExBU1RfU0VFTl9BUFBST1hfV0lUSElOX1dF'
    'RUsQAhIhCh1MQVNUX1NFRU5fQVBQUk9YX1dJVEhJTl9NT05USBADEh0KGUxBU1RfU0VFTl9BUF'
    'BST1hfTE9OR19BR08QBA==');

@$core.Deprecated('Use privacyKeyDescriptor instead')
const PrivacyKey$json = {
  '1': 'PrivacyKey',
  '2': [
    {'1': 'PRIVACY_KEY_UNSPECIFIED', '2': 0},
    {'1': 'PRIVACY_KEY_PHONE_NUMBER', '2': 1},
    {'1': 'PRIVACY_KEY_LAST_SEEN', '2': 2},
    {'1': 'PRIVACY_KEY_PROFILE_PHOTO', '2': 3},
    {'1': 'PRIVACY_KEY_GROUP_INVITES', '2': 4},
    {'1': 'PRIVACY_KEY_FORWARDS', '2': 5},
    {'1': 'PRIVACY_KEY_CALLS', '2': 6},
  ],
};

/// Descriptor for `PrivacyKey`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List privacyKeyDescriptor = $convert.base64Decode(
    'CgpQcml2YWN5S2V5EhsKF1BSSVZBQ1lfS0VZX1VOU1BFQ0lGSUVEEAASHAoYUFJJVkFDWV9LRV'
    'lfUEhPTkVfTlVNQkVSEAESGQoVUFJJVkFDWV9LRVlfTEFTVF9TRUVOEAISHQoZUFJJVkFDWV9L'
    'RVlfUFJPRklMRV9QSE9UTxADEh0KGVBSSVZBQ1lfS0VZX0dST1VQX0lOVklURVMQBBIYChRQUk'
    'lWQUNZX0tFWV9GT1JXQVJEUxAFEhUKEVBSSVZBQ1lfS0VZX0NBTExTEAY=');

@$core.Deprecated('Use privacyRuleDescriptor instead')
const PrivacyRule$json = {
  '1': 'PrivacyRule',
  '2': [
    {'1': 'PRIVACY_RULE_UNSPECIFIED', '2': 0},
    {'1': 'PRIVACY_RULE_EVERYBODY', '2': 1},
    {'1': 'PRIVACY_RULE_CONTACTS', '2': 2},
    {'1': 'PRIVACY_RULE_NOBODY', '2': 3},
  ],
};

/// Descriptor for `PrivacyRule`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List privacyRuleDescriptor = $convert.base64Decode(
    'CgtQcml2YWN5UnVsZRIcChhQUklWQUNZX1JVTEVfVU5TUEVDSUZJRUQQABIaChZQUklWQUNZX1'
    'JVTEVfRVZFUllCT0RZEAESGQoVUFJJVkFDWV9SVUxFX0NPTlRBQ1RTEAISFwoTUFJJVkFDWV9S'
    'VUxFX05PQk9EWRAD');

@$core.Deprecated('Use userDescriptor instead')
const User$json = {
  '1': 'User',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {'1': 'first_name', '3': 2, '4': 1, '5': 9, '10': 'firstName'},
    {'1': 'last_name', '3': 3, '4': 1, '5': 9, '10': 'lastName'},
    {'1': 'username', '3': 4, '4': 1, '5': 9, '10': 'username'},
    {'1': 'phone', '3': 5, '4': 1, '5': 9, '10': 'phone'},
    {'1': 'bio', '3': 6, '4': 1, '5': 9, '10': 'bio'},
    {
      '1': 'photo',
      '3': 7,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Avatar',
      '10': 'photo'
    },
    {
      '1': 'status',
      '3': 8,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.UserStatus',
      '10': 'status'
    },
    {'1': 'is_self', '3': 9, '4': 1, '5': 8, '10': 'isSelf'},
    {'1': 'is_contact', '3': 10, '4': 1, '5': 8, '10': 'isContact'},
    {
      '1': 'is_mutual_contact',
      '3': 11,
      '4': 1,
      '5': 8,
      '10': 'isMutualContact'
    },
    {'1': 'is_blocked', '3': 12, '4': 1, '5': 8, '10': 'isBlocked'},
    {'1': 'is_deleted', '3': 13, '4': 1, '5': 8, '10': 'isDeleted'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode(
    'CgRVc2VyEg4KAmlkGAEgASgDUgJpZBIdCgpmaXJzdF9uYW1lGAIgASgJUglmaXJzdE5hbWUSGw'
    'oJbGFzdF9uYW1lGAMgASgJUghsYXN0TmFtZRIaCgh1c2VybmFtZRgEIAEoCVIIdXNlcm5hbWUS'
    'FAoFcGhvbmUYBSABKAlSBXBob25lEhAKA2JpbxgGIAEoCVIDYmlvEiYKBXBob3RvGAcgASgLMh'
    'Aud2FzbGEudjEuQXZhdGFyUgVwaG90bxIsCgZzdGF0dXMYCCABKAsyFC53YXNsYS52MS5Vc2Vy'
    'U3RhdHVzUgZzdGF0dXMSFwoHaXNfc2VsZhgJIAEoCFIGaXNTZWxmEh0KCmlzX2NvbnRhY3QYCi'
    'ABKAhSCWlzQ29udGFjdBIqChFpc19tdXR1YWxfY29udGFjdBgLIAEoCFIPaXNNdXR1YWxDb250'
    'YWN0Eh0KCmlzX2Jsb2NrZWQYDCABKAhSCWlzQmxvY2tlZBIdCgppc19kZWxldGVkGA0gASgIUg'
    'lpc0RlbGV0ZWQ=');

@$core.Deprecated('Use userStatusDescriptor instead')
const UserStatus$json = {
  '1': 'UserStatus',
  '2': [
    {
      '1': 'online',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Online',
      '9': 0,
      '10': 'online'
    },
    {'1': 'last_seen_at', '3': 2, '4': 1, '5': 3, '9': 0, '10': 'lastSeenAt'},
    {
      '1': 'approx',
      '3': 3,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.LastSeenApprox',
      '9': 0,
      '10': 'approx'
    },
  ],
  '8': [
    {'1': 'kind'},
  ],
};

/// Descriptor for `UserStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userStatusDescriptor = $convert.base64Decode(
    'CgpVc2VyU3RhdHVzEioKBm9ubGluZRgBIAEoCzIQLndhc2xhLnYxLk9ubGluZUgAUgZvbmxpbm'
    'USIgoMbGFzdF9zZWVuX2F0GAIgASgDSABSCmxhc3RTZWVuQXQSMgoGYXBwcm94GAMgASgOMhgu'
    'd2FzbGEudjEuTGFzdFNlZW5BcHByb3hIAFIGYXBwcm94QgYKBGtpbmQ=');

@$core.Deprecated('Use onlineDescriptor instead')
const Online$json = {
  '1': 'Online',
  '2': [
    {'1': 'expires_at', '3': 1, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `Online`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List onlineDescriptor = $convert
    .base64Decode('CgZPbmxpbmUSHQoKZXhwaXJlc19hdBgBIAEoA1IJZXhwaXJlc0F0');

@$core.Deprecated('Use privacySettingDescriptor instead')
const PrivacySetting$json = {
  '1': 'PrivacySetting',
  '2': [
    {
      '1': 'key',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.PrivacyKey',
      '10': 'key'
    },
    {
      '1': 'rule',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.PrivacyRule',
      '10': 'rule'
    },
    {
      '1': 'always_allow_user_ids',
      '3': 3,
      '4': 3,
      '5': 3,
      '10': 'alwaysAllowUserIds'
    },
    {
      '1': 'never_allow_user_ids',
      '3': 4,
      '4': 3,
      '5': 3,
      '10': 'neverAllowUserIds'
    },
  ],
};

/// Descriptor for `PrivacySetting`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List privacySettingDescriptor = $convert.base64Decode(
    'Cg5Qcml2YWN5U2V0dGluZxImCgNrZXkYASABKA4yFC53YXNsYS52MS5Qcml2YWN5S2V5UgNrZX'
    'kSKQoEcnVsZRgCIAEoDjIVLndhc2xhLnYxLlByaXZhY3lSdWxlUgRydWxlEjEKFWFsd2F5c19h'
    'bGxvd191c2VyX2lkcxgDIAMoA1ISYWx3YXlzQWxsb3dVc2VySWRzEi8KFG5ldmVyX2FsbG93X3'
    'VzZXJfaWRzGAQgAygDUhFuZXZlckFsbG93VXNlcklkcw==');

@$core.Deprecated('Use getMeRequestDescriptor instead')
const GetMeRequest$json = {
  '1': 'GetMeRequest',
};

/// Descriptor for `GetMeRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeRequestDescriptor =
    $convert.base64Decode('CgxHZXRNZVJlcXVlc3Q=');

@$core.Deprecated('Use getMeResponseDescriptor instead')
const GetMeResponse$json = {
  '1': 'GetMeResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `GetMeResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getMeResponseDescriptor = $convert.base64Decode(
    'Cg1HZXRNZVJlc3BvbnNlEiIKBHVzZXIYASABKAsyDi53YXNsYS52MS5Vc2VyUgR1c2Vy');

@$core.Deprecated('Use getUsersRequestDescriptor instead')
const GetUsersRequest$json = {
  '1': 'GetUsersRequest',
  '2': [
    {'1': 'user_ids', '3': 1, '4': 3, '5': 3, '10': 'userIds'},
  ],
};

/// Descriptor for `GetUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUsersRequestDescriptor = $convert.base64Decode(
    'Cg9HZXRVc2Vyc1JlcXVlc3QSGQoIdXNlcl9pZHMYASADKANSB3VzZXJJZHM=');

@$core.Deprecated('Use getUsersResponseDescriptor instead')
const GetUsersResponse$json = {
  '1': 'GetUsersResponse',
  '2': [
    {
      '1': 'users',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
  ],
};

/// Descriptor for `GetUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUsersResponseDescriptor = $convert.base64Decode(
    'ChBHZXRVc2Vyc1Jlc3BvbnNlEiQKBXVzZXJzGAEgAygLMg4ud2FzbGEudjEuVXNlclIFdXNlcn'
    'M=');

@$core.Deprecated('Use updateProfileRequestDescriptor instead')
const UpdateProfileRequest$json = {
  '1': 'UpdateProfileRequest',
  '2': [
    {
      '1': 'first_name',
      '3': 1,
      '4': 1,
      '5': 9,
      '9': 0,
      '10': 'firstName',
      '17': true
    },
    {
      '1': 'last_name',
      '3': 2,
      '4': 1,
      '5': 9,
      '9': 1,
      '10': 'lastName',
      '17': true
    },
    {'1': 'bio', '3': 3, '4': 1, '5': 9, '9': 2, '10': 'bio', '17': true},
  ],
  '8': [
    {'1': '_first_name'},
    {'1': '_last_name'},
    {'1': '_bio'},
  ],
};

/// Descriptor for `UpdateProfileRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProfileRequestDescriptor = $convert.base64Decode(
    'ChRVcGRhdGVQcm9maWxlUmVxdWVzdBIiCgpmaXJzdF9uYW1lGAEgASgJSABSCWZpcnN0TmFtZY'
    'gBARIgCglsYXN0X25hbWUYAiABKAlIAVIIbGFzdE5hbWWIAQESFQoDYmlvGAMgASgJSAJSA2Jp'
    'b4gBAUINCgtfZmlyc3RfbmFtZUIMCgpfbGFzdF9uYW1lQgYKBF9iaW8=');

@$core.Deprecated('Use updateProfileResponseDescriptor instead')
const UpdateProfileResponse$json = {
  '1': 'UpdateProfileResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `UpdateProfileResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateProfileResponseDescriptor = $convert.base64Decode(
    'ChVVcGRhdGVQcm9maWxlUmVzcG9uc2USIgoEdXNlchgBIAEoCzIOLndhc2xhLnYxLlVzZXJSBH'
    'VzZXI=');

@$core.Deprecated('Use setProfilePhotoRequestDescriptor instead')
const SetProfilePhotoRequest$json = {
  '1': 'SetProfilePhotoRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 3, '10': 'mediaId'},
  ],
};

/// Descriptor for `SetProfilePhotoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setProfilePhotoRequestDescriptor =
    $convert.base64Decode(
        'ChZTZXRQcm9maWxlUGhvdG9SZXF1ZXN0EhkKCG1lZGlhX2lkGAEgASgDUgdtZWRpYUlk');

@$core.Deprecated('Use setProfilePhotoResponseDescriptor instead')
const SetProfilePhotoResponse$json = {
  '1': 'SetProfilePhotoResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `SetProfilePhotoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setProfilePhotoResponseDescriptor =
    $convert.base64Decode(
        'ChdTZXRQcm9maWxlUGhvdG9SZXNwb25zZRIiCgR1c2VyGAEgASgLMg4ud2FzbGEudjEuVXNlcl'
        'IEdXNlcg==');

@$core.Deprecated('Use deleteProfilePhotoRequestDescriptor instead')
const DeleteProfilePhotoRequest$json = {
  '1': 'DeleteProfilePhotoRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 3, '10': 'mediaId'},
  ],
};

/// Descriptor for `DeleteProfilePhotoRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteProfilePhotoRequestDescriptor =
    $convert.base64Decode(
        'ChlEZWxldGVQcm9maWxlUGhvdG9SZXF1ZXN0EhkKCG1lZGlhX2lkGAEgASgDUgdtZWRpYUlk');

@$core.Deprecated('Use deleteProfilePhotoResponseDescriptor instead')
const DeleteProfilePhotoResponse$json = {
  '1': 'DeleteProfilePhotoResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `DeleteProfilePhotoResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteProfilePhotoResponseDescriptor =
    $convert.base64Decode(
        'ChpEZWxldGVQcm9maWxlUGhvdG9SZXNwb25zZRIiCgR1c2VyGAEgASgLMg4ud2FzbGEudjEuVX'
        'NlclIEdXNlcg==');

@$core.Deprecated('Use checkUsernameRequestDescriptor instead')
const CheckUsernameRequest$json = {
  '1': 'CheckUsernameRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `CheckUsernameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkUsernameRequestDescriptor =
    $convert.base64Decode(
        'ChRDaGVja1VzZXJuYW1lUmVxdWVzdBIaCgh1c2VybmFtZRgBIAEoCVIIdXNlcm5hbWU=');

@$core.Deprecated('Use checkUsernameResponseDescriptor instead')
const CheckUsernameResponse$json = {
  '1': 'CheckUsernameResponse',
  '2': [
    {'1': 'available', '3': 1, '4': 1, '5': 8, '10': 'available'},
  ],
};

/// Descriptor for `CheckUsernameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List checkUsernameResponseDescriptor = $convert.base64Decode(
    'ChVDaGVja1VzZXJuYW1lUmVzcG9uc2USHAoJYXZhaWxhYmxlGAEgASgIUglhdmFpbGFibGU=');

@$core.Deprecated('Use setUsernameRequestDescriptor instead')
const SetUsernameRequest$json = {
  '1': 'SetUsernameRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `SetUsernameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setUsernameRequestDescriptor =
    $convert.base64Decode(
        'ChJTZXRVc2VybmFtZVJlcXVlc3QSGgoIdXNlcm5hbWUYASABKAlSCHVzZXJuYW1l');

@$core.Deprecated('Use setUsernameResponseDescriptor instead')
const SetUsernameResponse$json = {
  '1': 'SetUsernameResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `SetUsernameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setUsernameResponseDescriptor = $convert.base64Decode(
    'ChNTZXRVc2VybmFtZVJlc3BvbnNlEiIKBHVzZXIYASABKAsyDi53YXNsYS52MS5Vc2VyUgR1c2'
    'Vy');

@$core.Deprecated('Use resolveUsernameRequestDescriptor instead')
const ResolveUsernameRequest$json = {
  '1': 'ResolveUsernameRequest',
  '2': [
    {'1': 'username', '3': 1, '4': 1, '5': 9, '10': 'username'},
  ],
};

/// Descriptor for `ResolveUsernameRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveUsernameRequestDescriptor =
    $convert.base64Decode(
        'ChZSZXNvbHZlVXNlcm5hbWVSZXF1ZXN0EhoKCHVzZXJuYW1lGAEgASgJUgh1c2VybmFtZQ==');

@$core.Deprecated('Use resolveUsernameResponseDescriptor instead')
const ResolveUsernameResponse$json = {
  '1': 'ResolveUsernameResponse',
  '2': [
    {'1': 'user', '3': 1, '4': 1, '5': 11, '6': '.wasla.v1.User', '10': 'user'},
  ],
};

/// Descriptor for `ResolveUsernameResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resolveUsernameResponseDescriptor =
    $convert.base64Decode(
        'ChdSZXNvbHZlVXNlcm5hbWVSZXNwb25zZRIiCgR1c2VyGAEgASgLMg4ud2FzbGEudjEuVXNlcl'
        'IEdXNlcg==');

@$core.Deprecated('Use searchUsersRequestDescriptor instead')
const SearchUsersRequest$json = {
  '1': 'SearchUsersRequest',
  '2': [
    {'1': 'query', '3': 1, '4': 1, '5': 9, '10': 'query'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `SearchUsersRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersRequestDescriptor = $convert.base64Decode(
    'ChJTZWFyY2hVc2Vyc1JlcXVlc3QSFAoFcXVlcnkYASABKAlSBXF1ZXJ5EhQKBWxpbWl0GAIgAS'
    'gFUgVsaW1pdA==');

@$core.Deprecated('Use searchUsersResponseDescriptor instead')
const SearchUsersResponse$json = {
  '1': 'SearchUsersResponse',
  '2': [
    {
      '1': 'contacts',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'contacts'
    },
    {
      '1': 'global',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'global'
    },
  ],
};

/// Descriptor for `SearchUsersResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List searchUsersResponseDescriptor = $convert.base64Decode(
    'ChNTZWFyY2hVc2Vyc1Jlc3BvbnNlEioKCGNvbnRhY3RzGAEgAygLMg4ud2FzbGEudjEuVXNlcl'
    'IIY29udGFjdHMSJgoGZ2xvYmFsGAIgAygLMg4ud2FzbGEudjEuVXNlclIGZ2xvYmFs');

@$core.Deprecated('Use getPrivacyRequestDescriptor instead')
const GetPrivacyRequest$json = {
  '1': 'GetPrivacyRequest',
};

/// Descriptor for `GetPrivacyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPrivacyRequestDescriptor =
    $convert.base64Decode('ChFHZXRQcml2YWN5UmVxdWVzdA==');

@$core.Deprecated('Use getPrivacyResponseDescriptor instead')
const GetPrivacyResponse$json = {
  '1': 'GetPrivacyResponse',
  '2': [
    {
      '1': 'settings',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.PrivacySetting',
      '10': 'settings'
    },
  ],
};

/// Descriptor for `GetPrivacyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getPrivacyResponseDescriptor = $convert.base64Decode(
    'ChJHZXRQcml2YWN5UmVzcG9uc2USNAoIc2V0dGluZ3MYASADKAsyGC53YXNsYS52MS5Qcml2YW'
    'N5U2V0dGluZ1IIc2V0dGluZ3M=');

@$core.Deprecated('Use setPrivacyRequestDescriptor instead')
const SetPrivacyRequest$json = {
  '1': 'SetPrivacyRequest',
  '2': [
    {
      '1': 'setting',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.PrivacySetting',
      '10': 'setting'
    },
  ],
};

/// Descriptor for `SetPrivacyRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrivacyRequestDescriptor = $convert.base64Decode(
    'ChFTZXRQcml2YWN5UmVxdWVzdBIyCgdzZXR0aW5nGAEgASgLMhgud2FzbGEudjEuUHJpdmFjeV'
    'NldHRpbmdSB3NldHRpbmc=');

@$core.Deprecated('Use setPrivacyResponseDescriptor instead')
const SetPrivacyResponse$json = {
  '1': 'SetPrivacyResponse',
  '2': [
    {
      '1': 'setting',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.PrivacySetting',
      '10': 'setting'
    },
  ],
};

/// Descriptor for `SetPrivacyResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setPrivacyResponseDescriptor = $convert.base64Decode(
    'ChJTZXRQcml2YWN5UmVzcG9uc2USMgoHc2V0dGluZxgBIAEoCzIYLndhc2xhLnYxLlByaXZhY3'
    'lTZXR0aW5nUgdzZXR0aW5n');

@$core.Deprecated('Use blockUserRequestDescriptor instead')
const BlockUserRequest$json = {
  '1': 'BlockUserRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `BlockUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockUserRequestDescriptor = $convert.base64Decode(
    'ChBCbG9ja1VzZXJSZXF1ZXN0EhcKB3VzZXJfaWQYASABKANSBnVzZXJJZA==');

@$core.Deprecated('Use blockUserResponseDescriptor instead')
const BlockUserResponse$json = {
  '1': 'BlockUserResponse',
};

/// Descriptor for `BlockUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List blockUserResponseDescriptor =
    $convert.base64Decode('ChFCbG9ja1VzZXJSZXNwb25zZQ==');

@$core.Deprecated('Use unblockUserRequestDescriptor instead')
const UnblockUserRequest$json = {
  '1': 'UnblockUserRequest',
  '2': [
    {'1': 'user_id', '3': 1, '4': 1, '5': 3, '10': 'userId'},
  ],
};

/// Descriptor for `UnblockUserRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unblockUserRequestDescriptor =
    $convert.base64Decode(
        'ChJVbmJsb2NrVXNlclJlcXVlc3QSFwoHdXNlcl9pZBgBIAEoA1IGdXNlcklk');

@$core.Deprecated('Use unblockUserResponseDescriptor instead')
const UnblockUserResponse$json = {
  '1': 'UnblockUserResponse',
};

/// Descriptor for `UnblockUserResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List unblockUserResponseDescriptor =
    $convert.base64Decode('ChNVbmJsb2NrVXNlclJlc3BvbnNl');

@$core.Deprecated('Use listBlockedRequestDescriptor instead')
const ListBlockedRequest$json = {
  '1': 'ListBlockedRequest',
  '2': [
    {'1': 'offset', '3': 1, '4': 1, '5': 5, '10': 'offset'},
    {'1': 'limit', '3': 2, '4': 1, '5': 5, '10': 'limit'},
  ],
};

/// Descriptor for `ListBlockedRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBlockedRequestDescriptor = $convert.base64Decode(
    'ChJMaXN0QmxvY2tlZFJlcXVlc3QSFgoGb2Zmc2V0GAEgASgFUgZvZmZzZXQSFAoFbGltaXQYAi'
    'ABKAVSBWxpbWl0');

@$core.Deprecated('Use listBlockedResponseDescriptor instead')
const ListBlockedResponse$json = {
  '1': 'ListBlockedResponse',
  '2': [
    {
      '1': 'users',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.User',
      '10': 'users'
    },
    {'1': 'total', '3': 2, '4': 1, '5': 5, '10': 'total'},
  ],
};

/// Descriptor for `ListBlockedResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List listBlockedResponseDescriptor = $convert.base64Decode(
    'ChNMaXN0QmxvY2tlZFJlc3BvbnNlEiQKBXVzZXJzGAEgAygLMg4ud2FzbGEudjEuVXNlclIFdX'
    'NlcnMSFAoFdG90YWwYAiABKAVSBXRvdGFs');

const $core.Map<$core.String, $core.dynamic> UsersServiceBase$json = {
  '1': 'UsersService',
  '2': [
    {
      '1': 'GetMe',
      '2': '.wasla.v1.GetMeRequest',
      '3': '.wasla.v1.GetMeResponse'
    },
    {
      '1': 'GetUsers',
      '2': '.wasla.v1.GetUsersRequest',
      '3': '.wasla.v1.GetUsersResponse'
    },
    {
      '1': 'UpdateProfile',
      '2': '.wasla.v1.UpdateProfileRequest',
      '3': '.wasla.v1.UpdateProfileResponse'
    },
    {
      '1': 'SetProfilePhoto',
      '2': '.wasla.v1.SetProfilePhotoRequest',
      '3': '.wasla.v1.SetProfilePhotoResponse'
    },
    {
      '1': 'DeleteProfilePhoto',
      '2': '.wasla.v1.DeleteProfilePhotoRequest',
      '3': '.wasla.v1.DeleteProfilePhotoResponse'
    },
    {
      '1': 'CheckUsername',
      '2': '.wasla.v1.CheckUsernameRequest',
      '3': '.wasla.v1.CheckUsernameResponse'
    },
    {
      '1': 'SetUsername',
      '2': '.wasla.v1.SetUsernameRequest',
      '3': '.wasla.v1.SetUsernameResponse'
    },
    {
      '1': 'ResolveUsername',
      '2': '.wasla.v1.ResolveUsernameRequest',
      '3': '.wasla.v1.ResolveUsernameResponse'
    },
    {
      '1': 'SearchUsers',
      '2': '.wasla.v1.SearchUsersRequest',
      '3': '.wasla.v1.SearchUsersResponse'
    },
    {
      '1': 'GetPrivacy',
      '2': '.wasla.v1.GetPrivacyRequest',
      '3': '.wasla.v1.GetPrivacyResponse'
    },
    {
      '1': 'SetPrivacy',
      '2': '.wasla.v1.SetPrivacyRequest',
      '3': '.wasla.v1.SetPrivacyResponse'
    },
    {
      '1': 'BlockUser',
      '2': '.wasla.v1.BlockUserRequest',
      '3': '.wasla.v1.BlockUserResponse'
    },
    {
      '1': 'UnblockUser',
      '2': '.wasla.v1.UnblockUserRequest',
      '3': '.wasla.v1.UnblockUserResponse'
    },
    {
      '1': 'ListBlocked',
      '2': '.wasla.v1.ListBlockedRequest',
      '3': '.wasla.v1.ListBlockedResponse'
    },
  ],
};

@$core.Deprecated('Use usersServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    UsersServiceBase$messageJson = {
  '.wasla.v1.GetMeRequest': GetMeRequest$json,
  '.wasla.v1.GetMeResponse': GetMeResponse$json,
  '.wasla.v1.User': User$json,
  '.wasla.v1.Avatar': $0.Avatar$json,
  '.wasla.v1.UserStatus': UserStatus$json,
  '.wasla.v1.Online': Online$json,
  '.wasla.v1.GetUsersRequest': GetUsersRequest$json,
  '.wasla.v1.GetUsersResponse': GetUsersResponse$json,
  '.wasla.v1.UpdateProfileRequest': UpdateProfileRequest$json,
  '.wasla.v1.UpdateProfileResponse': UpdateProfileResponse$json,
  '.wasla.v1.SetProfilePhotoRequest': SetProfilePhotoRequest$json,
  '.wasla.v1.SetProfilePhotoResponse': SetProfilePhotoResponse$json,
  '.wasla.v1.DeleteProfilePhotoRequest': DeleteProfilePhotoRequest$json,
  '.wasla.v1.DeleteProfilePhotoResponse': DeleteProfilePhotoResponse$json,
  '.wasla.v1.CheckUsernameRequest': CheckUsernameRequest$json,
  '.wasla.v1.CheckUsernameResponse': CheckUsernameResponse$json,
  '.wasla.v1.SetUsernameRequest': SetUsernameRequest$json,
  '.wasla.v1.SetUsernameResponse': SetUsernameResponse$json,
  '.wasla.v1.ResolveUsernameRequest': ResolveUsernameRequest$json,
  '.wasla.v1.ResolveUsernameResponse': ResolveUsernameResponse$json,
  '.wasla.v1.SearchUsersRequest': SearchUsersRequest$json,
  '.wasla.v1.SearchUsersResponse': SearchUsersResponse$json,
  '.wasla.v1.GetPrivacyRequest': GetPrivacyRequest$json,
  '.wasla.v1.GetPrivacyResponse': GetPrivacyResponse$json,
  '.wasla.v1.PrivacySetting': PrivacySetting$json,
  '.wasla.v1.SetPrivacyRequest': SetPrivacyRequest$json,
  '.wasla.v1.SetPrivacyResponse': SetPrivacyResponse$json,
  '.wasla.v1.BlockUserRequest': BlockUserRequest$json,
  '.wasla.v1.BlockUserResponse': BlockUserResponse$json,
  '.wasla.v1.UnblockUserRequest': UnblockUserRequest$json,
  '.wasla.v1.UnblockUserResponse': UnblockUserResponse$json,
  '.wasla.v1.ListBlockedRequest': ListBlockedRequest$json,
  '.wasla.v1.ListBlockedResponse': ListBlockedResponse$json,
};

/// Descriptor for `UsersService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List usersServiceDescriptor = $convert.base64Decode(
    'CgxVc2Vyc1NlcnZpY2USOAoFR2V0TWUSFi53YXNsYS52MS5HZXRNZVJlcXVlc3QaFy53YXNsYS'
    '52MS5HZXRNZVJlc3BvbnNlEkEKCEdldFVzZXJzEhkud2FzbGEudjEuR2V0VXNlcnNSZXF1ZXN0'
    'Ghoud2FzbGEudjEuR2V0VXNlcnNSZXNwb25zZRJQCg1VcGRhdGVQcm9maWxlEh4ud2FzbGEudj'
    'EuVXBkYXRlUHJvZmlsZVJlcXVlc3QaHy53YXNsYS52MS5VcGRhdGVQcm9maWxlUmVzcG9uc2US'
    'VgoPU2V0UHJvZmlsZVBob3RvEiAud2FzbGEudjEuU2V0UHJvZmlsZVBob3RvUmVxdWVzdBohLn'
    'dhc2xhLnYxLlNldFByb2ZpbGVQaG90b1Jlc3BvbnNlEl8KEkRlbGV0ZVByb2ZpbGVQaG90bxIj'
    'Lndhc2xhLnYxLkRlbGV0ZVByb2ZpbGVQaG90b1JlcXVlc3QaJC53YXNsYS52MS5EZWxldGVQcm'
    '9maWxlUGhvdG9SZXNwb25zZRJQCg1DaGVja1VzZXJuYW1lEh4ud2FzbGEudjEuQ2hlY2tVc2Vy'
    'bmFtZVJlcXVlc3QaHy53YXNsYS52MS5DaGVja1VzZXJuYW1lUmVzcG9uc2USSgoLU2V0VXNlcm'
    '5hbWUSHC53YXNsYS52MS5TZXRVc2VybmFtZVJlcXVlc3QaHS53YXNsYS52MS5TZXRVc2VybmFt'
    'ZVJlc3BvbnNlElYKD1Jlc29sdmVVc2VybmFtZRIgLndhc2xhLnYxLlJlc29sdmVVc2VybmFtZV'
    'JlcXVlc3QaIS53YXNsYS52MS5SZXNvbHZlVXNlcm5hbWVSZXNwb25zZRJKCgtTZWFyY2hVc2Vy'
    'cxIcLndhc2xhLnYxLlNlYXJjaFVzZXJzUmVxdWVzdBodLndhc2xhLnYxLlNlYXJjaFVzZXJzUm'
    'VzcG9uc2USRwoKR2V0UHJpdmFjeRIbLndhc2xhLnYxLkdldFByaXZhY3lSZXF1ZXN0Ghwud2Fz'
    'bGEudjEuR2V0UHJpdmFjeVJlc3BvbnNlEkcKClNldFByaXZhY3kSGy53YXNsYS52MS5TZXRQcm'
    'l2YWN5UmVxdWVzdBocLndhc2xhLnYxLlNldFByaXZhY3lSZXNwb25zZRJECglCbG9ja1VzZXIS'
    'Gi53YXNsYS52MS5CbG9ja1VzZXJSZXF1ZXN0Ghsud2FzbGEudjEuQmxvY2tVc2VyUmVzcG9uc2'
    'USSgoLVW5ibG9ja1VzZXISHC53YXNsYS52MS5VbmJsb2NrVXNlclJlcXVlc3QaHS53YXNsYS52'
    'MS5VbmJsb2NrVXNlclJlc3BvbnNlEkoKC0xpc3RCbG9ja2VkEhwud2FzbGEudjEuTGlzdEJsb2'
    'NrZWRSZXF1ZXN0Gh0ud2FzbGEudjEuTGlzdEJsb2NrZWRSZXNwb25zZQ==');
