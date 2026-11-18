// This is a generated file - do not edit.
//
// Generated from wasla/v1/frame.proto.

// @dart = 3.3

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names
// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: deprecated_member_use_from_same_package, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_relative_imports

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'common.pbenum.dart' as $1;
import 'frame.pbenum.dart';
import 'updates.pb.dart' as $0;

export 'package:protobuf/protobuf.dart' show GeneratedMessageGenericExtensions;

export 'frame.pbenum.dart';

enum Frame_Kind {
  request,
  response,
  updates,
  ping,
  pong,
  hello,
  helloAck,
  notSet
}

/// Frame is the only type that crosses the WebSocket: exactly one Frame per
/// binary WebSocket message, compressed with permessage-deflate.
///
/// Life of a connection:
///   1. Client opens wss://edge.wasla.app/ws and sends Hello.
///   2. Server answers HelloAck. If Hello carried a valid session token the
///      connection is authenticated; otherwise only AuthService methods work
///      until SignIn/SignUp/CheckPassword succeeds on this connection.
///   3. Either side sends RpcRequest/RpcResponse; the server pushes UpdatesPush.
///   4. Client sends Ping every 25 s when idle (keeps mobile NAT mappings open).
/// See docs/03-protocol.md.
class Frame extends $pb.GeneratedMessage {
  factory Frame({
    RpcRequest? request,
    RpcResponse? response,
    $0.UpdatesPush? updates,
    Ping? ping,
    Pong? pong,
    Hello? hello,
    HelloAck? helloAck,
  }) {
    final result = Frame._();
    if (request != null) result.request = request;
    if (response != null) result.response = response;
    if (updates != null) result.updates = updates;
    if (ping != null) result.ping = ping;
    if (pong != null) result.pong = pong;
    if (hello != null) result.hello = hello;
    if (helloAck != null) result.helloAck = helloAck;
    return result;
  }

  Frame._();

