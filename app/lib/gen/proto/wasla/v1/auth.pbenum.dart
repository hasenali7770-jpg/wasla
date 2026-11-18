// This is a generated file - do not edit.
//
// Generated from wasla/v1/auth.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class CodeDelivery extends $pb.ProtobufEnum {
  static const CodeDelivery CODE_DELIVERY_UNSPECIFIED =
      CodeDelivery._(0, _omitEnumNames ? '' : 'CODE_DELIVERY_UNSPECIFIED');
  static const CodeDelivery CODE_DELIVERY_SMS =
      CodeDelivery._(1, _omitEnumNames ? '' : 'CODE_DELIVERY_SMS');
  static const CodeDelivery CODE_DELIVERY_VOICE_CALL =
      CodeDelivery._(2, _omitEnumNames ? '' : 'CODE_DELIVERY_VOICE_CALL');

  /// Sent as a message to the user's already-logged-in devices (free).
  static const CodeDelivery CODE_DELIVERY_APP =
      CodeDelivery._(3, _omitEnumNames ? '' : 'CODE_DELIVERY_APP');

  static const $core.List<CodeDelivery> values = <CodeDelivery>[
    CODE_DELIVERY_UNSPECIFIED,
    CODE_DELIVERY_SMS,
    CODE_DELIVERY_VOICE_CALL,
    CODE_DELIVERY_APP,
  ];

  static final $core.List<CodeDelivery?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static CodeDelivery? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const CodeDelivery._(super.value, super.name);
}

class PushProvider extends $pb.ProtobufEnum {
  static const PushProvider PUSH_PROVIDER_UNSPECIFIED =
      PushProvider._(0, _omitEnumNames ? '' : 'PUSH_PROVIDER_UNSPECIFIED');
  static const PushProvider PUSH_PROVIDER_FCM =
      PushProvider._(1, _omitEnumNames ? '' : 'PUSH_PROVIDER_FCM');
  static const PushProvider PUSH_PROVIDER_APNS =
      PushProvider._(2, _omitEnumNames ? '' : 'PUSH_PROVIDER_APNS');
  static const PushProvider PUSH_PROVIDER_HMS =
      PushProvider._(3, _omitEnumNames ? '' : 'PUSH_PROVIDER_HMS');

  static const $core.List<PushProvider> values = <PushProvider>[
    PUSH_PROVIDER_UNSPECIFIED,
    PUSH_PROVIDER_FCM,
    PUSH_PROVIDER_APNS,
    PUSH_PROVIDER_HMS,
  ];

  static final $core.List<PushProvider?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static PushProvider? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PushProvider._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
