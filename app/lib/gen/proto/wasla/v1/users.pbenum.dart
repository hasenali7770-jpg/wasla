// This is a generated file - do not edit.
//
// Generated from wasla/v1/users.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class LastSeenApprox extends $pb.ProtobufEnum {
  static const LastSeenApprox LAST_SEEN_APPROX_UNSPECIFIED =
      LastSeenApprox._(0, _omitEnumNames ? '' : 'LAST_SEEN_APPROX_UNSPECIFIED');
  static const LastSeenApprox LAST_SEEN_APPROX_RECENTLY =
      LastSeenApprox._(1, _omitEnumNames ? '' : 'LAST_SEEN_APPROX_RECENTLY');
  static const LastSeenApprox LAST_SEEN_APPROX_WITHIN_WEEK =
      LastSeenApprox._(2, _omitEnumNames ? '' : 'LAST_SEEN_APPROX_WITHIN_WEEK');
  static const LastSeenApprox LAST_SEEN_APPROX_WITHIN_MONTH = LastSeenApprox._(
      3, _omitEnumNames ? '' : 'LAST_SEEN_APPROX_WITHIN_MONTH');
  static const LastSeenApprox LAST_SEEN_APPROX_LONG_AGO =
      LastSeenApprox._(4, _omitEnumNames ? '' : 'LAST_SEEN_APPROX_LONG_AGO');

  static const $core.List<LastSeenApprox> values = <LastSeenApprox>[
    LAST_SEEN_APPROX_UNSPECIFIED,
    LAST_SEEN_APPROX_RECENTLY,
    LAST_SEEN_APPROX_WITHIN_WEEK,
    LAST_SEEN_APPROX_WITHIN_MONTH,
    LAST_SEEN_APPROX_LONG_AGO,
  ];

  static final $core.List<LastSeenApprox?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static LastSeenApprox? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const LastSeenApprox._(super.value, super.name);
}

class PrivacyKey extends $pb.ProtobufEnum {
  static const PrivacyKey PRIVACY_KEY_UNSPECIFIED =
      PrivacyKey._(0, _omitEnumNames ? '' : 'PRIVACY_KEY_UNSPECIFIED');
  static const PrivacyKey PRIVACY_KEY_PHONE_NUMBER =
      PrivacyKey._(1, _omitEnumNames ? '' : 'PRIVACY_KEY_PHONE_NUMBER');
  static const PrivacyKey PRIVACY_KEY_LAST_SEEN =
      PrivacyKey._(2, _omitEnumNames ? '' : 'PRIVACY_KEY_LAST_SEEN');
  static const PrivacyKey PRIVACY_KEY_PROFILE_PHOTO =
      PrivacyKey._(3, _omitEnumNames ? '' : 'PRIVACY_KEY_PROFILE_PHOTO');
  static const PrivacyKey PRIVACY_KEY_GROUP_INVITES =
      PrivacyKey._(4, _omitEnumNames ? '' : 'PRIVACY_KEY_GROUP_INVITES');

  /// Whether forwarded messages link back to the author's account.
  static const PrivacyKey PRIVACY_KEY_FORWARDS =
      PrivacyKey._(5, _omitEnumNames ? '' : 'PRIVACY_KEY_FORWARDS');

  /// Reserved for Phase 3.
  static const PrivacyKey PRIVACY_KEY_CALLS =
      PrivacyKey._(6, _omitEnumNames ? '' : 'PRIVACY_KEY_CALLS');

  static const $core.List<PrivacyKey> values = <PrivacyKey>[
    PRIVACY_KEY_UNSPECIFIED,
    PRIVACY_KEY_PHONE_NUMBER,
    PRIVACY_KEY_LAST_SEEN,
    PRIVACY_KEY_PROFILE_PHOTO,
    PRIVACY_KEY_GROUP_INVITES,
    PRIVACY_KEY_FORWARDS,
    PRIVACY_KEY_CALLS,
  ];

  static final $core.List<PrivacyKey?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static PrivacyKey? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PrivacyKey._(super.value, super.name);
}

class PrivacyRule extends $pb.ProtobufEnum {
  static const PrivacyRule PRIVACY_RULE_UNSPECIFIED =
      PrivacyRule._(0, _omitEnumNames ? '' : 'PRIVACY_RULE_UNSPECIFIED');
  static const PrivacyRule PRIVACY_RULE_EVERYBODY =
      PrivacyRule._(1, _omitEnumNames ? '' : 'PRIVACY_RULE_EVERYBODY');
  static const PrivacyRule PRIVACY_RULE_CONTACTS =
      PrivacyRule._(2, _omitEnumNames ? '' : 'PRIVACY_RULE_CONTACTS');
  static const PrivacyRule PRIVACY_RULE_NOBODY =
      PrivacyRule._(3, _omitEnumNames ? '' : 'PRIVACY_RULE_NOBODY');

  static const $core.List<PrivacyRule> values = <PrivacyRule>[
    PRIVACY_RULE_UNSPECIFIED,
    PRIVACY_RULE_EVERYBODY,
    PRIVACY_RULE_CONTACTS,
    PRIVACY_RULE_NOBODY,
  ];

  static final $core.List<PrivacyRule?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 3);
  static PrivacyRule? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const PrivacyRule._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
