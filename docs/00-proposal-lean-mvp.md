# Wasla — Lean MVP, Reduced Roadmap, Matrix vs. Own Backend

Status: **Draft for sign-off** · Date: 2026-11-18 · Team model: regional (Iraq / Jordan / Egypt)

---

## 0. Regulatory flag (read first)

**What we know (as of 18 Nov 2026):**

- **The CMC blocked Telegram in Iraq on 16 Nov 2026.** It said the company failed to deal with content that breaks Iraqi law, and gave Telegram 30 days to settle its legal status ([Proton VPN](https://protonvpn.com/blog/iraq-telegram-ban-2026)). The stated reason was content handling, not where data is hosted.
- **The CMC's 2025 *Framework Regulations for Digital Platforms and Services*** ask platforms to follow Iraqi data-protection law, *including data localization*. They also say all platforms must comply with CMC regulations whatever their licensing route ([CMC PDF](https://cmc.iq/ar/wp-content/uploads/2025/03/Framework-regulations-for-digital-platforms-and-services-en.pdf)). From the excerpts we could see, it is **not clear** whether messaging apps must host *in* Iraq or only meet specific conditions.
- Freedom House reported in 2021 that Iraq had **no** data-localization rule ([Freedom House](https://freedomhouse.org/country/iraq/freedom-net/2021)). That predates the 2025 framework and should be treated as out of date.
- We could not read the full framework from this environment (cmc.iq is not reachable from the build sandbox). **Someone needs to read it in full.**

**What it means for Wasla:**

1. **Get Iraqi telecom/media counsel before launch, not after.** The CMC clearly enforces against messaging platforms, and a new app aimed at Iraqi users that works like Telegram will draw attention, especially right now. Budget roughly $3–8k for local legal work. This is not included in the engineering numbers below.
2. **Plan to host in Bahrain or the UAE, but keep the stack portable.** That means Postgres, Redis, S3-compatible storage and containers, with no cloud-specific services in the core. If counsel says data must stay in Iraq, we can move to an Iraqi data centre. The extra engineering cost is close to zero if we stay disciplined from day one.
3. **Treat moderation as a launch feature, not a later add-on.** This is already in the Lean MVP: report → queue → takedown/ban, with an audit trail (`reports`, `moderation_actions`), Arabic-speaking moderators, and a documented process for legal requests.
4. **Be explicit about encryption.** Normal (cloud) chats can be read by the server, as on Telegram, so a court order can be answered. Secret Chats (Phase 4) cannot. That legal position has to be settled before Phase 4.
5. **Expect a demand spike.** People leaving Telegram are an opportunity, but they can also overwhelm a 20k-user launch. Plan a waitlist or invite gate, and make sure the sign-up flow has strict SMS-fraud limits.

---

## 1. Lean MVP (Android only)

**Goal:** a reliable Android messenger for private chats and small groups. It is built on the same protocol and data model as the full product, so nothing gets thrown away later.

### 1.1 Scope

| In scope | Out of scope (later stages) |
|---|---|
| Phone + SMS OTP sign-up and login, with voice-call fallback and code delivery in-app to other logged-in devices | iOS, Web, Desktop |
| Two-step password, active sessions list, remote logout | Voice/video calls |
| Profile: name, bio, photo(s), @username, last seen | Channels, groups over 200 members, topics |
| Private chats, Saved Messages, **groups of up to 200 members** with owner/admin roles and invite links | Reactions, polls, scheduled messages, chat folders |
| Text with formatting, emoji, photos, videos (compressed), files (**500 MB cap** in the MVP; the protocol supports 2 GB), voice messages, location (static pin), contact cards | Stickers, GIFs, custom emoji, stories |
| Reply, forward, edit (within 48 h), delete for me / for everyone, pin, copy, multi-select | Secret Chats, auto-delete timers |
| Sent ✓ / read ✓✓, typing indicator, online / last seen | Bots, Mini Apps |
| Phone-book contact sync; search for users by @username and by contact name; **local** full-text search of messages on the device | Server-side message search, multiple accounts |
| FCM push notifications, per-chat mute | Chat wallpapers (only light and dark themes) |
| Chat list with archive, pinned chats and swipe actions; light/dark theme; **Arabic (RTL, default) + English** | |
| **Report and block**, a minimal moderation panel, **in-app account deletion** (required by Google Play), privacy settings (phone, last seen, photo, group invites, forwards) | |

### 1.2 Simplifications that keep it under $100k

| Full plan | Lean MVP | Upgrade path |
|---|---|---|
| Microservices on Kubernetes | **One Go binary (modular monolith)** on 2 VMs with Docker Compose | Same binary runs as separate gateway/api/worker roles on Kubernetes |
| ScyllaDB for messages | **Postgres**, hash-partitioned, behind a `MessageStore` interface | Move `messages` and `user_updates` to Scylla, keeping the same primary keys |
| NATS JetStream | **Redis pub/sub** for routing to sockets | Durability already comes from the pts log, so a lost pub/sub message is recovered by `GetDifference` |
| OpenSearch | Postgres prefix search for usernames; SQLite FTS5 on the device for messages | OpenSearch with an Arabic analyzer in Stage 2 |
| Self-hosted MinIO + CDN | **Managed S3-compatible storage** (AWS S3 in me-south-1 + CloudFront, or Cloudflare R2, which has no egress fees) | Any S3 API works; the choice depends on the CMC answer |

### 1.3 Team and budget

Rates are fully loaded monthly contractor rates in the region.

| Role | FTE | Months | Rate/month | Cost |
|---|---|---|---|---|
| Tech lead: senior Go engineer who also covers DevOps | 1.0 | 3.5 | $6,000 | $21,000 |
| Go backend engineer | 1.0 | 3.0 | $4,000 | $12,000 |
| Senior Flutter engineer | 1.0 | 3.5 | $5,000 | $17,500 |
| Flutter engineer | 1.0 | 3.0 | $3,500 | $10,500 |
| UI/UX designer with Arabic RTL experience | 0.5 | 3.0 | $3,500 | $5,250 |
| QA engineer (manual + automation) | 0.5 | 2.5 | $3,000 | $3,750 |
| **Labour subtotal** | | | | **$70,000** |
| Infrastructure during the build: dev, staging, and the first month of production | | | | $2,500 |
| SMS/voice OTP for testing and the closed beta | | | | $2,000 |
| External security review (1-week penetration test) | | | | $5,000 |
| Tools and accounts: Play Console, Sentry, Codemagic, Figma, domain | | | | $1,500 |
| Contingency (about 12%) | | | | $9,800 |
| **Total** | | | | **≈ $91,000** |

The product owner role is you. The tech lead also does sprint planning.

### 1.4 Timeline (15 weeks, plus 1 buffer week)

| Weeks | Deliverable |
|---|---|
| 1–2 | Phase 0 sign-off; Figma design system and key screens in RTL; infrastructure and CI set up |
| 3–5 | Gateway and protocol; auth (OTP, 2FA, sessions); profile; sync engine (pts) on server and client; local database |
| 6–8 | Private chats with full messaging features; Saved Messages; offline outbox with retry |
| 9–10 | Media: photo, video, file, voice; compression; resumable uploads; location and contact sharing |
| 11–12 | Groups and invite links; contact sync; search; push and mute; archive, pinned chats, swipe actions, themes |
| 13 | Report/block, moderation panel, account deletion, privacy settings |
| 14 | Hardening: k6 load test at 20k simulated users, security review, crash fixes |
| 15 | Closed beta on Google Play; store listing |
| 16 | Buffer |

> **Google Play note:** new *personal* developer accounts must run a closed test with at least 12 testers for 14 days before going public. Register an **organization** account to avoid this; it needs a D-U-N-S number, which takes 1–3 weeks, so start now.

### 1.5 Running costs after launch

| Item | ~20k users | ~200k users |
|---|---|---|
| Compute: app VMs or Kubernetes nodes | $250 | $1,500–2,500 |
| Managed Postgres (multi-AZ) + Redis | $400 | $1,500–3,000 |
| Media storage + CDN egress | $100 (R2) – $900 (CloudFront) | $800 – $5,000 |
| Monitoring, Sentry, backups | $100 | $300 |
| **Infrastructure / month** | **≈ $0.8–1.6k** | **≈ $4–10k** |
| SMS OTP (≈ $0.05–0.25 per message to Iraqi numbers) | ≈ $2–4k at launch, then usage-based | grows with sign-ups and logins |

---

## 2. Reduced roadmap (if the budget is limited after the MVP)

Each stage ships on its own and pays for the next. The team grows from 5 to about 6–7 people.

| Stage | Scope | Duration | Cost (regional) |
|---|---|---|---|
| **1. Lean MVP** | Section 1 above | 3.5–4 months | ≈ $91k |
| **2. Launch+** | iOS build (Flutter, TestFlight/App Store), web app, **channels and large groups** (fan-out on read), mentions, reactions, polls, chat folders, server-side search | 4 months | ≈ $110–130k |
| **3. Calls** | 1:1 voice/video (P2P WebRTC + coturn, end-to-end encrypted), group voice chats (LiveKit) | 3 months | ≈ $85–100k |
| **4. Privacy+** | Secret Chats (vodozemac), auto-delete timers, full privacy controls, account self-destruct, **external crypto audit** | 3 months | ≈ $70–85k + audit $25–40k |
| **5. Bots** | Bot API (HTTP + webhooks, inline keyboards, commands), bot creator | 2.5 months | ≈ $55–70k |
| **Total** | | **≈ 16 months** | **≈ $440–520k** |

**Deferred indefinitely** (add only when there is traction): stories, live streams, round video messages, the in-app video editor, user-uploaded sticker packs and custom emoji, forum topics, multiple accounts, native desktop apps (the web app covers desktop), Mini Apps, and the public developer portal.

---

## 3. Own backend vs. building on Matrix

### 3.1 License implications

| Component | License | What it means for closed-source Wasla |
|---|---|---|
| **Synapse** (main Matrix server) | **AGPL-3.0**, or a paid commercial license from Element ([Element](https://element.io/blog/element-to-adopt-agplv3/), [GitHub](https://github.com/element-hq/synapse)) | Running it unmodified is fine. If you **modify** it (phone login, Telegram-style features), you must publish the modified server source to your users. Synapse plugins that run inside the server are very likely covered too. The alternative is to buy Element's commercial license. |
| Dendrite | AGPL-3.0, maintenance mode | Same obligations as Synapse, and it is not actively developed. |
| conduwuit / continuwuity (Rust) | Apache-2.0 | Permissive license, but a small community project; risky to bet a company on it. |
| **matrix-rust-sdk** (client) | **Apache-2.0** ([Element](https://element.io/blog/sustainable-licensing-at-element-with-agpl)) | ✅ Works with a closed-source app. It needs a Rust↔Dart bridge (flutter_rust_bridge), the same approach Element X uses for Kotlin and Swift. |
| **matrix-dart-sdk** (Famedly) | **AGPL-3.0** per the Matrix.org SDK catalog ([mirror](https://git.sudo.is/matrix/matrix.org/src/branch/main/content/ecosystem/sdks/sdks.toml)); confirm against the repository's LICENSE | ❌ Would force you to publish the Flutter app's source. Ruled out given your closed-source requirement. |
| vodozemac (Olm/Megolm crypto) | Apache-2.0 | ✅ Usable in either approach. We plan to use it for Secret Chats. |

### 3.2 Fit with the product

| | Own backend (recommended) | Matrix |
|---|---|---|
| Phone + SMS login | Built in | Not native. Needs a custom auth module, which is AGPL if it is a Synapse module. |
| Cloud chats synced to every device, server-side search | This is the core design | Possible with unencrypted rooms, but Matrix is built around E2EE by default and federation. |
| Groups of 200k members, channels with unlimited subscribers | Fan-out-on-read model planned from day one | Very large rooms are a known weak spot (state resolution and room-state size). There is no native channel model with view counters or signed posts. |
| Delete for everyone, edits, read receipts, typing | Built in | Built in (redactions, `m.replace`, receipts) |
| Bot API like Telegram's | Our own simple HTTP API | Application Service API: powerful, but nothing like the BotFather model |
| Operations at 200k users | One Go binary + Postgres | Synapse (Python) needs a worker split and careful tuning; more servers per user |
| Federation | Not needed | Must be disabled and kept disabled; it adds complexity you will not use |
| Speed to a Lean MVP | ≈ 15 weeks | ≈ 10–12 weeks (client still custom, on matrix-rust-sdk) |
| Lean MVP cost | ≈ $91k | ≈ $70–80k |
| Cost from Stage 2 onward | Linear: features fit the model | Rising: channels, huge groups and the bot model fight Matrix's design. A rewrite within 12–18 months is likely. |

### 3.3 Recommendation

**Build our own backend.** Wasla is a cloud-first, phone-number-based messenger with very large channels and a Telegram-style bot platform. Matrix's strengths (federation, E2EE everywhere, open standard) are not what you need, and its weak spots (huge rooms, phone login, channels) are exactly what you do need. Matrix saves roughly 4–5 weeks on the MVP and then costs much more from Stage 2 on, plus either AGPL obligations or an Element license.

**When Matrix would be the right choice:** you need something live in 8–10 weeks to catch users leaving Telegram, and you accept a likely rewrite later. In that case use Synapse unmodified (or an Element commercial license), matrix-rust-sdk with flutter_rust_bridge, and no Synapse modules. Do phone login in a separate service that issues Matrix login tokens.

---

## 4. Decisions needed from you

1. Approve the **Lean MVP scope and budget (≈ $91k, about 15 weeks)**.
2. Confirm **own backend** (recommended) or **Matrix**.
3. Engage **Iraqi counsel** on the CMC framework, then confirm the hosting region.
4. Register the **Google Play organization account** (D-U-N-S) and buy the domain.
5. Provide a **private Git repository** (GitHub or GitLab) so this Phase 0 work can be pushed.
