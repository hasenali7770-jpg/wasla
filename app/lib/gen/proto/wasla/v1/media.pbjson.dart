// This is a generated file - do not edit.
//
// Generated from wasla/v1/media.proto.

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

@$core.Deprecated('Use mediaKindDescriptor instead')
const MediaKind$json = {
  '1': 'MediaKind',
  '2': [
    {'1': 'MEDIA_KIND_UNSPECIFIED', '2': 0},
    {'1': 'MEDIA_KIND_PHOTO', '2': 1},
    {'1': 'MEDIA_KIND_VIDEO', '2': 2},
    {'1': 'MEDIA_KIND_DOCUMENT', '2': 3},
    {'1': 'MEDIA_KIND_VOICE', '2': 4},
    {'1': 'MEDIA_KIND_AUDIO', '2': 5},
    {'1': 'MEDIA_KIND_ANIMATION', '2': 6},
  ],
};

/// Descriptor for `MediaKind`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaKindDescriptor = $convert.base64Decode(
    'CglNZWRpYUtpbmQSGgoWTUVESUFfS0lORF9VTlNQRUNJRklFRBAAEhQKEE1FRElBX0tJTkRfUE'
    'hPVE8QARIUChBNRURJQV9LSU5EX1ZJREVPEAISFwoTTUVESUFfS0lORF9ET0NVTUVOVBADEhQK'
    'EE1FRElBX0tJTkRfVk9JQ0UQBBIUChBNRURJQV9LSU5EX0FVRElPEAUSGAoUTUVESUFfS0lORF'
    '9BTklNQVRJT04QBg==');

@$core.Deprecated('Use mediaStatusDescriptor instead')
const MediaStatus$json = {
  '1': 'MediaStatus',
  '2': [
    {'1': 'MEDIA_STATUS_UNSPECIFIED', '2': 0},
    {'1': 'MEDIA_STATUS_UPLOADING', '2': 1},
    {'1': 'MEDIA_STATUS_PROCESSING', '2': 2},
    {'1': 'MEDIA_STATUS_READY', '2': 3},
    {'1': 'MEDIA_STATUS_FAILED', '2': 4},
  ],
};

/// Descriptor for `MediaStatus`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaStatusDescriptor = $convert.base64Decode(
    'CgtNZWRpYVN0YXR1cxIcChhNRURJQV9TVEFUVVNfVU5TUEVDSUZJRUQQABIaChZNRURJQV9TVE'
    'FUVVNfVVBMT0FESU5HEAESGwoXTUVESUFfU1RBVFVTX1BST0NFU1NJTkcQAhIWChJNRURJQV9T'
    'VEFUVVNfUkVBRFkQAxIXChNNRURJQV9TVEFUVVNfRkFJTEVEEAQ=');

@$core.Deprecated('Use mediaDescriptor instead')
const Media$json = {
  '1': 'Media',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 3, '10': 'id'},
    {
      '1': 'kind',
      '3': 2,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.MediaKind',
      '10': 'kind'
    },
    {'1': 'mime_type', '3': 3, '4': 1, '5': 9, '10': 'mimeType'},
    {'1': 'size_bytes', '3': 4, '4': 1, '5': 3, '10': 'sizeBytes'},
    {'1': 'file_name', '3': 5, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'width', '3': 6, '4': 1, '5': 5, '10': 'width'},
    {'1': 'height', '3': 7, '4': 1, '5': 5, '10': 'height'},
    {'1': 'duration_ms', '3': 8, '4': 1, '5': 5, '10': 'durationMs'},
    {'1': 'thumbhash', '3': 9, '4': 1, '5': 12, '10': 'thumbhash'},
    {'1': 'waveform', '3': 10, '4': 1, '5': 12, '10': 'waveform'},
    {
      '1': 'variants',
      '3': 11,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.MediaVariant',
      '10': 'variants'
    },
    {
      '1': 'status',
      '3': 12,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.MediaStatus',
      '10': 'status'
    },
  ],
};

