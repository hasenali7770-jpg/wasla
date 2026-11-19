# Staging server: setup guide for the owner

**What this gives you:** a private test copy of Wasla on the internet, and an Android app (APK) you can install on your phone to try it. No real SMS is sent: the login code is shown on the screen ("وضع الاختبار — الرمز: …").

**Cost:** about **€8–25 per month**, depending on the provider. You can delete the server at any time to stop paying.

**Your time:** about 30 minutes, plus waiting for account approval.

You do steps 1–4 once. After that, every update merged into `main` is installed on the server automatically, and a new APK is built.

---

## Step 1: Create a cloud account

We recommend **Hetzner** (cheaper). If Hetzner rejects your sign-up, which sometimes happens for some countries, use **DigitalOcean** (Step 1B).

### 1A. Hetzner (recommended)

1. Go to **https://www.hetzner.com/cloud** and click **Sign up**.
2. Enter your email and a strong password, then confirm the email they send you.
3. Fill in your name and address. Hetzner may ask for **identity verification** (a photo of your passport or ID, or a small PayPal payment). Approval can take from a few minutes to a day.
4. Add a payment method: **credit/debit card or PayPal**.

### 1B. DigitalOcean (alternative)

1. Go to **https://www.digitalocean.com** and click **Sign up**.
2. Sign up with email (or Google), then confirm your email.
3. Add a **credit/debit card or PayPal**. DigitalOcean may place a small temporary charge to check the card.

---

## Step 2: Create the server

You will paste one file during this step:

1. Open **[deploy/staging/cloud-init.yaml](../deploy/staging/cloud-init.yaml)** on GitHub.
2. Click the **Raw** button.
3. Select all the text and copy it.

### On Hetzner

1. In the Hetzner Console, click **+ New project**, name it `Wasla`, and open it.
2. Click **Add Server**, then choose:
   - **Location:** Falkenstein or Nuremberg (Germany). Fine for testing; production will be in the Gulf region.
   - **Image:** Ubuntu **24.04**.
   - **Type:** Shared vCPU → **CX32** (4 vCPU, 8 GB RAM), around €8/month. If CX32 is not listed, pick any shared plan with **at least 4 GB RAM**.
   - **Networking:** keep **Public IPv4** switched on.
   - **SSH keys:** leave empty. The pasted file sets up access.
   - **Cloud config:** paste the text you copied.
   - **Name:** `wasla-staging`.
3. Click **Create & Buy now**.
4. Wait about 1 minute, then **copy the server's IPv4 address** (four numbers with dots, for example `203.0.113.25`).

### On DigitalOcean

1. Click **Create → Droplets**, then choose:
   - **Region:** Frankfurt.
   - **Image:** Ubuntu **24.04 (LTS)**.
   - **Size:** Basic → Regular → **4 GB / 2 CPUs** (about $24/month).
   - **Authentication:** choose **Password** and let it generate a long random one. It won't be used; the pasted file turns password login off.
   - **Advanced options → Add initialization scripts:** paste the text you copied.
   - **Hostname:** `wasla-staging`.
2. Click **Create Droplet**.
3. **Copy the IPv4 address** shown.

> Give the server **5 minutes** after creation to finish installing before Step 4.

---

## Step 3: Add two secrets to GitHub

These let GitHub install Wasla on your server.

1. On GitHub, open the **wasla** repository → **Settings** → **Secrets and variables** → **Actions**.
2. Click **New repository secret**:
   - **Name:** `STAGING_HOST`
   - **Secret:** the IPv4 address from Step 2 (just the numbers, e.g. `203.0.113.25`)
   - Click **Add secret**.
3. Click **New repository secret** again:
   - **Name:** `STAGING_SSH_KEY`
   - **Secret:** the whole content of the key file Claude gave you, including the `-----BEGIN…` and `-----END…` lines.
   - Click **Add secret**.

> 🔒 This key opens the staging server. Don't share it anywhere else. After pasting it into GitHub, delete your copy. If it ever leaks, ask for a new one; it takes 2 minutes to replace.

---

## Step 4: Start the first installation

1. In the repository, click **Actions** → **deploy-staging** (left side) → **Run workflow** → **Run workflow**. (This button appears once the Sprint 1 pull request is merged into `main`.)
2. Wait about **10–15 minutes** until both jobs show a green ✓.
3. The test server address is shown in the "Health check" step, for example `https://203-0-113-25.sslip.io`.

From now on this repeats **automatically** after every merge into `main`.

---

## Step 5: Install the app on your Android phone

1. Open the finished **deploy-staging** run and scroll to **Artifacts**.
2. Tap **wasla-staging-apk**. It downloads a `.zip` file.
3. On your phone, open the zip and tap **app-debug.apk**.
4. If Android asks, allow **"Install unknown apps"** for your browser or Files app.
5. If Google Play Protect warns about an unknown developer, choose **Install anyway**. This is normal for test builds; the store version will be signed.
6. Open **Wasla**, enter your phone number, and type the code shown under the code box.

> The test server is separate from the real service. Data on it can be wiped at any time.

---

## Later: moderator alerts on your phone

*Postponed until moderators are hired (see [launch-checklist.md](launch-checklist.md)).*

When someone reports child abuse or terrorism, Wasla can post an alert to a chat channel:

1. Create a free **Slack** workspace and add an "Incoming Webhook" to a channel such as `#wasla-alerts`. (Mattermost works too.) Copy the webhook URL.
2. Ask your engineer, or Claude, to add `ALERT_WEBHOOK_URL=<that URL>` to `/opt/wasla/.env` on the server and restart. It is a secret: never post it in a chat.

## Stopping or deleting

- **Hetzner:** open the server → **Delete**. Billing stops right away (charged by the hour).
- **DigitalOcean:** open the Droplet → **Destroy**. Billing stops right away.

## If something goes wrong

Send Claude (or your engineer) a screenshot of the failed step in the **deploy-staging** run. The most common causes are:

- Running Step 4 before the server finished setting up. Wait 5 minutes and run it again.
- A typo in the IP address secret.
