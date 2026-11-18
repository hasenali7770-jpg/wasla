// This is a generated file - do not edit.
//
// Generated from wasla/v1/auth.proto.

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

import 'auth.pbenum.dart';
import 'common.pbenum.dart' as $1;
import 'users.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'auth.pbenum.dart';

class SendCodeRequest extends $pb.GeneratedMessage {
  factory SendCodeRequest({
    $core.String? phone,
    $core.String? deviceAttestation,
  }) {
    final result = SendCodeRequest._();
    if (phone != null) result.phone = phone;
    if (deviceAttestation != null) result.deviceAttestation = deviceAttestation;
    return result;
  }

  SendCodeRequest._();

  factory SendCodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendCodeRequest()..mergeFromBuffer(data, registry);
  factory SendCodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendCodeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendCodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SendCodeRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'deviceAttestation')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendCodeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendCodeRequest copyWith(void Function(SendCodeRequest) updates) =>
      super.copyWith((message) => updates(message as SendCodeRequest))
          as SendCodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SendCodeRequest() / SendCodeRequest.new instead')
  static SendCodeRequest create() => SendCodeRequest._();
  static $pb.GeneratedMessage $_createMessage() => SendCodeRequest._();
  @$core.override
  SendCodeRequest createEmptyInstance() => SendCodeRequest._();
  @$core.pragma('dart2js:noInline')
  static SendCodeRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendCodeRequest>(
          SendCodeRequest.$_createMessage);
  static SendCodeRequest? _defaultInstance;

  /// E.164, e.g. "+9647701234567".
  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  /// Play Integrity (Android) / App Attest (iOS) token. Missing or invalid
  /// tokens get stricter rate limits (SMS-pumping defence).
  @$pb.TagNumber(2)
  $core.String get deviceAttestation => $_getSZ(1);
  @$pb.TagNumber(2)
  set deviceAttestation($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasDeviceAttestation() => $_has(1);
  @$pb.TagNumber(2)
  void clearDeviceAttestation() => $_clearField(2);
}

class SendCodeResponse extends $pb.GeneratedMessage {
  factory SendCodeResponse({
    $core.String? codeHash,
    CodeDelivery? delivery,
    $core.int? codeLength,
    $core.int? resendAfterSeconds,
    $core.int? expiresInSeconds,
    CodeDelivery? nextDelivery,
    $core.String? devCode,
  }) {
    final result = SendCodeResponse._();
    if (codeHash != null) result.codeHash = codeHash;
    if (delivery != null) result.delivery = delivery;
    if (codeLength != null) result.codeLength = codeLength;
    if (resendAfterSeconds != null)
      result.resendAfterSeconds = resendAfterSeconds;
    if (expiresInSeconds != null) result.expiresInSeconds = expiresInSeconds;
    if (nextDelivery != null) result.nextDelivery = nextDelivery;
    if (devCode != null) result.devCode = devCode;
    return result;
  }

  SendCodeResponse._();

