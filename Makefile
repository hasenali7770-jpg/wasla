BUF ?= buf
PSQL ?= psql
COMPOSE = docker compose -f deploy/docker-compose.dev.yml
DEV_DB ?= postgres://wasla:wasla-dev-only@localhost:5432/wasla

.PHONY: dev-up dev-down proto-lint proto-gen db-migrate db-test backend-test run

dev-up:            ## start Postgres, Redis, MinIO
	$(COMPOSE) up -d

dev-down:
	$(COMPOSE) down

proto-lint:
	cd proto && $(BUF) lint

proto-gen:         ## regenerate Go + Dart code from proto/
	cd proto && $(BUF) generate

db-migrate:
	for f in db/postgres/migrations/*.up.sql; do $(PSQL) "$(DEV_DB)" -v ON_ERROR_STOP=1 -q -f $$f; done

db-test:
	for f in db/postgres/tests/*.sql; do $(PSQL) "$(DEV_DB)" -v ON_ERROR_STOP=1 -f $$f; done

backend-test:
	cd backend && go vet ./... && go test -race ./...

run:
	cd backend && WASLA_POSTGRES_URL=$(DEV_DB) go run ./cmd/wasla-server
