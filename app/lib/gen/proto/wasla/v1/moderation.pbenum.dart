// This is a generated file - do not edit.
//
// Generated from wasla/v1/moderation.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class ReportReason extends $pb.ProtobufEnum {
  static const ReportReason REPORT_REASON_UNSPECIFIED =
      ReportReason._(0, _omitEnumNames ? '' : 'REPORT_REASON_UNSPECIFIED');
  static const ReportReason REPORT_REASON_SPAM =
      ReportReason._(1, _omitEnumNames ? '' : 'REPORT_REASON_SPAM');
  static const ReportReason REPORT_REASON_SCAM =
      ReportReason._(2, _omitEnumNames ? '' : 'REPORT_REASON_SCAM');
  static const ReportReason REPORT_REASON_VIOLENCE =
      ReportReason._(3, _omitEnumNames ? '' : 'REPORT_REASON_VIOLENCE');
  static const ReportReason REPORT_REASON_TERRORISM =
      ReportReason._(4, _omitEnumNames ? '' : 'REPORT_REASON_TERRORISM');
  static const ReportReason REPORT_REASON_CHILD_ABUSE =
      ReportReason._(5, _omitEnumNames ? '' : 'REPORT_REASON_CHILD_ABUSE');
  static const ReportReason REPORT_REASON_PORNOGRAPHY =
      ReportReason._(6, _omitEnumNames ? '' : 'REPORT_REASON_PORNOGRAPHY');
  static const ReportReason REPORT_REASON_ILLEGAL_GOODS =
      ReportReason._(7, _omitEnumNames ? '' : 'REPORT_REASON_ILLEGAL_GOODS');
  static const ReportReason REPORT_REASON_PERSONAL_DATA =
      ReportReason._(8, _omitEnumNames ? '' : 'REPORT_REASON_PERSONAL_DATA');
  static const ReportReason REPORT_REASON_HARASSMENT =
      ReportReason._(9, _omitEnumNames ? '' : 'REPORT_REASON_HARASSMENT');
  static const ReportReason REPORT_REASON_FAKE_ACCOUNT =
      ReportReason._(10, _omitEnumNames ? '' : 'REPORT_REASON_FAKE_ACCOUNT');
  static const ReportReason REPORT_REASON_COPYRIGHT =
      ReportReason._(11, _omitEnumNames ? '' : 'REPORT_REASON_COPYRIGHT');
  static const ReportReason REPORT_REASON_OTHER =
      ReportReason._(12, _omitEnumNames ? '' : 'REPORT_REASON_OTHER');

  static const $core.List<ReportReason> values = <ReportReason>[
    REPORT_REASON_UNSPECIFIED,
    REPORT_REASON_SPAM,
    REPORT_REASON_SCAM,
    REPORT_REASON_VIOLENCE,
    REPORT_REASON_TERRORISM,
    REPORT_REASON_CHILD_ABUSE,
    REPORT_REASON_PORNOGRAPHY,
    REPORT_REASON_ILLEGAL_GOODS,
    REPORT_REASON_PERSONAL_DATA,
    REPORT_REASON_HARASSMENT,
    REPORT_REASON_FAKE_ACCOUNT,
    REPORT_REASON_COPYRIGHT,
    REPORT_REASON_OTHER,
  ];

  static final $core.List<ReportReason?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 12);
  static ReportReason? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const ReportReason._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
