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

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'users.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

class InputContact extends $pb.GeneratedMessage {
  factory InputContact({
    $fixnum.Int64? clientId,
    $core.String? phone,
    $core.String? firstName,
    $core.String? lastName,
  }) {
    final result = InputContact._();
    if (clientId != null) result.clientId = clientId;
    if (phone != null) result.phone = phone;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    return result;
  }

  InputContact._();

  factory InputContact.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InputContact()..mergeFromBuffer(data, registry);
  factory InputContact.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      InputContact()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'InputContact',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: InputContact.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'clientId')
    ..aOS(2, _omitFieldNames ? '' : 'phone')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputContact clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  InputContact copyWith(void Function(InputContact) updates) =>
      super.copyWith((message) => updates(message as InputContact))
          as InputContact;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use InputContact() / InputContact.new instead')
  static InputContact create() => InputContact._();
  static $pb.GeneratedMessage $_createMessage() => InputContact._();
  @$core.override
  InputContact createEmptyInstance() => InputContact._();
  @$core.pragma('dart2js:noInline')
  static InputContact getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<InputContact>(
          InputContact.$_createMessage);
  static InputContact? _defaultInstance;

  /// Client-side identifier, echoed back so results can be matched.
  @$pb.TagNumber(1)
  $fixnum.Int64 get clientId => $_getI64(0);
  @$pb.TagNumber(1)
  set clientId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientId() => $_clearField(1);

  /// Normalised to E.164 by the client (libphonenumber, default region IQ).
  @$pb.TagNumber(2)
  $core.String get phone => $_getSZ(1);
  @$pb.TagNumber(2)
  set phone($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPhone() => $_has(1);
  @$pb.TagNumber(2)
  void clearPhone() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get firstName => $_getSZ(2);
  @$pb.TagNumber(3)
  set firstName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasFirstName() => $_has(2);
  @$pb.TagNumber(3)
  void clearFirstName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get lastName => $_getSZ(3);
  @$pb.TagNumber(4)
  set lastName($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasLastName() => $_has(3);
  @$pb.TagNumber(4)
  void clearLastName() => $_clearField(4);
}

class ImportedContact extends $pb.GeneratedMessage {
  factory ImportedContact({
    $fixnum.Int64? clientId,
    $fixnum.Int64? userId,
  }) {
    final result = ImportedContact._();
    if (clientId != null) result.clientId = clientId;
    if (userId != null) result.userId = userId;
    return result;
  }

  ImportedContact._();

  factory ImportedContact.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportedContact()..mergeFromBuffer(data, registry);
  factory ImportedContact.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportedContact()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportedContact',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ImportedContact.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'clientId')
    ..aInt64(2, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportedContact clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportedContact copyWith(void Function(ImportedContact) updates) =>
      super.copyWith((message) => updates(message as ImportedContact))
          as ImportedContact;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ImportedContact() / ImportedContact.new instead')
  static ImportedContact create() => ImportedContact._();
  static $pb.GeneratedMessage $_createMessage() => ImportedContact._();
  @$core.override
  ImportedContact createEmptyInstance() => ImportedContact._();
  @$core.pragma('dart2js:noInline')
  static ImportedContact getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ImportedContact>(
          ImportedContact.$_createMessage);
  static ImportedContact? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get clientId => $_getI64(0);
  @$pb.TagNumber(1)
  set clientId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasClientId() => $_has(0);
  @$pb.TagNumber(1)
  void clearClientId() => $_clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get userId => $_getI64(1);
  @$pb.TagNumber(2)
  set userId($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasUserId() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserId() => $_clearField(2);
}

class ImportContactsRequest extends $pb.GeneratedMessage {
  factory ImportContactsRequest({
    $core.Iterable<InputContact>? contacts,
  }) {
    final result = ImportContactsRequest._();
    if (contacts != null) result.contacts.addAll(contacts);
    return result;
  }

  ImportContactsRequest._();

  factory ImportContactsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportContactsRequest()..mergeFromBuffer(data, registry);
  factory ImportContactsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportContactsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportContactsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ImportContactsRequest.$_createMessage)
    ..pPM<InputContact>(1, _omitFieldNames ? '' : 'contacts',
        subBuilder: InputContact.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportContactsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportContactsRequest copyWith(
          void Function(ImportContactsRequest) updates) =>
      super.copyWith((message) => updates(message as ImportContactsRequest))
          as ImportContactsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ImportContactsRequest() / ImportContactsRequest.new instead')
  static ImportContactsRequest create() => ImportContactsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ImportContactsRequest._();
  @$core.override
  ImportContactsRequest createEmptyInstance() => ImportContactsRequest._();
  @$core.pragma('dart2js:noInline')
  static ImportContactsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportContactsRequest>(
          ImportContactsRequest.$_createMessage);
  static ImportContactsRequest? _defaultInstance;

  /// At most 500 per call.
  @$pb.TagNumber(1)
  $pb.PbList<InputContact> get contacts => $_getList(0);
}

class ImportContactsResponse extends $pb.GeneratedMessage {
  factory ImportContactsResponse({
    $core.Iterable<ImportedContact>? imported,
    $core.Iterable<$0.User>? users,
    $core.Iterable<$fixnum.Int64>? retryClientIds,
  }) {
    final result = ImportContactsResponse._();
    if (imported != null) result.imported.addAll(imported);
    if (users != null) result.users.addAll(users);
    if (retryClientIds != null) result.retryClientIds.addAll(retryClientIds);
    return result;
  }

  ImportContactsResponse._();

  factory ImportContactsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportContactsResponse()..mergeFromBuffer(data, registry);
  factory ImportContactsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ImportContactsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ImportContactsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ImportContactsResponse.$_createMessage)
    ..pPM<ImportedContact>(1, _omitFieldNames ? '' : 'imported',
        subBuilder: ImportedContact.$_createMessage)
    ..pPM<$0.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $0.User.$_createMessage)
    ..p<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'retryClientIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportContactsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ImportContactsResponse copyWith(
          void Function(ImportContactsResponse) updates) =>
      super.copyWith((message) => updates(message as ImportContactsResponse))
          as ImportContactsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ImportContactsResponse() / ImportContactsResponse.new instead')
  static ImportContactsResponse create() => ImportContactsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ImportContactsResponse._();
  @$core.override
  ImportContactsResponse createEmptyInstance() => ImportContactsResponse._();
  @$core.pragma('dart2js:noInline')
  static ImportContactsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ImportContactsResponse>(
          ImportContactsResponse.$_createMessage);
  static ImportContactsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<ImportedContact> get imported => $_getList(0);

  @$pb.TagNumber(2)
  $pb.PbList<$0.User> get users => $_getList(1);

  /// client_ids skipped because of a rate limit; retry later.
  @$pb.TagNumber(3)
  $pb.PbList<$fixnum.Int64> get retryClientIds => $_getList(2);
}