/// Descriptor for `Media`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaDescriptor = $convert.base64Decode(
    'CgVNZWRpYRIOCgJpZBgBIAEoA1ICaWQSJwoEa2luZBgCIAEoDjITLndhc2xhLnYxLk1lZGlhS2'
    'luZFIEa2luZBIbCgltaW1lX3R5cGUYAyABKAlSCG1pbWVUeXBlEh0KCnNpemVfYnl0ZXMYBCAB'
    'KANSCXNpemVCeXRlcxIbCglmaWxlX25hbWUYBSABKAlSCGZpbGVOYW1lEhQKBXdpZHRoGAYgAS'
    'gFUgV3aWR0aBIWCgZoZWlnaHQYByABKAVSBmhlaWdodBIfCgtkdXJhdGlvbl9tcxgIIAEoBVIK'
    'ZHVyYXRpb25NcxIcCgl0aHVtYmhhc2gYCSABKAxSCXRodW1iaGFzaBIaCgh3YXZlZm9ybRgKIA'
    'EoDFIId2F2ZWZvcm0SMgoIdmFyaWFudHMYCyADKAsyFi53YXNsYS52MS5NZWRpYVZhcmlhbnRS'
    'CHZhcmlhbnRzEi0KBnN0YXR1cxgMIAEoDjIVLndhc2xhLnYxLk1lZGlhU3RhdHVzUgZzdGF0dX'
    'M=');

@$core.Deprecated('Use mediaVariantDescriptor instead')
const MediaVariant$json = {
  '1': 'MediaVariant',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 9, '10': 'type'},
    {'1': 'width', '3': 2, '4': 1, '5': 5, '10': 'width'},
    {'1': 'height', '3': 3, '4': 1, '5': 5, '10': 'height'},
    {'1': 'size_bytes', '3': 4, '4': 1, '5': 3, '10': 'sizeBytes'},
  ],
};

/// Descriptor for `MediaVariant`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mediaVariantDescriptor = $convert.base64Decode(
    'CgxNZWRpYVZhcmlhbnQSEgoEdHlwZRgBIAEoCVIEdHlwZRIUCgV3aWR0aBgCIAEoBVIFd2lkdG'
    'gSFgoGaGVpZ2h0GAMgASgFUgZoZWlnaHQSHQoKc2l6ZV9ieXRlcxgEIAEoA1IJc2l6ZUJ5dGVz');

@$core.Deprecated('Use uploadPartUrlDescriptor instead')
const UploadPartUrl$json = {
  '1': 'UploadPartUrl',
  '2': [
    {'1': 'part_number', '3': 1, '4': 1, '5': 5, '10': 'partNumber'},
    {'1': 'url', '3': 2, '4': 1, '5': 9, '10': 'url'},
    {'1': 'expires_at', '3': 3, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `UploadPartUrl`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List uploadPartUrlDescriptor = $convert.base64Decode(
    'Cg1VcGxvYWRQYXJ0VXJsEh8KC3BhcnRfbnVtYmVyGAEgASgFUgpwYXJ0TnVtYmVyEhAKA3VybB'
    'gCIAEoCVIDdXJsEh0KCmV4cGlyZXNfYXQYAyABKANSCWV4cGlyZXNBdA==');

@$core.Deprecated('Use completedPartDescriptor instead')
const CompletedPart$json = {
  '1': 'CompletedPart',
  '2': [
    {'1': 'part_number', '3': 1, '4': 1, '5': 5, '10': 'partNumber'},
    {'1': 'etag', '3': 2, '4': 1, '5': 9, '10': 'etag'},
  ],
};

/// Descriptor for `CompletedPart`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completedPartDescriptor = $convert.base64Decode(
    'Cg1Db21wbGV0ZWRQYXJ0Eh8KC3BhcnRfbnVtYmVyGAEgASgFUgpwYXJ0TnVtYmVyEhIKBGV0YW'
    'cYAiABKAlSBGV0YWc=');

@$core.Deprecated('Use createUploadRequestDescriptor instead')
const CreateUploadRequest$json = {
  '1': 'CreateUploadRequest',
  '2': [
    {
      '1': 'kind',
      '3': 1,
      '4': 1,
      '5': 14,
      '6': '.wasla.v1.MediaKind',
      '10': 'kind'
    },
    {'1': 'mime_type', '3': 2, '4': 1, '5': 9, '10': 'mimeType'},
    {'1': 'size_bytes', '3': 3, '4': 1, '5': 3, '10': 'sizeBytes'},
    {'1': 'file_name', '3': 4, '4': 1, '5': 9, '10': 'fileName'},
    {'1': 'width', '3': 5, '4': 1, '5': 5, '10': 'width'},
    {'1': 'height', '3': 6, '4': 1, '5': 5, '10': 'height'},
    {'1': 'duration_ms', '3': 7, '4': 1, '5': 5, '10': 'durationMs'},
  ],
};

/// Descriptor for `CreateUploadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUploadRequestDescriptor = $convert.base64Decode(
    'ChNDcmVhdGVVcGxvYWRSZXF1ZXN0EicKBGtpbmQYASABKA4yEy53YXNsYS52MS5NZWRpYUtpbm'
    'RSBGtpbmQSGwoJbWltZV90eXBlGAIgASgJUghtaW1lVHlwZRIdCgpzaXplX2J5dGVzGAMgASgD'
    'UglzaXplQnl0ZXMSGwoJZmlsZV9uYW1lGAQgASgJUghmaWxlTmFtZRIUCgV3aWR0aBgFIAEoBV'
    'IFd2lkdGgSFgoGaGVpZ2h0GAYgASgFUgZoZWlnaHQSHwoLZHVyYXRpb25fbXMYByABKAVSCmR1'
    'cmF0aW9uTXM=');

@$core.Deprecated('Use createUploadResponseDescriptor instead')
const CreateUploadResponse$json = {
  '1': 'CreateUploadResponse',
  '2': [
    {'1': 'upload_id', '3': 1, '4': 1, '5': 9, '10': 'uploadId'},
    {'1': 'media_id', '3': 2, '4': 1, '5': 3, '10': 'mediaId'},
    {'1': 'part_size_bytes', '3': 3, '4': 1, '5': 5, '10': 'partSizeBytes'},
    {'1': 'part_count', '3': 4, '4': 1, '5': 5, '10': 'partCount'},
    {
      '1': 'urls',
      '3': 5,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.UploadPartUrl',
      '10': 'urls'
    },
  ],
};

/// Descriptor for `CreateUploadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List createUploadResponseDescriptor = $convert.base64Decode(
    'ChRDcmVhdGVVcGxvYWRSZXNwb25zZRIbCgl1cGxvYWRfaWQYASABKAlSCHVwbG9hZElkEhkKCG'
    '1lZGlhX2lkGAIgASgDUgdtZWRpYUlkEiYKD3BhcnRfc2l6ZV9ieXRlcxgDIAEoBVINcGFydFNp'
    'emVCeXRlcxIdCgpwYXJ0X2NvdW50GAQgASgFUglwYXJ0Q291bnQSKwoEdXJscxgFIAMoCzIXLn'
    'dhc2xhLnYxLlVwbG9hZFBhcnRVcmxSBHVybHM=');