  factory SendCodeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendCodeResponse()..mergeFromBuffer(data, registry);
  factory SendCodeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SendCodeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SendCodeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SendCodeResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'codeHash')
    ..aE<CodeDelivery>(2, _omitFieldNames ? '' : 'delivery',
        enumValues: CodeDelivery.values)
    ..aI(3, _omitFieldNames ? '' : 'codeLength')
    ..aI(4, _omitFieldNames ? '' : 'resendAfterSeconds')
    ..aI(5, _omitFieldNames ? '' : 'expiresInSeconds')
    ..aE<CodeDelivery>(6, _omitFieldNames ? '' : 'nextDelivery',
        enumValues: CodeDelivery.values)
    ..aOS(7, _omitFieldNames ? '' : 'devCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendCodeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SendCodeResponse copyWith(void Function(SendCodeResponse) updates) =>
      super.copyWith((message) => updates(message as SendCodeResponse))
          as SendCodeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SendCodeResponse() / SendCodeResponse.new instead')
  static SendCodeResponse create() => SendCodeResponse._();
  static $pb.GeneratedMessage $_createMessage() => SendCodeResponse._();
  @$core.override
  SendCodeResponse createEmptyInstance() => SendCodeResponse._();
  @$core.pragma('dart2js:noInline')
  static SendCodeResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SendCodeResponse>(
          SendCodeResponse.$_createMessage);
  static SendCodeResponse? _defaultInstance;

  /// Opaque handle for this verification attempt.
  @$pb.TagNumber(1)
  $core.String get codeHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set codeHash($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCodeHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearCodeHash() => $_clearField(1);

  @$pb.TagNumber(2)
  CodeDelivery get delivery => $_getN(1);
  @$pb.TagNumber(2)
  set delivery(CodeDelivery value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDelivery() => $_has(1);
  @$pb.TagNumber(2)
  void clearDelivery() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get codeLength => $_getIZ(2);
  @$pb.TagNumber(3)
  set codeLength($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCodeLength() => $_has(2);
  @$pb.TagNumber(3)
  void clearCodeLength() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get resendAfterSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set resendAfterSeconds($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasResendAfterSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearResendAfterSeconds() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get expiresInSeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set expiresInSeconds($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiresInSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresInSeconds() => $_clearField(5);

  /// What ResendCode will use next (e.g. SMS → VOICE_CALL).
  @$pb.TagNumber(6)
  CodeDelivery get nextDelivery => $_getN(5);
  @$pb.TagNumber(6)
  set nextDelivery(CodeDelivery value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasNextDelivery() => $_has(5);
  @$pb.TagNumber(6)
  void clearNextDelivery() => $_clearField(6);

  /// The code itself. Only development/staging servers (WASLA_ENV=dev, no
  /// SMS provider) fill this in, so testers can log in; production servers
  /// never set it.
  @$pb.TagNumber(7)
  $core.String get devCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set devCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDevCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearDevCode() => $_clearField(7);
}

class ResendCodeRequest extends $pb.GeneratedMessage {
  factory ResendCodeRequest({
    $core.String? phone,
    $core.String? codeHash,
  }) {
    final result = ResendCodeRequest._();
    if (phone != null) result.phone = phone;
    if (codeHash != null) result.codeHash = codeHash;
    return result;
  }

  ResendCodeRequest._();

  factory ResendCodeRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ResendCodeRequest()..mergeFromBuffer(data, registry);
  factory ResendCodeRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ResendCodeRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResendCodeRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ResendCodeRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'codeHash')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendCodeRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendCodeRequest copyWith(void Function(ResendCodeRequest) updates) =>
      super.copyWith((message) => updates(message as ResendCodeRequest))
          as ResendCodeRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ResendCodeRequest() / ResendCodeRequest.new instead')
  static ResendCodeRequest create() => ResendCodeRequest._();
  static $pb.GeneratedMessage $_createMessage() => ResendCodeRequest._();
  @$core.override
  ResendCodeRequest createEmptyInstance() => ResendCodeRequest._();
  @$core.pragma('dart2js:noInline')
  static ResendCodeRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResendCodeRequest>(
          ResendCodeRequest.$_createMessage);
  static ResendCodeRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get codeHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set codeHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCodeHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearCodeHash() => $_clearField(2);
}

class ResendCodeResponse extends $pb.GeneratedMessage {
  factory ResendCodeResponse({
    $core.String? codeHash,
    CodeDelivery? delivery,
    $core.int? codeLength,
    $core.int? resendAfterSeconds,
    $core.int? expiresInSeconds,
    CodeDelivery? nextDelivery,
    $core.String? devCode,
  }) {
    final result = ResendCodeResponse._();
    if (codeHash != null) result.codeHash = codeHash;
    if (delivery != null) result.delivery = delivery;
    if (codeLength != null) result.codeLength = codeLength;
    if (resendAfterSeconds != null)
      result.resendAfterSeconds = resendAfterSeconds;
    if (expiresInSeconds != null) result.expiresInSeconds = expiresInSeconds;
    if (nextDelivery != null) result.nextDelivery = nextDelivery;
    if (devCode != null) result.devCode = devCode;
    return result;
  }

  ResendCodeResponse._();

  factory ResendCodeResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ResendCodeResponse()..mergeFromBuffer(data, registry);
  factory ResendCodeResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ResendCodeResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ResendCodeResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ResendCodeResponse.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'codeHash')
    ..aE<CodeDelivery>(2, _omitFieldNames ? '' : 'delivery',
        enumValues: CodeDelivery.values)
    ..aI(3, _omitFieldNames ? '' : 'codeLength')
    ..aI(4, _omitFieldNames ? '' : 'resendAfterSeconds')
    ..aI(5, _omitFieldNames ? '' : 'expiresInSeconds')
    ..aE<CodeDelivery>(6, _omitFieldNames ? '' : 'nextDelivery',
        enumValues: CodeDelivery.values)
    ..aOS(7, _omitFieldNames ? '' : 'devCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendCodeResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ResendCodeResponse copyWith(void Function(ResendCodeResponse) updates) =>
      super.copyWith((message) => updates(message as ResendCodeResponse))
          as ResendCodeResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use ResendCodeResponse() / ResendCodeResponse.new instead')
  static ResendCodeResponse create() => ResendCodeResponse._();
  static $pb.GeneratedMessage $_createMessage() => ResendCodeResponse._();
  @$core.override
  ResendCodeResponse createEmptyInstance() => ResendCodeResponse._();
  @$core.pragma('dart2js:noInline')
  static ResendCodeResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ResendCodeResponse>(
          ResendCodeResponse.$_createMessage);
  static ResendCodeResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get codeHash => $_getSZ(0);
  @$pb.TagNumber(1)
  set codeHash($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCodeHash() => $_has(0);
  @$pb.TagNumber(1)
  void clearCodeHash() => $_clearField(1);

  @$pb.TagNumber(2)
  CodeDelivery get delivery => $_getN(1);
  @$pb.TagNumber(2)
  set delivery(CodeDelivery value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasDelivery() => $_has(1);
  @$pb.TagNumber(2)
  void clearDelivery() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.int get codeLength => $_getIZ(2);
  @$pb.TagNumber(3)
  set codeLength($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCodeLength() => $_has(2);
  @$pb.TagNumber(3)
  void clearCodeLength() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.int get resendAfterSeconds => $_getIZ(3);
  @$pb.TagNumber(4)
  set resendAfterSeconds($core.int value) => $_setSignedInt32(3, value);
  @$pb.TagNumber(4)
  $core.bool hasResendAfterSeconds() => $_has(3);
  @$pb.TagNumber(4)
  void clearResendAfterSeconds() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.int get expiresInSeconds => $_getIZ(4);
  @$pb.TagNumber(5)
  set expiresInSeconds($core.int value) => $_setSignedInt32(4, value);
  @$pb.TagNumber(5)
  $core.bool hasExpiresInSeconds() => $_has(4);
  @$pb.TagNumber(5)
  void clearExpiresInSeconds() => $_clearField(5);

  @$pb.TagNumber(6)
  CodeDelivery get nextDelivery => $_getN(5);
  @$pb.TagNumber(6)
  set nextDelivery(CodeDelivery value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasNextDelivery() => $_has(5);
  @$pb.TagNumber(6)
  void clearNextDelivery() => $_clearField(6);

  /// See SendCodeResponse.dev_code.
  @$pb.TagNumber(7)
  $core.String get devCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set devCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasDevCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearDevCode() => $_clearField(7);
}

class SignInRequest extends $pb.GeneratedMessage {
  factory SignInRequest({
    $core.String? phone,
    $core.String? codeHash,
    $core.String? code,
  }) {
    final result = SignInRequest._();
    if (phone != null) result.phone = phone;
    if (codeHash != null) result.codeHash = codeHash;
    if (code != null) result.code = code;
    return result;
  }

  SignInRequest._();

  factory SignInRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignInRequest()..mergeFromBuffer(data, registry);
  factory SignInRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignInRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignInRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SignInRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'codeHash')
    ..aOS(3, _omitFieldNames ? '' : 'code')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignInRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignInRequest copyWith(void Function(SignInRequest) updates) =>
      super.copyWith((message) => updates(message as SignInRequest))
          as SignInRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SignInRequest() / SignInRequest.new instead')
  static SignInRequest create() => SignInRequest._();
  static $pb.GeneratedMessage $_createMessage() => SignInRequest._();
  @$core.override
  SignInRequest createEmptyInstance() => SignInRequest._();
  @$core.pragma('dart2js:noInline')
  static SignInRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignInRequest>(
          SignInRequest.$_createMessage);
  static SignInRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get codeHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set codeHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCodeHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearCodeHash() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get code => $_getSZ(2);
  @$pb.TagNumber(3)
  set code($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(2);
  @$pb.TagNumber(3)
  void clearCode() => $_clearField(3);
}

enum SignInResponse_Result {
  authorization,
  signUpRequired,
  passwordRequired,
  notSet
}

class SignInResponse extends $pb.GeneratedMessage {
  factory SignInResponse({
    Authorization? authorization,
    SignUpRequired? signUpRequired,
    PasswordRequired? passwordRequired,
  }) {
    final result = SignInResponse._();
    if (authorization != null) result.authorization = authorization;
    if (signUpRequired != null) result.signUpRequired = signUpRequired;
    if (passwordRequired != null) result.passwordRequired = passwordRequired;
    return result;
  }

  SignInResponse._();

  factory SignInResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignInResponse()..mergeFromBuffer(data, registry);
  factory SignInResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignInResponse()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, SignInResponse_Result>
      _SignInResponse_ResultByTag = {
    1: SignInResponse_Result.authorization,
    2: SignInResponse_Result.signUpRequired,
    3: SignInResponse_Result.passwordRequired,
    0: SignInResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignInResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SignInResponse.$_createMessage)
    ..oo(0, [1, 2, 3])
    ..aOM<Authorization>(1, _omitFieldNames ? '' : 'authorization',
        subBuilder: Authorization.$_createMessage)
    ..aOM<SignUpRequired>(2, _omitFieldNames ? '' : 'signUpRequired',
        subBuilder: SignUpRequired.$_createMessage)
    ..aOM<PasswordRequired>(3, _omitFieldNames ? '' : 'passwordRequired',
        subBuilder: PasswordRequired.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignInResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignInResponse copyWith(void Function(SignInResponse) updates) =>
      super.copyWith((message) => updates(message as SignInResponse))
          as SignInResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SignInResponse() / SignInResponse.new instead')
  static SignInResponse create() => SignInResponse._();
  static $pb.GeneratedMessage $_createMessage() => SignInResponse._();
  @$core.override
  SignInResponse createEmptyInstance() => SignInResponse._();
  @$core.pragma('dart2js:noInline')
  static SignInResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignInResponse>(
          SignInResponse.$_createMessage);
  static SignInResponse? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  SignInResponse_Result whichResult() =>
      _SignInResponse_ResultByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearResult() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  Authorization get authorization => $_getN(0);
  @$pb.TagNumber(1)
  set authorization(Authorization value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAuthorization() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuthorization() => $_clearField(1);
  @$pb.TagNumber(1)
  Authorization ensureAuthorization() => $_ensure(0);

  @$pb.TagNumber(2)
  SignUpRequired get signUpRequired => $_getN(1);
  @$pb.TagNumber(2)
  set signUpRequired(SignUpRequired value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasSignUpRequired() => $_has(1);
  @$pb.TagNumber(2)
  void clearSignUpRequired() => $_clearField(2);
  @$pb.TagNumber(2)
  SignUpRequired ensureSignUpRequired() => $_ensure(1);

  @$pb.TagNumber(3)
  PasswordRequired get passwordRequired => $_getN(2);
  @$pb.TagNumber(3)
  set passwordRequired(PasswordRequired value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPasswordRequired() => $_has(2);
  @$pb.TagNumber(3)
  void clearPasswordRequired() => $_clearField(3);
  @$pb.TagNumber(3)
  PasswordRequired ensurePasswordRequired() => $_ensure(2);
}

class Authorization extends $pb.GeneratedMessage {
  factory Authorization({
    $core.String? sessionToken,
    $0.User? user,
  }) {
    final result = Authorization._();
    if (sessionToken != null) result.sessionToken = sessionToken;
    if (user != null) result.user = user;
    return result;
  }

  Authorization._();

  factory Authorization.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Authorization()..mergeFromBuffer(data, registry);
  factory Authorization.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Authorization()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Authorization',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Authorization.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'sessionToken')
    ..aOM<$0.User>(2, _omitFieldNames ? '' : 'user',
        subBuilder: $0.User.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Authorization clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Authorization copyWith(void Function(Authorization) updates) =>
      super.copyWith((message) => updates(message as Authorization))
          as Authorization;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Authorization() / Authorization.new instead')
  static Authorization create() => Authorization._();
  static $pb.GeneratedMessage $_createMessage() => Authorization._();
  @$core.override
  Authorization createEmptyInstance() => Authorization._();
  @$core.pragma('dart2js:noInline')
  static Authorization getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Authorization>(
          Authorization.$_createMessage);
  static Authorization? _defaultInstance;

  /// 256-bit random token, base64url. Store in secure storage
  /// (Android Keystore / iOS Keychain); send it in Hello.
  @$pb.TagNumber(1)
  $core.String get sessionToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set sessionToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $0.User get user => $_getN(1);
  @$pb.TagNumber(2)
  set user($0.User value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasUser() => $_has(1);
  @$pb.TagNumber(2)
  void clearUser() => $_clearField(2);
  @$pb.TagNumber(2)
  $0.User ensureUser() => $_ensure(1);
}

class SignUpRequired extends $pb.GeneratedMessage {
  factory SignUpRequired({
    $core.String? termsVersion,
  }) {
    final result = SignUpRequired._();
    if (termsVersion != null) result.termsVersion = termsVersion;
    return result;
  }

  SignUpRequired._();

  factory SignUpRequired.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignUpRequired()..mergeFromBuffer(data, registry);
  factory SignUpRequired.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignUpRequired()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignUpRequired',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SignUpRequired.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'termsVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpRequired clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpRequired copyWith(void Function(SignUpRequired) updates) =>
      super.copyWith((message) => updates(message as SignUpRequired))
          as SignUpRequired;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SignUpRequired() / SignUpRequired.new instead')
  static SignUpRequired create() => SignUpRequired._();
  static $pb.GeneratedMessage $_createMessage() => SignUpRequired._();
  @$core.override
  SignUpRequired createEmptyInstance() => SignUpRequired._();
  @$core.pragma('dart2js:noInline')
  static SignUpRequired getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpRequired>(
          SignUpRequired.$_createMessage);
  static SignUpRequired? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get termsVersion => $_getSZ(0);
  @$pb.TagNumber(1)
  set termsVersion($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasTermsVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearTermsVersion() => $_clearField(1);
}

class PasswordRequired extends $pb.GeneratedMessage {
  factory PasswordRequired({
    $core.String? hint,
    $core.String? loginToken,
  }) {
    final result = PasswordRequired._();
    if (hint != null) result.hint = hint;
    if (loginToken != null) result.loginToken = loginToken;
    return result;
  }

  PasswordRequired._();

  factory PasswordRequired.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PasswordRequired()..mergeFromBuffer(data, registry);
  factory PasswordRequired.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      PasswordRequired()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'PasswordRequired',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: PasswordRequired.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'hint')
    ..aOS(2, _omitFieldNames ? '' : 'loginToken')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasswordRequired clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  PasswordRequired copyWith(void Function(PasswordRequired) updates) =>
      super.copyWith((message) => updates(message as PasswordRequired))
          as PasswordRequired;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use PasswordRequired() / PasswordRequired.new instead')
  static PasswordRequired create() => PasswordRequired._();
  static $pb.GeneratedMessage $_createMessage() => PasswordRequired._();
  @$core.override
  PasswordRequired createEmptyInstance() => PasswordRequired._();
  @$core.pragma('dart2js:noInline')
  static PasswordRequired getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PasswordRequired>(
          PasswordRequired.$_createMessage);
  static PasswordRequired? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get hint => $_getSZ(0);
  @$pb.TagNumber(1)
  set hint($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasHint() => $_has(0);
  @$pb.TagNumber(1)
  void clearHint() => $_clearField(1);

  /// Short-lived (10 min) token proving the phone was verified.
  @$pb.TagNumber(2)
  $core.String get loginToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set loginToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasLoginToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearLoginToken() => $_clearField(2);
}

class SignUpRequest extends $pb.GeneratedMessage {
  factory SignUpRequest({
    $core.String? phone,
    $core.String? codeHash,
    $core.String? firstName,
    $core.String? lastName,
    $core.String? termsVersion,
  }) {
    final result = SignUpRequest._();
    if (phone != null) result.phone = phone;
    if (codeHash != null) result.codeHash = codeHash;
    if (firstName != null) result.firstName = firstName;
    if (lastName != null) result.lastName = lastName;
    if (termsVersion != null) result.termsVersion = termsVersion;
    return result;
  }

  SignUpRequest._();

  factory SignUpRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignUpRequest()..mergeFromBuffer(data, registry);
  factory SignUpRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignUpRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignUpRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SignUpRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'phone')
    ..aOS(2, _omitFieldNames ? '' : 'codeHash')
    ..aOS(3, _omitFieldNames ? '' : 'firstName')
    ..aOS(4, _omitFieldNames ? '' : 'lastName')
    ..aOS(5, _omitFieldNames ? '' : 'termsVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpRequest copyWith(void Function(SignUpRequest) updates) =>
      super.copyWith((message) => updates(message as SignUpRequest))
          as SignUpRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SignUpRequest() / SignUpRequest.new instead')
  static SignUpRequest create() => SignUpRequest._();
  static $pb.GeneratedMessage $_createMessage() => SignUpRequest._();
  @$core.override
  SignUpRequest createEmptyInstance() => SignUpRequest._();
  @$core.pragma('dart2js:noInline')
  static SignUpRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpRequest>(
          SignUpRequest.$_createMessage);
  static SignUpRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get phone => $_getSZ(0);
  @$pb.TagNumber(1)
  set phone($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasPhone() => $_has(0);
  @$pb.TagNumber(1)
  void clearPhone() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get codeHash => $_getSZ(1);
  @$pb.TagNumber(2)
  set codeHash($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasCodeHash() => $_has(1);
  @$pb.TagNumber(2)
  void clearCodeHash() => $_clearField(2);

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

  @$pb.TagNumber(5)
  $core.String get termsVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set termsVersion($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasTermsVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearTermsVersion() => $_clearField(5);
}

class SignUpResponse extends $pb.GeneratedMessage {
  factory SignUpResponse({
    Authorization? authorization,
  }) {
    final result = SignUpResponse._();
    if (authorization != null) result.authorization = authorization;
    return result;
  }

  SignUpResponse._();

  factory SignUpResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignUpResponse()..mergeFromBuffer(data, registry);
  factory SignUpResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SignUpResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SignUpResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SignUpResponse.$_createMessage)
    ..aOM<Authorization>(1, _omitFieldNames ? '' : 'authorization',
        subBuilder: Authorization.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SignUpResponse copyWith(void Function(SignUpResponse) updates) =>
      super.copyWith((message) => updates(message as SignUpResponse))
          as SignUpResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SignUpResponse() / SignUpResponse.new instead')
  static SignUpResponse create() => SignUpResponse._();
  static $pb.GeneratedMessage $_createMessage() => SignUpResponse._();
  @$core.override
  SignUpResponse createEmptyInstance() => SignUpResponse._();
  @$core.pragma('dart2js:noInline')
  static SignUpResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SignUpResponse>(
          SignUpResponse.$_createMessage);
  static SignUpResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Authorization get authorization => $_getN(0);
  @$pb.TagNumber(1)
  set authorization(Authorization value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAuthorization() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuthorization() => $_clearField(1);
  @$pb.TagNumber(1)
  Authorization ensureAuthorization() => $_ensure(0);
}

class CheckPasswordRequest extends $pb.GeneratedMessage {
  factory CheckPasswordRequest({
    $core.String? loginToken,
    $core.String? password,
  }) {
    final result = CheckPasswordRequest._();
    if (loginToken != null) result.loginToken = loginToken;
    if (password != null) result.password = password;
    return result;
  }

  CheckPasswordRequest._();

  factory CheckPasswordRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckPasswordRequest()..mergeFromBuffer(data, registry);
  factory CheckPasswordRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckPasswordRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckPasswordRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CheckPasswordRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'loginToken')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckPasswordRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckPasswordRequest copyWith(void Function(CheckPasswordRequest) updates) =>
      super.copyWith((message) => updates(message as CheckPasswordRequest))
          as CheckPasswordRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckPasswordRequest() / CheckPasswordRequest.new instead')
  static CheckPasswordRequest create() => CheckPasswordRequest._();
  static $pb.GeneratedMessage $_createMessage() => CheckPasswordRequest._();
  @$core.override
  CheckPasswordRequest createEmptyInstance() => CheckPasswordRequest._();
  @$core.pragma('dart2js:noInline')
  static CheckPasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckPasswordRequest>(
          CheckPasswordRequest.$_createMessage);
  static CheckPasswordRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get loginToken => $_getSZ(0);
  @$pb.TagNumber(1)
  set loginToken($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasLoginToken() => $_has(0);
  @$pb.TagNumber(1)
  void clearLoginToken() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class CheckPasswordResponse extends $pb.GeneratedMessage {
  factory CheckPasswordResponse({
    Authorization? authorization,
  }) {
    final result = CheckPasswordResponse._();
    if (authorization != null) result.authorization = authorization;
    return result;
  }

  CheckPasswordResponse._();

  factory CheckPasswordResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckPasswordResponse()..mergeFromBuffer(data, registry);
  factory CheckPasswordResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      CheckPasswordResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'CheckPasswordResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: CheckPasswordResponse.$_createMessage)
    ..aOM<Authorization>(1, _omitFieldNames ? '' : 'authorization',
        subBuilder: Authorization.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckPasswordResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  CheckPasswordResponse copyWith(
          void Function(CheckPasswordResponse) updates) =>
      super.copyWith((message) => updates(message as CheckPasswordResponse))
          as CheckPasswordResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use CheckPasswordResponse() / CheckPasswordResponse.new instead')
  static CheckPasswordResponse create() => CheckPasswordResponse._();
  static $pb.GeneratedMessage $_createMessage() => CheckPasswordResponse._();
  @$core.override
  CheckPasswordResponse createEmptyInstance() => CheckPasswordResponse._();
  @$core.pragma('dart2js:noInline')
  static CheckPasswordResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<CheckPasswordResponse>(
          CheckPasswordResponse.$_createMessage);
  static CheckPasswordResponse? _defaultInstance;

  @$pb.TagNumber(1)
  Authorization get authorization => $_getN(0);
  @$pb.TagNumber(1)
  set authorization(Authorization value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasAuthorization() => $_has(0);
  @$pb.TagNumber(1)
  void clearAuthorization() => $_clearField(1);
  @$pb.TagNumber(1)
  Authorization ensureAuthorization() => $_ensure(0);
}

class LogOutRequest extends $pb.GeneratedMessage {
  factory LogOutRequest() => LogOutRequest._();

  LogOutRequest._();

  factory LogOutRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LogOutRequest()..mergeFromBuffer(data, registry);
  factory LogOutRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LogOutRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogOutRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: LogOutRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogOutRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogOutRequest copyWith(void Function(LogOutRequest) updates) =>
      super.copyWith((message) => updates(message as LogOutRequest))
          as LogOutRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LogOutRequest() / LogOutRequest.new instead')
  static LogOutRequest create() => LogOutRequest._();
  static $pb.GeneratedMessage $_createMessage() => LogOutRequest._();
  @$core.override
  LogOutRequest createEmptyInstance() => LogOutRequest._();
  @$core.pragma('dart2js:noInline')
  static LogOutRequest getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogOutRequest>(
          LogOutRequest.$_createMessage);
  static LogOutRequest? _defaultInstance;
}

class LogOutResponse extends $pb.GeneratedMessage {
  factory LogOutResponse() => LogOutResponse._();

  LogOutResponse._();

  factory LogOutResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LogOutResponse()..mergeFromBuffer(data, registry);
  factory LogOutResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      LogOutResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'LogOutResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: LogOutResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogOutResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  LogOutResponse copyWith(void Function(LogOutResponse) updates) =>
      super.copyWith((message) => updates(message as LogOutResponse))
          as LogOutResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use LogOutResponse() / LogOutResponse.new instead')
  static LogOutResponse create() => LogOutResponse._();
  static $pb.GeneratedMessage $_createMessage() => LogOutResponse._();
  @$core.override
  LogOutResponse createEmptyInstance() => LogOutResponse._();
  @$core.pragma('dart2js:noInline')
  static LogOutResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogOutResponse>(
          LogOutResponse.$_createMessage);
  static LogOutResponse? _defaultInstance;
}

class Session extends $pb.GeneratedMessage {
  factory Session({
    $fixnum.Int64? id,
    $1.Platform? platform,
    $core.String? deviceModel,
    $core.String? osVersion,
    $core.String? appVersion,
    $core.String? countryCode,
    $fixnum.Int64? createdAt,
    $fixnum.Int64? lastActiveAt,
    $core.bool? current,
  }) {
    final result = Session._();
    if (id != null) result.id = id;
    if (platform != null) result.platform = platform;
    if (deviceModel != null) result.deviceModel = deviceModel;
    if (osVersion != null) result.osVersion = osVersion;
    if (appVersion != null) result.appVersion = appVersion;
    if (countryCode != null) result.countryCode = countryCode;
    if (createdAt != null) result.createdAt = createdAt;
    if (lastActiveAt != null) result.lastActiveAt = lastActiveAt;
    if (current != null) result.current = current;
    return result;
  }

  Session._();

  factory Session.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Session()..mergeFromBuffer(data, registry);
  factory Session.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Session()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Session',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Session.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'id')
    ..aE<$1.Platform>(2, _omitFieldNames ? '' : 'platform',
        enumValues: $1.Platform.values)
    ..aOS(3, _omitFieldNames ? '' : 'deviceModel')
    ..aOS(4, _omitFieldNames ? '' : 'osVersion')
    ..aOS(5, _omitFieldNames ? '' : 'appVersion')
    ..aOS(6, _omitFieldNames ? '' : 'countryCode')
    ..aInt64(7, _omitFieldNames ? '' : 'createdAt')
    ..aInt64(8, _omitFieldNames ? '' : 'lastActiveAt')
    ..aOB(9, _omitFieldNames ? '' : 'current')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Session clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Session copyWith(void Function(Session) updates) =>
      super.copyWith((message) => updates(message as Session)) as Session;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Session() / Session.new instead')
  static Session create() => Session._();
  static $pb.GeneratedMessage $_createMessage() => Session._();
  @$core.override
  Session createEmptyInstance() => Session._();
  @$core.pragma('dart2js:noInline')
  static Session getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Session>(Session.$_createMessage);
  static Session? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $1.Platform get platform => $_getN(1);
  @$pb.TagNumber(2)
  set platform($1.Platform value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasPlatform() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlatform() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get deviceModel => $_getSZ(2);
  @$pb.TagNumber(3)
  set deviceModel($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasDeviceModel() => $_has(2);
  @$pb.TagNumber(3)
  void clearDeviceModel() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get osVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set osVersion($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasOsVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearOsVersion() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get appVersion => $_getSZ(4);
  @$pb.TagNumber(5)
  set appVersion($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasAppVersion() => $_has(4);
  @$pb.TagNumber(5)
  void clearAppVersion() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get countryCode => $_getSZ(5);
  @$pb.TagNumber(6)
  set countryCode($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasCountryCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearCountryCode() => $_clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get createdAt => $_getI64(6);
  @$pb.TagNumber(7)
  set createdAt($fixnum.Int64 value) => $_setInt64(6, value);
  @$pb.TagNumber(7)
  $core.bool hasCreatedAt() => $_has(6);
  @$pb.TagNumber(7)
  void clearCreatedAt() => $_clearField(7);

  @$pb.TagNumber(8)
  $fixnum.Int64 get lastActiveAt => $_getI64(7);
  @$pb.TagNumber(8)
  set lastActiveAt($fixnum.Int64 value) => $_setInt64(7, value);
  @$pb.TagNumber(8)
  $core.bool hasLastActiveAt() => $_has(7);
  @$pb.TagNumber(8)
  void clearLastActiveAt() => $_clearField(8);

  @$pb.TagNumber(9)
  $core.bool get current => $_getBF(8);
  @$pb.TagNumber(9)
  set current($core.bool value) => $_setBool(8, value);
  @$pb.TagNumber(9)
  $core.bool hasCurrent() => $_has(8);
  @$pb.TagNumber(9)
  void clearCurrent() => $_clearField(9);
}

class ListSessionsRequest extends $pb.GeneratedMessage {
  factory ListSessionsRequest() => ListSessionsRequest._();

  ListSessionsRequest._();

  factory ListSessionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListSessionsRequest()..mergeFromBuffer(data, registry);
  factory ListSessionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListSessionsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSessionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListSessionsRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSessionsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSessionsRequest copyWith(void Function(ListSessionsRequest) updates) =>
      super.copyWith((message) => updates(message as ListSessionsRequest))
          as ListSessionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use ListSessionsRequest() / ListSessionsRequest.new instead')
  static ListSessionsRequest create() => ListSessionsRequest._();
  static $pb.GeneratedMessage $_createMessage() => ListSessionsRequest._();
  @$core.override
  ListSessionsRequest createEmptyInstance() => ListSessionsRequest._();
  @$core.pragma('dart2js:noInline')
  static ListSessionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSessionsRequest>(
          ListSessionsRequest.$_createMessage);
  static ListSessionsRequest? _defaultInstance;
}

class ListSessionsResponse extends $pb.GeneratedMessage {
  factory ListSessionsResponse({
    $core.Iterable<Session>? sessions,
  }) {
    final result = ListSessionsResponse._();
    if (sessions != null) result.sessions.addAll(sessions);
    return result;
  }

  ListSessionsResponse._();

  factory ListSessionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListSessionsResponse()..mergeFromBuffer(data, registry);
  factory ListSessionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      ListSessionsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'ListSessionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: ListSessionsResponse.$_createMessage)
    ..pPM<Session>(1, _omitFieldNames ? '' : 'sessions',
        subBuilder: Session.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSessionsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  ListSessionsResponse copyWith(void Function(ListSessionsResponse) updates) =>
      super.copyWith((message) => updates(message as ListSessionsResponse))
          as ListSessionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use ListSessionsResponse() / ListSessionsResponse.new instead')
  static ListSessionsResponse create() => ListSessionsResponse._();
  static $pb.GeneratedMessage $_createMessage() => ListSessionsResponse._();
  @$core.override
  ListSessionsResponse createEmptyInstance() => ListSessionsResponse._();
  @$core.pragma('dart2js:noInline')
  static ListSessionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<ListSessionsResponse>(
          ListSessionsResponse.$_createMessage);
  static ListSessionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $pb.PbList<Session> get sessions => $_getList(0);
}

class RevokeSessionRequest extends $pb.GeneratedMessage {
  factory RevokeSessionRequest({
    $fixnum.Int64? sessionId,
  }) {
    final result = RevokeSessionRequest._();
    if (sessionId != null) result.sessionId = sessionId;
    return result;
  }

  RevokeSessionRequest._();

  factory RevokeSessionRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeSessionRequest()..mergeFromBuffer(data, registry);
  factory RevokeSessionRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeSessionRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevokeSessionRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RevokeSessionRequest.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'sessionId')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeSessionRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeSessionRequest copyWith(void Function(RevokeSessionRequest) updates) =>
      super.copyWith((message) => updates(message as RevokeSessionRequest))
          as RevokeSessionRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RevokeSessionRequest() / RevokeSessionRequest.new instead')
  static RevokeSessionRequest create() => RevokeSessionRequest._();
  static $pb.GeneratedMessage $_createMessage() => RevokeSessionRequest._();
  @$core.override
  RevokeSessionRequest createEmptyInstance() => RevokeSessionRequest._();
  @$core.pragma('dart2js:noInline')
  static RevokeSessionRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevokeSessionRequest>(
          RevokeSessionRequest.$_createMessage);
  static RevokeSessionRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get sessionId => $_getI64(0);
  @$pb.TagNumber(1)
  set sessionId($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasSessionId() => $_has(0);
  @$pb.TagNumber(1)
  void clearSessionId() => $_clearField(1);
}

class RevokeSessionResponse extends $pb.GeneratedMessage {
  factory RevokeSessionResponse() => RevokeSessionResponse._();

  RevokeSessionResponse._();

  factory RevokeSessionResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeSessionResponse()..mergeFromBuffer(data, registry);
  factory RevokeSessionResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeSessionResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevokeSessionResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RevokeSessionResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeSessionResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeSessionResponse copyWith(
          void Function(RevokeSessionResponse) updates) =>
      super.copyWith((message) => updates(message as RevokeSessionResponse))
          as RevokeSessionResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RevokeSessionResponse() / RevokeSessionResponse.new instead')
  static RevokeSessionResponse create() => RevokeSessionResponse._();
  static $pb.GeneratedMessage $_createMessage() => RevokeSessionResponse._();
  @$core.override
  RevokeSessionResponse createEmptyInstance() => RevokeSessionResponse._();
  @$core.pragma('dart2js:noInline')
  static RevokeSessionResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevokeSessionResponse>(
          RevokeSessionResponse.$_createMessage);
  static RevokeSessionResponse? _defaultInstance;
}

class RevokeOtherSessionsRequest extends $pb.GeneratedMessage {
  factory RevokeOtherSessionsRequest() => RevokeOtherSessionsRequest._();

  RevokeOtherSessionsRequest._();

  factory RevokeOtherSessionsRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeOtherSessionsRequest()..mergeFromBuffer(data, registry);
  factory RevokeOtherSessionsRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeOtherSessionsRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevokeOtherSessionsRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RevokeOtherSessionsRequest.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeOtherSessionsRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeOtherSessionsRequest copyWith(
          void Function(RevokeOtherSessionsRequest) updates) =>
      super.copyWith(
              (message) => updates(message as RevokeOtherSessionsRequest))
          as RevokeOtherSessionsRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RevokeOtherSessionsRequest() / RevokeOtherSessionsRequest.new instead')
  static RevokeOtherSessionsRequest create() => RevokeOtherSessionsRequest._();
  static $pb.GeneratedMessage $_createMessage() =>
      RevokeOtherSessionsRequest._();
  @$core.override
  RevokeOtherSessionsRequest createEmptyInstance() =>
      RevokeOtherSessionsRequest._();
  @$core.pragma('dart2js:noInline')
  static RevokeOtherSessionsRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevokeOtherSessionsRequest>(
          RevokeOtherSessionsRequest.$_createMessage);
  static RevokeOtherSessionsRequest? _defaultInstance;
}

class RevokeOtherSessionsResponse extends $pb.GeneratedMessage {
  factory RevokeOtherSessionsResponse({
    $core.int? revokedCount,
  }) {
    final result = RevokeOtherSessionsResponse._();
    if (revokedCount != null) result.revokedCount = revokedCount;
    return result;
  }

  RevokeOtherSessionsResponse._();

  factory RevokeOtherSessionsResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeOtherSessionsResponse()..mergeFromBuffer(data, registry);
  factory RevokeOtherSessionsResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RevokeOtherSessionsResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RevokeOtherSessionsResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RevokeOtherSessionsResponse.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'revokedCount')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeOtherSessionsResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RevokeOtherSessionsResponse copyWith(
          void Function(RevokeOtherSessionsResponse) updates) =>
      super.copyWith(
              (message) => updates(message as RevokeOtherSessionsResponse))
          as RevokeOtherSessionsResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RevokeOtherSessionsResponse() / RevokeOtherSessionsResponse.new instead')
  static RevokeOtherSessionsResponse create() =>
      RevokeOtherSessionsResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      RevokeOtherSessionsResponse._();
  @$core.override
  RevokeOtherSessionsResponse createEmptyInstance() =>
      RevokeOtherSessionsResponse._();
  @$core.pragma('dart2js:noInline')
  static RevokeOtherSessionsResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RevokeOtherSessionsResponse>(
          RevokeOtherSessionsResponse.$_createMessage);
  static RevokeOtherSessionsResponse? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get revokedCount => $_getIZ(0);
  @$pb.TagNumber(1)
  set revokedCount($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasRevokedCount() => $_has(0);
  @$pb.TagNumber(1)
  void clearRevokedCount() => $_clearField(1);
}

class RegisterPushTokenRequest extends $pb.GeneratedMessage {
  factory RegisterPushTokenRequest({
    PushProvider? provider,
    $core.String? token,
  }) {
    final result = RegisterPushTokenRequest._();
    if (provider != null) result.provider = provider;
    if (token != null) result.token = token;
    return result;
  }

  RegisterPushTokenRequest._();

  factory RegisterPushTokenRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RegisterPushTokenRequest()..mergeFromBuffer(data, registry);
  factory RegisterPushTokenRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RegisterPushTokenRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterPushTokenRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RegisterPushTokenRequest.$_createMessage)
    ..aE<PushProvider>(1, _omitFieldNames ? '' : 'provider',
        enumValues: PushProvider.values)
    ..aOS(2, _omitFieldNames ? '' : 'token')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterPushTokenRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterPushTokenRequest copyWith(
          void Function(RegisterPushTokenRequest) updates) =>
      super.copyWith((message) => updates(message as RegisterPushTokenRequest))
          as RegisterPushTokenRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RegisterPushTokenRequest() / RegisterPushTokenRequest.new instead')
  static RegisterPushTokenRequest create() => RegisterPushTokenRequest._();
  static $pb.GeneratedMessage $_createMessage() => RegisterPushTokenRequest._();
  @$core.override
  RegisterPushTokenRequest createEmptyInstance() =>
      RegisterPushTokenRequest._();
  @$core.pragma('dart2js:noInline')
  static RegisterPushTokenRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterPushTokenRequest>(
          RegisterPushTokenRequest.$_createMessage);
  static RegisterPushTokenRequest? _defaultInstance;

  @$pb.TagNumber(1)
  PushProvider get provider => $_getN(0);
  @$pb.TagNumber(1)
  set provider(PushProvider value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasProvider() => $_has(0);
  @$pb.TagNumber(1)
  void clearProvider() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.String get token => $_getSZ(1);
  @$pb.TagNumber(2)
  set token($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearToken() => $_clearField(2);
}

class RegisterPushTokenResponse extends $pb.GeneratedMessage {
  factory RegisterPushTokenResponse() => RegisterPushTokenResponse._();

  RegisterPushTokenResponse._();

  factory RegisterPushTokenResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RegisterPushTokenResponse()..mergeFromBuffer(data, registry);
  factory RegisterPushTokenResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RegisterPushTokenResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RegisterPushTokenResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RegisterPushTokenResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterPushTokenResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RegisterPushTokenResponse copyWith(
          void Function(RegisterPushTokenResponse) updates) =>
      super.copyWith((message) => updates(message as RegisterPushTokenResponse))
          as RegisterPushTokenResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use RegisterPushTokenResponse() / RegisterPushTokenResponse.new instead')
  static RegisterPushTokenResponse create() => RegisterPushTokenResponse._();
  static $pb.GeneratedMessage $_createMessage() =>
      RegisterPushTokenResponse._();
  @$core.override
  RegisterPushTokenResponse createEmptyInstance() =>
      RegisterPushTokenResponse._();
  @$core.pragma('dart2js:noInline')
  static RegisterPushTokenResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RegisterPushTokenResponse>(
          RegisterPushTokenResponse.$_createMessage);
  static RegisterPushTokenResponse? _defaultInstance;
}

class SetPasswordRequest extends $pb.GeneratedMessage {
  factory SetPasswordRequest({
    $core.String? currentPassword,
    $core.String? newPassword,
    $core.String? hint,
    $core.String? recoveryEmail,
  }) {
    final result = SetPasswordRequest._();
    if (currentPassword != null) result.currentPassword = currentPassword;
    if (newPassword != null) result.newPassword = newPassword;
    if (hint != null) result.hint = hint;
    if (recoveryEmail != null) result.recoveryEmail = recoveryEmail;
    return result;
  }

  SetPasswordRequest._();

  factory SetPasswordRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetPasswordRequest()..mergeFromBuffer(data, registry);
  factory SetPasswordRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetPasswordRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetPasswordRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetPasswordRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'currentPassword')
    ..aOS(2, _omitFieldNames ? '' : 'newPassword')
    ..aOS(3, _omitFieldNames ? '' : 'hint')
    ..aOS(4, _omitFieldNames ? '' : 'recoveryEmail')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPasswordRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPasswordRequest copyWith(void Function(SetPasswordRequest) updates) =>
      super.copyWith((message) => updates(message as SetPasswordRequest))
          as SetPasswordRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use SetPasswordRequest() / SetPasswordRequest.new instead')
  static SetPasswordRequest create() => SetPasswordRequest._();
  static $pb.GeneratedMessage $_createMessage() => SetPasswordRequest._();
  @$core.override
  SetPasswordRequest createEmptyInstance() => SetPasswordRequest._();
  @$core.pragma('dart2js:noInline')
  static SetPasswordRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetPasswordRequest>(
          SetPasswordRequest.$_createMessage);
  static SetPasswordRequest? _defaultInstance;

  /// Required when a password is already set.
  @$pb.TagNumber(1)
  $core.String get currentPassword => $_getSZ(0);
  @$pb.TagNumber(1)
  set currentPassword($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasCurrentPassword() => $_has(0);
  @$pb.TagNumber(1)
  void clearCurrentPassword() => $_clearField(1);

  /// Empty removes two-step verification.
  @$pb.TagNumber(2)
  $core.String get newPassword => $_getSZ(1);
  @$pb.TagNumber(2)
  set newPassword($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasNewPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearNewPassword() => $_clearField(2);

  @$pb.TagNumber(3)
  $core.String get hint => $_getSZ(2);
  @$pb.TagNumber(3)
  set hint($core.String value) => $_setString(2, value);
  @$pb.TagNumber(3)
  $core.bool hasHint() => $_has(2);
  @$pb.TagNumber(3)
  void clearHint() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get recoveryEmail => $_getSZ(3);
  @$pb.TagNumber(4)
  set recoveryEmail($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasRecoveryEmail() => $_has(3);
  @$pb.TagNumber(4)
  void clearRecoveryEmail() => $_clearField(4);
}

class SetPasswordResponse extends $pb.GeneratedMessage {
  factory SetPasswordResponse() => SetPasswordResponse._();

  SetPasswordResponse._();

  factory SetPasswordResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetPasswordResponse()..mergeFromBuffer(data, registry);
  factory SetPasswordResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      SetPasswordResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'SetPasswordResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: SetPasswordResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPasswordResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  SetPasswordResponse copyWith(void Function(SetPasswordResponse) updates) =>
      super.copyWith((message) => updates(message as SetPasswordResponse))
          as SetPasswordResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core
      .Deprecated('Use SetPasswordResponse() / SetPasswordResponse.new instead')
  static SetPasswordResponse create() => SetPasswordResponse._();
  static $pb.GeneratedMessage $_createMessage() => SetPasswordResponse._();
  @$core.override
  SetPasswordResponse createEmptyInstance() => SetPasswordResponse._();
  @$core.pragma('dart2js:noInline')
  static SetPasswordResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<SetPasswordResponse>(
          SetPasswordResponse.$_createMessage);
  static SetPasswordResponse? _defaultInstance;
}

class DeleteAccountRequest extends $pb.GeneratedMessage {
  factory DeleteAccountRequest({
    $core.String? reason,
    $core.String? password,
  }) {
    final result = DeleteAccountRequest._();
    if (reason != null) result.reason = reason;
    if (password != null) result.password = password;
    return result;
  }

  DeleteAccountRequest._();

  factory DeleteAccountRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteAccountRequest()..mergeFromBuffer(data, registry);
  factory DeleteAccountRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteAccountRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAccountRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DeleteAccountRequest.$_createMessage)
    ..aOS(1, _omitFieldNames ? '' : 'reason')
    ..aOS(2, _omitFieldNames ? '' : 'password')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAccountRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAccountRequest copyWith(void Function(DeleteAccountRequest) updates) =>
      super.copyWith((message) => updates(message as DeleteAccountRequest))
          as DeleteAccountRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteAccountRequest() / DeleteAccountRequest.new instead')
  static DeleteAccountRequest create() => DeleteAccountRequest._();
  static $pb.GeneratedMessage $_createMessage() => DeleteAccountRequest._();
  @$core.override
  DeleteAccountRequest createEmptyInstance() => DeleteAccountRequest._();
  @$core.pragma('dart2js:noInline')
  static DeleteAccountRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAccountRequest>(
          DeleteAccountRequest.$_createMessage);
  static DeleteAccountRequest? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get reason => $_getSZ(0);
  @$pb.TagNumber(1)
  set reason($core.String value) => $_setString(0, value);
  @$pb.TagNumber(1)
  $core.bool hasReason() => $_has(0);
  @$pb.TagNumber(1)
  void clearReason() => $_clearField(1);

  /// Required when two-step verification is on.
  @$pb.TagNumber(2)
  $core.String get password => $_getSZ(1);
  @$pb.TagNumber(2)
  set password($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPassword() => $_has(1);
  @$pb.TagNumber(2)
  void clearPassword() => $_clearField(2);
}

class DeleteAccountResponse extends $pb.GeneratedMessage {
  factory DeleteAccountResponse() => DeleteAccountResponse._();

  DeleteAccountResponse._();

  factory DeleteAccountResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteAccountResponse()..mergeFromBuffer(data, registry);
  factory DeleteAccountResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      DeleteAccountResponse()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'DeleteAccountResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: DeleteAccountResponse.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAccountResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  DeleteAccountResponse copyWith(
          void Function(DeleteAccountResponse) updates) =>
      super.copyWith((message) => updates(message as DeleteAccountResponse))
          as DeleteAccountResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated(
      'Use DeleteAccountResponse() / DeleteAccountResponse.new instead')
  static DeleteAccountResponse create() => DeleteAccountResponse._();
  static $pb.GeneratedMessage $_createMessage() => DeleteAccountResponse._();
  @$core.override
  DeleteAccountResponse createEmptyInstance() => DeleteAccountResponse._();
  @$core.pragma('dart2js:noInline')
  static DeleteAccountResponse getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<DeleteAccountResponse>(
          DeleteAccountResponse.$_createMessage);
  static DeleteAccountResponse? _defaultInstance;
}

/// AuthService: phone + one-time code login, two-step verification, sessions.
///
/// Login flow:
///   SendCode ─► SignIn ─┬─► authorization           (existing account)
///                       ├─► sign_up_required ─► SignUp
///                       └─► password_required ─► CheckPassword
/// A successful SignIn/SignUp/CheckPassword authenticates the current
/// connection and returns a session token for future Hello frames.
class AuthServiceApi {
  final $pb.RpcClient _client;

  AuthServiceApi(this._client);

  $async.Future<SendCodeResponse> sendCode(
          $pb.ClientContext? ctx, SendCodeRequest request) =>
      _client.invoke<SendCodeResponse>(
          ctx, 'AuthService', 'SendCode', request, SendCodeResponse());
  $async.Future<ResendCodeResponse> resendCode(
          $pb.ClientContext? ctx, ResendCodeRequest request) =>
      _client.invoke<ResendCodeResponse>(
          ctx, 'AuthService', 'ResendCode', request, ResendCodeResponse());
  $async.Future<SignInResponse> signIn(
          $pb.ClientContext? ctx, SignInRequest request) =>
      _client.invoke<SignInResponse>(
          ctx, 'AuthService', 'SignIn', request, SignInResponse());
  $async.Future<SignUpResponse> signUp(
          $pb.ClientContext? ctx, SignUpRequest request) =>
      _client.invoke<SignUpResponse>(
          ctx, 'AuthService', 'SignUp', request, SignUpResponse());
  $async.Future<CheckPasswordResponse> checkPassword(
          $pb.ClientContext? ctx, CheckPasswordRequest request) =>
      _client.invoke<CheckPasswordResponse>(ctx, 'AuthService', 'CheckPassword',
          request, CheckPasswordResponse());
  $async.Future<LogOutResponse> logOut(
          $pb.ClientContext? ctx, LogOutRequest request) =>
      _client.invoke<LogOutResponse>(
          ctx, 'AuthService', 'LogOut', request, LogOutResponse());
  $async.Future<ListSessionsResponse> listSessions(
          $pb.ClientContext? ctx, ListSessionsRequest request) =>
      _client.invoke<ListSessionsResponse>(
          ctx, 'AuthService', 'ListSessions', request, ListSessionsResponse());
  $async.Future<RevokeSessionResponse> revokeSession(
          $pb.ClientContext? ctx, RevokeSessionRequest request) =>
      _client.invoke<RevokeSessionResponse>(ctx, 'AuthService', 'RevokeSession',
          request, RevokeSessionResponse());
  $async.Future<RevokeOtherSessionsResponse> revokeOtherSessions(
          $pb.ClientContext? ctx, RevokeOtherSessionsRequest request) =>
      _client.invoke<RevokeOtherSessionsResponse>(ctx, 'AuthService',
          'RevokeOtherSessions', request, RevokeOtherSessionsResponse());
  $async.Future<RegisterPushTokenResponse> registerPushToken(
          $pb.ClientContext? ctx, RegisterPushTokenRequest request) =>
      _client.invoke<RegisterPushTokenResponse>(ctx, 'AuthService',
          'RegisterPushToken', request, RegisterPushTokenResponse());

  /// Sets, changes or removes the two-step verification password.
  $async.Future<SetPasswordResponse> setPassword(
          $pb.ClientContext? ctx, SetPasswordRequest request) =>
      _client.invoke<SetPasswordResponse>(
          ctx, 'AuthService', 'SetPassword', request, SetPasswordResponse());

  /// Required in-app by Google Play and the App Store.
  $async.Future<DeleteAccountResponse> deleteAccount(
          $pb.ClientContext? ctx, DeleteAccountRequest request) =>
      _client.invoke<DeleteAccountResponse>(ctx, 'AuthService', 'DeleteAccount',
          request, DeleteAccountResponse());
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