class ListContactsRequest extends $pb.GeneratedMessage {
  factory ListContactsRequest({
    $fixnum.Int64? hash,
  }) {
    final result = ListContactsRequest._();
    if (hash != null) result.hash = hash;
    return result;
  }

  ListContactsRequest._();

  factory ListContactsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListContactsRequest()..mergeFromBuffer(data, registry);
  factory ListContactsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListContactsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListContactsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListContactsRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'hash')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListContactsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListContactsRequest copyWith(void Function(ListContactsRequest) updates) =>
      super.copyWith((message) => updates(message as ListContactsRequest))
          as ListContactsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ListContactsRequest() / ListContactsRequest.new instead')
  static ListContactsRequest create() => ListContactsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListContactsRequest._();
  @$core.override
  ListContactsRequest createEmptyInstance() => ListContactsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListContactsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListContactsRequest>(
          ListContactsRequest.$_createMessage);
  static ListContactsRequest? _defaultInstance;

  /// Hash of the client's current contact user_ids; when it matches, the
  /// server answers not_modified and sends nothing else.
  @$pb.TagNumber(1)
  $fixnum.Int64 get hash => $_getI64(0);
  @$pb.TagNumber(1)
  set hash($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearHash() => $_clearField(1);
}

class ListContactsResponse extends $pb.GeneratedMessage {
  factory ListContactsResponse({
    $core.bool? notModified,
    $core.Iterable<$0.User>? users,
    $fixnum.Int64? hash,
  }) {
    final result = ListContactsResponse._();
    if (notModified != null) result.notModified = notModified;
    if (users != null) result.users.addAll(users);
    if (hash != null) result.hash = hash;
    return result;
  }

  ListContactsResponse._();

