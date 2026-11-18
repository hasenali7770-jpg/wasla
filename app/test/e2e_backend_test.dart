// End-to-end test of the app's protocol client against a real wasla-server
// running with WASLA_ENV=dev. Skipped unless WASLA_E2E_URL is set:
//
//   WASLA_E2E_URL=ws://127.0.0.1:8080/ws flutter test test/e2e_backend_test.dart
//
// Dev servers return the login code in SendCodeResponse.dev_code.
import 'dart:io' as io;
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:wasla/core/auth/auth_api.dart';
import 'package:wasla/core/chat/chat_api.dart';
import 'package:wasla/core/net/connection.dart';
import 'package:wasla/core/net/rpc_exception.dart';
import 'package:wasla/gen/proto/wasla/v1/auth.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/frame.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/messages.pb.dart';
import 'package:fixnum/fixnum.dart';
import 'package:image/image.dart' as img;
import 'package:wasla/core/media/media.dart';
import 'package:wasla/core/media/picker.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/gen/proto/wasla/v1/media.pb.dart';

final _url = io.Platform.environment['WASLA_E2E_URL'];

WaslaConnection _conn() => WaslaConnection(
  url: Uri.parse(_url!),
  info: const ClientInfo(platform: Platform.PLATFORM_ANDROID, appVersion: '0.1.0', deviceModel: 'e2e', langCode: 'ar'),
);

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

  test('photos and files: real upload to storage, send, download by the other user', () async {
    final (aliConn, _) = await newUser('علي');
    final (saraConn, saraId) = await newUser('سارة');
    final ali = RemoteChatApi(aliConn);
    final sara = RemoteChatApi(saraConn);
    final transfer = MediaTransfer(ali);

    // A photo prepared the way the app does it.
    final p = compressPhoto(img.encodePng(img.Image(width: 2000, height: 1500)..clear(img.ColorRgb8(247, 197, 49))))!;
    final photo = await transfer.upload(OutMedia(
        kind: 1, fileName: 'photo.jpg', mime: 'image/jpeg', size: p.bytes.length, bytes: p.bytes, width: p.width, height: p.height));
    expect(photo.status, MediaStatus.MEDIA_STATUS_READY);
    expect([for (final v in photo.variants) v.type], containsAll(['thumb_s', 'thumb_m']));
    final sent = await ali.send(SendMessageRequest(
      peer: userPeer(saraId),
      randomId: Int64(7),
      content: InputContent(media: InputMedia(mediaId: photo.id, caption: FormattedText(text: 'صورة'))),
    ));

    // Sara downloads the thumbnail and the original through her own access.
    final cache = MediaCache(MediaTransfer(sara), disk: const NoDisk());
    final where = InMessage(sent.message.chatId, sent.message.seq);
    final thumb = img.decodeJpg(await cache.get(photo.id, 'thumb_m', where))!;
    expect(thumb.width, 320);
    final orig = await cache.get(photo.id, '', where);
    expect(orig, p.bytes);

    // A 6 MB file goes up in two parts (multipart) and comes back identical.
    final big = Uint8List.fromList(List.generate(6 * 1024 * 1024 + 123, (i) => i * 31 % 251));
    final progress = <double>[];
    final doc = await transfer.upload(
        OutMedia(kind: 3, fileName: 'تقرير.pdf', mime: 'application/pdf', size: big.length, bytes: big),
        onProgress: progress.add);
    expect(progress.last, 1.0);
    final docMsg = await ali.send(SendMessageRequest(
      peer: userPeer(saraId),
      randomId: Int64(8),
      content: InputContent(media: InputMedia(mediaId: doc.id)),
    ));
    expect(docMsg.message.content.document.media.fileName, 'تقرير.pdf');
    final got = await MediaTransfer(sara).download(GetDownloadUrlRequest(
        mediaId: doc.id, message: MessageRef(chatId: docMsg.message.chatId, seq: docMsg.message.seq)));
    expect(got.length, big.length);
    expect(got, big);

    // Someone else's media cannot be fetched without a chat that shows it.
    await expectLater(
      MediaTransfer(sara).download(GetDownloadUrlRequest(mediaId: doc.id)),
      throwsA(isA<RpcException>()),
    );

    // Profile photo: Ali sets one, Sara sees it.
    final me = await ali.setProfilePhoto(photo.id);
    expect(me.photo.mediaId, photo.id);
    final aliId = me.id;
    final seen = (await sara.getUsers([aliId])).single;
    expect(seen.photo.mediaId, photo.id);
    final avatar = img.decodeJpg(await MediaCache(MediaTransfer(sara), disk: const NoDisk()).get(photo.id, 'thumb_s', OfUser(aliId)))!;
    expect(avatar.width, 90);
    await aliConn.close();
    await saraConn.close();
  }, skip: _url == null ? 'WASLA_E2E_URL not set' : null);
}
