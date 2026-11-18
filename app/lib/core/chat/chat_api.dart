import 'package:fixnum/fixnum.dart';

import '../../gen/proto/wasla/v1/chats.pb.dart';
import '../../gen/proto/wasla/v1/common.pb.dart';
import '../../gen/proto/wasla/v1/contacts.pb.dart';
import '../../gen/proto/wasla/v1/messages.pb.dart';
import '../../gen/proto/wasla/v1/moderation.pb.dart';
import '../../gen/proto/wasla/v1/updates.pb.dart';
import '../../gen/proto/wasla/v1/users.pb.dart';
import '../net/connection.dart';

/// Everything the chat screens need from the server. Faked in widget tests.
abstract interface class ChatApi {
  Future<ListDialogsResponse> listDialogs({Int64? offsetDate, Int64? offsetChatId});
  Future<GetDifferenceResponse> getDifference(Int64 pts);
  Future<GetPrivateChatResponse> getPrivateChat(Int64 userId);
  Future<UpdateDialogResponse> updateDialog(UpdateDialogRequest req);
  Future<GetHistoryResponse> getHistory(Int64 chatId, {Int64? beforeSeq, int limit = 50});
  Future<SendMessageResponse> send(SendMessageRequest req);
  Future<EditMessageResponse> edit(Int64 chatId, Int64 seq, String text);
  Future<DeleteMessagesResponse> delete(Int64 chatId, List<Int64> seqs, {required bool forEveryone});
  Future<ForwardMessagesResponse> forward(ForwardMessagesRequest req);
  Future<void> readHistory(Int64 chatId, Int64 maxSeq);
  Future<void> setTyping(Int64 chatId);
  Future<void> pin(Int64 chatId, Int64 seq, {required bool unpin});
  Future<List<User>> getUsers(List<Int64> ids);
  Future<SearchUsersResponse> searchUsers(String query);
  Future<User?> resolveUsername(String username);
  Future<ImportContactsResponse> importContacts(List<InputContact> contacts);
  Future<void> block(Int64 userId);
  Future<void> unblock(Int64 userId);
  Future<Int64> report(ReportRequest req);
}

class RemoteChatApi implements ChatApi {
  RemoteChatApi(this.conn);
  final WaslaConnection conn;
  static const _m = '/wasla.v1.MessagesService/';
  static const _c = '/wasla.v1.ChatsService/';
  static const _u = '/wasla.v1.UsersService/';

  @override
  Future<ListDialogsResponse> listDialogs({Int64? offsetDate, Int64? offsetChatId}) => conn.call(
        '${_c}ListDialogs',
        ListDialogsRequest(limit: 100, offsetDate: offsetDate, offsetChatId: offsetChatId),
        ListDialogsResponse.fromBuffer,
      );

  @override
  Future<GetDifferenceResponse> getDifference(Int64 pts) => conn.call(
        '/wasla.v1.UpdatesService/GetDifference',
        GetDifferenceRequest(pts: pts, limit: 500),
        GetDifferenceResponse.fromBuffer,
      );

  @override
  Future<GetPrivateChatResponse> getPrivateChat(Int64 userId) =>
      conn.call('${_c}GetPrivateChat', GetPrivateChatRequest(userId: userId), GetPrivateChatResponse.fromBuffer);

  @override
  Future<UpdateDialogResponse> updateDialog(UpdateDialogRequest req) =>
      conn.call('${_c}UpdateDialog', req, UpdateDialogResponse.fromBuffer);

  @override
  Future<GetHistoryResponse> getHistory(Int64 chatId, {Int64? beforeSeq, int limit = 50}) => conn.call(
        '${_m}GetHistory',
        GetHistoryRequest(
          chatId: chatId,
          offsetSeq: beforeSeq ?? Int64.ZERO,
          direction: HistoryDirection.HISTORY_DIRECTION_OLDER,
          limit: limit,
        ),
        GetHistoryResponse.fromBuffer,
      );

  @override
  Future<SendMessageResponse> send(SendMessageRequest req) => conn.call('${_m}SendMessage', req, SendMessageResponse.fromBuffer);

  @override
  Future<EditMessageResponse> edit(Int64 chatId, Int64 seq, String text) => conn.call(
        '${_m}EditMessage',
        EditMessageRequest(chatId: chatId, seq: seq, text: FormattedText(text: text)),
        EditMessageResponse.fromBuffer,
      );

  @override
  Future<DeleteMessagesResponse> delete(Int64 chatId, List<Int64> seqs, {required bool forEveryone}) => conn.call(
        '${_m}DeleteMessages',
        DeleteMessagesRequest(chatId: chatId, seqs: seqs, forEveryone: forEveryone),
        DeleteMessagesResponse.fromBuffer,
      );

  @override
  Future<ForwardMessagesResponse> forward(ForwardMessagesRequest req) =>
      conn.call('${_m}ForwardMessages', req, ForwardMessagesResponse.fromBuffer);

  @override
  Future<void> readHistory(Int64 chatId, Int64 maxSeq) =>
      conn.call('${_m}ReadHistory', ReadHistoryRequest(chatId: chatId, maxSeq: maxSeq), ReadHistoryResponse.fromBuffer);

  @override
  Future<void> setTyping(Int64 chatId) => conn.call(
        '${_m}SetTyping',
        SetTypingRequest(chatId: chatId, action: TypingAction.TYPING_ACTION_TYPING),
        SetTypingResponse.fromBuffer,
      );

  @override
  Future<void> pin(Int64 chatId, Int64 seq, {required bool unpin}) => conn.call(
        '${_m}PinMessage',
        PinMessageRequest(chatId: chatId, seq: seq, unpin: unpin),
        PinMessageResponse.fromBuffer,
      );

  @override
  Future<List<User>> getUsers(List<Int64> ids) async =>
      (await conn.call('${_u}GetUsers', GetUsersRequest(userIds: ids), GetUsersResponse.fromBuffer)).users;

  @override
  Future<SearchUsersResponse> searchUsers(String query) =>
      conn.call('${_u}SearchUsers', SearchUsersRequest(query: query, limit: 20), SearchUsersResponse.fromBuffer);

  @override
  Future<User?> resolveUsername(String username) async {
    final r = await conn.call('${_u}ResolveUsername', ResolveUsernameRequest(username: username), ResolveUsernameResponse.fromBuffer);
    return r.hasUser() ? r.user : null;
  }

  @override
  Future<ImportContactsResponse> importContacts(List<InputContact> contacts) => conn.call(
        '/wasla.v1.ContactsService/ImportContacts',
        ImportContactsRequest(contacts: contacts),
        ImportContactsResponse.fromBuffer,
      );

  @override
  Future<void> block(Int64 userId) => conn.call('${_u}BlockUser', BlockUserRequest(userId: userId), BlockUserResponse.fromBuffer);

  @override
  Future<void> unblock(Int64 userId) =>
      conn.call('${_u}UnblockUser', UnblockUserRequest(userId: userId), UnblockUserResponse.fromBuffer);

  @override
  Future<Int64> report(ReportRequest req) async =>
      (await conn.call('/wasla.v1.ModerationService/Report', req, ReportResponse.fromBuffer)).reportId;
}

/// Shorthand for a peer that is a user.
Peer userPeer(Int64 id) => Peer(userId: id);
