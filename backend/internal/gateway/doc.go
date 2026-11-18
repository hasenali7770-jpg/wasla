// Package gateway terminates client WebSocket connections: Hello/HelloAck,
// frame decoding, per-connection rate limits, RPC dispatch to modules, and
// delivery of UpdatesPush frames received from the Redis pub/sub fan-out.
// It holds no durable state; any instance can serve any client.
package gateway
