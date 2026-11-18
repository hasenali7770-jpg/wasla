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

import 'package:protobuf/protobuf.dart' as $pb;

import 'media.pb.dart' as $1;
import 'media.pbjson.dart';

export 'media.pb.dart';

abstract class MediaServiceBase extends $pb.GeneratedService {
  $async.Future<$1.CreateUploadResponse> createUpload(
      $pb.ServerContext ctx, $1.CreateUploadRequest request);
  $async.Future<$1.GetUploadPartUrlsResponse> getUploadPartUrls(
      $pb.ServerContext ctx, $1.GetUploadPartUrlsRequest request);
  $async.Future<$1.CompleteUploadResponse> completeUpload(
      $pb.ServerContext ctx, $1.CompleteUploadRequest request);
  $async.Future<$1.AbortUploadResponse> abortUpload(
      $pb.ServerContext ctx, $1.AbortUploadRequest request);
  $async.Future<$1.GetDownloadUrlResponse> getDownloadUrl(
      $pb.ServerContext ctx, $1.GetDownloadUrlRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'CreateUpload':
        return $1.CreateUploadRequest();
      case 'GetUploadPartUrls':
        return $1.GetUploadPartUrlsRequest();
      case 'CompleteUpload':
        return $1.CompleteUploadRequest();
      case 'AbortUpload':
        return $1.AbortUploadRequest();
      case 'GetDownloadUrl':
        return $1.GetDownloadUrlRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'CreateUpload':
        return createUpload(ctx, request as $1.CreateUploadRequest);
      case 'GetUploadPartUrls':
        return getUploadPartUrls(ctx, request as $1.GetUploadPartUrlsRequest);
      case 'CompleteUpload':
        return completeUpload(ctx, request as $1.CompleteUploadRequest);
      case 'AbortUpload':
        return abortUpload(ctx, request as $1.AbortUploadRequest);
      case 'GetDownloadUrl':
        return getDownloadUrl(ctx, request as $1.GetDownloadUrlRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => MediaServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => MediaServiceBase$messageJson;
}
