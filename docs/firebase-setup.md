# Firebase setup for push notifications (owner guide)

Wasla uses Firebase Cloud Messaging (FCM), Google's free service, to wake
Android phones when a message arrives. You set up two files. **Both go
straight into GitHub secrets. Never paste them into chat, email or a ticket.**

| File | What it is | GitHub secret name |
|---|---|---|
| `google-services.json` | Identifies the app to Firebase. It is built into the APK. | `GOOGLE_SERVICES_JSON` |
| Service-account key (`wasla-…-firebase-adminsdk-….json`) | Lets **our server** send pushes. Treat it like a password. | `FCM_SERVICE_ACCOUNT_JSON` |

About 15 minutes. It's free; no card is needed.

## 1. Create the Firebase project

1. Sign in to <https://console.firebase.google.com> with the **company**
   Google account (the one used for Google Play), not a personal one.
2. Click **Create a project** (or **Add project**).
3. Name: `Wasla`. Accept the terms and continue.
4. When asked about **Google Analytics**, turn it **off**. We don't need it,
   and it sends less data to Google. Then click **Create project**.

## 2. Add the Android app → `google-services.json`

1. On the project home page, click the **Android** icon ("Add app").
2. **Android package name:** `iq.wasla.messenger`. It must be exact, and it
   can never be changed later.
3. **App nickname:** `Wasla Android`. Leave **SHA-1** empty; push
   notifications don't need it.
4. Click **Register app**, then **Download google-services.json**.
5. Click **Next** through the remaining steps. I have already done the code
   changes they describe. Then click **Continue to console**.

## 3. Create the server key → service-account JSON

1. Click the gear ⚙ next to "Project Overview", then **Project settings**.
2. Open the **Cloud Messaging** tab. Check that **Firebase Cloud Messaging
   API (V1)** says **Enabled**. If it says disabled, click the ⋮ menu and
   enable it.
3. Open the **Service accounts** tab and click **Generate new private key**,
   then **Generate key**. A `.json` file downloads.
4. This file is a password. Keep it only on your computer until step 4, and
   delete the download afterwards.

## 4. Put both files into GitHub secrets

Do this once for each file:

1. Open the file in a plain text editor (Notepad on Windows, TextEdit on
   Mac). Select all and copy.
2. In GitHub, open the repository `wasla`, then **Settings → Secrets and
   variables → Actions**.
3. Click **New repository secret**.
4. **Name:** `GOOGLE_SERVICES_JSON` for the first file, or
   `FCM_SERVICE_ACCOUNT_JSON` for the second.
5. **Secret:** paste the content. Click **Add secret**.

When both secrets are listed, tell me in chat **"Firebase secrets added"**.
Don't send the files themselves. Then delete the downloaded service-account
file from your computer. If it's ever needed again, you can generate a new
one and revoke the old one.

## 5. What happens next (my side)

- CI turns `google-services.json` into Android settings at build time
  (`app/tool/firebase_config.py`). It is never committed. A build without
  the secret works normally, just without push.
- The deploy workflow copies the service-account key to the staging server
  as a file only the server can read (`/opt/wasla/secrets/fcm.json`, read-only
  for the server's own user). It goes over SSH and never appears in logs.
- **Privacy:** a push carries no message text and no sender name, only "you
  have new messages" plus the chat ID. The phone then fetches the message
  over our own encrypted connection. So Google never sees message content.
- iPhone pushes come later. They need an Apple Developer account and an
  APNs key, which you can add to the same Firebase project.

## If something goes wrong

- **"Package name already exists":** someone already registered
  `iq.wasla.messenger` in another Firebase project. Use that project instead,
  or ask me.
- **Lost the service-account key:** go to Project settings → Service
  accounts → **Manage service account permissions**, delete the old key,
  generate a new one and update the GitHub secret.
