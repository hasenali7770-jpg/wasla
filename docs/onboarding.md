# Onboarding: senior Go engineer (code review + server ownership)

Welcome. Wasla (وصلة) is a cloud messenger for Iraq: Arabic first, phone-number login, Telegram-like features. Moderation has been treated as a launch blocker from day one, because the CMC blocked Telegram in Iraq in Nov 2026 for not removing illegal content.

**Your role (part-time):**

1. Review every pull request before the owner merges it. Most code is written by Claude, sprint by sprint.
2. Own the servers: staging now, production later.
3. Act as the technical decision-maker when the docs and reality disagree.

## 1. Read first (about 1 hour)

| Order | Doc | Why |
|---|---|---|
| 1 | [00-proposal-lean-mvp.md](00-proposal-lean-mvp.md) | Scope, budget, the CMC situation |
| 2 | [01-architecture.md](01-architecture.md) | Topology, modules, send/sync flows, scaling triggers |
| 3 | [03-protocol.md](03-protocol.md) | WebSocket framing, RPC, **pts gap rule**, idempotency |
| 4 | [02-data-model.md](02-data-model.md) | Schema conventions, key queries |
| 5 | [05-moderation.md](05-moderation.md) | Reports, takedowns, legal requests, admin panel |
| 6 | [04-decisions.md](04-decisions.md) | Why Go, Postgres first, own backend vs Matrix, vodozemac |

## 2. Run it locally (about 15 minutes)

Requirements: Go 1.24+, Docker, psql, buf. Flutter 3.47.9 is only needed for the app.

Start Postgres, Redis and MinIO:

```bash
make dev-up
```

Apply the migrations through the server's own runner:

```bash
cd backend && WASLA_ENV=dev WASLA_POSTGRES_URL=postgres://wasla:wasla-dev-only@localhost:5432/wasla go run ./cmd/wasla-server migrate
```

Start the server. With WASLA_ENV=dev, login codes are returned to the app and logged, never sent:

```bash
make run
```

Run all Go tests. They create and drop their own databases and need a Postgres role allowed to CREATE DATABASE:

```bash
make backend-test
```

