// This is a generated file - do not edit.
//
// Generated from wasla/v1/frame.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ErrorCode extends $pb.ProtobufEnum {
  static const ErrorCode ERROR_CODE_UNSPECIFIED =
      ErrorCode._(0, _omitEnumNames ? '' : 'ERROR_CODE_UNSPECIFIED');

  /// Generic
  static const ErrorCode ERROR_CODE_INVALID_ARGUMENT =
      ErrorCode._(1, _omitEnumNames ? '' : 'ERROR_CODE_INVALID_ARGUMENT');
  static const ErrorCode ERROR_CODE_UNAUTHENTICATED =
      ErrorCode._(2, _omitEnumNames ? '' : 'ERROR_CODE_UNAUTHENTICATED');
  static const ErrorCode ERROR_CODE_PERMISSION_DENIED =
      ErrorCode._(3, _omitEnumNames ? '' : 'ERROR_CODE_PERMISSION_DENIED');
  static const ErrorCode ERROR_CODE_NOT_FOUND =
      ErrorCode._(4, _omitEnumNames ? '' : 'ERROR_CODE_NOT_FOUND');
  static const ErrorCode ERROR_CODE_ALREADY_EXISTS =
      ErrorCode._(5, _omitEnumNames ? '' : 'ERROR_CODE_ALREADY_EXISTS');
  static const ErrorCode ERROR_CODE_RATE_LIMITED =
      ErrorCode._(6, _omitEnumNames ? '' : 'ERROR_CODE_RATE_LIMITED');
  static const ErrorCode ERROR_CODE_INTERNAL =
      ErrorCode._(7, _omitEnumNames ? '' : 'ERROR_CODE_INTERNAL');
  static const ErrorCode ERROR_CODE_UNAVAILABLE =
      ErrorCode._(8, _omitEnumNames ? '' : 'ERROR_CODE_UNAVAILABLE');
  static const ErrorCode ERROR_CODE_UNIMPLEMENTED =
      ErrorCode._(9, _omitEnumNames ? '' : 'ERROR_CODE_UNIMPLEMENTED');
  static const ErrorCode ERROR_CODE_UPDATE_REQUIRED =
      ErrorCode._(10, _omitEnumNames ? '' : 'ERROR_CODE_UPDATE_REQUIRED');

  /// Auth
  static const ErrorCode ERROR_CODE_PHONE_INVALID =
      ErrorCode._(20, _omitEnumNames ? '' : 'ERROR_CODE_PHONE_INVALID');
  static const ErrorCode ERROR_CODE_PHONE_CODE_INVALID =
      ErrorCode._(21, _omitEnumNames ? '' : 'ERROR_CODE_PHONE_CODE_INVALID');
  static const ErrorCode ERROR_CODE_PHONE_CODE_EXPIRED =
      ErrorCode._(22, _omitEnumNames ? '' : 'ERROR_CODE_PHONE_CODE_EXPIRED');
  static const ErrorCode ERROR_CODE_PHONE_BANNED =
      ErrorCode._(23, _omitEnumNames ? '' : 'ERROR_CODE_PHONE_BANNED');
  static const ErrorCode ERROR_CODE_PASSWORD_INVALID =
      ErrorCode._(24, _omitEnumNames ? '' : 'ERROR_CODE_PASSWORD_INVALID');
  static const ErrorCode ERROR_CODE_SESSION_REVOKED =
      ErrorCode._(25, _omitEnumNames ? '' : 'ERROR_CODE_SESSION_REVOKED');

  /// Users
  static const ErrorCode ERROR_CODE_USERNAME_INVALID =
      ErrorCode._(30, _omitEnumNames ? '' : 'ERROR_CODE_USERNAME_INVALID');
  static const ErrorCode ERROR_CODE_USERNAME_TAKEN =
      ErrorCode._(31, _omitEnumNames ? '' : 'ERROR_CODE_USERNAME_TAKEN');
  static const ErrorCode ERROR_CODE_PEER_BLOCKED =
      ErrorCode._(32, _omitEnumNames ? '' : 'ERROR_CODE_PEER_BLOCKED');
  static const ErrorCode ERROR_CODE_PRIVACY_RESTRICTED =
      ErrorCode._(33, _omitEnumNames ? '' : 'ERROR_CODE_PRIVACY_RESTRICTED');

  /// Messages & chats
  static const ErrorCode ERROR_CODE_MESSAGE_TOO_LONG =
      ErrorCode._(40, _omitEnumNames ? '' : 'ERROR_CODE_MESSAGE_TOO_LONG');
  static const ErrorCode ERROR_CODE_MESSAGE_EDIT_EXPIRED =
      ErrorCode._(41, _omitEnumNames ? '' : 'ERROR_CODE_MESSAGE_EDIT_EXPIRED');
  static const ErrorCode ERROR_CODE_CHAT_MEMBER_LIMIT =
      ErrorCode._(42, _omitEnumNames ? '' : 'ERROR_CODE_CHAT_MEMBER_LIMIT');
  static const ErrorCode ERROR_CODE_CHAT_WRITE_FORBIDDEN =
      ErrorCode._(43, _omitEnumNames ? '' : 'ERROR_CODE_CHAT_WRITE_FORBIDDEN');
  static const ErrorCode ERROR_CODE_INVITE_INVALID =
      ErrorCode._(44, _omitEnumNames ? '' : 'ERROR_CODE_INVITE_INVALID');

  /// Media
  static const ErrorCode ERROR_CODE_FILE_TOO_LARGE =
      ErrorCode._(50, _omitEnumNames ? '' : 'ERROR_CODE_FILE_TOO_LARGE');
  static const ErrorCode ERROR_CODE_UPLOAD_INCOMPLETE =
      ErrorCode._(51, _omitEnumNames ? '' : 'ERROR_CODE_UPLOAD_INCOMPLETE');

  static const $core.List<ErrorCode> values = <ErrorCode>[
    ERROR_CODE_UNSPECIFIED,
    ERROR_CODE_INVALID_ARGUMENT,
    ERROR_CODE_UNAUTHENTICATED,
    ERROR_CODE_PERMISSION_DENIED,
    ERROR_CODE_NOT_FOUND,
    ERROR_CODE_ALREADY_EXISTS,
    ERROR_CODE_RATE_LIMITED,
    ERROR_CODE_INTERNAL,
    ERROR_CODE_UNAVAILABLE,
    ERROR_CODE_UNIMPLEMENTED,
    ERROR_CODE_UPDATE_REQUIRED,
    ERROR_CODE_PHONE_INVALID,
    ERROR_CODE_PHONE_CODE_INVALID,
    ERROR_CODE_PHONE_CODE_EXPIRED,
    ERROR_CODE_PHONE_BANNED,
    ERROR_CODE_PASSWORD_INVALID,
    ERROR_CODE_SESSION_REVOKED,
    ERROR_CODE_USERNAME_INVALID,
    ERROR_CODE_USERNAME_TAKEN,
    ERROR_CODE_PEER_BLOCKED,
    ERROR_CODE_PRIVACY_RESTRICTED,
    ERROR_CODE_MESSAGE_TOO_LONG,
    ERROR_CODE_MESSAGE_EDIT_EXPIRED,
    ERROR_CODE_CHAT_MEMBER_LIMIT,
    ERROR_CODE_CHAT_WRITE_FORBIDDEN,
    ERROR_CODE_INVITE_INVALID,
    ERROR_CODE_FILE_TOO_LARGE,
    ERROR_CODE_UPLOAD_INCOMPLETE,
  ];

  static final $core.Map<$core.int, ErrorCode> _byValue =
      $pb.ProtobufEnum.initByValue(values);
  static ErrorCode? valueOf($core.int value) => _byValue[value];

  const ErrorCode._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
