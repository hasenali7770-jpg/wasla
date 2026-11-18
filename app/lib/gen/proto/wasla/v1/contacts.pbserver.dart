// This is a generated file - do not edit.
//
// Generated from wasla/v1/contacts.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'contacts.pb.dart' as $2;
import 'contacts.pbjson.dart';

export 'contacts.pb.dart';

abstract class ContactsServiceBase extends $pb.GeneratedService {
  $async.Future<$2.ImportContactsResponse> importContacts(
      $pb.ServerContext ctx, $2.ImportContactsRequest request);
  $async.Future<$2.ListContactsResponse> listContacts(
      $pb.ServerContext ctx, $2.ListContactsRequest request);
  $async.Future<$2.DeleteContactsResponse> deleteContacts(
      $pb.ServerContext ctx, $2.DeleteContactsRequest request);

  $pb.GeneratedMessage createRequest($core.String methodName) {
    switch (methodName) {
      case 'ImportContacts':
        return $2.ImportContactsRequest();
      case 'ListContacts':
        return $2.ListContactsRequest();
      case 'DeleteContacts':
        return $2.DeleteContactsRequest();
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $async.Future<$pb.GeneratedMessage> handleCall($pb.ServerContext ctx,
      $core.String methodName, $pb.GeneratedMessage request) {
    switch (methodName) {
      case 'ImportContacts':
        return importContacts(ctx, request as $2.ImportContactsRequest);
      case 'ListContacts':
        return listContacts(ctx, request as $2.ListContactsRequest);
      case 'DeleteContacts':
        return deleteContacts(ctx, request as $2.DeleteContactsRequest);
      default:
        throw $core.ArgumentError('Unknown method: $methodName');
    }
  }

  $core.Map<$core.String, $core.dynamic> get $json => ContactsServiceBase$json;
  $core.Map<$core.String, $core.Map<$core.String, $core.dynamic>>
      get $messageJson => ContactsServiceBase$messageJson;
}
