# Build from the repository root:  docker build -f backend/Dockerfile -t wasla-server .
FROM golang:1.24.7-alpine AS build
WORKDIR /src/backend
COPY backend/go.mod backend/go.sum ./
RUN go mod download
COPY backend/ ./
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/wasla-server ./cmd/wasla-server

# Minimal runtime: no shell, no package manager, runs as non-root.
FROM gcr.io/distroless/static-debian12:nonroot
COPY --from=build /out/wasla-server /wasla-server
COPY db/postgres/migrations /migrations
ENV WASLA_MIGRATIONS_DIR=/migrations
EXPOSE 8080 8081
USER nonroot:nonroot
ENTRYPOINT ["/wasla-server"]
