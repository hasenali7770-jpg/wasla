// Package messaging implements wasla.v1.MessagesService. The send path is
// one Postgres transaction: allocate seq, insert message (idempotent on
// random_id), fan out updates via updates.Append, commit, then publish.
// Storage goes through the MessageStore interface so it can move to ScyllaDB.
package messaging
