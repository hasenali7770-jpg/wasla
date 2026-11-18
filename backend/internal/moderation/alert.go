package moderation

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"log/slog"
	"net/http"
	"time"
)

// Alerter notifies the on-call moderator about critical reports.
type Alerter interface {
	Alert(ctx context.Context, text string) error
}

// WebhookAlerter posts {"text": "..."} to a URL. That body is accepted by
// Slack and Mattermost incoming webhooks, and by most chat-ops relays
// (Discord needs "/slack" appended to its webhook URL).
type WebhookAlerter struct {
	URL    string
	Client *http.Client
}

func (w *WebhookAlerter) Alert(ctx context.Context, text string) error {
	body, _ := json.Marshal(map[string]string{"text": text})
	req, err := http.NewRequestWithContext(ctx, http.MethodPost, w.URL, bytes.NewReader(body))
	if err != nil {
		return err
	}
	req.Header.Set("Content-Type", "application/json")
	c := w.Client
	if c == nil {
		c = &http.Client{Timeout: 10 * time.Second}
	}
	resp, err := c.Do(req)
	if err != nil {
		return err
	}
	resp.Body.Close()
	if resp.StatusCode >= 300 {
		return fmt.Errorf("alert webhook: HTTP %d", resp.StatusCode)
	}
	return nil
}

// alertCritical sends the alert in the background; a failing webhook must
// never block or fail the user's report.
func (s *Reports) alertCritical(reportID int64, reason string) {
	if s.Alert == nil {
		return
	}
	text := fmt.Sprintf("🚨 Wasla: critical report #%d (%s) — must be handled within %s. Open the admin panel: /admin/reports/%d",
		reportID, reason, s.sla(PriorityCritical), reportID)
	go func() {
		ctx, cancel := context.WithTimeout(context.Background(), 15*time.Second)
		defer cancel()
		if err := s.Alert.Alert(ctx, text); err != nil {
			s.logger().Error("critical report alert failed", "report_id", reportID, "err", err)
		}
	}()
}

func (s *Reports) logger() *slog.Logger {
	if s.Log != nil {
		return s.Log
	}
	return slog.Default()
}