Create a staff account for the admin panel (http://127.0.0.1:8081/admin/):

```bash
make staff EMAIL=you@example.com NAME="Your Name" ROLE=3
```

## 3. Codebase map (backend)

```
backend/cmd/wasla-server     one binary; subcommands: (serve), migrate, staff create
backend/internal/
  gateway/     WebSocket: Hello → auth → concurrent RPC; Redis pub/sub hub for pushes and kicks
  auth/        OTP (Redis), anti-fraud limits, sessions, 2FA (argon2id), account deletion
  users/       profiles, blocking (privacy engine is still minimal: phone hidden from others)
  updates/     per-user pts log: Append (in caller's tx) → Publish (after commit) → GetDifference
  moderation/  Report RPC, staff Actions (all audited), admin panel (html/template, embedded)
  msgstore/    messages table access + proto conversion (the ScyllaDB seam)
  messaging/   MessagesService: send/edit/delete/forward/history/read/typing/pin
  chats/       membership checks (taken-down chats look like NOT_FOUND), private chats, chat list
  contacts/    phone-book import with anti-scraping limits
  media/ push/ presence/   ← not built yet (stubs)
  platform/    config, db, errs, migrate, password, phone, ratelimit, rpc, snowflake, totp
  server/      wiring + the integration test suite (real Postgres, miniredis, real WebSocket)
proto/wasla/v1  the API contract (buf, STANDARD lint, breaking-change check on PRs)
db/postgres     migrations (NNNN_name.up/down.sql) + SQL smoke tests
deploy/staging  compose + Caddy + cloud-init for the staging VM
```

## 4. Conventions to enforce in review

- **Every RPC goes through `rpc.Register`.** `Router.Validate()` checks method names and types against the proto descriptors at startup and in tests.
- **Expected failures return `*errs.Error`** with a stable `ErrorCode`. Anything else becomes `INTERNAL` and is logged; clients localise errors by code.
- **State changes append to the pts log inside the same transaction** (`updates.Append`) and publish only after commit. Never publish before commit; never skip the log for persistent state.
- **Lock order:** pts rows are always locked in `user_id` order (Append sorts). Any new multi-user locking must follow the same rule.
- **Every moderation action** goes through `moderation.Actions` (one transaction plus an audit row) and requires a reason.
- **Enum columns** are `smallint` holding the proto enum or oneof number.
- **Hot tables** (`messages`, `user_updates`) have no foreign keys, so they can move to ScyllaDB later; integrity is enforced in code.
- **Generated code** (`backend/gen`, `app/lib/gen`) is committed; CI fails if it's stale. Regenerate with `make proto-gen`.
- **App:** directional layout only (`EdgeInsetsDirectional`, `AlignmentDirectional`…), enforced by `app/tool/check_rtl.sh`.
- **Licences:** permissive dependencies only (ADR-009). No GPL/AGPL in the app.
- **Pull requests:** one per sprint, CI green before merge, owner merges after your review.

## 5. Servers you own

### Staging (EU VM, test mode)

The owner sets this up following [staging-setup.md](staging-setup.md). The **deploy-staging** workflow deploys `main` after CI passes, over SSH as user `deploy`, into `/opt/wasla`. Secrets live in `/opt/wasla/.env`, generated once on the server.

**Your access:** add your own public key to `/home/deploy/.ssh/authorized_keys` (via the provider's console the first time). Then, from `/opt/wasla`:

- Status and logs:
  ```bash
  docker compose ps
  ```
  ```bash
  docker compose logs -f --tail 100 wasla
  ```
- Database shell:
  ```bash
  docker compose exec postgres psql -U wasla
  ```
- Create a staff account on staging:
  ```bash
  docker compose run --rm wasla staff create --email E --name N --role 3
  ```

The admin panel on staging is at `https://<ip-with-dashes>.sslip.io/admin/`.

**Gaps you own:** staging has **no backups and no monitoring**; data there is disposable. The deploy key is a single shared key; rotating it means updating the `STAGING_SSH_KEY` secret and `cloud-init.yaml` (or `authorized_keys`).

### Production (not built yet)

Production goes to Bahrain/UAE unless counsel says it must be in Iraq (decision pending). Plan per [01-architecture.md §3](01-architecture.md):

- Managed Postgres with point-in-time recovery.
- Redis.
- Two app VMs behind a load balancer.
- The admin panel on a separate hostname behind an IP allowlist or VPN.
- Prometheus, Grafana and Loki, plus Sentry.

## 6. Known gaps and risks (prioritised)

1. **SMS providers.** None yet; the owner is negotiating with Asiacell, Zain and Korek. The server refuses to start in prod without one (`main.go`). Implement `auth.Sender` per provider and wire it through `Failover`.
2. **Device attestation.** `auth.Attestor` accepts only `"dev"`. The Play Integrity verifier is needed before launch, otherwise every caller gets the "unattested" (halved) limits.
3. **Rate limits** are fixed-window counters in Redis. That's acceptable now; consider sliding windows if abuse shows burst patterns at window edges.
4. **No metrics endpoint yet** (`/metrics`). Add Prometheus before the first public beta.
5. **Moderator alerts** go to one webhook (`WASLA_ALERT_WEBHOOK_URL`). There's no escalation if nobody acts; consider paging escalation before launch.
6. **Privacy engine** is minimal: phone numbers are never shown to others, and last-seen/photo rules are not enforced yet (Sprint 2–3).
7. **Push notifications** (FCM) are not built yet.
8. **Load testing** has not been done (planned for week 14, with k6).

## 7. First week checklist

- [ ] Read the docs in §1 and run the stack locally (§2).
- [ ] Review the open pull request(s); leave comments on GitHub.
- [ ] Get SSH access to staging (§5) once the owner has created it.
- [ ] Pick 1–2 risks from §6 to own, and tell the owner your estimate.
- [ ] Read [launch-checklist.md](launch-checklist.md); most items marked *(engineer)* are yours.
- [ ] Agree with the owner on a review turnaround (suggested: within 2 working days).