  factory ListContactsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListContactsResponse()..mergeFromBuffer(data, registry);
  factory ListContactsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListContactsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListContactsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListContactsResponse.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'notModified')
    ..pPM<$0.User>(2, _omitFieldNames ? '' : 'users',
        subBuilder: $0.User.$_createMessage)
    ..aInt64(3, _omitFieldNames ? '' : 'hash')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListContactsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListContactsResponse copyWith(void Function(ListContactsResponse) updates) =>
      super.copyWith((message) => updates(message as ListContactsResponse))
          as ListContactsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListContactsResponse() / ListContactsResponse.new instead')
  static ListContactsResponse create() => ListContactsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListContactsResponse._();
  @$core.override
  ListContactsResponse createEmptyInstance() => ListContactsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListContactsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListContactsResponse>(
          ListContactsResponse.$_createMessage);
  static ListContactsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get notModified => $_getBF(0);
  @$pb.TagNumber(1)
  set notModified($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNotModified() => $_has(0);
  @$pb.TagNumber(1)
  void clearNotModified() => $_clearField(1);

  @$pb.TagNumber(2)
  $pb.PbList<$0.User> get users => $_getList(1);

  @$pb.TagNumber(3)
  $fixnum.Int64 get hash => $_getI64(2);
  @$pb.TagNumber(3)
  set hash($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHash() => $_has(2);
  @$pb.TagNumber(3)
  void clearHash() => $_clearField(3);
}

class DeleteContactsRequest extends $pb.GeneratedMessage {
  factory DeleteContactsRequest({
    $core.Iterable<$fixnum.Int64>? userIds,
  }) {
    final result = DeleteContactsRequest._();
    if (userIds != null) result.userIds.addAll(userIds);
    return result;
  }

  DeleteContactsRequest._();

  factory DeleteContactsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteContactsRequest()..mergeFromBuffer(data, registry);
  factory DeleteContactsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteContactsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteContactsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DeleteContactsRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteContactsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteContactsRequest copyWith(
          void Function(DeleteContactsRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteContactsRequest))
          as DeleteContactsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteContactsRequest() / DeleteContactsRequest.new instead')
  static DeleteContactsRequest create() => DeleteContactsRequest._();
  static $pb.GeneratedMessage $_createMessage() => DeleteContactsRequest._();
  @$core.override
  DeleteContactsRequest createEmptyInstance() => DeleteContactsRequest._();
  @$core.pragma('dart2js:noInline')
  static DeleteContactsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteContactsRequest>(
          DeleteContactsRequest.$_createMessage);
  static DeleteContactsRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get userIds => $_getList(0);
}

class DeleteContactsResponse extends $pb.GeneratedMessage {
  factory DeleteContactsResponse() => DeleteContactsResponse._();

  DeleteContactsResponse._();

  factory DeleteContactsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteContactsResponse()..mergeFromBuffer(data, registry);
  factory DeleteContactsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteContactsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteContactsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DeleteContactsResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteContactsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteContactsResponse copyWith(
          void Function(DeleteContactsResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteContactsResponse))
          as DeleteContactsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteContactsResponse() / DeleteContactsResponse.new instead')
  static DeleteContactsResponse create() => DeleteContactsResponse._();
  static $pb.GeneratedMessage $_createMessage() => DeleteContactsResponse._();
  @$core.override
  DeleteContactsResponse createEmptyInstance() => DeleteContactsResponse._();
  @$core.pragma('dart2js:noInline')
  static DeleteContactsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteContactsResponse>(
          DeleteContactsResponse.$_createMessage);
  static DeleteContactsResponse? _defaultInstance;
}

/// ContactsService: phone-book sync.
///
/// Anti-abuse: ImportContacts is the main phone-number enumeration vector.
/// The server caps imports per account per day and the total number of
/// distinct numbers an account may ever look up; see docs/01-architecture.md §8.
class ContactsServiceApi {
  final $pb.RpcClient _client;

  ContactsServiceApi(this._client);

  $async.Future<ImportContactsResponse> importContacts(
          $pb.ClientContext? ctx, ImportContactsRequest request) =>
      _client.invoke<ImportContactsResponse>(ctx, 'ContactsService',
          'ImportContacts', request, ImportContactsResponse());
  $async.Future<ListContactsResponse> listContacts(
          $pb.ClientContext? ctx, ListContactsRequest request) =>
      _client.invoke<ListContactsResponse>(ctx, 'ContactsService',
          'ListContacts', request, ListContactsResponse());
  $async.Future<DeleteContactsResponse> deleteContacts(
          $pb.ClientContext? ctx, DeleteContactsRequest request) =>
      _client.invoke<DeleteContactsResponse>(ctx, 'ContactsService',
          'DeleteContacts', request, DeleteContactsResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
