import 'dart:typed_data';

import 'package:fixnum/fixnum.dart';
import 'package:flutter/material.dart' hide Dialog;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:image/image.dart' as img;
import 'package:sqlite3/sqlite3.dart';
import 'package:wasla/app/app.dart';
import 'package:wasla/core/chat/chat_store.dart';
import 'package:wasla/core/chat/format.dart';
import 'package:wasla/core/media/media.dart';
import 'package:wasla/core/media/picker.dart';
import 'package:wasla/core/media/source.dart';
import 'package:wasla/core/media/uploader.dart';
import 'package:wasla/core/net/connection.dart';
import 'package:wasla/core/providers.dart';
import 'package:wasla/core/storage/local_store.dart';
import 'package:wasla/core/storage/sqlite_store.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/media.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/messages.pb.dart';

import 'chat_flow_test.dart' show SignedIn, chatId, saraId, seeded, msg;
import 'fakes/fake_chat_api.dart';
import 'fakes/fake_media.dart';

Widget mediaApp(FakeChatApi api, FakeMediaTransfer transfer, FakePicker picker, {LocalStore? store}) => ProviderScope(
      overrides: [
        authProvider.overrideWith(SignedIn.new),
        localStoreProvider.overrideWithValue(Future.value(store ?? MemoryStore())),
        chatApiProvider.overrideWithValue(api),
        mediaTransferProvider.overrideWithValue(transfer),
        mediaCacheProvider.overrideWithValue(MediaCache(transfer, disk: const NoDisk())),
        mediaPickerProvider.overrideWithValue(picker),
        connectionProvider.overrideWithValue(
          WaslaConnection(url: Uri.parse('ws://127.0.0.1:1/ws'), info: const ClientInfo(platform: Platform.PLATFORM_ANDROID, appVersion: 't')),
        ),
      ],
      child: const WaslaApp(),
    );

Future<void> openChat(WidgetTester tester) async {
  await tester.tap(find.byKey(ValueKey('dialog-$chatId')));
  await tester.pumpAndSettle();
}