@$core.Deprecated('Use getUploadPartUrlsRequestDescriptor instead')
const GetUploadPartUrlsRequest$json = {
  '1': 'GetUploadPartUrlsRequest',
  '2': [
    {'1': 'upload_id', '3': 1, '4': 1, '5': 9, '10': 'uploadId'},
    {'1': 'part_numbers', '3': 2, '4': 3, '5': 5, '10': 'partNumbers'},
  ],
};

/// Descriptor for `GetUploadPartUrlsRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUploadPartUrlsRequestDescriptor =
    $convert.base64Decode(
        'ChhHZXRVcGxvYWRQYXJ0VXJsc1JlcXVlc3QSGwoJdXBsb2FkX2lkGAEgASgJUgh1cGxvYWRJZB'
        'IhCgxwYXJ0X251bWJlcnMYAiADKAVSC3BhcnROdW1iZXJz');

@$core.Deprecated('Use getUploadPartUrlsResponseDescriptor instead')
const GetUploadPartUrlsResponse$json = {
  '1': 'GetUploadPartUrlsResponse',
  '2': [
    {
      '1': 'urls',
      '3': 1,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.UploadPartUrl',
      '10': 'urls'
    },
    {
      '1': 'uploaded_parts',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.CompletedPart',
      '10': 'uploadedParts'
    },
  ],
};

/// Descriptor for `GetUploadPartUrlsResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getUploadPartUrlsResponseDescriptor = $convert.base64Decode(
    'ChlHZXRVcGxvYWRQYXJ0VXJsc1Jlc3BvbnNlEisKBHVybHMYASADKAsyFy53YXNsYS52MS5VcG'
    'xvYWRQYXJ0VXJsUgR1cmxzEj4KDnVwbG9hZGVkX3BhcnRzGAIgAygLMhcud2FzbGEudjEuQ29t'
    'cGxldGVkUGFydFINdXBsb2FkZWRQYXJ0cw==');

@$core.Deprecated('Use completeUploadRequestDescriptor instead')
const CompleteUploadRequest$json = {
  '1': 'CompleteUploadRequest',
  '2': [
    {'1': 'upload_id', '3': 1, '4': 1, '5': 9, '10': 'uploadId'},
    {
      '1': 'parts',
      '3': 2,
      '4': 3,
      '5': 11,
      '6': '.wasla.v1.CompletedPart',
      '10': 'parts'
    },
    {'1': 'sha256', '3': 3, '4': 1, '5': 12, '10': 'sha256'},
    {'1': 'thumbhash', '3': 4, '4': 1, '5': 12, '10': 'thumbhash'},
    {'1': 'waveform', '3': 5, '4': 1, '5': 12, '10': 'waveform'},
  ],
};

