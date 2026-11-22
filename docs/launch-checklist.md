# Wasla — Launch checklist

Everything that must be true before real users are let in. Owner: the person in brackets. Tick items in a pull request when done.

## Security and keys

- [x] **Launch blocker — Go upgraded to the latest supported version.** Done in Sprint 4: Go 1.27.4 (`go.mod`, Dockerfile; CI follows `go.mod`), all dependencies upgraded, full test suite passing. Keep it current: Go supports only the two newest major versions, so plan an upgrade every ~6 months. *(Claude; engineer reviews)*
- [ ] **Replace the staging deploy key** (it was shared in a chat on 18 Nov 2026). Generate a new key pair, update the `STAGING_SSH_KEY` secret and `deploy/staging/cloud-init.yaml` (or `/home/deploy/.ssh/authorized_keys` on the server). *(engineer)*
- [ ] **Production keys are new and never shared in chat or email:** server SSH keys, `WASLA_CODE_SECRET`, `WASLA_PHONE_PEPPER`, database passwords. Keep them in the cloud provider's secret manager. *(engineer)*
- [ ] Android release signing key created, backed up offline in two places, and enrolled in Play App Signing. *(owner + engineer)*
- [ ] Device attestation (Play Integrity) verified server-side; `auth.DevAttestor` removed from production builds. *(engineer)*
- [ ] Encrypt the on-device message database (SQLCipher, key in Android Keystore / iOS Keychain). *(Claude, Sprint 4)*
- [ ] External penetration test of the server and app (budgeted, ≈ $5k). *(owner)*

## Service

- [ ] SMS providers: two contracts covering Asiacell, Zain and Korek, wired into `auth.Failover`, with delivery tested on real SIMs from each operator. *(owner + engineer)*
- [ ] Production hosting region confirmed after the CMC legal review (Bahrain/UAE, or Iraq if required). *(owner)*
- [ ] Production stack running: managed Postgres with point-in-time recovery, daily off-site backups, and **one restore drill done**. *(engineer)*
- [ ] Monitoring and alerts: `/metrics` + Grafana dashboards, error tracking (Sentry), alerts on send latency, error rate and SMS spend. *(engineer)*
- [ ] Load test at 2× the expected launch load (20k users → 40k simulated). *(engineer)*
- [ ] Push notifications working on real Android devices (Firebase project owned by the company account). *(owner + Claude)*
- [ ] Production gets its own Firebase service-account key (not the staging one); the staging key is revoked if it was ever shared. *(owner)*

## Moderation and legal

- [ ] **Moderators hired:** at least 2 Arabic-speaking moderators covering 08:00–24:00 Baghdad time, plus an on-call senior moderator for critical reports at night. *(owner)*
- [ ] **Moderator alert webhook switched on** (`WASLA_ALERT_WEBHOOK_URL`). Postponed until moderators are hired. *(engineer)*
- [ ] Staff accounts created for each moderator (`wasla-server staff create`), with TOTP set up on their phones. *(engineer)*
- [ ] Takedown deadlines (1 h / 4 h / 24 h) confirmed by Iraqi counsel against the CMC framework. *(owner)*
- [ ] Procedure for authority data requests written and approved by counsel. *(owner)*
- [ ] Terms of Service and Privacy Policy published in Arabic and English, with the version matching `auth.Config.TermsVersion`. *(owner)*
- [ ] CMC registration / licensing status settled. *(owner)*

## Store and brand

- [ ] Brand kit applied: launcher icons, colours, font. *(Claude)*
- [ ] Google Play organization account verified (D-U-N-S). *(owner)*
- [ ] Store listing in Arabic and English: screenshots, description, privacy labels, content rating. *(owner)*
- [ ] In-app account deletion and report/block verified by a tester who wasn't involved in building it. *(owner)*
