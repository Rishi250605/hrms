# Deploying the API to Render (with Neon Postgres)

The Blueprint is `../render.yaml`. It creates:

| Render resource | What it runs |
| --- | --- |
| `hrms-api` (web service) | `npm ci --include=dev && npm run build && npx prisma migrate deploy`, then `npm start`; health check `/api/v1/health/ready` |
| `hrms-nightly-jobs` (cron, 00:05 IST) | `npm run job:prod -- employee-exits document-expiry leave-accrual purge-expired-auth` (replaces the BullMQ worker + Redis) |
| `hrms-api-shared` (env group) | non-secret config + generated `JWT_ACCESS_SECRET` / `TOKEN_HASH_PEPPER` |

## Before the first deploy

1. **Database (Neon).** Copy two connection strings from the Neon console:
   - `DATABASE_URL`: the **pooled** one (host contains `-pooler`), used by the app.
   - `DIRECT_URL`: the same without `-pooler`, used only by `prisma migrate deploy`.
2. **File storage (S3-compatible, required in production).** Documents, voice notes, receipts, payslips and report exports go here.
   - Cloudflare R2 (current, free tier 10 GB): private bucket `hrms-documents`, an R2 API token with Object Read & Write on that bucket only; `S3_ENDPOINT=https://<account-id>.r2.cloudflarestorage.com`, `S3_REGION=auto` (already in the env group).
   - Or AWS S3 in `ap-south-1` (Mumbai, matches CLAUDE.md §3): private bucket + an IAM user limited to it; leave `S3_ENDPOINT` empty and set `S3_REGION=ap-south-1`.
   - Bucket CORS is only needed for a Flutter **web** build (allow `PUT`/`GET` from its origin); the Android app does not need it.
3. **`DATA_ENCRYPTION_KEY`.** Use the same value as `api/.env` if you also run the API locally against the Neon database; otherwise generate one:
   `node -e "console.log(require('crypto').randomBytes(32).toString('base64'))"`.
   **Never change it once data exists**: encrypted PAN and bank numbers become unreadable. Keep a copy in a password manager.

## Deploy

Render Dashboard → **New → Blueprint** → select this repo → fill in the `sync: false` values above → **Apply**.
Then check `https://<service>.onrender.com/api/v1/health/ready` returns `{"status":"ok",...}`.

## Bootstrap data (once)

Migrations run on every deploy. The seed (business units, document requirements, allowance types, the director) is run by hand from a dev machine whose `api/.env` points at the same database:

```
cd api
SEED_DEMO=false npm run db:seed      # never seed demo logins (Demo@1234) into a public database
```

The seed refuses weak director passwords when `NODE_ENV=production`. Log in as `SEED_DIRECTOR_EMP_CODE` and create the other logins in the app.

## Mobile app

Build against the Render URL:

```
flutter build apk --release --dart-define=API_BASE_URL=https://<service>.onrender.com/api/v1
```

## Notes

- Region: Render has no Indian region; the Blueprint uses Singapore next to Neon `ap-southeast-1`. CLAUDE.md §3 still targets AWS/Azure Mumbai/Pune for production (DPDP).
- The free web plan sleeps after 15 idle minutes (≈1 min cold start). Use `starter` for daily use.
- Push notifications: set `PUSH_PROVIDER=fcm` and `FCM_SERVICE_ACCOUNT_B64` on `hrms-api` when Firebase is ready.
- To run a job by hand: Render Shell on `hrms-api` → `npm run job:prod -- document-expiry`.