/// Descriptor for `CompleteUploadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeUploadRequestDescriptor = $convert.base64Decode(
    'ChVDb21wbGV0ZVVwbG9hZFJlcXVlc3QSGwoJdXBsb2FkX2lkGAEgASgJUgh1cGxvYWRJZBItCg'
    'VwYXJ0cxgCIAMoCzIXLndhc2xhLnYxLkNvbXBsZXRlZFBhcnRSBXBhcnRzEhYKBnNoYTI1NhgD'
    'IAEoDFIGc2hhMjU2EhwKCXRodW1iaGFzaBgEIAEoDFIJdGh1bWJoYXNoEhoKCHdhdmVmb3JtGA'
    'UgASgMUgh3YXZlZm9ybQ==');

@$core.Deprecated('Use completeUploadResponseDescriptor instead')
const CompleteUploadResponse$json = {
  '1': 'CompleteUploadResponse',
  '2': [
    {
      '1': 'media',
      '3': 1,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.Media',
      '10': 'media'
    },
  ],
};

/// Descriptor for `CompleteUploadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List completeUploadResponseDescriptor =
    $convert.base64Decode(
        'ChZDb21wbGV0ZVVwbG9hZFJlc3BvbnNlEiUKBW1lZGlhGAEgASgLMg8ud2FzbGEudjEuTWVkaW'
        'FSBW1lZGlh');

@$core.Deprecated('Use abortUploadRequestDescriptor instead')
const AbortUploadRequest$json = {
  '1': 'AbortUploadRequest',
  '2': [
    {'1': 'upload_id', '3': 1, '4': 1, '5': 9, '10': 'uploadId'},
  ],
};

/// Descriptor for `AbortUploadRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List abortUploadRequestDescriptor =
    $convert.base64Decode(
        'ChJBYm9ydFVwbG9hZFJlcXVlc3QSGwoJdXBsb2FkX2lkGAEgASgJUgh1cGxvYWRJZA==');

@$core.Deprecated('Use abortUploadResponseDescriptor instead')
const AbortUploadResponse$json = {
  '1': 'AbortUploadResponse',
};

/// Descriptor for `AbortUploadResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List abortUploadResponseDescriptor =
    $convert.base64Decode('ChNBYm9ydFVwbG9hZFJlc3BvbnNl');

@$core.Deprecated('Use getDownloadUrlRequestDescriptor instead')
const GetDownloadUrlRequest$json = {
  '1': 'GetDownloadUrlRequest',
  '2': [
    {'1': 'media_id', '3': 1, '4': 1, '5': 3, '10': 'mediaId'},
    {'1': 'variant', '3': 2, '4': 1, '5': 9, '10': 'variant'},
    {
      '1': 'message',
      '3': 3,
      '4': 1,
      '5': 11,
      '6': '.wasla.v1.MessageRef',
      '9': 0,
      '10': 'message'
    },
    {'1': 'user_id', '3': 4, '4': 1, '5': 3, '9': 0, '10': 'userId'},
    {'1': 'chat_id', '3': 5, '4': 1, '5': 3, '9': 0, '10': 'chatId'},
  ],
  '8': [
    {'1': 'context'},
  ],
};

/// Descriptor for `GetDownloadUrlRequest`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDownloadUrlRequestDescriptor = $convert.base64Decode(
    'ChVHZXREb3dubG9hZFVybFJlcXVlc3QSGQoIbWVkaWFfaWQYASABKANSB21lZGlhSWQSGAoHdm'
    'FyaWFudBgCIAEoCVIHdmFyaWFudBIwCgdtZXNzYWdlGAMgASgLMhQud2FzbGEudjEuTWVzc2Fn'
    'ZVJlZkgAUgdtZXNzYWdlEhkKB3VzZXJfaWQYBCABKANIAFIGdXNlcklkEhkKB2NoYXRfaWQYBS'
    'ABKANIAFIGY2hhdElkQgkKB2NvbnRleHQ=');

@$core.Deprecated('Use getDownloadUrlResponseDescriptor instead')
const GetDownloadUrlResponse$json = {
  '1': 'GetDownloadUrlResponse',
  '2': [
    {'1': 'url', '3': 1, '4': 1, '5': 9, '10': 'url'},
    {'1': 'expires_at', '3': 2, '4': 1, '5': 3, '10': 'expiresAt'},
  ],
};

