// This is a generated file - do not edit.
//
// Generated from wasla/v1/media.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pb.dart' as $0;
import 'media.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'media.pbenum.dart';

class Media extends $pb.GeneratedMessage {
  factory Media({
    $fixnum.Int64? id,
    MediaKind? kind,
    $core.String? mimeType,
    $fixnum.Int64? sizeBytes,
    $core.String? fileName,
    $core.int? width,
    $core.int? height,
    $core.int? durationMs,
    $core.List<$core.int>? thumbhash,
    $core.List<$core.int>? waveform,
    $core.Iterable<MediaVariant>? variants,
    MediaStatus? status,
  }) {
    final result = Media._();
    if (id != null) result.id = id;
    if (kind != null) result.kind = kind;
    if (mimeType != null) result.mimeType = mimeType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (fileName != null) result.fileName = fileName;
    if (width != null) result.width = width;
    if (height != null) result.height = height;
    if (durationMs != null) result.durationMs = durationMs;
    if (thumbhash != null) result.thumbhash = thumbhash;
    if (waveform != null) result.waveform = waveform;
    if (variants != null) result.variants.addAll(variants);
    if (status != null) result.status = status;
    return result;
  }

  Media._();

  factory Media.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Media()..mergeFromBuffer(data, registry);
  factory Media.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Media()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Media',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Media.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aE<MediaKind>(2, _omitFieldNames ? '' : 'kind',
        enumValues: MediaKind.values)
    ..aOS(3, _omitFieldNames ? '' : 'mimeType')
    ..aInt64(4, _omitFieldNames ? '' : 'sizeBytes')
    ..aOS(5, _omitFieldNames ? '' : 'fileName')
    ..aI(6, _omitFieldNames ? '' : 'width')
    ..aI(7, _omitFieldNames ? '' : 'height')
    ..aI(8, _omitFieldNames ? '' : 'durationMs')
    ..a<$core.List<$core.int>>(
        9, _omitFieldNames ? '' : 'thumbhash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        10, _omitFieldNames ? '' : 'waveform', $pb.PbFieldType.OY)
    ..pPM<MediaVariant>(11, _omitFieldNames ? '' : 'variants',
        subBuilder: MediaVariant.$_createMessage)
    ..aE<MediaStatus>(12, _omitFieldNames ? '' : 'status',
        enumValues: MediaStatus.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Media clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Media copyWith(void Function(Media) updates) =>
      super.copyWith((message) => updates(message as Media)) as Media;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Media() / Media.new instead')
  static Media create() => Media._();
  static $pb.GeneratedMessage $_createMessage() => Media._();
  @$core.override
  Media createEmptyInstance() => Media._();
  @$core.pragma('dart2js:noInline')
  static Media getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Media>(Media.$_createMessage);
  static Media? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  MediaKind get kind => $_getN(1);
  @$pb.TagNumber(2)
  set kind(MediaKind value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasKind() => $_has(1);
  @$pb.TagNumber(2)
  void clearKind() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get mimeType => $_getSZ(2);
  @$pb.TagNumber(3)
  set mimeType($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasMimeType() => $_has(2);
  @$pb.TagNumber(3)
  void clearMimeType() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get sizeBytes => $_getI64(3);
  @$pb.TagNumber(4)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSizeBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearSizeBytes() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get fileName => $_getSZ(4);
  @$pb.TagNumber(5)
  set fileName($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasFileName() => $_has(4);
  @$pb.TagNumber(5)
  void clearFileName() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get width => $_getIZ(5);
  @$pb.TagNumber(6)
  set width($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasWidth() => $_has(5);
  @$pb.TagNumber(6)
  void clearWidth() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get height => $_getIZ(6);
  @$pb.TagNumber(7)
  set height($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasHeight() => $_has(6);
  @$pb.TagNumber(7)
  void clearHeight() => $_clearField(7);

  @$pb.TagNumber(8)
  $core.int get durationMs => $_getIZ(7);
  @$pb.TagNumber(8)
  set durationMs($core.int value) => $_setSignedInt32(7, value);
  @$pb.TagNumber(8)
  $core.bool hasDurationMs() => $_has(7);
  @$pb.TagNumber(8)
  void clearDurationMs() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.List<$core.int> get thumbhash => $_getN(8);
  @$pb.TagNumber(9)
  set thumbhash($core.List<$core.int> value) => $_setBytes(8, value);
  @$pb.TagNumber(9)
  $core.bool hasThumbhash() => $_has(8);
  @$pb.TagNumber(9)
  void clearThumbhash() => $_clearField(9);

  /// Voice messages: 100 samples, 5 bits each, packed.
  @$pb.TagNumber(10)
  $core.List<$core.int> get waveform => $_getN(9);
  @$pb.TagNumber(10)
  set waveform($core.List<$core.int> value) => $_setBytes(9, value);
  @$pb.TagNumber(10)
  $core.bool hasWaveform() => $_has(9);
  @$pb.TagNumber(10)
  void clearWaveform() => $_clearField(10);

  @$pb.TagNumber(11)
  $pb.PbList<MediaVariant> get variants => $_getList(10);

  @$pb.TagNumber(12)
  MediaStatus get status => $_getN(11);
  @$pb.TagNumber(12)
  set status(MediaStatus value) => $_setField(12, value);
  @$pb.TagNumber(12)
  $core.bool hasStatus() => $_has(11);
  @$pb.TagNumber(12)
  void clearStatus() => $_clearField(12);
}

/// MediaVariant is a server-generated rendition: "thumb_s" (90px), "thumb_m"
/// (320px), "photo_l" (1280px), "video_480p", "video_720p".
class MediaVariant extends $pb.GeneratedMessage {
  factory MediaVariant({
    $core.String? type,
    $core.int? width,
    $core.int? height,
    $fixnum.Int64? sizeBytes,
  }) {
    final result = MediaVariant._();
    if (type != null) result.type = type;
    if (width != null) result.width = width;
    if (height != null) result.height = height;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    return result;
  }

  MediaVariant._();

  factory MediaVariant.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaVariant()..mergeFromBuffer(data, registry);
  factory MediaVariant.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      MediaVariant()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'MediaVariant',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: MediaVariant.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'type')
    ..aI(2, _omitFieldNames ? '' : 'width')
    ..aI(3, _omitFieldNames ? '' : 'height')
    ..aInt64(4, _omitFieldNames ? '' : 'sizeBytes')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaVariant clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  MediaVariant copyWith(void Function(MediaVariant) updates) =>
      super.copyWith((message) => updates(message as MediaVariant))
          as MediaVariant;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use MediaVariant() / MediaVariant.new instead')
  static MediaVariant create() => MediaVariant._();
  static $pb.GeneratedMessage $_createMessage() => MediaVariant._();
  @$core.override
  MediaVariant createEmptyInstance() => MediaVariant._();
  @$core.pragma('dart2js:noInline')
  static MediaVariant getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MediaVariant>(
          MediaVariant.$_createMessage);
  static MediaVariant? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get type => $_getSZ(0);
  @$pb.TagNumber(1)
  set type($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get width => $_getIZ(1);
  @$pb.TagNumber(2)
  set width($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasWidth() => $_has(1);
  @$pb.TagNumber(2)
  void clearWidth() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get height => $_getIZ(2);
  @$pb.TagNumber(3)
  set height($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHeight() => $_has(2);
  @$pb.TagNumber(3)
  void clearHeight() => $_clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get sizeBytes => $_getI64(3);
  @$pb.TagNumber(4)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasSizeBytes() => $_has(3);
  @$pb.TagNumber(4)
  void clearSizeBytes() => $_clearField(4);
}

class UploadPartUrl extends $pb.GeneratedMessage {
  factory UploadPartUrl({
    $core.int? partNumber,
    $core.String? url,
    $fixnum.Int64? expiresAt,
  }) {
    final result = UploadPartUrl._();
    if (partNumber != null) result.partNumber = partNumber;
    if (url != null) result.url = url;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  UploadPartUrl._();

  factory UploadPartUrl.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UploadPartUrl()..mergeFromBuffer(data, registry);
  factory UploadPartUrl.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UploadPartUrl()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UploadPartUrl',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UploadPartUrl.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'partNumber')
    ..aOS(2, _omitFieldNames ? '' : 'url')
    ..aInt64(3, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadPartUrl clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UploadPartUrl copyWith(void Function(UploadPartUrl) updates) =>
      super.copyWith((message) => updates(message as UploadPartUrl))
          as UploadPartUrl;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UploadPartUrl() / UploadPartUrl.new instead')
  static UploadPartUrl create() => UploadPartUrl._();
  static $pb.GeneratedMessage $_createMessage() => UploadPartUrl._();
  @$core.override
  UploadPartUrl createEmptyInstance() => UploadPartUrl._();
  @$core.pragma('dart2js:noInline')
  static UploadPartUrl getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UploadPartUrl>(
          UploadPartUrl.$_createMessage);
  static UploadPartUrl? _defaultInstance;

  /// 1-based.
  @$pb.TagNumber(1)
  $core.int get partNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set partNumber($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPartNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPartNumber() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get url => $_getSZ(1);
  @$pb.TagNumber(2)
  set url($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUrl() => $_has(1);
  @$pb.TagNumber(2)
  void clearUrl() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get expiresAt => $_getI64(2);
  @$pb.TagNumber(3)
  set expiresAt($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasExpiresAt() => $_has(2);
  @$pb.TagNumber(3)
  void clearExpiresAt() => $_clearField(3);
}

class CompletedPart extends $pb.GeneratedMessage {
  factory CompletedPart({
    $core.int? partNumber,
    $core.String? etag,
  }) {
    final result = CompletedPart._();
    if (partNumber != null) result.partNumber = partNumber;
    if (etag != null) result.etag = etag;
    return result;
  }

  CompletedPart._();

  factory CompletedPart.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompletedPart()..mergeFromBuffer(data, registry);
  factory CompletedPart.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompletedPart()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompletedPart',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CompletedPart.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'partNumber')
    ..aOS(2, _omitFieldNames ? '' : 'etag')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompletedPart clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompletedPart copyWith(void Function(CompletedPart) updates) =>
      super.copyWith((message) => updates(message as CompletedPart))
          as CompletedPart;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use CompletedPart() / CompletedPart.new instead')
  static CompletedPart create() => CompletedPart._();
  static $pb.GeneratedMessage $_createMessage() => CompletedPart._();
  @$core.override
  CompletedPart createEmptyInstance() => CompletedPart._();
  @$core.pragma('dart2js:noInline')
  static CompletedPart getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CompletedPart>(
          CompletedPart.$_createMessage);
  static CompletedPart? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get partNumber => $_getIZ(0);
  @$pb.TagNumber(1)
  set partNumber($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPartNumber() => $_has(0);
  @$pb.TagNumber(1)
  void clearPartNumber() => $_clearField(1);

  /// ETag returned by object storage for that PUT.
  @$pb.TagNumber(2)
  $core.String get etag => $_getSZ(1);
  @$pb.TagNumber(2)
  set etag($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasEtag() => $_has(1);
  @$pb.TagNumber(2)
  void clearEtag() => $_clearField(2);
}

class CreateUploadRequest extends $pb.GeneratedMessage {
  factory CreateUploadRequest({
    MediaKind? kind,
    $core.String? mimeType,
    $fixnum.Int64? sizeBytes,
    $core.String? fileName,
    $core.int? width,
    $core.int? height,
    $core.int? durationMs,
  }) {
    final result = CreateUploadRequest._();
    if (kind != null) result.kind = kind;
    if (mimeType != null) result.mimeType = mimeType;
    if (sizeBytes != null) result.sizeBytes = sizeBytes;
    if (fileName != null) result.fileName = fileName;
    if (width != null) result.width = width;
    if (height != null) result.height = height;
    if (durationMs != null) result.durationMs = durationMs;
    return result;
  }

  CreateUploadRequest._();

  factory CreateUploadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateUploadRequest()..mergeFromBuffer(data, registry);
  factory CreateUploadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateUploadRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUploadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CreateUploadRequest.$_createMessage)
    ..aE<MediaKind>(1, _omitFieldNames ? '' : 'kind',
        enumValues: MediaKind.values)
    ..aOS(2, _omitFieldNames ? '' : 'mimeType')
    ..aInt64(3, _omitFieldNames ? '' : 'sizeBytes')
    ..aOS(4, _omitFieldNames ? '' : 'fileName')
    ..aI(5, _omitFieldNames ? '' : 'width')
    ..aI(6, _omitFieldNames ? '' : 'height')
    ..aI(7, _omitFieldNames ? '' : 'durationMs')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUploadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUploadRequest copyWith(void Function(CreateUploadRequest) updates) =>
      super.copyWith((message) => updates(message as CreateUploadRequest))
          as CreateUploadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use CreateUploadRequest() / CreateUploadRequest.new instead')
  static CreateUploadRequest create() => CreateUploadRequest._();
  static $pb.GeneratedMessage $_createMessage() => CreateUploadRequest._();
  @$core.override
  CreateUploadRequest createEmptyInstance() => CreateUploadRequest._();
  @$core.pragma('dart2js:noInline')
  static CreateUploadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUploadRequest>(
          CreateUploadRequest.$_createMessage);
  static CreateUploadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  MediaKind get kind => $_getN(0);
  @$pb.TagNumber(1)
  set kind(MediaKind value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKind() => $_has(0);
  @$pb.TagNumber(1)
  void clearKind() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get mimeType => $_getSZ(1);
  @$pb.TagNumber(2)
  set mimeType($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMimeType() => $_has(1);
  @$pb.TagNumber(2)
  void clearMimeType() => $_clearField(2);

  /// Up to 2 GiB. The Lean MVP caps this at 500 MB via server config.
  @$pb.TagNumber(3)
  $fixnum.Int64 get sizeBytes => $_getI64(2);
  @$pb.TagNumber(3)
  set sizeBytes($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSizeBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearSizeBytes() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get fileName => $_getSZ(3);
  @$pb.TagNumber(4)
  set fileName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasFileName() => $_has(3);
  @$pb.TagNumber(4)
  void clearFileName() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get width => $_getIZ(4);
  @$pb.TagNumber(5)
  set width($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWidth() => $_has(4);
  @$pb.TagNumber(5)
  void clearWidth() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.int get height => $_getIZ(5);
  @$pb.TagNumber(6)
  set height($core.int value) => $_setSignedInt32(5, value);
  @$pb.TagNumber(6)
  $core.bool hasHeight() => $_has(5);
  @$pb.TagNumber(6)
  void clearHeight() => $_clearField(6);

  @$pb.TagNumber(7)
  $core.int get durationMs => $_getIZ(6);
  @$pb.TagNumber(7)
  set durationMs($core.int value) => $_setSignedInt32(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDurationMs() => $_has(6);
  @$pb.TagNumber(7)
  void clearDurationMs() => $_clearField(7);
}

class CreateUploadResponse extends $pb.GeneratedMessage {
  factory CreateUploadResponse({
    $core.String? uploadId,
    $fixnum.Int64? mediaId,
    $core.int? partSizeBytes,
    $core.int? partCount,
    $core.Iterable<UploadPartUrl>? urls,
  }) {
    final result = CreateUploadResponse._();
    if (uploadId != null) result.uploadId = uploadId;
    if (mediaId != null) result.mediaId = mediaId;
    if (partSizeBytes != null) result.partSizeBytes = partSizeBytes;
    if (partCount != null) result.partCount = partCount;
    if (urls != null) result.urls.addAll(urls);
    return result;
  }

  CreateUploadResponse._();

  factory CreateUploadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateUploadResponse()..mergeFromBuffer(data, registry);
  factory CreateUploadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CreateUploadResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CreateUploadResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CreateUploadResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'uploadId')
    ..aInt64(2, _omitFieldNames ? '' : 'mediaId')
    ..aI(3, _omitFieldNames ? '' : 'partSizeBytes')
    ..aI(4, _omitFieldNames ? '' : 'partCount')
    ..pPM<UploadPartUrl>(5, _omitFieldNames ? '' : 'urls',
        subBuilder: UploadPartUrl.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUploadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CreateUploadResponse copyWith(void Function(CreateUploadResponse) updates) =>
      super.copyWith((message) => updates(message as CreateUploadResponse))
          as CreateUploadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CreateUploadResponse() / CreateUploadResponse.new instead')
  static CreateUploadResponse create() => CreateUploadResponse._();
  static $pb.GeneratedMessage $_createMessage() => CreateUploadResponse._();
  @$core.override
  CreateUploadResponse createEmptyInstance() => CreateUploadResponse._();
  @$core.pragma('dart2js:noInline')
  static CreateUploadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CreateUploadResponse>(
          CreateUploadResponse.$_createMessage);
  static CreateUploadResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uploadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uploadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUploadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUploadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get mediaId => $_getI64(1);
  @$pb.TagNumber(2)
  set mediaId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMediaId() => $_has(1);
  @$pb.TagNumber(2)
  void clearMediaId() => $_clearField(2);

  /// 512 KiB on mobile networks; the server may raise it for big files so the
  /// part count stays under 10,000.
  @$pb.TagNumber(3)
  $core.int get partSizeBytes => $_getIZ(2);
  @$pb.TagNumber(3)
  set partSizeBytes($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPartSizeBytes() => $_has(2);
  @$pb.TagNumber(3)
  void clearPartSizeBytes() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get partCount => $_getIZ(3);
  @$pb.TagNumber(4)
  set partCount($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasPartCount() => $_has(3);
  @$pb.TagNumber(4)
  void clearPartCount() => $_clearField(4);

  /// URLs for the first parts (up to 50).
  @$pb.TagNumber(5)
  $pb.PbList<UploadPartUrl> get urls => $_getList(4);
}

class GetUploadPartUrlsRequest extends $pb.GeneratedMessage {
  factory GetUploadPartUrlsRequest({
    $core.String? uploadId,
    $core.Iterable<$core.int>? partNumbers,
  }) {
    final result = GetUploadPartUrlsRequest._();
    if (uploadId != null) result.uploadId = uploadId;
    if (partNumbers != null) result.partNumbers.addAll(partNumbers);
    return result;
  }

  GetUploadPartUrlsRequest._();

  factory GetUploadPartUrlsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUploadPartUrlsRequest()..mergeFromBuffer(data, registry);
  factory GetUploadPartUrlsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUploadPartUrlsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUploadPartUrlsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetUploadPartUrlsRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'uploadId')
    ..p<$core.int>(2, _omitFieldNames ? '' : 'partNumbers', $pb.PbFieldType.K3)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUploadPartUrlsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUploadPartUrlsRequest copyWith(
          void Function(GetUploadPartUrlsRequest) updates) =>
      super.copyWith((message) => updates(message as GetUploadPartUrlsRequest))
          as GetUploadPartUrlsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetUploadPartUrlsRequest() / GetUploadPartUrlsRequest.new instead')
  static GetUploadPartUrlsRequest create() => GetUploadPartUrlsRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetUploadPartUrlsRequest._();
  @$core.override
  GetUploadPartUrlsRequest createEmptyInstance() =>
      GetUploadPartUrlsRequest._();
  @$core.pragma('dart2js:noInline')
  static GetUploadPartUrlsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUploadPartUrlsRequest>(
          GetUploadPartUrlsRequest.$_createMessage);
  static GetUploadPartUrlsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uploadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uploadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUploadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUploadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$core.int> get partNumbers => $_getList(1);
}

class GetUploadPartUrlsResponse extends $pb.GeneratedMessage {
  factory GetUploadPartUrlsResponse({
    $core.Iterable<UploadPartUrl>? urls,
    $core.Iterable<CompletedPart>? uploadedParts,
  }) {
    final result = GetUploadPartUrlsResponse._();
    if (urls != null) result.urls.addAll(urls);
    if (uploadedParts != null) result.uploadedParts.addAll(uploadedParts);
    return result;
  }

  GetUploadPartUrlsResponse._();

  factory GetUploadPartUrlsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUploadPartUrlsResponse()..mergeFromBuffer(data, registry);
  factory GetUploadPartUrlsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUploadPartUrlsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUploadPartUrlsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetUploadPartUrlsResponse.$_createMessage)
    ..pPM<UploadPartUrl>(1, _omitFieldNames ? '' : 'urls',
        subBuilder: UploadPartUrl.$_createMessage)
    ..pPM<CompletedPart>(2, _omitFieldNames ? '' : 'uploadedParts',
        subBuilder: CompletedPart.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUploadPartUrlsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUploadPartUrlsResponse copyWith(
          void Function(GetUploadPartUrlsResponse) updates) =>
      super.copyWith((message) => updates(message as GetUploadPartUrlsResponse))
          as GetUploadPartUrlsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetUploadPartUrlsResponse() / GetUploadPartUrlsResponse.new instead')
  static GetUploadPartUrlsResponse create() => GetUploadPartUrlsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      GetUploadPartUrlsResponse._();
  @$core.override
  GetUploadPartUrlsResponse createEmptyInstance() =>
      GetUploadPartUrlsResponse._();
  @$core.pragma('dart2js:noInline')
  static GetUploadPartUrlsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetUploadPartUrlsResponse>(
          GetUploadPartUrlsResponse.$_createMessage);
  static GetUploadPartUrlsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<UploadPartUrl> get urls => $_getList(0);

  /// Parts object storage already has, so a resumed upload can skip them.
  @$pb.TagNumber(2)
  $pb.PbList<CompletedPart> get uploadedParts => $_getList(1);
}

class CompleteUploadRequest extends $pb.GeneratedMessage {
  factory CompleteUploadRequest({
    $core.String? uploadId,
    $core.Iterable<CompletedPart>? parts,
    $core.List<$core.int>? sha256,
    $core.List<$core.int>? thumbhash,
    $core.List<$core.int>? waveform,
  }) {
    final result = CompleteUploadRequest._();
    if (uploadId != null) result.uploadId = uploadId;
    if (parts != null) result.parts.addAll(parts);
    if (sha256 != null) result.sha256 = sha256;
    if (thumbhash != null) result.thumbhash = thumbhash;
    if (waveform != null) result.waveform = waveform;
    return result;
  }

  CompleteUploadRequest._();

  factory CompleteUploadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompleteUploadRequest()..mergeFromBuffer(data, registry);
  factory CompleteUploadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompleteUploadRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteUploadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CompleteUploadRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'uploadId')
    ..pPM<CompletedPart>(2, _omitFieldNames ? '' : 'parts',
        subBuilder: CompletedPart.$_createMessage)
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'sha256', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        4, _omitFieldNames ? '' : 'thumbhash', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(
        5, _omitFieldNames ? '' : 'waveform', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteUploadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteUploadRequest copyWith(
          void Function(CompleteUploadRequest) updates) =>
      super.copyWith((message) => updates(message as CompleteUploadRequest))
          as CompleteUploadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CompleteUploadRequest() / CompleteUploadRequest.new instead')
  static CompleteUploadRequest create() => CompleteUploadRequest._();
  static $pb.GeneratedMessage $_createMessage() => CompleteUploadRequest._();
  @$core.override
  CompleteUploadRequest createEmptyInstance() => CompleteUploadRequest._();
  @$core.pragma('dart2js:noInline')
  static CompleteUploadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteUploadRequest>(
          CompleteUploadRequest.$_createMessage);
  static CompleteUploadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uploadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uploadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUploadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUploadId() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<CompletedPart> get parts => $_getList(1);

  /// Optional client-computed SHA-256 of the whole file (integrity check).
  @$pb.TagNumber(3)
  $core.List<$core.int> get sha256 => $_getN(2);
  @$pb.TagNumber(3)
  set sha256($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasSha256() => $_has(2);
  @$pb.TagNumber(3)
  void clearSha256() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.List<$core.int> get thumbhash => $_getN(3);
  @$pb.TagNumber(4)
  set thumbhash($core.List<$core.int> value) => $_setBytes(3, value);
  @$pb.TagNumber(4)
  $core.bool hasThumbhash() => $_has(3);
  @$pb.TagNumber(4)
  void clearThumbhash() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.List<$core.int> get waveform => $_getN(4);
  @$pb.TagNumber(5)
  set waveform($core.List<$core.int> value) => $_setBytes(4, value);
  @$pb.TagNumber(5)
  $core.bool hasWaveform() => $_has(4);
  @$pb.TagNumber(5)
  void clearWaveform() => $_clearField(5);
}

class CompleteUploadResponse extends $pb.GeneratedMessage {
  factory CompleteUploadResponse({
    Media? media,
  }) {
    final result = CompleteUploadResponse._();
    if (media != null) result.media = media;
    return result;
  }

  CompleteUploadResponse._();

  factory CompleteUploadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompleteUploadResponse()..mergeFromBuffer(data, registry);
  factory CompleteUploadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CompleteUploadResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CompleteUploadResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CompleteUploadResponse.$_createMessage)
    ..aOM<Media>(1, _omitFieldNames ? '' : 'media',
        subBuilder: Media.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteUploadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CompleteUploadResponse copyWith(
          void Function(CompleteUploadResponse) updates) =>
      super.copyWith((message) => updates(message as CompleteUploadResponse))
          as CompleteUploadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CompleteUploadResponse() / CompleteUploadResponse.new instead')
  static CompleteUploadResponse create() => CompleteUploadResponse._();
  static $pb.GeneratedMessage $_createMessage() => CompleteUploadResponse._();
  @$core.override
  CompleteUploadResponse createEmptyInstance() => CompleteUploadResponse._();
  @$core.pragma('dart2js:noInline')
  static CompleteUploadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CompleteUploadResponse>(
          CompleteUploadResponse.$_createMessage);
  static CompleteUploadResponse? _defaultInstance;

  /// Photos and voice are usually READY at once; videos come back PROCESSING
  /// while transcoding but can be sent right away.
  @$pb.TagNumber(1)
  Media get media => $_getN(0);
  @$pb.TagNumber(1)
  set media(Media value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasMedia() => $_has(0);
  @$pb.TagNumber(1)
  void clearMedia() => $_clearField(1);
  @$pb.TagNumber(1)
  Media ensureMedia() => $_ensure(0);
}

class AbortUploadRequest extends $pb.GeneratedMessage {
  factory AbortUploadRequest({
    $core.String? uploadId,
  }) {
    final result = AbortUploadRequest._();
    if (uploadId != null) result.uploadId = uploadId;
    return result;
  }

  AbortUploadRequest._();

  factory AbortUploadRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AbortUploadRequest()..mergeFromBuffer(data, registry);
  factory AbortUploadRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AbortUploadRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AbortUploadRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: AbortUploadRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'uploadId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AbortUploadRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AbortUploadRequest copyWith(void Function(AbortUploadRequest) updates) =>
      super.copyWith((message) => updates(message as AbortUploadRequest))
          as AbortUploadRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use AbortUploadRequest() / AbortUploadRequest.new instead')
  static AbortUploadRequest create() => AbortUploadRequest._();
  static $pb.GeneratedMessage $_createMessage() => AbortUploadRequest._();
  @$core.override
  AbortUploadRequest createEmptyInstance() => AbortUploadRequest._();
  @$core.pragma('dart2js:noInline')
  static AbortUploadRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AbortUploadRequest>(
          AbortUploadRequest.$_createMessage);
  static AbortUploadRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get uploadId => $_getSZ(0);
  @$pb.TagNumber(1)
  set uploadId($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUploadId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUploadId() => $_clearField(1);
}

class AbortUploadResponse extends $pb.GeneratedMessage {
  factory AbortUploadResponse() => AbortUploadResponse._();

  AbortUploadResponse._();

  factory AbortUploadResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AbortUploadResponse()..mergeFromBuffer(data, registry);
  factory AbortUploadResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      AbortUploadResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'AbortUploadResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: AbortUploadResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AbortUploadResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  AbortUploadResponse copyWith(void Function(AbortUploadResponse) updates) =>
      super.copyWith((message) => updates(message as AbortUploadResponse))
          as AbortUploadResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use AbortUploadResponse() / AbortUploadResponse.new instead')
  static AbortUploadResponse create() => AbortUploadResponse._();
  static $pb.GeneratedMessage $_createMessage() => AbortUploadResponse._();
  @$core.override
  AbortUploadResponse createEmptyInstance() => AbortUploadResponse._();
  @$core.pragma('dart2js:noInline')
  static AbortUploadResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<AbortUploadResponse>(
          AbortUploadResponse.$_createMessage);
  static AbortUploadResponse? _defaultInstance;
}

enum GetDownloadUrlRequest_Context { message, userId, chatId, notSet }

class GetDownloadUrlRequest extends $pb.GeneratedMessage {
  factory GetDownloadUrlRequest({
    $fixnum.Int64? mediaId,
    $core.String? variant,
    $0.MessageRef? message,
    $fixnum.Int64? userId,
    $fixnum.Int64? chatId,
  }) {
    final result = GetDownloadUrlRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    if (variant != null) result.variant = variant;
    if (message != null) result.message = message;
    if (userId != null) result.userId = userId;
    if (chatId != null) result.chatId = chatId;
    return result;
  }

  GetDownloadUrlRequest._();

  factory GetDownloadUrlRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDownloadUrlRequest()..mergeFromBuffer(data, registry);
  factory GetDownloadUrlRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDownloadUrlRequest()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, GetDownloadUrlRequest_Context>
      _GetDownloadUrlRequest_ContextByTag = {
    3: GetDownloadUrlRequest_Context.message,
    4: GetDownloadUrlRequest_Context.userId,
    5: GetDownloadUrlRequest_Context.chatId,
    0: GetDownloadUrlRequest_Context.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDownloadUrlRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetDownloadUrlRequest.$_createMessage)
    ..oo(0, [3, 4, 5])
    ..aInt64(1, _omitFieldNames ? '' : 'mediaId')
    ..aOS(2, _omitFieldNames ? '' : 'variant')
    ..aOM<$0.MessageRef>(3, _omitFieldNames ? '' : 'message',
        subBuilder: $0.MessageRef.$_createMessage)
    ..aInt64(4, _omitFieldNames ? '' : 'userId')
    ..aInt64(5, _omitFieldNames ? '' : 'chatId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDownloadUrlRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDownloadUrlRequest copyWith(
          void Function(GetDownloadUrlRequest) updates) =>
      super.copyWith((message) => updates(message as GetDownloadUrlRequest))
          as GetDownloadUrlRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetDownloadUrlRequest() / GetDownloadUrlRequest.new instead')
  static GetDownloadUrlRequest create() => GetDownloadUrlRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetDownloadUrlRequest._();
  @$core.override
  GetDownloadUrlRequest createEmptyInstance() => GetDownloadUrlRequest._();
  @$core.pragma('dart2js:noInline')
  static GetDownloadUrlRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDownloadUrlRequest>(
          GetDownloadUrlRequest.$_createMessage);
  static GetDownloadUrlRequest? _defaultInstance;

  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  GetDownloadUrlRequest_Context whichContext() =>
      _GetDownloadUrlRequest_ContextByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  void clearContext() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get mediaId => $_getI64(0);
  @$pb.TagNumber(1)
  set mediaId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);

  /// Empty means the original file.
  @$pb.TagNumber(2)
  $core.String get variant => $_getSZ(1);
  @$pb.TagNumber(2)
  set variant($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasVariant() => $_has(1);
  @$pb.TagNumber(2)
  void clearVariant() => $_clearField(2);

  @$pb.TagNumber(3)
  $0.MessageRef get message => $_getN(2);
  @$pb.TagNumber(3)
  set message($0.MessageRef value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasMessage() => $_has(2);
  @$pb.TagNumber(3)
  void clearMessage() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.MessageRef ensureMessage() => $_ensure(2);

  @$pb.TagNumber(4)
  $fixnum.Int64 get userId => $_getI64(3);
  @$pb.TagNumber(4)
  set userId($fixnum.Int64 value) => $_setInt64(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUserId() => $_has(3);
  @$pb.TagNumber(4)
  void clearUserId() => $_clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get chatId => $_getI64(4);
  @$pb.TagNumber(5)
  set chatId($fixnum.Int64 value) => $_setInt64(4, value);
  @$pb.TagNumber(5)
  $core.bool hasChatId() => $_has(4);
  @$pb.TagNumber(5)
  void clearChatId() => $_clearField(5);
}

class GetDownloadUrlResponse extends $pb.GeneratedMessage {
  factory GetDownloadUrlResponse({
    $core.String? url,
    $fixnum.Int64? expiresAt,
  }) {
    final result = GetDownloadUrlResponse._();
    if (url != null) result.url = url;
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  GetDownloadUrlResponse._();

  factory GetDownloadUrlResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDownloadUrlResponse()..mergeFromBuffer(data, registry);
  factory GetDownloadUrlResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetDownloadUrlResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetDownloadUrlResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetDownloadUrlResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'url')
    ..aInt64(2, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDownloadUrlResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetDownloadUrlResponse copyWith(
          void Function(GetDownloadUrlResponse) updates) =>
      super.copyWith((message) => updates(message as GetDownloadUrlResponse))
          as GetDownloadUrlResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use GetDownloadUrlResponse() / GetDownloadUrlResponse.new instead')
  static GetDownloadUrlResponse create() => GetDownloadUrlResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetDownloadUrlResponse._();
  @$core.override
  GetDownloadUrlResponse createEmptyInstance() => GetDownloadUrlResponse._();
  @$core.pragma('dart2js:noInline')
  static GetDownloadUrlResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetDownloadUrlResponse>(
          GetDownloadUrlResponse.$_createMessage);
  static GetDownloadUrlResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get url => $_getSZ(0);
  @$pb.TagNumber(1)
  set url($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUrl() => $_has(0);
  @$pb.TagNumber(1)
  void clearUrl() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get expiresAt => $_getI64(1);
  @$pb.TagNumber(2)
  set expiresAt($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasExpiresAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearExpiresAt() => $_clearField(2);
}

/// MediaService: uploads and downloads. File bytes never go through the API
/// servers. The client PUTs parts straight to object storage with presigned
/// URLs (S3 multipart) and downloads from the CDN with short-lived signed URLs.
///
/// Upload flow (resumable, survives app restarts):
///   CreateUpload ─► PUT parts (parallel, 3 at a time on mobile) ─►
///   [GetUploadPartUrls to resume or refresh expired URLs] ─► CompleteUpload
class MediaServiceApi {
  final $pb.RpcClient _client;

  MediaServiceApi(this._client);

  $async.Future<CreateUploadResponse> createUpload(
          $pb.ClientContext? ctx, CreateUploadRequest request) =>
      _client.invoke<CreateUploadResponse>(
          ctx, 'MediaService', 'CreateUpload', request, CreateUploadResponse());
  $async.Future<GetUploadPartUrlsResponse> getUploadPartUrls(
          $pb.ClientContext? ctx, GetUploadPartUrlsRequest request) =>
      _client.invoke<GetUploadPartUrlsResponse>(ctx, 'MediaService',
          'GetUploadPartUrls', request, GetUploadPartUrlsResponse());
  $async.Future<CompleteUploadResponse> completeUpload(
          $pb.ClientContext? ctx, CompleteUploadRequest request) =>
      _client.invoke<CompleteUploadResponse>(ctx, 'MediaService',
          'CompleteUpload', request, CompleteUploadResponse());
  $async.Future<AbortUploadResponse> abortUpload(
          $pb.ClientContext? ctx, AbortUploadRequest request) =>
      _client.invoke<AbortUploadResponse>(
          ctx, 'MediaService', 'AbortUpload', request, AbortUploadResponse());
  $async.Future<GetDownloadUrlResponse> getDownloadUrl(
          $pb.ClientContext? ctx, GetDownloadUrlRequest request) =>
      _client.invoke<GetDownloadUrlResponse>(ctx, 'MediaService',
          'GetDownloadUrl', request, GetDownloadUrlResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
