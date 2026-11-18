# Wasla (وصلة)

A cloud messaging app for Android, iOS, web and desktop. Arabic (RTL) is the default language, with English as the second.

**Current phase: Lean MVP, Sprint 1 (auth/OTP + moderation).** Latest progress: [week 1](docs/progress/2026-11-18-week-1.md).

## Documents

| # | Document | Contents |
|---|---|---|
| 0 | [Proposal: Lean MVP, roadmap, Matrix comparison](docs/00-proposal-lean-mvp.md) | Scope, budget, timeline, **CMC regulatory flag** |
| 1 | [Architecture](docs/01-architecture.md) | Topology, modules, key flows, sync model, security, operations, client, scaling path |
| 2 | [Data model](docs/02-data-model.md) | ER diagram, table notes, privacy defaults, key queries, ScyllaDB migration map |
| 3 | [Protocol](docs/03-protocol.md) | Transports, connection lifecycle, RPC, updates and gap rule, idempotency, media, versioning |
| 4 | [Decision records](docs/04-decisions.md) | ADR-001 to ADR-009 |
| 5 | [Moderation and legal requests](docs/05-moderation.md) | Report flow, deadlines, roles, admin panel, authority requests |
| — | [Onboarding (engineers)](docs/onboarding.md) | Read order, local setup, conventions, servers, known gaps |
| — | [Staging setup (owner)](docs/staging-setup.md) | Create the test server and install the APK on your phone |

## Repository layout

```
wasla/
├── docs/                          architecture, decisions, moderation guide, weekly progress
├── proto/                         API contract — buf module, package wasla.v1
│   ├── buf.yaml / buf.gen.go.yaml / buf.gen.dart.yaml
│   └── wasla/v1/*.proto           frame, auth, users, contacts, chats, messages, media, updates, moderation
├── db/postgres/
│   ├── migrations/                golang-migrate files (0001_init.up/down.sql)
│   └── tests/                     SQL smoke tests run in CI
├── backend/                       Go module `wasla/backend` (modular monolith)
│   ├── cmd/wasla-server/          the single binary (WASLA_ROLE=all|gateway|api|worker)
│   └── internal/
│       ├── gateway/ auth/ users/ contacts/ chats/ messaging/
│       ├── updates/ media/ push/ presence/ moderation/
│       ├── platform/              config, db, errs, password, phone, ratelimit, rpc, snowflake, totp
│       ├── server/                wiring + integration tests
│       └── testutil/              real Postgres + in-memory Redis for tests
├── app/                           Flutter client (Android first; layout in app/README.md)
├── deploy/
│   ├── docker-compose.dev.yml     Postgres, Redis, MinIO for local development
│   └── staging/                   compose + Caddy (HTTPS) + cloud-init for the staging server
├── .github/workflows/            ci.yml (all checks, debug APK) · deploy-staging.yml (staging + staging APK)
└── Makefile
```

## Getting started (backend developers)

Requirements: Docker, Go 1.24+, [buf](https://buf.build/docs/installation), psql.

Start the local dependencies (Postgres, Redis, MinIO):

```bash
make dev-up
```

Apply the database schema:

```bash
make db-migrate
```

Run the SQL smoke tests:

```bash
make db-test
```

Lint the protobuf files:

```bash
make proto-lint
```

Run the Go vet and test suite:

```bash
make backend-test
```

Start the server in dev mode (login codes are printed to the log instead of sent by SMS), then check `curl localhost:8080/readyz`:

```bash
make run
```

Create a moderator account (prints a one-time password and the authenticator secret); the panel is at http://127.0.0.1:8081/admin/:

```bash
make staff EMAIL=you@example.com NAME="Your Name" ROLE=3
```

Run the app against it (Flutter 3.47.9):

```bash
cd app && flutter run --dart-define=WASLA_WS_URL=ws://10.0.2.2:8080/ws
```

## Status

- [x] Phase 0: architecture, schema, protocol, repository, CI
- [x] Sprint 1 backend: phone/OTP login with anti-fraud limits, two-step password, sessions, account deletion
- [x] Sprint 1 moderation: reports with evidence, review queue with deadlines, takedowns, bans, audit log, legal-request register
- [x] Sprint 1 app: Flutter project, Arabic/English (RTL/LTR), login screens, devices screen
- [ ] Sprint 2: chats (text messages, chat list, read receipts, typing), in-app Report/Block buttons
- [ ] Legal review of CMC obligations; SMS providers; brand assets
