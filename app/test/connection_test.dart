import 'dart:async';
import 'dart:io';

import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/core/net/connection.dart';
import 'package:wasla/core/net/rpc_exception.dart';
import 'package:wasla/gen/proto/wasla/v1/auth.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/frame.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/updates.pb.dart';

/// A tiny stand-in for the Go gateway, speaking the same framing.
class FakeGateway {
  late HttpServer _server;
  final hellos = <Hello>[];
  WebSocket? socket;

  Uri get url => Uri.parse('ws://127.0.0.1:${_server.port}/ws');

  Future<void> start() async {
    _server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    _server.listen((req) async {
      final ws = await WebSocketTransformer.upgrade(req);
      socket = ws;
      ws.listen((data) {
        final f = Frame.fromBuffer(data as List<int>);
        if (f.hasHello()) {
          hellos.add(f.hello);
          ws.add(Frame(helloAck: HelloAck(authenticated: f.hello.sessionToken == 'good', userId: Int64(42))).writeToBuffer());
        } else if (f.hasRequest()) {
          final r = f.request;
          if (r.method == '/wasla.v1.AuthService/SendCode') {
            final req = SendCodeRequest.fromBuffer(r.payload);
            if (req.phone == '+9647801111111') {
              ws.add(Frame(
                response: RpcResponse(
                  id: r.id,
                  error: Error(code: ErrorCode.ERROR_CODE_PHONE_BANNED, message: 'banned'),
                ),
              ).writeToBuffer());
              return;
            }
            ws.add(Frame(
              response: RpcResponse(id: r.id, payload: SendCodeResponse(codeHash: 'abc', codeLength: 5).writeToBuffer()),
            ).writeToBuffer());
          }
        }
      });
    });
  }

  void push(UpdatesPush p) => socket!.add(Frame(updates: p).writeToBuffer());

  Future<void> kick(int code) => socket!.close(code, 'bye');

  Future<void> stop() => _server.close(force: true);
}

void main() {
  late FakeGateway gw;
  late WaslaConnection conn;

  setUp(() async {
    gw = FakeGateway();
    await gw.start();
    conn = WaslaConnection(
      url: gw.url,
      info: const ClientInfo(platform: Platform.PLATFORM_ANDROID, appVersion: '0.1.0', langCode: 'ar'),
      rpcTimeout: const Duration(seconds: 2),
    );
  });

  tearDown(() async {
    await conn.close();
    await gw.stop();
  });

  test('Hello carries the token and device info', () async {
    conn.token = 'good';
    final ack = await conn.connect();
    expect(ack.authenticated, isTrue);
    expect(ack.userId, Int64(42));
    expect(conn.state.value, ConnState.connected);
    expect(gw.hellos.single.protocolVersion, 1);
    expect(gw.hellos.single.langCode, 'ar');
  });

  test('RPC responses and errors are matched by id', () async {
    await conn.connect();
    final ok = await conn.call(
      '/wasla.v1.AuthService/SendCode',
      SendCodeRequest(phone: '+9647701234567'),
      SendCodeResponse.fromBuffer,
    );
    expect(ok.codeHash, 'abc');
    await expectLater(
      conn.call('/wasla.v1.AuthService/SendCode', SendCodeRequest(phone: '+9647801111111'), SendCodeResponse.fromBuffer),
      throwsA(isA<RpcException>().having((e) => e.code, 'code', ErrorCode.ERROR_CODE_PHONE_BANNED)),
    );
  });

  test('server pushes arrive on the updates stream', () async {
    await conn.connect();
    final next = conn.updates.first;
    gw.push(UpdatesPush(updates: [Update(pts: Int64(7))]));
    expect((await next).updates.single.pts, Int64(7));
  });

  test('close code 4001 signals a revoked session and does not reconnect', () async {
    conn.token = 'good';
    await conn.connect();
    final revoked = Completer<void>();
    conn.onSessionRevoked = revoked.complete;
    await gw.kick(4001);
    await revoked.future.timeout(const Duration(seconds: 2));
    expect(conn.state.value, ConnState.disconnected);
  });

  test('reconnects automatically after a dropped connection', () async {
    await conn.connect();
    await gw.kick(1001);
    // First retry is after ~0.5 s.
    for (var i = 0; i < 40 && gw.hellos.length < 2; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 100));
    }
    expect(gw.hellos.length, 2);
  });
}
