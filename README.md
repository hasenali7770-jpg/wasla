# Wasla (وصلة)

A cloud messaging app for Android, iOS, web and desktop. Arabic (RTL) is the default language, with English as the second.

**Current phase: Phase 0, architecture (draft for sign-off).**

## Documents

| # | Document | Contents |
|---|---|---|
| 0 | [Proposal: Lean MVP, roadmap, Matrix comparison](docs/00-proposal-lean-mvp.md) | Scope, budget, timeline, **CMC regulatory flag** |
| 1 | [Architecture](docs/01-architecture.md) | Topology, modules, key flows, sync model, security, operations, client, scaling path |
| 2 | [Data model](docs/02-data-model.md) | ER diagram, table notes, privacy defaults, key queries, ScyllaDB migration map |
| 3 | [Protocol](docs/03-protocol.md) | Transports, connection lifecycle, RPC, updates and gap rule, idempotency, media, versioning |
| 4 | [Decision records](docs/04-decisions.md) | ADR-001 to ADR-009 |

## Repository layout

```
wasla/
├── docs/                          architecture and decisions (this phase)
├── proto/                         API contract — buf module, package wasla.v1
│   ├── buf.yaml / buf.gen.yaml
│   └── wasla/v1/*.proto           frame, auth, users, contacts, chats, messages, media, updates, moderation
├── db/postgres/
│   ├── migrations/                golang-migrate files (0001_init.up/down.sql)
│   └── tests/                     SQL smoke tests run in CI
├── backend/                       Go module `wasla/backend` (modular monolith)
│   ├── cmd/wasla-server/          the single binary (WASLA_ROLE=all|gateway|api|worker)
│   └── internal/
│       ├── gateway/ auth/ users/ contacts/ chats/ messaging/
│       ├── updates/ media/ push/ presence/ moderation/
│       └── platform/              config, snowflake IDs (+ db, redis, s3, metrics in sprint 1)
├── app/                           Flutter client (generated in sprint 1; layout in app/README.md)
├── deploy/
│   └── docker-compose.dev.yml     Postgres, Redis, MinIO for local development
├── .github/workflows/ci.yml       buf lint/breaking · migrations + smoke tests · go vet/test/build
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

Start the server, then check `curl localhost:8080/healthz`:

```bash
make run
```

## Status of Phase 0 deliverables

- [x] Architecture document with diagrams
- [x] Database schema; migrations verified up/down/up on Postgres 16, with a smoke test of the send path
- [x] Protobuf API spec (`buf lint` STANDARD passes)
- [x] Repository layout, Go skeleton (builds; Snowflake ID generator with tests), dev environment, CI
- [ ] Sign-off on scope and budget, and backend choice (own vs. Matrix)
- [ ] CMC legal review, then hosting region
- [ ] Brand assets and Figma design system (weeks 1–2)
