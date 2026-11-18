// This is a generated file - do not edit.
//
// Generated from wasla/v1/users.proto.

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
import 'users.pbenum.dart';

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'users.pbenum.dart';

/// User as seen by the requesting user: fields hidden by the target's privacy
/// settings are left empty.
class User extends $pb.GeneratedMessage {
  factory User({
    $fixnum.Int64? id,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? username,
    $core.String? phone,
    $core.String? bio,
    $0.Avatar? photo,
    UserStatus? status,
    $core.bool? isSelf,
    $core.bool? isContact,
    $core.bool? isMutualContact,
    $core.bool? isBlocked,
    $core.bool? isDeleted,
  }) {
    final result = User._();
    if (id != null) result.id = id;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (username != null) result.username = username;
    if (phone != null) result.phone = phone;
    if (bio != null) result.bio = bio;
    if (photo != null) result.photo = photo;
    if (status != null) result.status = status;
    if (isSelf != null) result.isSelf = isSelf;
    if (isContact != null) result.isContact = isContact;
    if (isMutualContact != null) result.isMutualContact = isMutualContact;
    if (isBlocked != null) result.isBlocked = isBlocked;
    if (isDeleted != null) result.isDeleted = isDeleted;
    return result;
  }

  User._();

  factory User.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      User()..mergeFromBuffer(data, registry);
  factory User.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      User()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'User',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: User.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'firstName')
    ..aOS(3, _omitFieldNames ? '' : 'lastName')
    ..aOS(4, _omitFieldNames ? '' : 'username')
    ..aOS(5, _omitFieldNames ? '' : 'phone')
    ..aOS(6, _omitFieldNames ? '' : 'bio')
    ..aOM<$0.Avatar>(7, _omitFieldNames ? '' : 'photo',
        subBuilder: $0.Avatar.$_createMessage)
    ..aOM<UserStatus>(8, _omitFieldNames ? '' : 'status',
        subBuilder: UserStatus.$_createMessage)
    ..aOB(9, _omitFieldNames ? '' : 'isSelf')
    ..aOB(10, _omitFieldNames ? '' : 'isContact')
    ..aOB(11, _omitFieldNames ? '' : 'isMutualContact')
    ..aOB(12, _omitFieldNames ? '' : 'isBlocked')
    ..aOB(13, _omitFieldNames ? '' : 'isDeleted')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  User copyWith(void Function(User) updates) =>
      super.copyWith((message) => updates(message as User)) as User;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use User() / User.new instead')
  static User create() => User._();
  static $pb.GeneratedMessage $_createMessage() => User._();
  @$core.override
  User createEmptyInstance() => User._();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<User>(User.$_createMessage);
  static User? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get firstName => $_getSZ(1);
  @$pb.TagNumber(2)
  set firstName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasFirstName() => $_has(1);
  @$pb.TagNumber(2)
  void clearFirstName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get lastName => $_getSZ(2);
  @$pb.TagNumber(3)
  set lastName($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasLastName() => $_has(2);
  @$pb.TagNumber(3)
  void clearLastName() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get username => $_getSZ(3);
  @$pb.TagNumber(4)
  set username($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasUsername() => $_has(3);
  @$pb.TagNumber(4)
  void clearUsername() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get phone => $_getSZ(4);
  @$pb.TagNumber(5)
  set phone($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasPhone() => $_has(4);
  @$pb.TagNumber(5)
  void clearPhone() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get bio => $_getSZ(5);
  @$pb.TagNumber(6)
  set bio($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasBio() => $_has(5);
  @$pb.TagNumber(6)
  void clearBio() => $_clearField(6);

  @$pb.TagNumber(7)
  $0.Avatar get photo => $_getN(6);
  @$pb.TagNumber(7)
  set photo($0.Avatar value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasPhoto() => $_has(6);
  @$pb.TagNumber(7)
  void clearPhoto() => $_clearField(7);
  @$pb.TagNumber(7)
  $0.Avatar ensurePhoto() => $_ensure(6);

  @$pb.TagNumber(8)
  UserStatus get status => $_getN(7);
  @$pb.TagNumber(8)
  set status(UserStatus value) => $_setField(8, value);
  @$pb.TagNumber(8)
  $core.bool hasStatus() => $_has(7);
  @$pb.TagNumber(8)
  void clearStatus() => $_clearField(8);
  @$pb.TagNumber(8)
  UserStatus ensureStatus() => $_ensure(7);

  @$pb.TagNumber(9)
  $core.bool get isSelf => $_getBF(8);
  @$pb.TagNumber(9)
  set isSelf($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasIsSelf() => $_has(8);
  @$pb.TagNumber(9)
  void clearIsSelf() => $_clearField(9);

  /// The requester has this user in their contacts.
  @$pb.TagNumber(10)
  $core.bool get isContact => $_getBF(9);
  @$pb.TagNumber(10)
  set isContact($core.bool value) => $_setBool(9, value);
  @$pb.TagNumber(10)
  $core.bool hasIsContact() => $_has(9);
  @$pb.TagNumber(10)
  void clearIsContact() => $_clearField(10);

  @$pb.TagNumber(11)
  $core.bool get isMutualContact => $_getBF(10);
  @$pb.TagNumber(11)
  set isMutualContact($core.bool value) => $_setBool(10, value);
  @$pb.TagNumber(11)
  $core.bool hasIsMutualContact() => $_has(10);
  @$pb.TagNumber(11)
  void clearIsMutualContact() => $_clearField(11);

  @$pb.TagNumber(12)
  $core.bool get isBlocked => $_getBF(11);
  @$pb.TagNumber(12)
  set isBlocked($core.bool value) => $_setBool(11, value);
  @$pb.TagNumber(12)
  $core.bool hasIsBlocked() => $_has(11);
  @$pb.TagNumber(12)
  void clearIsBlocked() => $_clearField(12);

  @$pb.TagNumber(13)
  $core.bool get isDeleted => $_getBF(12);
  @$pb.TagNumber(13)
  set isDeleted($core.bool value) => $_setBool(12, value);
  @$pb.TagNumber(13)
  $core.bool hasIsDeleted() => $_has(12);
  @$pb.TagNumber(13)
  void clearIsDeleted() => $_clearField(13);
}

enum UserStatus_Kind { online, lastSeenAt, approx, notSet }

class UserStatus extends $pb.GeneratedMessage {
  factory UserStatus({
    Online? online,
    $fixnum.Int64? lastSeenAt,
    LastSeenApprox? approx,
  }) {
    final result = UserStatus._();
    if (online != null) result.online = online;
    if (lastSeenAt != null) result.lastSeenAt = lastSeenAt;
    if (approx != null) result.approx = approx;
    return result;
  }

  UserStatus._();

  factory UserStatus.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStatus()..mergeFromBuffer(data, registry);
  factory UserStatus.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UserStatus()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, UserStatus_Kind> _UserStatus_KindByTag = {
    1: UserStatus_Kind.online,
    2: UserStatus_Kind.lastSeenAt,
    3: UserStatus_Kind.approx,
    0: UserStatus_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UserStatus',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UserStatus.$_createMessage)
    ..oo(0, [1, 2, 3])
    ..aOM<Online>(1, _omitFieldNames ? '' : 'online',
        subBuilder: Online.$_createMessage)
    ..aInt64(2, _omitFieldNames ? '' : 'lastSeenAt')
    ..aE<LastSeenApprox>(3, _omitFieldNames ? '' : 'approx',
        enumValues: LastSeenApprox.values)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStatus clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UserStatus copyWith(void Function(UserStatus) updates) =>
      super.copyWith((message) => updates(message as UserStatus)) as UserStatus;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UserStatus() / UserStatus.new instead')
  static UserStatus create() => UserStatus._();
  static $pb.GeneratedMessage $_createMessage() => UserStatus._();
  @$core.override
  UserStatus createEmptyInstance() => UserStatus._();
  @$core.pragma('dart2js:noInline')
  static UserStatus getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UserStatus>(UserStatus.$_createMessage);
  static UserStatus? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  UserStatus_Kind whichKind() => _UserStatus_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Online get online => $_getN(0);
  @$pb.TagNumber(1)
  set online(Online value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasOnline() => $_has(0);
  @$pb.TagNumber(1)
  void clearOnline() => $_clearField(1);
  @$pb.TagNumber(1)
  Online ensureOnline() => $_ensure(0);

  /// Exact time, when privacy allows it.
  @$pb.TagNumber(2)
  $fixnum.Int64 get lastSeenAt => $_getI64(1);
  @$pb.TagNumber(2)
  set lastSeenAt($fixnum.Int64 value) => $_setInt64(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastSeenAt() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastSeenAt() => $_clearField(2);

  /// Rounded value shown when exact last-seen is hidden.
  @$pb.TagNumber(3)
  LastSeenApprox get approx => $_getN(2);
  @$pb.TagNumber(3)
  set approx(LastSeenApprox value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasApprox() => $_has(2);
  @$pb.TagNumber(3)
  void clearApprox() => $_clearField(3);
}

class Online extends $pb.GeneratedMessage {
  factory Online({
    $fixnum.Int64? expiresAt,
  }) {
    final result = Online._();
    if (expiresAt != null) result.expiresAt = expiresAt;
    return result;
  }

  Online._();

  factory Online.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Online()..mergeFromBuffer(data, registry);
  factory Online.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Online()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Online',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Online.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'expiresAt')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Online clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Online copyWith(void Function(Online) updates) =>
      super.copyWith((message) => updates(message as Online)) as Online;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Online() / Online.new instead')
  static Online create() => Online._();
  static $pb.GeneratedMessage $_createMessage() => Online._();
  @$core.override
  Online createEmptyInstance() => Online._();
  @$core.pragma('dart2js:noInline')
  static Online getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Online>(Online.$_createMessage);
  static Online? _defaultInstance;

  /// The client shows "online" until this time unless refreshed.
  @$pb.TagNumber(1)
  $fixnum.Int64 get expiresAt => $_getI64(0);
  @$pb.TagNumber(1)
  set expiresAt($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasExpiresAt() => $_has(0);
  @$pb.TagNumber(1)
  void clearExpiresAt() => $_clearField(1);
}

class PrivacySetting extends $pb.GeneratedMessage {
  factory PrivacySetting({
    PrivacyKey? key,
    PrivacyRule? rule,
    $core.Iterable<$fixnum.Int64>? alwaysAllowUserIds,
    $core.Iterable<$fixnum.Int64>? neverAllowUserIds,
  }) {
    final result = PrivacySetting._();
    if (key != null) result.key = key;
    if (rule != null) result.rule = rule;
    if (alwaysAllowUserIds != null)
      result.alwaysAllowUserIds.addAll(alwaysAllowUserIds);
    if (neverAllowUserIds != null)
      result.neverAllowUserIds.addAll(neverAllowUserIds);
    return result;
  }

  PrivacySetting._();

  factory PrivacySetting.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PrivacySetting()..mergeFromBuffer(data, registry);
  factory PrivacySetting.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PrivacySetting()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PrivacySetting',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: PrivacySetting.$_createMessage)
    ..aE<PrivacyKey>(1, _omitFieldNames ? '' : 'key',
        enumValues: PrivacyKey.values)
    ..aE<PrivacyRule>(2, _omitFieldNames ? '' : 'rule',
        enumValues: PrivacyRule.values)
    ..p<$fixnum.Int64>(
        3, _omitFieldNames ? '' : 'alwaysAllowUserIds', $pb.PbFieldType.K6)
    ..p<$fixnum.Int64>(
        4, _omitFieldNames ? '' : 'neverAllowUserIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrivacySetting clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PrivacySetting copyWith(void Function(PrivacySetting) updates) =>
      super.copyWith((message) => updates(message as PrivacySetting))
          as PrivacySetting;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PrivacySetting() / PrivacySetting.new instead')
  static PrivacySetting create() => PrivacySetting._();
  static $pb.GeneratedMessage $_createMessage() => PrivacySetting._();
  @$core.override
  PrivacySetting createEmptyInstance() => PrivacySetting._();
  @$core.pragma('dart2js:noInline')
  static PrivacySetting getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PrivacySetting>(
          PrivacySetting.$_createMessage);
  static PrivacySetting? _defaultInstance;

  @$pb.TagNumber(1)
  PrivacyKey get key => $_getN(0);
  @$pb.TagNumber(1)
  set key(PrivacyKey value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasKey() => $_has(0);
  @$pb.TagNumber(1)
  void clearKey() => $_clearField(1);

  @$pb.TagNumber(2)
  PrivacyRule get rule => $_getN(1);
  @$pb.TagNumber(2)
  set rule(PrivacyRule value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasRule() => $_has(1);
  @$pb.TagNumber(2)
  void clearRule() => $_clearField(2);

  @$pb.TagNumber(3)
  $pb.PbList<$fixnum.Int64> get alwaysAllowUserIds => $_getList(2);

  @$pb.TagNumber(4)
  $pb.PbList<$fixnum.Int64> get neverAllowUserIds => $_getList(3);
}

class GetMeRequest extends $pb.GeneratedMessage {
  factory GetMeRequest() => GetMeRequest._();

  GetMeRequest._();

  factory GetMeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetMeRequest()..mergeFromBuffer(data, registry);
  factory GetMeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetMeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetMeRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeRequest copyWith(void Function(GetMeRequest) updates) =>
      super.copyWith((message) => updates(message as GetMeRequest))
          as GetMeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetMeRequest() / GetMeRequest.new instead')
  static GetMeRequest create() => GetMeRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetMeRequest._();
  @$core.override
  GetMeRequest createEmptyInstance() => GetMeRequest._();
  @$core.pragma('dart2js:noInline')
  static GetMeRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeRequest>(
          GetMeRequest.$_createMessage);
  static GetMeRequest? _defaultInstance;
}

class GetMeResponse extends $pb.GeneratedMessage {
  factory GetMeResponse({
    User? user,
  }) {
    final result = GetMeResponse._();
    if (user != null) result.user = user;
    return result;
  }

  GetMeResponse._();

  factory GetMeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetMeResponse()..mergeFromBuffer(data, registry);
  factory GetMeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetMeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetMeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetMeResponse.$_createMessage)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetMeResponse copyWith(void Function(GetMeResponse) updates) =>
      super.copyWith((message) => updates(message as GetMeResponse))
          as GetMeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetMeResponse() / GetMeResponse.new instead')
  static GetMeResponse create() => GetMeResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetMeResponse._();
  @$core.override
  GetMeResponse createEmptyInstance() => GetMeResponse._();
  @$core.pragma('dart2js:noInline')
  static GetMeResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetMeResponse>(
          GetMeResponse.$_createMessage);
  static GetMeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class GetUsersRequest extends $pb.GeneratedMessage {
  factory GetUsersRequest({
    $core.Iterable<$fixnum.Int64>? userIds,
  }) {
    final result = GetUsersRequest._();
    if (userIds != null) result.userIds.addAll(userIds);
    return result;
  }

  GetUsersRequest._();

  factory GetUsersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUsersRequest()..mergeFromBuffer(data, registry);
  factory GetUsersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUsersRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUsersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetUsersRequest.$_createMessage)
    ..p<$fixnum.Int64>(1, _omitFieldNames ? '' : 'userIds', $pb.PbFieldType.K6)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUsersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUsersRequest copyWith(void Function(GetUsersRequest) updates) =>
      super.copyWith((message) => updates(message as GetUsersRequest))
          as GetUsersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetUsersRequest() / GetUsersRequest.new instead')
  static GetUsersRequest create() => GetUsersRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetUsersRequest._();
  @$core.override
  GetUsersRequest createEmptyInstance() => GetUsersRequest._();
  @$core.pragma('dart2js:noInline')
  static GetUsersRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUsersRequest>(
          GetUsersRequest.$_createMessage);
  static GetUsersRequest? _defaultInstance;

  /// At most 200.
  @$pb.TagNumber(1)
  $pb.PbList<$fixnum.Int64> get userIds => $_getList(0);
}

class GetUsersResponse extends $pb.GeneratedMessage {
  factory GetUsersResponse({
    $core.Iterable<User>? users,
  }) {
    final result = GetUsersResponse._();
    if (users != null) result.users.addAll(users);
    return result;
  }

  GetUsersResponse._();

  factory GetUsersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUsersResponse()..mergeFromBuffer(data, registry);
  factory GetUsersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetUsersResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetUsersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetUsersResponse.$_createMessage)
    ..pPM<User>(1, _omitFieldNames ? '' : 'users',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUsersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetUsersResponse copyWith(void Function(GetUsersResponse) updates) =>
      super.copyWith((message) => updates(message as GetUsersResponse))
          as GetUsersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetUsersResponse() / GetUsersResponse.new instead')
  static GetUsersResponse create() => GetUsersResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetUsersResponse._();
  @$core.override
  GetUsersResponse createEmptyInstance() => GetUsersResponse._();
  @$core.pragma('dart2js:noInline')
  static GetUsersResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetUsersResponse>(
          GetUsersResponse.$_createMessage);
  static GetUsersResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get users => $_getList(0);
}

class UpdateProfileRequest extends $pb.GeneratedMessage {
  factory UpdateProfileRequest({
    $core.String? firstName,
    $core.String? lastName,
    $core.String? bio,
  }) {
    final result = UpdateProfileRequest._();
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (bio != null) result.bio = bio;
    return result;
  }

  UpdateProfileRequest._();

  factory UpdateProfileRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateProfileRequest()..mergeFromBuffer(data, registry);
  factory UpdateProfileRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateProfileRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateProfileRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UpdateProfileRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'firstName')
    ..aOS(2, _omitFieldNames ? '' : 'lastName')
    ..aOS(3, _omitFieldNames ? '' : 'bio')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProfileRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProfileRequest copyWith(void Function(UpdateProfileRequest) updates) =>
      super.copyWith((message) => updates(message as UpdateProfileRequest))
          as UpdateProfileRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateProfileRequest() / UpdateProfileRequest.new instead')
  static UpdateProfileRequest create() => UpdateProfileRequest._();
  static $pb.GeneratedMessage $_createMessage() => UpdateProfileRequest._();
  @$core.override
  UpdateProfileRequest createEmptyInstance() => UpdateProfileRequest._();
  @$core.pragma('dart2js:noInline')
  static UpdateProfileRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateProfileRequest>(
          UpdateProfileRequest.$_createMessage);
  static UpdateProfileRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get firstName => $_getSZ(0);
  @$pb.TagNumber(1)
  set firstName($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasFirstName() => $_has(0);
  @$pb.TagNumber(1)
  void clearFirstName() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get lastName => $_getSZ(1);
  @$pb.TagNumber(2)
  set lastName($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLastName() => $_has(1);
  @$pb.TagNumber(2)
  void clearLastName() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get bio => $_getSZ(2);
  @$pb.TagNumber(3)
  set bio($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasBio() => $_has(2);
  @$pb.TagNumber(3)
  void clearBio() => $_clearField(3);
}

class UpdateProfileResponse extends $pb.GeneratedMessage {
  factory UpdateProfileResponse({
    User? user,
  }) {
    final result = UpdateProfileResponse._();
    if (user != null) result.user = user;
    return result;
  }

  UpdateProfileResponse._();

  factory UpdateProfileResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateProfileResponse()..mergeFromBuffer(data, registry);
  factory UpdateProfileResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UpdateProfileResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UpdateProfileResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UpdateProfileResponse.$_createMessage)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProfileResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UpdateProfileResponse copyWith(
          void Function(UpdateProfileResponse) updates) =>
      super.copyWith((message) => updates(message as UpdateProfileResponse))
          as UpdateProfileResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use UpdateProfileResponse() / UpdateProfileResponse.new instead')
  static UpdateProfileResponse create() => UpdateProfileResponse._();
  static $pb.GeneratedMessage $_createMessage() => UpdateProfileResponse._();
  @$core.override
  UpdateProfileResponse createEmptyInstance() => UpdateProfileResponse._();
  @$core.pragma('dart2js:noInline')
  static UpdateProfileResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UpdateProfileResponse>(
          UpdateProfileResponse.$_createMessage);
  static UpdateProfileResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class SetProfilePhotoRequest extends $pb.GeneratedMessage {
  factory SetProfilePhotoRequest({
    $fixnum.Int64? mediaId,
  }) {
    final result = SetProfilePhotoRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    return result;
  }

  SetProfilePhotoRequest._();

  factory SetProfilePhotoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetProfilePhotoRequest()..mergeFromBuffer(data, registry);
  factory SetProfilePhotoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetProfilePhotoRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetProfilePhotoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetProfilePhotoRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'mediaId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetProfilePhotoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetProfilePhotoRequest copyWith(
          void Function(SetProfilePhotoRequest) updates) =>
      super.copyWith((message) => updates(message as SetProfilePhotoRequest))
          as SetProfilePhotoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetProfilePhotoRequest() / SetProfilePhotoRequest.new instead')
  static SetProfilePhotoRequest create() => SetProfilePhotoRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetProfilePhotoRequest._();
  @$core.override
  SetProfilePhotoRequest createEmptyInstance() => SetProfilePhotoRequest._();
  @$core.pragma('dart2js:noInline')
  static SetProfilePhotoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetProfilePhotoRequest>(
          SetProfilePhotoRequest.$_createMessage);
  static SetProfilePhotoRequest? _defaultInstance;

  /// A PHOTO uploaded with MediaService.
  @$pb.TagNumber(1)
  $fixnum.Int64 get mediaId => $_getI64(0);
  @$pb.TagNumber(1)
  set mediaId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);
}

class SetProfilePhotoResponse extends $pb.GeneratedMessage {
  factory SetProfilePhotoResponse({
    User? user,
  }) {
    final result = SetProfilePhotoResponse._();
    if (user != null) result.user = user;
    return result;
  }

  SetProfilePhotoResponse._();

  factory SetProfilePhotoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetProfilePhotoResponse()..mergeFromBuffer(data, registry);
  factory SetProfilePhotoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetProfilePhotoResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetProfilePhotoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetProfilePhotoResponse.$_createMessage)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetProfilePhotoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetProfilePhotoResponse copyWith(
          void Function(SetProfilePhotoResponse) updates) =>
      super.copyWith((message) => updates(message as SetProfilePhotoResponse))
          as SetProfilePhotoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use SetProfilePhotoResponse() / SetProfilePhotoResponse.new instead')
  static SetProfilePhotoResponse create() => SetProfilePhotoResponse._();
  static $pb.GeneratedMessage $_createMessage() => SetProfilePhotoResponse._();
  @$core.override
  SetProfilePhotoResponse createEmptyInstance() => SetProfilePhotoResponse._();
  @$core.pragma('dart2js:noInline')
  static SetProfilePhotoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetProfilePhotoResponse>(
          SetProfilePhotoResponse.$_createMessage);
  static SetProfilePhotoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class DeleteProfilePhotoRequest extends $pb.GeneratedMessage {
  factory DeleteProfilePhotoRequest({
    $fixnum.Int64? mediaId,
  }) {
    final result = DeleteProfilePhotoRequest._();
    if (mediaId != null) result.mediaId = mediaId;
    return result;
  }

  DeleteProfilePhotoRequest._();

  factory DeleteProfilePhotoRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteProfilePhotoRequest()..mergeFromBuffer(data, registry);
  factory DeleteProfilePhotoRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteProfilePhotoRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteProfilePhotoRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DeleteProfilePhotoRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'mediaId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteProfilePhotoRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteProfilePhotoRequest copyWith(
          void Function(DeleteProfilePhotoRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteProfilePhotoRequest))
          as DeleteProfilePhotoRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteProfilePhotoRequest() / DeleteProfilePhotoRequest.new instead')
  static DeleteProfilePhotoRequest create() => DeleteProfilePhotoRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeleteProfilePhotoRequest._();
  @$core.override
  DeleteProfilePhotoRequest createEmptyInstance() =>
      DeleteProfilePhotoRequest._();
  @$core.pragma('dart2js:noInline')
  static DeleteProfilePhotoRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteProfilePhotoRequest>(
          DeleteProfilePhotoRequest.$_createMessage);
  static DeleteProfilePhotoRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get mediaId => $_getI64(0);
  @$pb.TagNumber(1)
  set mediaId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasMediaId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMediaId() => $_clearField(1);
}

class DeleteProfilePhotoResponse extends $pb.GeneratedMessage {
  factory DeleteProfilePhotoResponse({
    User? user,
  }) {
    final result = DeleteProfilePhotoResponse._();
    if (user != null) result.user = user;
    return result;
  }

  DeleteProfilePhotoResponse._();

  factory DeleteProfilePhotoResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteProfilePhotoResponse()..mergeFromBuffer(data, registry);
  factory DeleteProfilePhotoResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteProfilePhotoResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteProfilePhotoResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DeleteProfilePhotoResponse.$_createMessage)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteProfilePhotoResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteProfilePhotoResponse copyWith(
          void Function(DeleteProfilePhotoResponse) updates) =>
      super.copyWith(
              (message) => updates(message as DeleteProfilePhotoResponse))
          as DeleteProfilePhotoResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteProfilePhotoResponse() / DeleteProfilePhotoResponse.new instead')
  static DeleteProfilePhotoResponse create() => DeleteProfilePhotoResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      DeleteProfilePhotoResponse._();
  @$core.override
  DeleteProfilePhotoResponse createEmptyInstance() =>
      DeleteProfilePhotoResponse._();
  @$core.pragma('dart2js:noInline')
  static DeleteProfilePhotoResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteProfilePhotoResponse>(
          DeleteProfilePhotoResponse.$_createMessage);
  static DeleteProfilePhotoResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class CheckUsernameRequest extends $pb.GeneratedMessage {
  factory CheckUsernameRequest({
    $core.String? username,
  }) {
    final result = CheckUsernameRequest._();
    if (username != null) result.username = username;
    return result;
  }

  CheckUsernameRequest._();

  factory CheckUsernameRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckUsernameRequest()..mergeFromBuffer(data, registry);
  factory CheckUsernameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckUsernameRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckUsernameRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CheckUsernameRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckUsernameRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckUsernameRequest copyWith(void Function(CheckUsernameRequest) updates) =>
      super.copyWith((message) => updates(message as CheckUsernameRequest))
          as CheckUsernameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckUsernameRequest() / CheckUsernameRequest.new instead')
  static CheckUsernameRequest create() => CheckUsernameRequest._();
  static $pb.GeneratedMessage $_createMessage() => CheckUsernameRequest._();
  @$core.override
  CheckUsernameRequest createEmptyInstance() => CheckUsernameRequest._();
  @$core.pragma('dart2js:noInline')
  static CheckUsernameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckUsernameRequest>(
          CheckUsernameRequest.$_createMessage);
  static CheckUsernameRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);
}

class CheckUsernameResponse extends $pb.GeneratedMessage {
  factory CheckUsernameResponse({
    $core.bool? available,
  }) {
    final result = CheckUsernameResponse._();
    if (available != null) result.available = available;
    return result;
  }

  CheckUsernameResponse._();

  factory CheckUsernameResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckUsernameResponse()..mergeFromBuffer(data, registry);
  factory CheckUsernameResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckUsernameResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckUsernameResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CheckUsernameResponse.$_createMessage)
    ..aOB(1, _omitFieldNames ? '' : 'available')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckUsernameResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckUsernameResponse copyWith(
          void Function(CheckUsernameResponse) updates) =>
      super.copyWith((message) => updates(message as CheckUsernameResponse))
          as CheckUsernameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckUsernameResponse() / CheckUsernameResponse.new instead')
  static CheckUsernameResponse create() => CheckUsernameResponse._();
  static $pb.GeneratedMessage $_createMessage() => CheckUsernameResponse._();
  @$core.override
  CheckUsernameResponse createEmptyInstance() => CheckUsernameResponse._();
  @$core.pragma('dart2js:noInline')
  static CheckUsernameResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckUsernameResponse>(
          CheckUsernameResponse.$_createMessage);
  static CheckUsernameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get available => $_getBF(0);
  @$pb.TagNumber(1)
  set available($core.bool value) => $_setBool(0, value);
  @$pb.TagNumber(1)
  $core.bool hasAvailable() => $_has(0);
  @$pb.TagNumber(1)
  void clearAvailable() => $_clearField(1);
}

class SetUsernameRequest extends $pb.GeneratedMessage {
  factory SetUsernameRequest({
    $core.String? username,
  }) {
    final result = SetUsernameRequest._();
    if (username != null) result.username = username;
    return result;
  }

  SetUsernameRequest._();

  factory SetUsernameRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUsernameRequest()..mergeFromBuffer(data, registry);
  factory SetUsernameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUsernameRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetUsernameRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetUsernameRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUsernameRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUsernameRequest copyWith(void Function(SetUsernameRequest) updates) =>
      super.copyWith((message) => updates(message as SetUsernameRequest))
          as SetUsernameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetUsernameRequest() / SetUsernameRequest.new instead')
  static SetUsernameRequest create() => SetUsernameRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetUsernameRequest._();
  @$core.override
  SetUsernameRequest createEmptyInstance() => SetUsernameRequest._();
  @$core.pragma('dart2js:noInline')
  static SetUsernameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetUsernameRequest>(
          SetUsernameRequest.$_createMessage);
  static SetUsernameRequest? _defaultInstance;

  /// Empty removes the username.
  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);
}

class SetUsernameResponse extends $pb.GeneratedMessage {
  factory SetUsernameResponse({
    User? user,
  }) {
    final result = SetUsernameResponse._();
    if (user != null) result.user = user;
    return result;
  }

  SetUsernameResponse._();

  factory SetUsernameResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUsernameResponse()..mergeFromBuffer(data, registry);
  factory SetUsernameResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetUsernameResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetUsernameResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetUsernameResponse.$_createMessage)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUsernameResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetUsernameResponse copyWith(void Function(SetUsernameResponse) updates) =>
      super.copyWith((message) => updates(message as SetUsernameResponse))
          as SetUsernameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use SetUsernameResponse() / SetUsernameResponse.new instead')
  static SetUsernameResponse create() => SetUsernameResponse._();
  static $pb.GeneratedMessage $_createMessage() => SetUsernameResponse._();
  @$core.override
  SetUsernameResponse createEmptyInstance() => SetUsernameResponse._();
  @$core.pragma('dart2js:noInline')
  static SetUsernameResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetUsernameResponse>(
          SetUsernameResponse.$_createMessage);
  static SetUsernameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class ResolveUsernameRequest extends $pb.GeneratedMessage {
  factory ResolveUsernameRequest({
    $core.String? username,
  }) {
    final result = ResolveUsernameRequest._();
    if (username != null) result.username = username;
    return result;
  }

  ResolveUsernameRequest._();

  factory ResolveUsernameRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ResolveUsernameRequest()..mergeFromBuffer(data, registry);
  factory ResolveUsernameRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ResolveUsernameRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolveUsernameRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ResolveUsernameRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'username')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveUsernameRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveUsernameRequest copyWith(
          void Function(ResolveUsernameRequest) updates) =>
      super.copyWith((message) => updates(message as ResolveUsernameRequest))
          as ResolveUsernameRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ResolveUsernameRequest() / ResolveUsernameRequest.new instead')
  static ResolveUsernameRequest create() => ResolveUsernameRequest._();
  static $pb.GeneratedMessage $_createMessage() => ResolveUsernameRequest._();
  @$core.override
  ResolveUsernameRequest createEmptyInstance() => ResolveUsernameRequest._();
  @$core.pragma('dart2js:noInline')
  static ResolveUsernameRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolveUsernameRequest>(
          ResolveUsernameRequest.$_createMessage);
  static ResolveUsernameRequest? _defaultInstance;

  /// With or without the leading "@".
  @$pb.TagNumber(1)
  $core.String get username => $_getSZ(0);
  @$pb.TagNumber(1)
  set username($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUsername() => $_has(0);
  @$pb.TagNumber(1)
  void clearUsername() => $_clearField(1);
}

class ResolveUsernameResponse extends $pb.GeneratedMessage {
  factory ResolveUsernameResponse({
    User? user,
  }) {
    final result = ResolveUsernameResponse._();
    if (user != null) result.user = user;
    return result;
  }

  ResolveUsernameResponse._();

  factory ResolveUsernameResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ResolveUsernameResponse()..mergeFromBuffer(data, registry);
  factory ResolveUsernameResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ResolveUsernameResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResolveUsernameResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ResolveUsernameResponse.$_createMessage)
    ..aOM<User>(1, _omitFieldNames ? '' : 'user',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveUsernameResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResolveUsernameResponse copyWith(
          void Function(ResolveUsernameResponse) updates) =>
      super.copyWith((message) => updates(message as ResolveUsernameResponse))
          as ResolveUsernameResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ResolveUsernameResponse() / ResolveUsernameResponse.new instead')
  static ResolveUsernameResponse create() => ResolveUsernameResponse._();
  static $pb.GeneratedMessage $_createMessage() => ResolveUsernameResponse._();
  @$core.override
  ResolveUsernameResponse createEmptyInstance() => ResolveUsernameResponse._();
  @$core.pragma('dart2js:noInline')
  static ResolveUsernameResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResolveUsernameResponse>(
          ResolveUsernameResponse.$_createMessage);
  static ResolveUsernameResponse? _defaultInstance;

  @$pb.TagNumber(1)
  User get user => $_getN(0);
  @$pb.TagNumber(1)
  set user(User value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasUser() => $_has(0);
  @$pb.TagNumber(1)
  void clearUser() => $_clearField(1);
  @$pb.TagNumber(1)
  User ensureUser() => $_ensure(0);
}

class SearchUsersRequest extends $pb.GeneratedMessage {
  factory SearchUsersRequest({
    $core.String? query,
    $core.int? limit,
  }) {
    final result = SearchUsersRequest._();
    if (query != null) result.query = query;
    if (limit != null) result.limit = limit;
    return result;
  }

  SearchUsersRequest._();

  factory SearchUsersRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchUsersRequest()..mergeFromBuffer(data, registry);
  factory SearchUsersRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchUsersRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchUsersRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SearchUsersRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'query')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersRequest copyWith(void Function(SearchUsersRequest) updates) =>
      super.copyWith((message) => updates(message as SearchUsersRequest))
          as SearchUsersRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SearchUsersRequest() / SearchUsersRequest.new instead')
  static SearchUsersRequest create() => SearchUsersRequest._();
  static $pb.GeneratedMessage $_createMessage() => SearchUsersRequest._();
  @$core.override
  SearchUsersRequest createEmptyInstance() => SearchUsersRequest._();
  @$core.pragma('dart2js:noInline')
  static SearchUsersRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchUsersRequest>(
          SearchUsersRequest.$_createMessage);
  static SearchUsersRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get query => $_getSZ(0);
  @$pb.TagNumber(1)
  set query($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasQuery() => $_has(0);
  @$pb.TagNumber(1)
  void clearQuery() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class SearchUsersResponse extends $pb.GeneratedMessage {
  factory SearchUsersResponse({
    $core.Iterable<User>? contacts,
    $core.Iterable<User>? global,
  }) {
    final result = SearchUsersResponse._();
    if (contacts != null) result.contacts.addAll(contacts);
    if (global != null) result.global.addAll(global);
    return result;
  }

  SearchUsersResponse._();

  factory SearchUsersResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchUsersResponse()..mergeFromBuffer(data, registry);
  factory SearchUsersResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SearchUsersResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SearchUsersResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SearchUsersResponse.$_createMessage)
    ..pPM<User>(1, _omitFieldNames ? '' : 'contacts',
        subBuilder: User.$_createMessage)
    ..pPM<User>(2, _omitFieldNames ? '' : 'global',
        subBuilder: User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SearchUsersResponse copyWith(void Function(SearchUsersResponse) updates) =>
      super.copyWith((message) => updates(message as SearchUsersResponse))
          as SearchUsersResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use SearchUsersResponse() / SearchUsersResponse.new instead')
  static SearchUsersResponse create() => SearchUsersResponse._();
  static $pb.GeneratedMessage $_createMessage() => SearchUsersResponse._();
  @$core.override
  SearchUsersResponse createEmptyInstance() => SearchUsersResponse._();
  @$core.pragma('dart2js:noInline')
  static SearchUsersResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SearchUsersResponse>(
          SearchUsersResponse.$_createMessage);
  static SearchUsersResponse? _defaultInstance;

  /// Matches among the requester's contacts.
  @$pb.TagNumber(1)
  $pb.PbList<User> get contacts => $_getList(0);

  /// Public username matches.
  @$pb.TagNumber(2)
  $pb.PbList<User> get global => $_getList(1);
}

class GetPrivacyRequest extends $pb.GeneratedMessage {
  factory GetPrivacyRequest() => GetPrivacyRequest._();

  GetPrivacyRequest._();

  factory GetPrivacyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetPrivacyRequest()..mergeFromBuffer(data, registry);
  factory GetPrivacyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetPrivacyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPrivacyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetPrivacyRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrivacyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrivacyRequest copyWith(void Function(GetPrivacyRequest) updates) =>
      super.copyWith((message) => updates(message as GetPrivacyRequest))
          as GetPrivacyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetPrivacyRequest() / GetPrivacyRequest.new instead')
  static GetPrivacyRequest create() => GetPrivacyRequest._();
  static $pb.GeneratedMessage $_createMessage() => GetPrivacyRequest._();
  @$core.override
  GetPrivacyRequest createEmptyInstance() => GetPrivacyRequest._();
  @$core.pragma('dart2js:noInline')
  static GetPrivacyRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<GetPrivacyRequest>(
          GetPrivacyRequest.$_createMessage);
  static GetPrivacyRequest? _defaultInstance;
}

class GetPrivacyResponse extends $pb.GeneratedMessage {
  factory GetPrivacyResponse({
    $core.Iterable<PrivacySetting>? settings,
  }) {
    final result = GetPrivacyResponse._();
    if (settings != null) result.settings.addAll(settings);
    return result;
  }

  GetPrivacyResponse._();

  factory GetPrivacyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetPrivacyResponse()..mergeFromBuffer(data, registry);
  factory GetPrivacyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      GetPrivacyResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'GetPrivacyResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: GetPrivacyResponse.$_createMessage)
    ..pPM<PrivacySetting>(1, _omitFieldNames ? '' : 'settings',
        subBuilder: PrivacySetting.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrivacyResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  GetPrivacyResponse copyWith(void Function(GetPrivacyResponse) updates) =>
      super.copyWith((message) => updates(message as GetPrivacyResponse))
          as GetPrivacyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use GetPrivacyResponse() / GetPrivacyResponse.new instead')
  static GetPrivacyResponse create() => GetPrivacyResponse._();
  static $pb.GeneratedMessage $_createMessage() => GetPrivacyResponse._();
  @$core.override
  GetPrivacyResponse createEmptyInstance() => GetPrivacyResponse._();
  @$core.pragma('dart2js:noInline')
  static GetPrivacyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<GetPrivacyResponse>(
          GetPrivacyResponse.$_createMessage);
  static GetPrivacyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<PrivacySetting> get settings => $_getList(0);
}

class SetPrivacyRequest extends $pb.GeneratedMessage {
  factory SetPrivacyRequest({
    PrivacySetting? setting,
  }) {
    final result = SetPrivacyRequest._();
    if (setting != null) result.setting = setting;
    return result;
  }

  SetPrivacyRequest._();

  factory SetPrivacyRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetPrivacyRequest()..mergeFromBuffer(data, registry);
  factory SetPrivacyRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetPrivacyRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetPrivacyRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetPrivacyRequest.$_createMessage)
    ..aOM<PrivacySetting>(1, _omitFieldNames ? '' : 'setting',
        subBuilder: PrivacySetting.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPrivacyRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPrivacyRequest copyWith(void Function(SetPrivacyRequest) updates) =>
      super.copyWith((message) => updates(message as SetPrivacyRequest))
          as SetPrivacyRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetPrivacyRequest() / SetPrivacyRequest.new instead')
  static SetPrivacyRequest create() => SetPrivacyRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetPrivacyRequest._();
  @$core.override
  SetPrivacyRequest createEmptyInstance() => SetPrivacyRequest._();
  @$core.pragma('dart2js:noInline')
  static SetPrivacyRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetPrivacyRequest>(
          SetPrivacyRequest.$_createMessage);
  static SetPrivacyRequest? _defaultInstance;

  @$pb.TagNumber(1)
  PrivacySetting get setting => $_getN(0);
  @$pb.TagNumber(1)
  set setting(PrivacySetting value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSetting() => $_has(0);
  @$pb.TagNumber(1)
  void clearSetting() => $_clearField(1);
  @$pb.TagNumber(1)
  PrivacySetting ensureSetting() => $_ensure(0);
}

class SetPrivacyResponse extends $pb.GeneratedMessage {
  factory SetPrivacyResponse({
    PrivacySetting? setting,
  }) {
    final result = SetPrivacyResponse._();
    if (setting != null) result.setting = setting;
    return result;
  }

  SetPrivacyResponse._();

  factory SetPrivacyResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetPrivacyResponse()..mergeFromBuffer(data, registry);
  factory SetPrivacyResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetPrivacyResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetPrivacyResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetPrivacyResponse.$_createMessage)
    ..aOM<PrivacySetting>(1, _omitFieldNames ? '' : 'setting',
        subBuilder: PrivacySetting.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPrivacyResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPrivacyResponse copyWith(void Function(SetPrivacyResponse) updates) =>
      super.copyWith((message) => updates(message as SetPrivacyResponse))
          as SetPrivacyResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetPrivacyResponse() / SetPrivacyResponse.new instead')
  static SetPrivacyResponse create() => SetPrivacyResponse._();
  static $pb.GeneratedMessage $_createMessage() => SetPrivacyResponse._();
  @$core.override
  SetPrivacyResponse createEmptyInstance() => SetPrivacyResponse._();
  @$core.pragma('dart2js:noInline')
  static SetPrivacyResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetPrivacyResponse>(
          SetPrivacyResponse.$_createMessage);
  static SetPrivacyResponse? _defaultInstance;

  @$pb.TagNumber(1)
  PrivacySetting get setting => $_getN(0);
  @$pb.TagNumber(1)
  set setting(PrivacySetting value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasSetting() => $_has(0);
  @$pb.TagNumber(1)
  void clearSetting() => $_clearField(1);
  @$pb.TagNumber(1)
  PrivacySetting ensureSetting() => $_ensure(0);
}

class BlockUserRequest extends $pb.GeneratedMessage {
  factory BlockUserRequest({
    $fixnum.Int64? userId,
  }) {
    final result = BlockUserRequest._();
    if (userId != null) result.userId = userId;
    return result;
  }

  BlockUserRequest._();

  factory BlockUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BlockUserRequest()..mergeFromBuffer(data, registry);
  factory BlockUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BlockUserRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BlockUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: BlockUserRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BlockUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BlockUserRequest copyWith(void Function(BlockUserRequest) updates) =>
      super.copyWith((message) => updates(message as BlockUserRequest))
          as BlockUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BlockUserRequest() / BlockUserRequest.new instead')
  static BlockUserRequest create() => BlockUserRequest._();
  static $pb.GeneratedMessage $_createMessage() => BlockUserRequest._();
  @$core.override
  BlockUserRequest createEmptyInstance() => BlockUserRequest._();
  @$core.pragma('dart2js:noInline')
  static BlockUserRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockUserRequest>(
          BlockUserRequest.$_createMessage);
  static BlockUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class BlockUserResponse extends $pb.GeneratedMessage {
  factory BlockUserResponse() => BlockUserResponse._();

  BlockUserResponse._();

  factory BlockUserResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BlockUserResponse()..mergeFromBuffer(data, registry);
  factory BlockUserResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      BlockUserResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'BlockUserResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: BlockUserResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BlockUserResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  BlockUserResponse copyWith(void Function(BlockUserResponse) updates) =>
      super.copyWith((message) => updates(message as BlockUserResponse))
          as BlockUserResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use BlockUserResponse() / BlockUserResponse.new instead')
  static BlockUserResponse create() => BlockUserResponse._();
  static $pb.GeneratedMessage $_createMessage() => BlockUserResponse._();
  @$core.override
  BlockUserResponse createEmptyInstance() => BlockUserResponse._();
  @$core.pragma('dart2js:noInline')
  static BlockUserResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<BlockUserResponse>(
          BlockUserResponse.$_createMessage);
  static BlockUserResponse? _defaultInstance;
}

class UnblockUserRequest extends $pb.GeneratedMessage {
  factory UnblockUserRequest({
    $fixnum.Int64? userId,
  }) {
    final result = UnblockUserRequest._();
    if (userId != null) result.userId = userId;
    return result;
  }

  UnblockUserRequest._();

  factory UnblockUserRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnblockUserRequest()..mergeFromBuffer(data, registry);
  factory UnblockUserRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnblockUserRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnblockUserRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UnblockUserRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'userId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnblockUserRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnblockUserRequest copyWith(void Function(UnblockUserRequest) updates) =>
      super.copyWith((message) => updates(message as UnblockUserRequest))
          as UnblockUserRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use UnblockUserRequest() / UnblockUserRequest.new instead')
  static UnblockUserRequest create() => UnblockUserRequest._();
  static $pb.GeneratedMessage $_createMessage() => UnblockUserRequest._();
  @$core.override
  UnblockUserRequest createEmptyInstance() => UnblockUserRequest._();
  @$core.pragma('dart2js:noInline')
  static UnblockUserRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnblockUserRequest>(
          UnblockUserRequest.$_createMessage);
  static UnblockUserRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get userId => $_getI64(0);
  @$pb.TagNumber(1)
  set userId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasUserId() => $_has(0);
  @$pb.TagNumber(1)
  void clearUserId() => $_clearField(1);
}

class UnblockUserResponse extends $pb.GeneratedMessage {
  factory UnblockUserResponse() => UnblockUserResponse._();

  UnblockUserResponse._();

  factory UnblockUserResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnblockUserResponse()..mergeFromBuffer(data, registry);
  factory UnblockUserResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      UnblockUserResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'UnblockUserResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: UnblockUserResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnblockUserResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  UnblockUserResponse copyWith(void Function(UnblockUserResponse) updates) =>
      super.copyWith((message) => updates(message as UnblockUserResponse))
          as UnblockUserResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use UnblockUserResponse() / UnblockUserResponse.new instead')
  static UnblockUserResponse create() => UnblockUserResponse._();
  static $pb.GeneratedMessage $_createMessage() => UnblockUserResponse._();
  @$core.override
  UnblockUserResponse createEmptyInstance() => UnblockUserResponse._();
  @$core.pragma('dart2js:noInline')
  static UnblockUserResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<UnblockUserResponse>(
          UnblockUserResponse.$_createMessage);
  static UnblockUserResponse? _defaultInstance;
}

class ListBlockedRequest extends $pb.GeneratedMessage {
  factory ListBlockedRequest({
    $core.int? offset,
    $core.int? limit,
  }) {
    final result = ListBlockedRequest._();
    if (offset != null) result.offset = offset;
    if (limit != null) result.limit = limit;
    return result;
  }

  ListBlockedRequest._();

  factory ListBlockedRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBlockedRequest()..mergeFromBuffer(data, registry);
  factory ListBlockedRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBlockedRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBlockedRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListBlockedRequest.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'offset')
    ..aI(2, _omitFieldNames ? '' : 'limit')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBlockedRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBlockedRequest copyWith(void Function(ListBlockedRequest) updates) =>
      super.copyWith((message) => updates(message as ListBlockedRequest))
          as ListBlockedRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ListBlockedRequest() / ListBlockedRequest.new instead')
  static ListBlockedRequest create() => ListBlockedRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListBlockedRequest._();
  @$core.override
  ListBlockedRequest createEmptyInstance() => ListBlockedRequest._();
  @$core.pragma('dart2js:noInline')
  static ListBlockedRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBlockedRequest>(
          ListBlockedRequest.$_createMessage);
  static ListBlockedRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get offset => $_getIZ(0);
  @$pb.TagNumber(1)
  set offset($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasOffset() => $_has(0);
  @$pb.TagNumber(1)
  void clearOffset() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.int get limit => $_getIZ(1);
  @$pb.TagNumber(2)
  set limit($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLimit() => $_has(1);
  @$pb.TagNumber(2)
  void clearLimit() => $_clearField(2);
}

class ListBlockedResponse extends $pb.GeneratedMessage {
  factory ListBlockedResponse({
    $core.Iterable<User>? users,
    $core.int? total,
  }) {
    final result = ListBlockedResponse._();
    if (users != null) result.users.addAll(users);
    if (total != null) result.total = total;
    return result;
  }

  ListBlockedResponse._();

  factory ListBlockedResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBlockedResponse()..mergeFromBuffer(data, registry);
  factory ListBlockedResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListBlockedResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListBlockedResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListBlockedResponse.$_createMessage)
    ..pPM<User>(1, _omitFieldNames ? '' : 'users',
        subBuilder: User.$_createMessage)
    ..aI(2, _omitFieldNames ? '' : 'total')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBlockedResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListBlockedResponse copyWith(void Function(ListBlockedResponse) updates) =>
      super.copyWith((message) => updates(message as ListBlockedResponse))
          as ListBlockedResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ListBlockedResponse() / ListBlockedResponse.new instead')
  static ListBlockedResponse create() => ListBlockedResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListBlockedResponse._();
  @$core.override
  ListBlockedResponse createEmptyInstance() => ListBlockedResponse._();
  @$core.pragma('dart2js:noInline')
  static ListBlockedResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListBlockedResponse>(
          ListBlockedResponse.$_createMessage);
  static ListBlockedResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<User> get users => $_getList(0);

  @$pb.TagNumber(2)
  $core.int get total => $_getIZ(1);
  @$pb.TagNumber(2)
  set total($core.int value) => $_setSignedInt32(1, value);
  @$pb.TagNumber(2)
  $core.bool hasTotal() => $_has(1);
  @$pb.TagNumber(2)
  void clearTotal() => $_clearField(2);
}

/// UsersService: profiles, usernames, privacy and blocking.
class UsersServiceApi {
  final $pb.RpcClient _client;

  UsersServiceApi(this._client);

  $async.Future<GetMeResponse> getMe(
          $pb.ClientContext? ctx, GetMeRequest request) =>
      _client.invoke<GetMeResponse>(
          ctx, 'UsersService', 'GetMe', request, GetMeResponse());
  $async.Future<GetUsersResponse> getUsers(
          $pb.ClientContext? ctx, GetUsersRequest request) =>
      _client.invoke<GetUsersResponse>(
          ctx, 'UsersService', 'GetUsers', request, GetUsersResponse());
  $async.Future<UpdateProfileResponse> updateProfile(
          $pb.ClientContext? ctx, UpdateProfileRequest request) =>
      _client.invoke<UpdateProfileResponse>(ctx, 'UsersService',
          'UpdateProfile', request, UpdateProfileResponse());
  $async.Future<SetProfilePhotoResponse> setProfilePhoto(
          $pb.ClientContext? ctx, SetProfilePhotoRequest request) =>
      _client.invoke<SetProfilePhotoResponse>(ctx, 'UsersService',
          'SetProfilePhoto', request, SetProfilePhotoResponse());
  $async.Future<DeleteProfilePhotoResponse> deleteProfilePhoto(
          $pb.ClientContext? ctx, DeleteProfilePhotoRequest request) =>
      _client.invoke<DeleteProfilePhotoResponse>(ctx, 'UsersService',
          'DeleteProfilePhoto', request, DeleteProfilePhotoResponse());
  $async.Future<CheckUsernameResponse> checkUsername(
          $pb.ClientContext? ctx, CheckUsernameRequest request) =>
      _client.invoke<CheckUsernameResponse>(ctx, 'UsersService',
          'CheckUsername', request, CheckUsernameResponse());
  $async.Future<SetUsernameResponse> setUsername(
          $pb.ClientContext? ctx, SetUsernameRequest request) =>
      _client.invoke<SetUsernameResponse>(
          ctx, 'UsersService', 'SetUsername', request, SetUsernameResponse());
  $async.Future<ResolveUsernameResponse> resolveUsername(
          $pb.ClientContext? ctx, ResolveUsernameRequest request) =>
      _client.invoke<ResolveUsernameResponse>(ctx, 'UsersService',
          'ResolveUsername', request, ResolveUsernameResponse());

  /// Global search: public usernames (prefix) + own contacts (name).
  $async.Future<SearchUsersResponse> searchUsers(
          $pb.ClientContext? ctx, SearchUsersRequest request) =>
      _client.invoke<SearchUsersResponse>(
          ctx, 'UsersService', 'SearchUsers', request, SearchUsersResponse());
  $async.Future<GetPrivacyResponse> getPrivacy(
          $pb.ClientContext? ctx, GetPrivacyRequest request) =>
      _client.invoke<GetPrivacyResponse>(
          ctx, 'UsersService', 'GetPrivacy', request, GetPrivacyResponse());
  $async.Future<SetPrivacyResponse> setPrivacy(
          $pb.ClientContext? ctx, SetPrivacyRequest request) =>
      _client.invoke<SetPrivacyResponse>(
          ctx, 'UsersService', 'SetPrivacy', request, SetPrivacyResponse());
  $async.Future<BlockUserResponse> blockUser(
          $pb.ClientContext? ctx, BlockUserRequest request) =>
      _client.invoke<BlockUserResponse>(
          ctx, 'UsersService', 'BlockUser', request, BlockUserResponse());
  $async.Future<UnblockUserResponse> unblockUser(
          $pb.ClientContext? ctx, UnblockUserRequest request) =>
      _client.invoke<UnblockUserResponse>(
          ctx, 'UsersService', 'UnblockUser', request, UnblockUserResponse());
  $async.Future<ListBlockedResponse> listBlocked(
          $pb.ClientContext? ctx, ListBlockedRequest request) =>
      _client.invoke<ListBlockedResponse>(
          ctx, 'UsersService', 'ListBlocked', request, ListBlockedResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
