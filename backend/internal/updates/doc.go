// Package updates owns the per-user update log (pts): Append allocates pts
// for a set of users in user_id order (deadlock-safe) and writes user_updates;
// GetState/GetDifference serve sync; Publish notifies gateways via Redis.
package updates
