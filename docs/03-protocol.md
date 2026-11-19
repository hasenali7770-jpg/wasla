# Wasla — Client/Server Protocol

Source of truth: [`proto/wasla/v1/`](../proto/wasla/v1). It passes `buf lint` with the STANDARD rules, and CI checks for breaking changes on every pull request.

## 1. Transports

| Transport | Used for | Details |
|---|---|---|
| **WebSocket** `wss://edge.wasla.app/ws` | Everything interactive | Binary messages, one `wasla.v1.Frame` each, `permessage-deflate` compression |
| **Connect over HTTP** `POST https://edge.wasla.app/wasla.v1.<Service>/<Method>` | Fallback where WebSockets are blocked or unstable (some captive portals and proxies); later also the Bot API base | Same protobuf messages. Updates are fetched by long-polling `UpdatesService/GetDifference`. The session token goes in `Authorization: Bearer …`. |
| **HTTPS to object storage / CDN** | File bytes only | Presigned PUT URLs for upload parts, signed GET URLs for downloads |

We use TLS 1.3 instead of an MTProto-style custom crypto layer. It is standard, well audited, and costs nothing extra on the wire.

## 2. Connection lifecycle

```
client                                server
  │── Hello{protocol_version=1, session_token?, platform, app_version, lang} ─►│
  │◄─ HelloAck{server_time, authenticated, user_id, min_app_version} ──────────│
  │                                                                            │
  │── RpcRequest{id, method, payload} ────────────────────────────────────────►│
  │◄─ RpcResponse{id, payload | error} ────────────────────────────────────────│
  │◄─ UpdatesPush{updates[], users[], chats[]} (any time) ─────────────────────│
  │── Ping{nonce} (idle 25 s) ──► ◄── Pong{nonce}                               │
```

- If `app_version < min_app_version`, the client shows a forced-update screen.
- On an unauthenticated connection only `AuthService` methods work. A successful `SignIn`, `SignUp` or `CheckPassword` authenticates **the same connection**; no reconnect is needed.
- The server may close the socket with close code `4001` (session revoked; the client wipes local data) or `4002` (protocol too old).

## 3. RPC

- `RpcRequest.method` is the gRPC-style full name, e.g. `/wasla.v1.MessagesService/SendMessage`. The same name is the Connect HTTP path, so both transports share one router.
- `id` is chosen by the client and unique per connection. Several requests can be in flight at once, and responses may come back in any order.
- The client times out a request after 15 s. A send is then retried **with the same `random_id`**, so it is safe.
- Errors: `Error.code` is a `wasla.v1.ErrorCode`. Clients translate the code into Arabic or English; the `message` field is for developers only. `RATE_LIMITED` comes with `retry_after_seconds`.

## 4. Identifiers and encoding

- IDs are int64 Snowflakes. A message is identified by `(chat_id, seq)`.
- Times are Unix seconds.
- Text entity offsets and lengths are in **UTF-16 code units**, which matches Dart and JS strings. The server validates them against the UTF-16 length of the text.
- Limits: message text up to 4096 characters, captions up to 1024, up to 100 IDs per batch call.

## 5. Updates and the gap rule

Every persistent update carries `pts` and `pts_count` (normally 1). The client keeps `local_pts` in its database and handles each incoming update, or a pts returned by a mutating RPC, like this:

| Condition | Action |
|---|---|
| `local_pts + pts_count == pts` | Apply the update and set `local_pts = pts`, in one local DB transaction |
| `local_pts + pts_count > pts` | Already applied (a duplicate); ignore it |
| `local_pts + pts_count < pts` | **Gap.** Buffer the update and wait 500 ms, since out-of-order delivery usually fills it. If the gap is still there, call `GetDifference(local_pts)`. |

- Updates with `pts == 0` (typing, status) are applied directly and never stored.
- `GetDifference` returns up to 500 updates and `has_more`; the client loops until it is false. `too_long` means: reload the chat list with `ListDialogs` and take the new `pts` from that response.
- `GetDifference` is always called after a reconnect. The live push is a latency optimisation; the log is what guarantees nothing is missed.

## 6. Idempotency and the offline outbox

| Operation | Key |
|---|---|
| SendMessage | `random_id` (random int64 per message), unique per `(chat_id, sender_id)` |
| ForwardMessages | `random_ids[]`, one per forwarded message |
| CreateGroup | `random_id` |
| Edit, Delete, Read, Pin | Naturally idempotent (setting a state) |

Outbox states are `pending → sending → sent | failed(permanent)`. Network errors retry with backoff (1, 2, 4, 8 s, capped at 60 s) for up to 24 h. Errors such as `PEER_BLOCKED` or `MESSAGE_TOO_LONG` are permanent: the client shows ⚠ and offers a retry or delete.

## 7. Media transfer

