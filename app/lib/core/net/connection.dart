import 'dart:async';
import 'dart:math';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/foundation.dart';
import 'package:protobuf/protobuf.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../gen/proto/wasla/v1/common.pbenum.dart';
import '../../gen/proto/wasla/v1/frame.pb.dart';
import '../../gen/proto/wasla/v1/updates.pb.dart';
import 'rpc_exception.dart';

enum ConnState { disconnected, connecting, connected }

/// Opens a WebSocket. Replaced in tests.
typedef SocketConnector = WebSocketChannel Function(Uri url);

/// Device details sent in every Hello.
class ClientInfo {
  const ClientInfo({
    required this.platform,
    required this.appVersion,
    this.deviceModel = '',
    this.osVersion = '',
    this.langCode = 'ar',
  });
  final Platform platform;
  final String appVersion;
  final String deviceModel;
  final String osVersion;
  final String langCode;
}

/// One persistent connection to the Wasla gateway (docs/03-protocol.md).
///
/// * Multiplexes RPCs by request id.
/// * Reconnects with exponential backoff and jitter (0.5 s → 30 s).
/// * Pings every 25 s when idle so mobile NAT mappings stay open.
/// * Exposes server pushes on [updates].
class WaslaConnection {
  WaslaConnection({
    required this.url,
    required this.info,
    SocketConnector? connector,
    this.rpcTimeout = const Duration(seconds: 15),
  }) : _connector = connector ?? WebSocketChannel.connect;

  final Uri url;
  final ClientInfo info;
  final Duration rpcTimeout;
  final SocketConnector _connector;

  final state = ValueNotifier<ConnState>(ConnState.disconnected);
  final _updates = StreamController<UpdatesPush>.broadcast();
  final _pending = <Int64, Completer<List<int>>>{};
  final _random = Random();

  WebSocketChannel? _channel;
  StreamSubscription<dynamic>? _sub;
  Completer<HelloAck>? _helloWaiter;
  Timer? _pingTimer;
  Timer? _reconnectTimer;
  int _nextId = 1;
  int _attempt = 0;
  String _token = '';
  bool _closedByUser = false;
  HelloAck? _ack;

  /// Server pushes (new messages, deletions, ...).
  Stream<UpdatesPush> get updates => _updates.stream;

  /// The last HelloAck (authentication status, server time).
  HelloAck? get ack => _ack;

  /// Session token sent in Hello; set after login, cleared on logout.
  set token(String value) => _token = value;

  /// Called when the server closes with 4001 (session revoked) or 4002
  /// (protocol too old).
  void Function()? onSessionRevoked;
  void Function()? onUpdateRequired;

  /// Connects and completes with the server's HelloAck.
  Future<HelloAck> connect() async {
    _closedByUser = false;
    _reconnectTimer?.cancel();
    if (state.value == ConnState.connected && _ack != null) return _ack!;
    if (_helloWaiter != null) return _helloWaiter!.future;
    final waiter = _helloWaiter = Completer<HelloAck>();
    state.value = ConnState.connecting;
    try {
      final ch = _connector(url);
      _channel = ch;
      await ch.ready;
      _sub = ch.stream.listen(_onData, onDone: _onDone, onError: (_) => _onDone());
      final hello = Frame(
        hello: Hello(
          protocolVersion: 1,
          sessionToken: _token,
          platform: info.platform,
          appVersion: info.appVersion,
          deviceModel: info.deviceModel,
          osVersion: info.osVersion,
          langCode: info.langCode,
        ),
      );
      ch.sink.add(hello.writeToBuffer());
    } catch (_) {
      _helloWaiter = null;
      _onDone();
      if (!waiter.isCompleted) waiter.completeError(RpcException.network());
    }
    return waiter.future;
  }

  /// Performs an RPC. [parse] is the response type's `fromBuffer`.
  Future<T> call<T extends GeneratedMessage>(
    String method,
    GeneratedMessage request,
    T Function(List<int>) parse,
  ) async {
    if (state.value != ConnState.connected) {
      await connect();
    }
    final id = Int64(_nextId++);
    final completer = Completer<List<int>>();
    _pending[id] = completer;
    final frame = Frame(
      request: RpcRequest(id: id, method: method, payload: request.writeToBuffer()),
    );
    try {
      _channel!.sink.add(frame.writeToBuffer());
    } catch (_) {
      _pending.remove(id);
      throw RpcException.network();
    }
    final bytes = await completer.future.timeout(
      rpcTimeout,
      onTimeout: () {
        _pending.remove(id);
        throw RpcException.network();
      },
    );
    return parse(bytes);
  }

  /// Closes for good (logout). No reconnect.
  Future<void> close() async {
    _closedByUser = true;
    _reconnectTimer?.cancel();
    await _teardown();
    state.value = ConnState.disconnected;
  }

  void _onData(dynamic data) {
    if (data is! List<int>) return;
    final Frame frame;
    try {
      frame = Frame.fromBuffer(data);
    } catch (_) {
      return;
    }
    _schedulePing();
    switch (frame.whichKind()) {
      case Frame_Kind.helloAck:
        _ack = frame.helloAck;
        _attempt = 0;
        state.value = ConnState.connected;
        _helloWaiter?.complete(frame.helloAck);
        _helloWaiter = null;
      case Frame_Kind.response:
        final r = frame.response;
        final c = _pending.remove(r.id);
        if (c == null) return;
        if (r.hasError()) {
          c.completeError(RpcException.fromProto(r.error));
        } else {
          c.complete(r.payload);
        }
      case Frame_Kind.updates:
        _updates.add(frame.updates);
      default:
        break;
    }
  }

  void _onDone() {
    final code = _channel?.closeCode;
    _teardown();
    state.value = ConnState.disconnected;
    final waiter = _helloWaiter;
    _helloWaiter = null;
    if (waiter != null && !waiter.isCompleted) waiter.completeError(RpcException.network());
    if (code == 4001) {
      onSessionRevoked?.call();
      return;
    }
    if (code == 4002) {
      onUpdateRequired?.call();
      return;
    }
    if (!_closedByUser) _scheduleReconnect();
  }

  Future<void> _teardown() async {
    _pingTimer?.cancel();
    for (final c in _pending.values) {
      if (!c.isCompleted) c.completeError(RpcException.network());
    }
    _pending.clear();
    await _sub?.cancel();
    _sub = null;
    await _channel?.sink.close();
    _channel = null;
    _ack = null;
  }

  void _scheduleReconnect() {
    final base = min(30.0, 0.5 * pow(2, _attempt));
    final delay = base * (0.75 + _random.nextDouble() * 0.5);
    _attempt++;
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(
      Duration(milliseconds: (delay * 1000).round()),
      () => connect().catchError((_) => HelloAck()),
    );
  }

  void _schedulePing() {
    _pingTimer?.cancel();
    _pingTimer = Timer.periodic(const Duration(seconds: 25), (_) {
      try {
        _channel?.sink.add(Frame(ping: Ping(nonce: Int64(_random.nextInt(1 << 31)))).writeToBuffer());
      } catch (_) {}
    });
  }
}
