import 'package:fixnum/fixnum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/core/storage/sqlite_store.dart';
import 'package:wasla/gen/proto/wasla/v1/chats.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/messages.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/users.pb.dart';

Message msg(int chat, int seq, String t) => Message(
      chatId: Int64(chat),
      seq: Int64(seq),
      senderId: Int64(2),
      content: MessageContent(text: TextContent(text: FormattedText(text: t))),
    );

void main() {
  late SqliteStore store;
  setUp(() => store = SqliteStore(sqlite3.openInMemory()));
  tearDown(() => store.close());

  test('round-trips chats, users, messages, outbox and pts', () {
    store.setOwner(Int64(1));
    store.saveChat(Chat(id: Int64(7), peerUserId: Int64(2)), Dialog(chatId: Int64(7), unreadCount: 3));
    store.saveUser(User(id: Int64(2), firstName: 'سارة'));
    store.saveMessages([msg(7, 1, 'مرحبا'), msg(7, 2, 'كيف حالك؟')]);
    store.saveOutgoing(StoredOutgoing(chatId: Int64(7), randomId: Int64(99), text: 'بخير', createdAt: DateTime(2026, 11, 18)));
    store.savePts(Int64(42));

    final s = store.load(Int64(1));
    expect(s.pts, Int64(42));
    expect(s.ownerId, Int64(1));
    expect(s.chats[Int64(7)]!.$2.unreadCount, 3);
    expect(s.users[Int64(2)]!.firstName, 'سارة');
    expect(s.messages[Int64(7)]!.map((m) => m.content.text.text.text), ['مرحبا', 'كيف حالك؟']);
    expect(s.outbox.single.randomId, Int64(99));
  });

  test('deletes, clears and outbox removal', () {
    store.saveChat(Chat(id: Int64(7)), Dialog(chatId: Int64(7)));
    store.saveMessages([for (var i = 1; i <= 5; i++) msg(7, i, 'm$i')]);
    store.deleteMessages(Int64(7), [Int64(2)]);
    store.deleteMessagesUpTo(Int64(7), Int64(3));
    expect(store.load(Int64.ZERO).messages[Int64(7)]!.map((m) => m.seq.toInt()), [4, 5]);
    store.saveOutgoing(StoredOutgoing(chatId: Int64(7), randomId: Int64(1), text: 'x', createdAt: DateTime.now()));
    store.deleteOutgoing(Int64(1));
    expect(store.load(Int64.ZERO).outbox, isEmpty);
    store.deleteChat(Int64(7));
    expect(store.load(Int64.ZERO).chats, isEmpty);
  });

  test('keeps the newest 200 messages per chat in the snapshot', () {
    store.saveChat(Chat(id: Int64(7)), Dialog(chatId: Int64(7)));
    store.saveMessages([for (var i = 1; i <= 250; i++) msg(7, i, 'm$i')]);
    final list = store.load(Int64.ZERO).messages[Int64(7)]!;
    expect(list.length, 200);
    expect(list.first.seq, Int64(51));
    expect(list.last.seq, Int64(250));
  });

  test("another account signing in never sees the previous account's data", () {
    store.setOwner(Int64(1));
    store.saveChat(Chat(id: Int64(7)), Dialog(chatId: Int64(7)));
    store.savePts(Int64(10));
    final s = store.load(Int64(2));
    expect(s.isEmpty, isTrue);
    expect(s.pts, Int64.ZERO);
    expect(store.load(Int64.ZERO).chats, isEmpty, reason: 'data was wiped, not just hidden');
  });

  test('wipe removes everything', () {
    store.setOwner(Int64(1));
    store.saveChat(Chat(id: Int64(7)), Dialog(chatId: Int64(7)));
    store.wipe();
    final s = store.load(Int64(1));
    expect(s.isEmpty, isTrue);
    expect(s.ownerId, Int64.ZERO);
  });
}