  factory Frame.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Frame()..mergeFromBuffer(data, registry);
  factory Frame.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Frame()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, Frame_Kind> _Frame_KindByTag = {
    1: Frame_Kind.request,
    2: Frame_Kind.response,
    3: Frame_Kind.updates,
    4: Frame_Kind.ping,
    5: Frame_Kind.pong,
    6: Frame_Kind.hello,
    7: Frame_Kind.helloAck,
    0: Frame_Kind.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Frame',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Frame.$_createMessage)
    ..oo(0, [1, 2, 3, 4, 5, 6, 7])
    ..aOM<RpcRequest>(1, _omitFieldNames ? '' : 'request',
        subBuilder: RpcRequest.$_createMessage)
    ..aOM<RpcResponse>(2, _omitFieldNames ? '' : 'response',
        subBuilder: RpcResponse.$_createMessage)
    ..aOM<$0.UpdatesPush>(3, _omitFieldNames ? '' : 'updates',
        subBuilder: $0.UpdatesPush.$_createMessage)
    ..aOM<Ping>(4, _omitFieldNames ? '' : 'ping',
        subBuilder: Ping.$_createMessage)
    ..aOM<Pong>(5, _omitFieldNames ? '' : 'pong',
        subBuilder: Pong.$_createMessage)
    ..aOM<Hello>(6, _omitFieldNames ? '' : 'hello',
        subBuilder: Hello.$_createMessage)
    ..aOM<HelloAck>(7, _omitFieldNames ? '' : 'helloAck',
        subBuilder: HelloAck.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Frame clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Frame copyWith(void Function(Frame) updates) =>
      super.copyWith((message) => updates(message as Frame)) as Frame;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Frame() / Frame.new instead')
  static Frame create() => Frame._();
  static $pb.GeneratedMessage $_createMessage() => Frame._();
  @$core.override
  Frame createEmptyInstance() => Frame._();
  @$core.pragma('dart2js:noInline')
  static Frame getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Frame>(Frame.$_createMessage);
  static Frame? _defaultInstance;

  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  Frame_Kind whichKind() => _Frame_KindByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(1)
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  @$pb.TagNumber(4)
  @$pb.TagNumber(5)
  @$pb.TagNumber(6)
  @$pb.TagNumber(7)
  void clearKind() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  RpcRequest get request => $_getN(0);
  @$pb.TagNumber(1)
  set request(RpcRequest value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasRequest() => $_has(0);
  @$pb.TagNumber(1)
  void clearRequest() => $_clearField(1);
  @$pb.TagNumber(1)
  RpcRequest ensureRequest() => $_ensure(0);

  @$pb.TagNumber(2)
  RpcResponse get response => $_getN(1);
  @$pb.TagNumber(2)
  set response(RpcResponse value) => $_setField(2, value);
  @$pb.TagNumber(2)
  $core.bool hasResponse() => $_has(1);
  @$pb.TagNumber(2)
  void clearResponse() => $_clearField(2);
  @$pb.TagNumber(2)
  RpcResponse ensureResponse() => $_ensure(1);

  @$pb.TagNumber(3)
  $0.UpdatesPush get updates => $_getN(2);
  @$pb.TagNumber(3)
  set updates($0.UpdatesPush value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasUpdates() => $_has(2);
  @$pb.TagNumber(3)
  void clearUpdates() => $_clearField(3);
  @$pb.TagNumber(3)
  $0.UpdatesPush ensureUpdates() => $_ensure(2);

  @$pb.TagNumber(4)
  Ping get ping => $_getN(3);
  @$pb.TagNumber(4)
  set ping(Ping value) => $_setField(4, value);
  @$pb.TagNumber(4)
  $core.bool hasPing() => $_has(3);
  @$pb.TagNumber(4)
  void clearPing() => $_clearField(4);
  @$pb.TagNumber(4)
  Ping ensurePing() => $_ensure(3);

  @$pb.TagNumber(5)
  Pong get pong => $_getN(4);
  @$pb.TagNumber(5)
  set pong(Pong value) => $_setField(5, value);
  @$pb.TagNumber(5)
  $core.bool hasPong() => $_has(4);
  @$pb.TagNumber(5)
  void clearPong() => $_clearField(5);
  @$pb.TagNumber(5)
  Pong ensurePong() => $_ensure(4);

  @$pb.TagNumber(6)
  Hello get hello => $_getN(5);
  @$pb.TagNumber(6)
  set hello(Hello value) => $_setField(6, value);
  @$pb.TagNumber(6)
  $core.bool hasHello() => $_has(5);
  @$pb.TagNumber(6)
  void clearHello() => $_clearField(6);
  @$pb.TagNumber(6)
  Hello ensureHello() => $_ensure(5);

  @$pb.TagNumber(7)
  HelloAck get helloAck => $_getN(6);
  @$pb.TagNumber(7)
  set helloAck(HelloAck value) => $_setField(7, value);
  @$pb.TagNumber(7)
  $core.bool hasHelloAck() => $_has(6);
  @$pb.TagNumber(7)
  void clearHelloAck() => $_clearField(7);
  @$pb.TagNumber(7)
  HelloAck ensureHelloAck() => $_ensure(6);
}

class Hello extends $pb.GeneratedMessage {
  factory Hello({
    $core.int? protocolVersion,
    $core.String? sessionToken,
    $1.Platform? platform,
    $core.String? appVersion,
    $core.String? deviceModel,
    $core.String? osVersion,
    $core.String? langCode,
  }) {
    final result = Hello._();
    if (protocolVersion != null) result.protocolVersion = protocolVersion;
    if (sessionToken != null) result.sessionToken = sessionToken;
    if (platform != null) result.platform = platform;
    if (appVersion != null) result.appVersion = appVersion;
    if (deviceModel != null) result.deviceModel = deviceModel;
    if (osVersion != null) result.osVersion = osVersion;
    if (langCode != null) result.langCode = langCode;
    return result;
  }

  Hello._();

  factory Hello.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Hello()..mergeFromBuffer(data, registry);
  factory Hello.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Hello()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Hello',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Hello.$_createMessage)
    ..aI(1, _omitFieldNames ? '' : 'protocolVersion')
    ..aOS(2, _omitFieldNames ? '' : 'sessionToken')
    ..aE<$1.Platform>(3, _omitFieldNames ? '' : 'platform',
        enumValues: $1.Platform.values)
    ..aOS(4, _omitFieldNames ? '' : 'appVersion')
    ..aOS(5, _omitFieldNames ? '' : 'deviceModel')
    ..aOS(6, _omitFieldNames ? '' : 'osVersion')
    ..aOS(7, _omitFieldNames ? '' : 'langCode')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Hello clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Hello copyWith(void Function(Hello) updates) =>
      super.copyWith((message) => updates(message as Hello)) as Hello;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Hello() / Hello.new instead')
  static Hello create() => Hello._();
  static $pb.GeneratedMessage $_createMessage() => Hello._();
  @$core.override
  Hello createEmptyInstance() => Hello._();
  @$core.pragma('dart2js:noInline')
  static Hello getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Hello>(Hello.$_createMessage);
  static Hello? _defaultInstance;

  /// Increase only on incompatible framing changes. Current: 1.
  @$pb.TagNumber(1)
  $core.int get protocolVersion => $_getIZ(0);
  @$pb.TagNumber(1)
  set protocolVersion($core.int value) => $_setSignedInt32(0, value);
  @$pb.TagNumber(1)
  $core.bool hasProtocolVersion() => $_has(0);
  @$pb.TagNumber(1)
  void clearProtocolVersion() => $_clearField(1);

  /// Empty for a fresh install.
  @$pb.TagNumber(2)
  $core.String get sessionToken => $_getSZ(1);
  @$pb.TagNumber(2)
  set sessionToken($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasSessionToken() => $_has(1);
  @$pb.TagNumber(2)
  void clearSessionToken() => $_clearField(2);

  @$pb.TagNumber(3)
  $1.Platform get platform => $_getN(2);
  @$pb.TagNumber(3)
  set platform($1.Platform value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasPlatform() => $_has(2);
  @$pb.TagNumber(3)
  void clearPlatform() => $_clearField(3);

  @$pb.TagNumber(4)
  $core.String get appVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set appVersion($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasAppVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearAppVersion() => $_clearField(4);

  @$pb.TagNumber(5)
  $core.String get deviceModel => $_getSZ(4);
  @$pb.TagNumber(5)
  set deviceModel($core.String value) => $_setString(4, value);
  @$pb.TagNumber(5)
  $core.bool hasDeviceModel() => $_has(4);
  @$pb.TagNumber(5)
  void clearDeviceModel() => $_clearField(5);

  @$pb.TagNumber(6)
  $core.String get osVersion => $_getSZ(5);
  @$pb.TagNumber(6)
  set osVersion($core.String value) => $_setString(5, value);
  @$pb.TagNumber(6)
  $core.bool hasOsVersion() => $_has(5);
  @$pb.TagNumber(6)
  void clearOsVersion() => $_clearField(6);

  /// BCP 47, e.g. "ar-IQ". Used for SMS text and server-generated strings.
  @$pb.TagNumber(7)
  $core.String get langCode => $_getSZ(6);
  @$pb.TagNumber(7)
  set langCode($core.String value) => $_setString(6, value);
  @$pb.TagNumber(7)
  $core.bool hasLangCode() => $_has(6);
  @$pb.TagNumber(7)
  void clearLangCode() => $_clearField(7);
}

class HelloAck extends $pb.GeneratedMessage {
  factory HelloAck({
    $fixnum.Int64? serverTime,
    $core.bool? authenticated,
    $fixnum.Int64? userId,
    $core.String? minAppVersion,
  }) {
    final result = HelloAck._();
    if (serverTime != null) result.serverTime = serverTime;
    if (authenticated != null) result.authenticated = authenticated;
    if (userId != null) result.userId = userId;
    if (minAppVersion != null) result.minAppVersion = minAppVersion;
    return result;
  }

  HelloAck._();

  factory HelloAck.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HelloAck()..mergeFromBuffer(data, registry);
  factory HelloAck.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      HelloAck()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'HelloAck',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: HelloAck.$_createMessage)
    ..aInt64(1, _omitFieldNames ? '' : 'serverTime')
    ..aOB(2, _omitFieldNames ? '' : 'authenticated')
    ..aInt64(3, _omitFieldNames ? '' : 'userId')
    ..aOS(4, _omitFieldNames ? '' : 'minAppVersion')
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HelloAck clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  HelloAck copyWith(void Function(HelloAck) updates) =>
      super.copyWith((message) => updates(message as HelloAck)) as HelloAck;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use HelloAck() / HelloAck.new instead')
  static HelloAck create() => HelloAck._();
  static $pb.GeneratedMessage $_createMessage() => HelloAck._();
  @$core.override
  HelloAck createEmptyInstance() => HelloAck._();
  @$core.pragma('dart2js:noInline')
  static HelloAck getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<HelloAck>(HelloAck.$_createMessage);
  static HelloAck? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get serverTime => $_getI64(0);
  @$pb.TagNumber(1)
  set serverTime($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasServerTime() => $_has(0);
  @$pb.TagNumber(1)
  void clearServerTime() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.bool get authenticated => $_getBF(1);
  @$pb.TagNumber(2)
  set authenticated($core.bool value) => $_setBool(1, value);
  @$pb.TagNumber(2)
  $core.bool hasAuthenticated() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthenticated() => $_clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get userId => $_getI64(2);
  @$pb.TagNumber(3)
  set userId($fixnum.Int64 value) => $_setInt64(2, value);
  @$pb.TagNumber(3)
  $core.bool hasUserId() => $_has(2);
  @$pb.TagNumber(3)
  void clearUserId() => $_clearField(3);

  /// Clients older than this must show a forced-update screen.
  @$pb.TagNumber(4)
  $core.String get minAppVersion => $_getSZ(3);
  @$pb.TagNumber(4)
  set minAppVersion($core.String value) => $_setString(3, value);
  @$pb.TagNumber(4)
  $core.bool hasMinAppVersion() => $_has(3);
  @$pb.TagNumber(4)
  void clearMinAppVersion() => $_clearField(4);
}

class RpcRequest extends $pb.GeneratedMessage {
  factory RpcRequest({
    $fixnum.Int64? id,
    $core.String? method,
    $core.List<$core.int>? payload,
  }) {
    final result = RpcRequest._();
    if (id != null) result.id = id;
    if (method != null) result.method = method;
    if (payload != null) result.payload = payload;
    return result;
  }

  RpcRequest._();

  factory RpcRequest.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcRequest()..mergeFromBuffer(data, registry);
  factory RpcRequest.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcRequest()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RpcRequest',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RpcRequest.$_createMessage)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, _omitFieldNames ? '' : 'method')
    ..a<$core.List<$core.int>>(
        3, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcRequest clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcRequest copyWith(void Function(RpcRequest) updates) =>
      super.copyWith((message) => updates(message as RpcRequest)) as RpcRequest;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RpcRequest() / RpcRequest.new instead')
  static RpcRequest create() => RpcRequest._();
  static $pb.GeneratedMessage $_createMessage() => RpcRequest._();
  @$core.override
  RpcRequest createEmptyInstance() => RpcRequest._();
  @$core.pragma('dart2js:noInline')
  static RpcRequest getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<RpcRequest>(RpcRequest.$_createMessage);
  static RpcRequest? _defaultInstance;

  /// Chosen by the client, unique per connection, echoed in RpcResponse.
  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  /// gRPC-style full method name, e.g. "/wasla.v1.MessagesService/SendMessage".
  /// The same name is the HTTP path of the Connect fallback transport.
  @$pb.TagNumber(2)
  $core.String get method => $_getSZ(1);
  @$pb.TagNumber(2)
  set method($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMethod() => $_has(1);
  @$pb.TagNumber(2)
  void clearMethod() => $_clearField(2);

  /// The serialized request message.
  @$pb.TagNumber(3)
  $core.List<$core.int> get payload => $_getN(2);
  @$pb.TagNumber(3)
  set payload($core.List<$core.int> value) => $_setBytes(2, value);
  @$pb.TagNumber(3)
  $core.bool hasPayload() => $_has(2);
  @$pb.TagNumber(3)
  void clearPayload() => $_clearField(3);
}

enum RpcResponse_Result { payload, error, notSet }

class RpcResponse extends $pb.GeneratedMessage {
  factory RpcResponse({
    $fixnum.Int64? id,
    $core.List<$core.int>? payload,
    Error? error,
  }) {
    final result = RpcResponse._();
    if (id != null) result.id = id;
    if (payload != null) result.payload = payload;
    if (error != null) result.error = error;
    return result;
  }

  RpcResponse._();

  factory RpcResponse.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcResponse()..mergeFromBuffer(data, registry);
  factory RpcResponse.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      RpcResponse()..mergeFromJson(json, registry);

  static const $core.Map<$core.int, RpcResponse_Result>
      _RpcResponse_ResultByTag = {
    2: RpcResponse_Result.payload,
    3: RpcResponse_Result.error,
    0: RpcResponse_Result.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'RpcResponse',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: RpcResponse.$_createMessage)
    ..oo(0, [2, 3])
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$core.List<$core.int>>(
        2, _omitFieldNames ? '' : 'payload', $pb.PbFieldType.OY)
    ..aOM<Error>(3, _omitFieldNames ? '' : 'error',
        subBuilder: Error.$_createMessage)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcResponse clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  RpcResponse copyWith(void Function(RpcResponse) updates) =>
      super.copyWith((message) => updates(message as RpcResponse))
          as RpcResponse;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use RpcResponse() / RpcResponse.new instead')
  static RpcResponse create() => RpcResponse._();
  static $pb.GeneratedMessage $_createMessage() => RpcResponse._();
  @$core.override
  RpcResponse createEmptyInstance() => RpcResponse._();
  @$core.pragma('dart2js:noInline')
  static RpcResponse getDefault() =>
      _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RpcResponse>(
          RpcResponse.$_createMessage);
  static RpcResponse? _defaultInstance;

  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  RpcResponse_Result whichResult() =>
      _RpcResponse_ResultByTag[$_whichOneof(0)]!;
  @$pb.TagNumber(2)
  @$pb.TagNumber(3)
  void clearResult() => $_clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => $_clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get payload => $_getN(1);
  @$pb.TagNumber(2)
  set payload($core.List<$core.int> value) => $_setBytes(1, value);
  @$pb.TagNumber(2)
  $core.bool hasPayload() => $_has(1);
  @$pb.TagNumber(2)
  void clearPayload() => $_clearField(2);

  @$pb.TagNumber(3)
  Error get error => $_getN(2);
  @$pb.TagNumber(3)
  set error(Error value) => $_setField(3, value);
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => $_clearField(3);
  @$pb.TagNumber(3)
  Error ensureError() => $_ensure(2);
}

class Error extends $pb.GeneratedMessage {
  factory Error({
    ErrorCode? code,
    $core.String? message,
    $core.int? retryAfterSeconds,
    $core.Iterable<$core.MapEntry<$core.String, $core.String>>? details,
  }) {
    final result = Error._();
    if (code != null) result.code = code;
    if (message != null) result.message = message;
    if (retryAfterSeconds != null) result.retryAfterSeconds = retryAfterSeconds;
    if (details != null) result.details.addEntries(details);
    return result;
  }

  Error._();

  factory Error.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Error()..mergeFromBuffer(data, registry);
  factory Error.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Error()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Error',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Error.$_createMessage)
    ..aE<ErrorCode>(1, _omitFieldNames ? '' : 'code',
        enumValues: ErrorCode.values)
    ..aOS(2, _omitFieldNames ? '' : 'message')
    ..aI(3, _omitFieldNames ? '' : 'retryAfterSeconds')
    ..m<$core.String, $core.String>(4, _omitFieldNames ? '' : 'details',
        entryClassName: 'Error.DetailsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('wasla.v1'))
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Error clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Error copyWith(void Function(Error) updates) =>
      super.copyWith((message) => updates(message as Error)) as Error;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Error() / Error.new instead')
  static Error create() => Error._();
  static $pb.GeneratedMessage $_createMessage() => Error._();
  @$core.override
  Error createEmptyInstance() => Error._();
  @$core.pragma('dart2js:noInline')
  static Error getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Error>(Error.$_createMessage);
  static Error? _defaultInstance;

  @$pb.TagNumber(1)
  ErrorCode get code => $_getN(0);
  @$pb.TagNumber(1)
  set code(ErrorCode value) => $_setField(1, value);
  @$pb.TagNumber(1)
  $core.bool hasCode() => $_has(0);
  @$pb.TagNumber(1)
  void clearCode() => $_clearField(1);

  /// Developer-facing English text. Clients localise from `code`.
  @$pb.TagNumber(2)
  $core.String get message => $_getSZ(1);
  @$pb.TagNumber(2)
  set message($core.String value) => $_setString(1, value);
  @$pb.TagNumber(2)
  $core.bool hasMessage() => $_has(1);
  @$pb.TagNumber(2)
  void clearMessage() => $_clearField(2);

  /// Set with ERROR_CODE_RATE_LIMITED.
  @$pb.TagNumber(3)
  $core.int get retryAfterSeconds => $_getIZ(2);
  @$pb.TagNumber(3)
  set retryAfterSeconds($core.int value) => $_setSignedInt32(2, value);
  @$pb.TagNumber(3)
  $core.bool hasRetryAfterSeconds() => $_has(2);
  @$pb.TagNumber(3)
  void clearRetryAfterSeconds() => $_clearField(3);

  @$pb.TagNumber(4)
  $pb.PbMap<$core.String, $core.String> get details => $_getMap(3);
}

class Ping extends $pb.GeneratedMessage {
  factory Ping({
    $fixnum.Int64? nonce,
  }) {
    final result = Ping._();
    if (nonce != null) result.nonce = nonce;
    return result;
  }

  Ping._();

  factory Ping.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Ping()..mergeFromBuffer(data, registry);
  factory Ping.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Ping()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Ping',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Ping.$_createMessage)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'nonce', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Ping clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Ping copyWith(void Function(Ping) updates) =>
      super.copyWith((message) => updates(message as Ping)) as Ping;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Ping() / Ping.new instead')
  static Ping create() => Ping._();
  static $pb.GeneratedMessage $_createMessage() => Ping._();
  @$core.override
  Ping createEmptyInstance() => Ping._();
  @$core.pragma('dart2js:noInline')
  static Ping getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Ping>(Ping.$_createMessage);
  static Ping? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get nonce => $_getI64(0);
  @$pb.TagNumber(1)
  set nonce($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNonce() => $_has(0);
  @$pb.TagNumber(1)
  void clearNonce() => $_clearField(1);
}

class Pong extends $pb.GeneratedMessage {
  factory Pong({
    $fixnum.Int64? nonce,
  }) {
    final result = Pong._();
    if (nonce != null) result.nonce = nonce;
    return result;
  }

  Pong._();

  factory Pong.fromBuffer($core.List<$core.int> data,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Pong()..mergeFromBuffer(data, registry);
  factory Pong.fromJson($core.String json,
          [$pb.ExtensionRegistry registry = $pb.ExtensionRegistry.EMPTY]) =>
      Pong()..mergeFromJson(json, registry);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      _omitMessageNames ? '' : 'Pong',
      package: const $pb.PackageName(_omitMessageNames ? '' : 'wasla.v1'),
      createEmptyInstance: Pong.$_createMessage)
    ..a<$fixnum.Int64>(1, _omitFieldNames ? '' : 'nonce', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false;

  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Pong clone() => deepCopy();
  @$core.Deprecated('See https://github.com/google/protobuf.dart/issues/998.')
  Pong copyWith(void Function(Pong) updates) =>
      super.copyWith((message) => updates(message as Pong)) as Pong;

  @$core.override
  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  @$core.Deprecated('Use Pong() / Pong.new instead')
  static Pong create() => Pong._();
  static $pb.GeneratedMessage $_createMessage() => Pong._();
  @$core.override
  Pong createEmptyInstance() => Pong._();
  @$core.pragma('dart2js:noInline')
  static Pong getDefault() => _defaultInstance ??=
      $pb.GeneratedMessage.$_defaultFor<Pong>(Pong.$_createMessage);
  static Pong? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get nonce => $_getI64(0);
  @$pb.TagNumber(1)
  set nonce($fixnum.Int64 value) => $_setInt64(0, value);
  @$pb.TagNumber(1)
  $core.bool hasNonce() => $_has(0);
  @$pb.TagNumber(1)
  void clearNonce() => $_clearField(1);
}

const $core.bool _omitFieldNames =
    $core.bool.fromEnvironment('protobuf.omit_field_names');
const $core.bool _omitMessageNames =
    $core.bool.fromEnvironment('protobuf.omit_message_names');
