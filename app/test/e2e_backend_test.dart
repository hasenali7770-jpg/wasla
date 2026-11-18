// End-to-end test of the app's protocol client against a real wasla-server
// running with WASLA_ENV=dev. Skipped unless WASLA_E2E_URL is set:
//
//   WASLA_E2E_URL=ws://127.0.0.1:8080/ws flutter test test/e2e_backend_test.dart
//
// Dev servers return the login code in SendCodeResponse.dev_code.
import 'dart:io' as io;
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/core/auth/auth_api.dart';
import 'package:wasla/core/chat/chat_api.dart';
import 'package:wasla/core/net/connection.dart';
import 'package:wasla/core/net/rpc_exception.dart';
import 'package:wasla/gen/proto/wasla/v1/auth.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/frame.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/messages.pb.dart';
import 'package:fixnum/fixnum.dart';

final _url = io.Platform.environment['WASLA_E2E_URL'];

WaslaConnection _conn() => WaslaConnection(
  url: Uri.parse(_url!),
  info: const ClientInfo(platform: Platform.PLATFORM_ANDROID, appVersion: '0.1.0', deviceModel: 'e2e', langCode: 'ar'),
);

void main() {
  test('sign up, reconnect with token, sessions, logout', () async {
    final phone = '+964770${1000000 + Random().nextInt(8999999)}';
    final conn = _conn();
    final api = RemoteAuthApi(conn);

    final ack = await conn.connect();
    expect(ack.authenticated, isFalse);

    final sent = await api.sendCode(phone, 'dev');
    expect(sent.codeLength, 5);
    final code = sent.devCode;
    expect(code, hasLength(5), reason: 'dev servers return the code');

    await expectLater(
      api.signIn(phone, sent.codeHash, code == '00000' ? '11111' : '00000'),
      throwsA(isA<RpcException>().having((e) => e.code, 'code', ErrorCode.ERROR_CODE_PHONE_CODE_INVALID)),
    );
    final signIn = await api.signIn(phone, sent.codeHash, code);
    expect(signIn.hasSignUpRequired(), isTrue);

    final up = await api.signUp(
      SignUpRequest(
        phone: phone,
        codeHash: sent.codeHash,
        firstName: 'اختبار',
        termsVersion: signIn.signUpRequired.termsVersion,
      ),
    );
    final token = up.authorization.sessionToken;
    expect(up.authorization.user.firstName, 'اختبار');
    await conn.close();

    // A fresh connection authenticates with the stored token.
    final conn2 = _conn()..token = token;
    final api2 = RemoteAuthApi(conn2);
    expect((await conn2.connect()).authenticated, isTrue);
    expect((await api2.getMe()).phone, phone);
    final sessions = await api2.listSessions();
    expect(sessions.single.current, isTrue);
    expect(sessions.single.deviceModel, 'e2e');

    await api2.logOut();
    await conn2.close();
    final conn3 = _conn()..token = token;
    expect((await conn3.connect()).authenticated, isFalse, reason: 'token must be dead after logout');
    await conn3.close();
  }, skip: _url == null ? 'WASLA_E2E_URL not set' : null);

  test('two users message each other live', () async {
    Future<(WaslaConnection, Int64)> newUser(String name) async {
      final phone = '+964780${1000000 + Random().nextInt(8999999)}';
      final conn = _conn();
      final api = RemoteAuthApi(conn);
      final sent = await api.sendCode(phone, 'dev');
      final signIn = await api.signIn(phone, sent.codeHash, sent.devCode);
      final up = await api.signUp(
        SignUpRequest(
          phone: phone,
          codeHash: sent.codeHash,
          firstName: name,
          termsVersion: signIn.signUpRequired.termsVersion,
        ),
      );
      return (conn, up.authorization.user.id);
    }

    final (aliConn, _) = await newUser('علي');
    final (saraConn, saraId) = await newUser('سارة');
    final incoming = saraConn.updates.firstWhere((p) => p.updates.any((u) => u.hasNewMessage()));

    final r = await RemoteChatApi(aliConn).send(
      SendMessageRequest(
        peer: userPeer(saraId),
        randomId: Int64(42),
        content: InputContent(text: FormattedText(text: 'مرحبا من الاختبار')),
      ),
    );
    expect(r.message.seq, Int64.ONE);

    final push = await incoming.timeout(const Duration(seconds: 5));
    final m = push.updates.firstWhere((u) => u.hasNewMessage()).newMessage.message;
    expect(m.content.text.text.text, 'مرحبا من الاختبار');
    expect(m.randomId, Int64.ZERO, reason: 'random_id is only shown to the sender');

    final dialogs = await RemoteChatApi(saraConn).listDialogs();
    expect(dialogs.dialogs.single.unreadCount, 1);
    await aliConn.close();
    await saraConn.close();
  }, skip: _url == null ? 'WASLA_E2E_URL not set' : null);
}