Future<void> attach(WidgetTester tester, String label) async {
  await tester.tap(find.byKey(const Key('attach')));
  await tester.pumpAndSettle();
  await tester.tap(find.text(label));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('send a photo with a caption: upload, then send, shown from local bytes', (tester) async {
    final api = seeded();
    final transfer = FakeMediaTransfer(api);
    final picker = FakePicker()..nextPhoto = testPhoto();
    await tester.pumpWidget(mediaApp(api, transfer, picker));
    await tester.pumpAndSettle();
    await openChat(tester);

    await attach(tester, 'صورة من المعرض');
    await tester.enterText(find.byKey(const Key('caption')), 'من الرحلة');
    await tester.tap(find.byKey(const Key('send-media')));
    await tester.pumpAndSettle();

    final sent = api.sent.single;
    expect(transfer.uploads.single.width, 8);
    expect(sent.content.media.mediaId, api.media.keys.single);
    expect(sent.content.media.caption.text, 'من الرحلة');
    expect(find.text('من الرحلة'), findsOneWidget);
    // Our own photo is drawn from the bytes we have: nothing downloaded.
    expect(find.byKey(ValueKey('photo-${sent.content.media.mediaId}')), findsOneWidget);
    expect(api.downloads, isEmpty);

    // The chat list says "📷 صورة · caption".
    Navigator.of(tester.element(find.byKey(const Key('composer')))).pop();
    await tester.pumpAndSettle();
    expect(find.text(isolate('📷 صورة · من الرحلة')), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('a failed upload retries on its own and then sends', (tester) async {
    final api = seeded();
    final transfer = FakeMediaTransfer(api)..failNext = 1;
    final picker = FakePicker()..nextFile = testDoc();
    await tester.pumpWidget(mediaApp(api, transfer, picker));
    await tester.pumpAndSettle();
    await openChat(tester);

    await attach(tester, 'ملف');
    expect(find.text(isolate('تقرير.pdf')), findsOneWidget); // preview sheet
    await tester.tap(find.byKey(const Key('send-media')));
    await tester.pump();
    expect(api.sent, isEmpty);
    await tester.pump(const Duration(seconds: 2)); // backoff
    await tester.pumpAndSettle();
    expect(api.sent.single.content.media.mediaId, api.media.keys.single);
    expect(find.text('3.0 م.ب'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('received photo loads its thumbnail; a document downloads on tap', (tester) async {
    final api = seeded();
    final photo = Media(id: Int64(900), kind: MediaKind.MEDIA_KIND_PHOTO, width: 1280, height: 960);
    final doc = Media(id: Int64(901), kind: MediaKind.MEDIA_KIND_DOCUMENT, fileName: 'Invoice.pdf', sizeBytes: Int64(2048));
    api.history[chatId] = [
      msg(1, 1, 'مرحبا'),
      msg(3, 2, '')..content = MessageContent(photo: PhotoContent(media: photo)),
      msg(4, 2, '')..content = MessageContent(document: DocumentContent(media: doc)),
    ];
    final transfer = FakeMediaTransfer(api);
    await tester.pumpWidget(mediaApp(api, transfer, FakePicker()));
    await tester.pumpAndSettle();
    await openChat(tester);

    final thumb = api.downloads.singleWhere((r) => r.mediaId == Int64(900));
    expect(thumb.variant, 'thumb_m');
    expect(thumb.message.chatId, chatId);
    expect(thumb.message.seq, Int64(3));
    expect(find.byType(Image), findsWidgets);

    await tester.tap(find.byKey(const ValueKey('doc-901')));
    await tester.pumpAndSettle();
    expect(transfer.fileDownloads.single.mediaId, Int64(901));
    expect(find.text('2 ك.ب'), findsOneWidget);

    // Full-screen viewer asks for the original.
    await tester.tap(find.byKey(const ValueKey('photo-900')));
    await tester.pumpAndSettle();
    expect(api.downloads.any((r) => r.mediaId == Int64(900) && r.variant.isEmpty), isTrue);
    expect(find.byType(InteractiveViewer), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('profile photos: shown for others, and I can change mine', (tester) async {
    final api = seeded();
    api.dialogs.users.first.photo = Avatar(mediaId: Int64(777));
    final transfer = FakeMediaTransfer(api);
    final picker = FakePicker()..nextPhoto = testPhoto();
    await tester.pumpWidget(mediaApp(api, transfer, picker));
    await tester.pumpAndSettle();
    final req = api.downloads.singleWhere((r) => r.mediaId == Int64(777));
    expect(req.variant, 'thumb_s');
    expect(req.userId, saraId);

    await tester.tap(find.byKey(const Key('main-menu')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('صورتي الشخصية'));
    await tester.pumpAndSettle();
    expect(api.profilePhoto, api.media.keys.single);
    expect(find.text('تم تحديث صورتك'), findsOneWidget);
    await tester.pumpWidget(const SizedBox());
  });

  test('a media message waiting to be sent survives a restart (schema v2)', () {
    final db = sqlite3.openInMemory();
    // A v1 database from the previous app version.
    db.execute('''
      CREATE TABLE outbox (random_id INTEGER PRIMARY KEY, chat_id INTEGER NOT NULL, text TEXT NOT NULL,
        reply_to INTEGER, created_at INTEGER NOT NULL, failed INTEGER NOT NULL DEFAULT 0);
      CREATE TABLE kv (key TEXT PRIMARY KEY, value TEXT NOT NULL);
      CREATE TABLE chats (id INTEGER PRIMARY KEY, chat BLOB NOT NULL, dialog BLOB NOT NULL);
      CREATE TABLE users (id INTEGER PRIMARY KEY, user BLOB NOT NULL);
      CREATE TABLE messages (chat_id INTEGER NOT NULL, seq INTEGER NOT NULL, msg BLOB NOT NULL,
        PRIMARY KEY (chat_id, seq)) WITHOUT ROWID;
      INSERT INTO outbox VALUES (5, 7, 'old text', NULL, 1, 0);
      PRAGMA user_version = 1;
    ''');
    final store = SqliteStore(db);
    store.saveOutgoing(StoredOutgoing(
      chatId: Int64(7),
      randomId: Int64(6),
      text: 'تعليق',
      createdAt: DateTime(2026, 11, 18),
      media: OutMedia(
          kind: 3, fileName: 'a.pdf', mime: 'application/pdf', size: 10, path: '/x/a.pdf', mediaId: Int64(44)),
    ));
    final out = store.load(Int64.ZERO).outbox;
    expect(out.first.text, 'old text');
    expect(out.first.media, isNull);
    final m = out.last.media!;
    expect([m.fileName, m.path, m.mediaId, m.isPhoto], ['a.pdf', '/x/a.pdf', Int64(44), false]);
    store.close();
  });

  test('uploader: parts in parallel to signed URLs, retries a 500, completes in order', () async {
    final api = PlanApi(partSize: 4, parts: 3);
    var fails = 1;
    final client = MockClient((r) async {
      expect(r.method, 'PUT');
      final n = int.parse(r.url.queryParameters['partNumber']!);
      if (n == 2 && fails-- > 0) return http.Response('busy', 500);
      api.received[n] = r.bodyBytes;
      return http.Response('', 200, headers: {'etag': '"e$n"'});
    });
    final progress = <double>[];
    final media = await Uploader(api, client: client).upload(
      source: BytesSource(Uint8List.fromList(List.generate(10, (i) => i))),
      kind: MediaKind.MEDIA_KIND_DOCUMENT,
      mime: 'application/pdf',
      fileName: 'x.pdf',
      onProgress: progress.add,
    );
    expect(media.id, Int64(1));
    expect(api.received[1], [0, 1, 2, 3]);
    expect(api.received[2], [4, 5, 6, 7]);
    expect(api.received[3], [8, 9]);
    expect(api.urlRequests, [[3]]); // the plan only had URLs for parts 1–2
    expect([for (final p in api.completed!.parts) p.partNumber]..sort(), [1, 2, 3]);
    expect(progress.last, 1.0);
  });

  test('photos are shrunk to 1280 px, re-encoded as JPEG, EXIF dropped', () {
    final big = img.Image(width: 3000, height: 1000);
    big.exif.imageIfd['Make'] = 'Test';
    final p = compressPhoto(img.encodeJpg(big))!;
    expect([p.width, p.height], [1280, 427]);
    final back = img.decodeJpg(p.bytes)!;
    expect(back.width, 1280);
    expect(back.exif.imageIfd['Make'], isNull);
    expect(compressPhoto(Uint8List.fromList([1, 2, 3])), isNull);
    expect(mimeFromName('Report.PDF'), 'application/pdf');
    expect(mimeFromName('noext'), 'application/octet-stream');
  });
}

/// MediaService side of the uploader test.
class PlanApi extends FakeChatApi {
  PlanApi({required this.partSize, required this.parts});
  final int partSize;
  final int parts;
  final received = <int, List<int>>{};
  final urlRequests = <List<int>>[];
  CompleteUploadRequest? completed;

  String _url(int n) => 'https://s3.test/b/k?partNumber=$n&uploadId=u';

  @override
  Future<CreateUploadResponse> createUpload(CreateUploadRequest req) async => CreateUploadResponse(
        uploadId: 'tok',
        mediaId: Int64(1),
        partSizeBytes: partSize,
        partCount: parts,
        urls: [for (var n = 1; n <= 2; n++) UploadPartUrl(partNumber: n, url: _url(n))],
      );

  @override
  Future<GetUploadPartUrlsResponse> uploadPartUrls(String uploadId, List<int> parts) async {
    urlRequests.add(parts);
    return GetUploadPartUrlsResponse(urls: [for (final n in parts) UploadPartUrl(partNumber: n, url: _url(n))]);
  }

  @override
  Future<Media> completeUpload(CompleteUploadRequest req) async {
    completed = req;
    return Media(id: Int64(1), status: MediaStatus.MEDIA_STATUS_READY);
  }
}
