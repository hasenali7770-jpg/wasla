// This is a generated file - do not edit.
//
// Generated from wasla/v1/media.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class MediaKind extends $pb.ProtobufEnum {
  static const MediaKind MEDIA_KIND_UNSPECIFIED =
      MediaKind._(0, _omitEnumNames ? '' : 'MEDIA_KIND_UNSPECIFIED');
  static const MediaKind MEDIA_KIND_PHOTO =
      MediaKind._(1, _omitEnumNames ? '' : 'MEDIA_KIND_PHOTO');
  static const MediaKind MEDIA_KIND_VIDEO =
      MediaKind._(2, _omitEnumNames ? '' : 'MEDIA_KIND_VIDEO');
  static const MediaKind MEDIA_KIND_DOCUMENT =
      MediaKind._(3, _omitEnumNames ? '' : 'MEDIA_KIND_DOCUMENT');
  static const MediaKind MEDIA_KIND_VOICE =
      MediaKind._(4, _omitEnumNames ? '' : 'MEDIA_KIND_VOICE');
  static const MediaKind MEDIA_KIND_AUDIO =
      MediaKind._(5, _omitEnumNames ? '' : 'MEDIA_KIND_AUDIO');
  static const MediaKind MEDIA_KIND_ANIMATION =
      MediaKind._(6, _omitEnumNames ? '' : 'MEDIA_KIND_ANIMATION');

  static const $core.List<MediaKind> values = <MediaKind>[
    MEDIA_KIND_UNSPECIFIED,
    MEDIA_KIND_PHOTO,
    MEDIA_KIND_VIDEO,
    MEDIA_KIND_DOCUMENT,
    MEDIA_KIND_VOICE,
    MEDIA_KIND_AUDIO,
    MEDIA_KIND_ANIMATION,
  ];

  static final $core.List<MediaKind?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 6);
  static MediaKind? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MediaKind._(super.value, super.name);
}

class MediaStatus extends $pb.ProtobufEnum {
  static const MediaStatus MEDIA_STATUS_UNSPECIFIED =
      MediaStatus._(0, _omitEnumNames ? '' : 'MEDIA_STATUS_UNSPECIFIED');
  static const MediaStatus MEDIA_STATUS_UPLOADING =
      MediaStatus._(1, _omitEnumNames ? '' : 'MEDIA_STATUS_UPLOADING');
  static const MediaStatus MEDIA_STATUS_PROCESSING =
      MediaStatus._(2, _omitEnumNames ? '' : 'MEDIA_STATUS_PROCESSING');
  static const MediaStatus MEDIA_STATUS_READY =
      MediaStatus._(3, _omitEnumNames ? '' : 'MEDIA_STATUS_READY');
  static const MediaStatus MEDIA_STATUS_FAILED =
      MediaStatus._(4, _omitEnumNames ? '' : 'MEDIA_STATUS_FAILED');

  static const $core.List<MediaStatus> values = <MediaStatus>[
    MEDIA_STATUS_UNSPECIFIED,
    MEDIA_STATUS_UPLOADING,
    MEDIA_STATUS_PROCESSING,
    MEDIA_STATUS_READY,
    MEDIA_STATUS_FAILED,
  ];

  static final $core.List<MediaStatus?> _byValue =
      $pb.ProtobufEnum.$_initByValueList(values, 4);
  static MediaStatus? valueOf($core.int value) =>
      value < 0 || value >= _byValue.length ? null : _byValue[value];

  const MediaStatus._(super.value, super.name);
}

const $core.bool _omitEnumNames =
    $core.bool.fromEnvironment('protobuf.omit_enum_names');
