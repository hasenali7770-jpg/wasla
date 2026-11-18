import 'package:fixnum/fixnum.dart';
import 'package:wasla/core/chat/chat_api.dart';
import 'package:wasla/core/net/rpc_exception.dart';
import 'package:wasla/gen/proto/wasla/v1/chats.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/common.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/contacts.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/frame.pbenum.dart';
import 'package:wasla/gen/proto/wasla/v1/media.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/messages.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/moderation.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/updates.pb.dart';
import 'package:wasla/gen/proto/wasla/v1/users.pb.dart';

/// In-memory ChatsService/MessagesService for widget tests.
class FakeChatApi implements ChatApi {
  ListDialogsResponse dialogs = ListDialogsResponse();
  final history = <Int64, List<Message>>{};
  final sent = <SendMessageRequest>[];
  final reports = <ReportRequest>[];
  final blocked = <Int64>[];
  final differenceCalls = <Int64>[];
  GetDifferenceResponse Function(Int64 pts)? difference;
  int _seq = 100;

  /// Uploaded media by id (filled by FakeMediaTransfer).
  final media = <Int64, Media>{};
  final downloads = <GetDownloadUrlRequest>[];
  Int64? profilePhoto;
  int listCalls = 0;

  /// Simulates no network: list, difference and send fail.
  bool offline = false;

  void _net() {
    if (offline) throw RpcException.network();
  }

  @override
  Future<ListDialogsResponse> listDialogs({Int64? offsetDate, Int64? offsetChatId}) async {
    _net();
    listCalls++;
    return dialogs;
  }

  @override
  Future<GetDifferenceResponse> getDifference(Int64 pts) async {
    _net();
    differenceCalls.add(pts);
    return difference?.call(pts) ?? GetDifferenceResponse(pts: pts);
  }

  @override
  Future<GetHistoryResponse> getHistory(Int64 chatId, {Int64? beforeSeq, int limit = 50}) async {
    _net();
    return GetHistoryResponse(messages: (history[chatId] ?? []).reversed, users: dialogs.users);
  }

  @override
  Future<SendMessageResponse> send(SendMessageRequest req) async {
    _net();
    sent.add(req);
    final chatId = dialogs.chats.isEmpty ? Int64(1) : dialogs.chats.first.id;
    final m = Message(
      chatId: chatId,
      seq: Int64(++_seq),
      senderId: Int64(1),
      randomId: req.randomId,
      date: Int64(DateTime.now().millisecondsSinceEpoch ~/ 1000),
      content: req.content.hasMedia()
          ? _mediaContent(req.content.media)
          : MessageContent(text: TextContent(text: req.content.text)),
      replyToSeq: req.replyToSeq,
    );
    return SendMessageResponse(message: m, pts: Int64(_seq), ptsCount: 1);
  }

  MessageContent _mediaContent(InputMedia in_) {
    final m = media[in_.mediaId];
    if (m == null) throw const RpcException(ErrorCode.ERROR_CODE_NOT_FOUND);
    return m.kind == MediaKind.MEDIA_KIND_PHOTO
        ? MessageContent(photo: PhotoContent(media: m, caption: in_.caption))
        : MessageContent(document: DocumentContent(media: m, caption: in_.caption));
  }

  @override
  Future<CreateUploadResponse> createUpload(CreateUploadRequest req) async => throw UnimplementedError();
  @override
  Future<GetUploadPartUrlsResponse> uploadPartUrls(String uploadId, List<int> parts) async => throw UnimplementedError();
  @override
  Future<Media> completeUpload(CompleteUploadRequest req) async => throw UnimplementedError();
  @override
  Future<String> downloadUrl(GetDownloadUrlRequest req) async {
    downloads.add(req);
    return 'https://media.test/${req.mediaId}';
  }

  @override
  Future<User> setProfilePhoto(Int64 mediaId) async {
    profilePhoto = mediaId;
    return User(id: Int64(1), firstName: 'Me', photo: Avatar(mediaId: mediaId));
  }

  @override
  Future<Int64> report(ReportRequest req) async {
    reports.add(req);
    return Int64(reports.length);
  }

  @override
  Future<void> block(Int64 userId) async => blocked.add(userId);
  @override
  Future<void> unblock(Int64 userId) async => blocked.remove(userId);
  @override
  Future<void> readHistory(Int64 chatId, Int64 maxSeq) async {}
  @override
  Future<void> setTyping(Int64 chatId) async {}
  @override
  Future<GetPrivateChatResponse> getPrivateChat(Int64 userId) async =>
      GetPrivateChatResponse(chat: Chat(id: Int64(99), type: ChatType.CHAT_TYPE_PRIVATE, peerUserId: userId), user: User(id: userId));
  @override
  Future<UpdateDialogResponse> updateDialog(UpdateDialogRequest req) async =>
      UpdateDialogResponse(dialog: Dialog(chatId: req.chatId, pinnedRank: req.pinned ? 1000 : 0));
  @override
  Future<EditMessageResponse> edit(Int64 chatId, Int64 seq, String text) async => EditMessageResponse();
  @override
  Future<DeleteMessagesResponse> delete(Int64 chatId, List<Int64> seqs, {required bool forEveryone}) async =>
      DeleteMessagesResponse();
  @override
  Future<ForwardMessagesResponse> forward(ForwardMessagesRequest req) async => ForwardMessagesResponse();
  @override
  Future<void> pin(Int64 chatId, Int64 seq, {required bool unpin}) async {}
  @override
  Future<List<User>> getUsers(List<Int64> ids) async => [for (final id in ids) User(id: id, firstName: 'User $id')];
  @override
  Future<SearchUsersResponse> searchUsers(String query) async => SearchUsersResponse();
  @override
  Future<User?> resolveUsername(String username) async => null;
  @override
  Future<ImportContactsResponse> importContacts(List<InputContact> contacts) async => ImportContactsResponse();
}