1. Compress on the device (defaults below). Then call `CreateUpload`. Files up to 5 MiB are one part. Larger files are split into parts of at least 5 MiB (the S3 minimum), at most 10,000 parts. The response carries `part_size_bytes`, `part_count` and the first presigned part URLs; `GetUploadPartUrls` returns the rest (up to 100 per call).
2. Upload parts with `PUT` straight to storage, 3 in parallel; the server never handles the bytes. Each part is retried 5 times with backoff.
3. To resume after a restart, call `GetUploadPartUrls`. It returns the parts already stored plus fresh URLs for the missing ones. *App status (Sprint 3):* the app keeps the prepared file and restarts an interrupted upload from the first part; part-level resume in the app is planned with video.
4. Call `CompleteUpload`, then `SendMessage` with the `media_id`. On `CompleteUpload` the server checks the file's SHA-256 against the moderation blocklist (files up to 20 MB before answering, larger ones in the background) and makes photo thumbnails `thumb_s` (90 px) and `thumb_m` (320 px). Videos can be sent while the server is still transcoding (status `PROCESSING`); recipients see the thumbhash placeholder until a rendition is ready.
5. Downloads: `GetDownloadUrl` with the context the file is seen in (a message, a user's profile photo, or a chat photo); the server checks access there. `variant` is `thumb_s`, `thumb_m` or empty for the original. URLs live 1 hour. Some S3 services (SeaweedFS on staging) ignore the requested download file name, so the app always names saved files from `Media.file_name`.

Default compression:

| Type | Default |
|---|---|
| Photo | Long side 1280 px, JPEG quality 80 (WebP later). Re-encoding also removes EXIF data such as GPS location. |
| Video | 720p H.264, about 1.5 Mbps; "Send as file" sends the original |
| Voice | Opus at 32 kbps in an OGG container |

## 7a. Push notifications

- After sign-in the app calls `AuthService.RegisterPushToken` (provider FCM) with its Firebase token, and again whenever Firebase issues a new one. A token belongs to one session; logging in elsewhere with the same phone moves it.
- **When:** the server pushes only when a new message from someone else reached **no connected device** of the user (`PUBLISH` to the user's Redis channel was received by 0 gateways), and the chat is not muted. While a device is connected, updates arrive over the WebSocket instead.
- **App in the background:** the app disconnects 15 s after going to the background and reconnects (then catches up with `GetDifference`) when it returns. Without that, a hidden app would keep its connection and get no notifications.
- **Content:** the push carries only `{type: "new_message", chat_id}`. The visible text comes from the app's own resources (`push_title`, `push_new_message`, in the phone's language), so message text and sender names never pass through Google. Pushes for the same chat replace each other (`tag = chat_<id>`).
- Tokens that FCM reports as unregistered are removed. Servers without `WASLA_FCM_CREDENTIALS_FILE` don't send pushes (dev servers log them).

## 8. Versioning rules

- Package `wasla.v1`. Adding fields, messages, enum values and RPCs is backward compatible. **Never** renumber or reuse a field; mark removed fields `reserved`.
- Old clients must ignore unknown oneof cases in `Update` and `MessageContent`, rendering "This message is not supported, please update". This is enforced by a client unit test.
- A `wasla.v2` package is created only for an incompatible redesign. The server would then serve both versions for at least 6 months.
- `Hello.protocol_version` covers framing changes only.

## 9. Service summary

| Service | Methods |
|---|---|
| `AuthService` | SendCode, ResendCode, SignIn, SignUp, CheckPassword, LogOut, ListSessions, RevokeSession, RevokeOtherSessions, RegisterPushToken, SetPassword, DeleteAccount |
| `UsersService` | GetMe, GetUsers, UpdateProfile, SetProfilePhoto, DeleteProfilePhoto, CheckUsername, SetUsername, ResolveUsername, SearchUsers, GetPrivacy, SetPrivacy, BlockUser, UnblockUser, ListBlocked |
| `ContactsService` | ImportContacts, ListContacts, DeleteContacts |
| `ChatsService` | ListDialogs, UpdateDialog, ReorderPinnedDialogs, ClearHistory, GetChats, GetPrivateChat, CreateGroup, UpdateChatInfo, SetDefaultPermissions, ListMembers, AddMembers, RemoveMember, SetMemberRole, LeaveChat, CreateInviteLink, RevokeInviteLink, CheckInviteLink, JoinByInviteLink |
| `MessagesService` | SendMessage, EditMessage, DeleteMessages, ForwardMessages, GetHistory, GetMessages, ReadHistory, SetTyping, PinMessage |
| `MediaService` | CreateUpload, GetUploadPartUrls, CompleteUpload, AbortUpload, GetDownloadUrl |
| `UpdatesService` | GetState, GetDifference |
| `ModerationService` | Report |
