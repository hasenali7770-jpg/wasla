// This is a generated file - do not edit.
//
// Generated from wasla/v1/updates.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'updates.pb.dart' as $5;
import 'updates.pbjson.dart';

export 'updates.pb.dart';

abstract class UpdatesServiceBase extends $pb.GeneratedService {
  $async.Future<$5.GetStateResponse> getState(
      $pb.ServerContext ctx, $5.GetStateRequest request);
  $async.Future<$5.GetDifferenceResponse> getDifference(
      $pb.ServerContext ctx, $5.GetDifferenceRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'GetState':
        return $5.GetStateRequest();
      case 'GetDifference':
        return $5.GetDifferenceRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'GetState':
        return getState(ctx, request as $5.GetStateRequest);
      case 'GetDifference':
        return getDifference(ctx, request as $5.GetDifferenceRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => UpdatesServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => UpdatesServiceBase$messageJson;
}