/// Descriptor for `GetDownloadUrlResponse`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List getDownloadUrlResponseDescriptor =
    $convert.base64Decode(
        'ChZHZXREb3dubG9hZFVybFJlc3BvbnNlEhAKA3VybBgBIAEoCVIDdXJsEh0KCmV4cGlyZXNfYX'
        'QYAiABKANSCWV4cGlyZXNBdA==');

const $core.Map<$core.String, $core.dynamic> MediaServiceBase$json = {
  '1': 'MediaService',
  '2': [
    {
      '1': 'CreateUpload',
      '2': '.wasla.v1.CreateUploadRequest',
      '3': '.wasla.v1.CreateUploadResponse'
    },
    {
      '1': 'GetUploadPartUrls',
      '2': '.wasla.v1.GetUploadPartUrlsRequest',
      '3': '.wasla.v1.GetUploadPartUrlsResponse'
    },
    {
      '1': 'CompleteUpload',
      '2': '.wasla.v1.CompleteUploadRequest',
      '3': '.wasla.v1.CompleteUploadResponse'
    },
    {
      '1': 'AbortUpload',
      '2': '.wasla.v1.AbortUploadRequest',
      '3': '.wasla.v1.AbortUploadResponse'
    },
    {
      '1': 'GetDownloadUrl',
      '2': '.wasla.v1.GetDownloadUrlRequest',
      '3': '.wasla.v1.GetDownloadUrlResponse'
    },
  ],
};

@$core.Deprecated('Use mediaServiceDescriptor instead')
const $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
    MediaServiceBase$messageJson = {
  '.wasla.v1.CreateUploadRequest': CreateUploadRequest$json,
  '.wasla.v1.CreateUploadResponse': CreateUploadResponse$json,
  '.wasla.v1.UploadPartUrl': UploadPartUrl$json,
  '.wasla.v1.GetUploadPartUrlsRequest': GetUploadPartUrlsRequest$json,
  '.wasla.v1.GetUploadPartUrlsResponse': GetUploadPartUrlsResponse$json,
  '.wasla.v1.CompletedPart': CompletedPart$json,
  '.wasla.v1.CompleteUploadRequest': CompleteUploadRequest$json,
  '.wasla.v1.CompleteUploadResponse': CompleteUploadResponse$json,
  '.wasla.v1.Media': Media$json,
  '.wasla.v1.MediaVariant': MediaVariant$json,
  '.wasla.v1.AbortUploadRequest': AbortUploadRequest$json,
  '.wasla.v1.AbortUploadResponse': AbortUploadResponse$json,
  '.wasla.v1.GetDownloadUrlRequest': GetDownloadUrlRequest$json,
  '.wasla.v1.MessageRef': $0.MessageRef$json,
  '.wasla.v1.GetDownloadUrlResponse': GetDownloadUrlResponse$json,
};

/// Descriptor for `MediaService`. Decode as a `google.protobuf.ServiceDescriptorProto`.
final $typed_data.Uint8List mediaServiceDescriptor = $convert.base64Decode(
    'CgxNZWRpYVNlcnZpY2USTQoMQ3JlYXRlVXBsb2FkEh0ud2FzbGEudjEuQ3JlYXRlVXBsb2FkUm'
    'VxdWVzdBoeLndhc2xhLnYxLkNyZWF0ZVVwbG9hZFJlc3BvbnNlElwKEUdldFVwbG9hZFBhcnRV'
    'cmxzEiIud2FzbGEudjEuR2V0VXBsb2FkUGFydFVybHNSZXF1ZXN0GiMud2FzbGEudjEuR2V0VX'
    'Bsb2FkUGFydFVybHNSZXNwb25zZRJTCg5Db21wbGV0ZVVwbG9hZBIfLndhc2xhLnYxLkNvbXBs'
    'ZXRlVXBsb2FkUmVxdWVzdBogLndhc2xhLnYxLkNvbXBsZXRlVXBsb2FkUmVzcG9uc2USSgoLQW'
    'JvcnRVcGxvYWQSHC53YXNsYS52MS5BYm9ydFVwbG9hZFJlcXVlc3QaHS53YXNsYS52MS5BYm9y'
    'dFVwbG9hZFJlc3BvbnNlElMKDkdldERvd25sb2FkVXJsEh8ud2FzbGEudjEuR2V0RG93bmxvYW'
    'RVcmxSZXF1ZXN0GiAud2FzbGEudjEuR2V0RG93bmxvYWRVcmxSZXNwb25zZQ==');
