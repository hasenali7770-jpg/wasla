import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:wasla/app/app.dart';
import 'package:wasla/core/auth/auth_controller.dart';
import 'package:wasla/core/chat/chat_store.dart';
import 'package:wasla/core/chat/format.dart';
import 'package:wasla/core/net/connection.dart';
import 'package:wasla/core/providers.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/core/storage/sqlite_store.dart';
import 'package:wasla/gen/proto/wasla/v1/chats.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/messages.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/updates.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/users.pb.dart';

import 'fakes/fake_chat_api.dart';

/// Offline app start: auth state has no profile (it could not be fetched).
class OfflineSignedIn extends AuthController {
  @override
  AuthState build() => AuthSignedIn(User());
}

final chatId = Int64(7);

SqliteStore previousSession() {
  final s = SqliteStore(sqlite3.openInMemory());
  s.setOwner(Int64(1));
  s.saveUser(User(id: Int64(2), firstName: 'سارة'));
  s.saveChat(
    Chat(id: chatId, type: ChatType.CHAT_TYPE_PRIVATE, peerUserId: Int64(2)),
    Dialog(chatId: chatId, readOutboxSeq: Int64(1)),
  );
  s.saveMessages([
    Message(chatId: chatId, seq: Int64(1), senderId: Int64(1), date: Int64(1795500000),
        content: MessageContent(text: TextContent(text: FormattedText(text: 'رسالتي المحفوظة')))),
    Message(chatId: chatId, seq: Int64(2), senderId: Int64(2), date: Int64(1795500060),
        content: MessageContent(text: TextContent(text: FormattedText(text: 'رد سارة المحفوظ')))),
  ]);
  s.saveOutgoing(StoredOutgoing(chatId: chatId, randomId: Int64(555), text: 'لم تُرسل بعد', createdAt: DateTime.now()));
  s.savePts(Int64(10));
  return s;
}

Widget app(FakeChatApi api, LocalStore store) => ProviderScope(
      overrides: [
        authProvider.overrideWith(OfflineSignedIn.new),
        localStoreProvider.overrideWithValue(Future.value(store)),
        chatApiProvider.overrideWithValue(api),
        connectionProvider.overrideWithValue(
          WaslaConnection(url: Uri.parse('ws://127.0.0.1:1/ws'), info: const ClientInfo(platform: Platform.PLATFORM_ANDROID, appVersion: 't')),
        ),
      ],
      child: const WaslaApp(),
    );

void main() {
  testWidgets('with no network the app opens straight into stored chats', (tester) async {
    final api = FakeChatApi()..offline = true;
    await tester.pumpWidget(app(api, previousSession()));
    await tester.pumpAndSettle();

    expect(find.text(isolate('سارة')), findsOneWidget);
    expect(api.listCalls, 0, reason: 'a stored session catches up with GetDifference, not a full reload');

    await tester.tap(find.byKey(ValueKey('dialog-$chatId')));
    await tester.pumpAndSettle();
    expect(find.text('رسالتي المحفوظة'), findsOneWidget);
    expect(find.text('رد سارة المحفوظ'), findsOneWidget);
    expect(find.text('لم تُرسل بعد'), findsOneWidget, reason: 'unsent message survives the restart');

    // My stored message is on my side (end = left in Arabic), even though
    // the profile could not be loaded: the owner id comes from the device.
    final width = tester.view.physicalSize.width / tester.view.devicePixelRatio;
    expect(tester.getCenter(find.text('رسالتي المحفوظة')).dx, lessThan(width / 2));
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('back online: catches up from the stored pts and re-sends the stored outbox', (tester) async {
    final api = FakeChatApi();
    api.difference = (pts) => GetDifferenceResponse(pts: Int64(11), updates: [
          Update(pts: Int64(11), ptsCount: 1, newMessage: NewMessage(message: Message(
            chatId: chatId, seq: Int64(3), senderId: Int64(2), date: Int64(1795500120),
            content: MessageContent(text: TextContent(text: FormattedText(text: 'وصلت أثناء غيابك')))))),
        ]);
    api.dialogs = ListDialogsResponse(chats: [Chat(id: chatId)]);
    final store = previousSession();
    await tester.pumpWidget(app(api, store));
    await tester.pumpAndSettle();

    expect(api.differenceCalls.first, Int64(10));
    expect(api.sent.single.randomId, Int64(555), reason: 'same random_id: the server de-duplicates');
    // The chat list preview shows the newest message (the re-sent one);
    // the message that arrived while offline is in the conversation.
    expect(find.text(isolate('لم تُرسل بعد')), findsOneWidget);
    await tester.tap(find.byKey(ValueKey('dialog-$chatId')));
    await tester.pumpAndSettle();
    expect(find.text('وصلت أثناء غيابك'), findsOneWidget);

    final after = store.load(Int64(1));
    expect(after.pts, Int64(11));
    expect(after.outbox, isEmpty);
    expect(after.messages[chatId]!.map((m) => m.seq.toInt()), containsAll([1, 2, 3]));
    await tester.pumpWidget(const SizedBox());
  });
}
