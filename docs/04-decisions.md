# Wasla — Architecture Decision Records

Each entry gives the decision, the reason, and the alternative that was rejected. A new ADR replaces an old one; existing entries are not edited.

---

### ADR-001 — Flutter for every client
**Decision:** a single Flutter codebase. Android first; then iOS, web and desktop.
**Why:** one team, one design system, RTL handled in one place, and a permissive license (BSD).
**Rejected:** forking Telegram's clients. They are GPL (incompatible with closed source), they speak MTProto against Telegram's server API with over 1,000 methods, and they are 4 separate codebases.

### ADR-002 — Go backend as a modular monolith
**Decision:** one Go binary with internal modules that talk through interfaces. `WASLA_ROLE` decides which modules a process runs.
**Why:** large hiring pool in the region; strong at concurrency and media/infrastructure work. A monolith is far cheaper to build and run at 20k–200k users, and the role split gives a clear path to separate services.
**Rejected:** Elixir (harder to hire for); microservices from day one (too much operational cost for a team of 5).

### ADR-003 — Custom protobuf protocol over WebSocket and TLS 1.3, with a Connect fallback
**Decision:** see [03-protocol.md](03-protocol.md).
**Why:** compact on 3G, generated code for both Go and Dart, standard audited transport security.
**Rejected:** MTProto-style custom crypto (risk with no benefit); JSON (larger, untyped); plain gRPC on mobile (HTTP/2 fragility on poor networks, and no browser support without a proxy).

### ADR-004 — Postgres first for messages, ScyllaDB when measurements say so
**Decision:** `messages` and `user_updates` live in hash-partitioned Postgres tables behind a `MessageStore` interface.
**Why:** about 1.5B messages per year at 200k users is well within reach of partitioned Postgres. It saves a database cluster and an extra engineer in the MVP. The primary keys already match the Scylla layout.
**Trigger to move:** `messages` above about 2 TB, or sustained write IOPS above 70%.

### ADR-005 — Per-user pts log; fan-out on write for small chats, on read for large ones
**Decision:** see [01-architecture.md §6](01-architecture.md).
**Why:** exact sync across devices with a simple rule for spotting gaps. Live pushes can be lost safely. Large channels stay affordable.

### ADR-006 — vodozemac for Secret Chats
**Decision:** use vodozemac (Rust, Apache-2.0) through flutter_rust_bridge, with Olm sessions per device pair.
**Why:** a permissive license that works with closed-source clients, and a maintained, audited implementation of X3DH-style key agreement plus the Double Ratchet.
**Rejected:** libsignal (AGPL-3.0 would force publishing the client source); writing our own implementation (unacceptable risk).

### ADR-007 — Own backend instead of Matrix
**Decision:** build our own backend. The full comparison is in [00-proposal-lean-mvp.md §3](00-proposal-lean-mvp.md).
**Why:** Telegram-style features (phone login, huge channels, Bot API) conflict with Matrix's model. Synapse is AGPL, and the Dart SDK is AGPL.

### ADR-008 — Managed S3-compatible storage in production
**Decision:** use the S3 API only. Production runs on managed storage (AWS S3 in me-south-1 with CloudFront, or Cloudflare R2); local development uses a pinned MinIO image.
**Why:** no storage cluster to operate; R2 removes egress fees. MinIO's community edition is in maintenance mode, has stopped publishing new images, and is AGPL.
**Revisit if:** the CMC requires hosting in Iraq. Then evaluate a self-hosted S3-compatible store (Garage, SeaweedFS or Ceph RGW).

### ADR-010 — On-device storage: plain SQLite with protobuf rows (replaces "Drift" in the architecture doc)
**Decision:** use `package:sqlite3` (bundles SQLite; MIT). Each table is keyed by id and holds the object's protobuf bytes. The chat store writes through on every change, restores at startup, then catches up with `GetDifference` from the stored pts.
**Why:** no code generator or ORM layer. The server's protobuf messages are already the data model, so schema changes need no client migrations. Drift can still be adopted if local queries grow complex (e.g. full-text search).
**Follow-ups:** encryption (done, ADR-011); local full-text search (FTS5) with the search sprint; SQLite on the web via WebAssembly with the web release.

### ADR-011 — On-device encryption: SQLite3MultipleCiphers
**Decision:** `package:sqlite3` bundles SQLite3MultipleCiphers (`hooks: user_defines: sqlite3: source: sqlite3mc` in `app/pubspec.yaml`) instead of plain SQLite. Its default cipher is ChaCha20-Poly1305. The 256-bit key is random, made on first start, and kept in the Android Keystore / iOS Keychain through `flutter_secure_storage`, never in the app's files. `openEncrypted` (`app/lib/core/storage/sqlite_store.dart`) encrypts an unencrypted database from an older version in place. A file the key can't open (key lost, damage) is deleted and started fresh: it is a cache, and the server holds the chats.
**Why not SQLCipher:** the package also offers a SQLCipher build. That build links OpenSSL on Android and may ship an older SQLite. SQLite3MultipleCiphers is MIT-licensed, needs no OpenSSL, and follows SQLite releases. It can also read SQLCipher-format files (`PRAGMA cipher`) if that is ever needed.
**Not covered yet:** downloaded photos and files (`wasla_media` cache) and files waiting to be sent (`wasla_outbox`) are plain files in the app's private storage. Android's per-app sandbox and device encryption protect them. Encrypting them too is a follow-up.

### ADR-009 — Client licence policy
**Decision:** client dependencies must be MIT, BSD, Apache-2.0, MPL-2.0 (file-level copyleft only) or OFL (fonts). GPL, LGPL (where static linking applies) and AGPL are blocked by a CI licence check, added in sprint 1.
