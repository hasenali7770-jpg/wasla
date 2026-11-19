# Wasla — sprint plan

What is done, what comes next. Each sprint ends in one pull request
(`sprint-N` → `main`). The overall 15-week timeline is in
`00-proposal-lean-mvp.md` §1.4; launch blockers are in `launch-checklist.md`.

| Sprint | Contents | Status |
|---|---|---|
| 0 | Architecture, data model, protocol, CI | Done (PR #1) |
| 1 | Flutter app setup, phone login with OTP, sessions | Done (PR #1) |
| 2 | Chats, messages, sync engine, Report/Block, admin panel | Done (PR #2) |
| 3 | Offline storage on the phone, brand kit, photos and files | PR #3 |
| 3b | Push notifications (Firebase Cloud Messaging) | In progress |
| 4 | See below | Next |

## Sprint 4

1. **Upgrade Go to the latest supported version (first task, launch
   blocker).** The backend is on Go 1.24, which is out of security support.
   Then upgrade the dependencies held back for Go 1.24 (minio-go, x/image,
   gofakes3) and re-run all tests.
2. Encrypt the on-device message database (SQLCipher; key in Android
   Keystore).
3. Small groups (create, add/remove members, admin roles) in the app.
4. Push: move from FCM registration tokens to the newer Firebase
   Installation ID registration (`register()` / `onRegistered` in
   firebase_messaging 17) once the server-side send format is confirmed.
