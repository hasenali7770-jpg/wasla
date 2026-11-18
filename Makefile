BUF ?= buf
PSQL ?= psql
COMPOSE = docker compose -f deploy/docker-compose.dev.yml
DEV_DB ?= postgres://wasla:wasla-dev-only@localhost:5432/wasla

.PHONY: dev-up dev-down proto-lint proto-gen db-migrate migrate db-test backend-test app-test run staff

dev-up:            ## start Postgres, Redis, MinIO
	$(COMPOSE) up -d

dev-down:
	$(COMPOSE) down

proto-lint:
	cd proto && $(BUF) lint

proto-gen:         ## regenerate Go + Dart code from proto/ (needs protoc-gen-go v1.36.6, protoc_plugin 25.1.0)
	cd proto && $(BUF) generate --template buf.gen.go.yaml && $(BUF) generate --template buf.gen.dart.yaml

db-migrate:
	for f in db/postgres/migrations/*.up.sql; do $(PSQL) "$(DEV_DB)" -v ON_ERROR_STOP=1 -q -f $$f; done

migrate:           ## apply pending migrations with the server's own runner (records them in wasla_migrations)
	cd backend && WASLA_ENV=dev WASLA_POSTGRES_URL=$(DEV_DB) go run ./cmd/wasla-server migrate

db-test:
	for f in db/postgres/tests/*.sql; do $(PSQL) "$(DEV_DB)" -v ON_ERROR_STOP=1 -f $$f; done

backend-test:      ## needs a Postgres the tests may CREATE DATABASE on
	cd backend && go vet ./... && WASLA_TEST_POSTGRES_URL=$(DEV_DB) go test -race ./...

app-test:
	cd app && tool/check_rtl.sh && flutter analyze && flutter test

run:               ## dev server: login codes are printed to the log, not sent by SMS
	cd backend && WASLA_ENV=dev WASLA_POSTGRES_URL=$(DEV_DB) go run ./cmd/wasla-server

staff:             ## make staff EMAIL=a@b.c NAME="..." ROLE=1
	cd backend && WASLA_ENV=dev WASLA_POSTGRES_URL=$(DEV_DB) go run ./cmd/wasla-server staff create --email "$(EMAIL)" --name "$(NAME)" --role $(ROLE)
