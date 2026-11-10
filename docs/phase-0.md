# Phase 0 — Foundations (2026-11-09)

Status: **done.** All definition-of-done checks pass locally. CI is written but has not run yet (the repo isn't under git yet).

| Check | Result |
| --- | --- |
| Migration `20261109000000_init` applied (`hrms`, `hrms_test`) | ✅ |
| `npm run db:check` (migrations = schema.prisma) | ✅ no drift |
| `npm run db:seed` (run twice, idempotent) | ✅ |
| API lint / typecheck | ✅ |
| API tests (`npm test`) | ✅ 62 passed: 39 unit + 23 integration |
| `npm run openapi:check` | ✅ |
| Flutter client regenerated (`tool/gen_api`) | ✅ |
| `flutter analyze` / `flutter test` | ✅ no issues / 21 passed |
| `flutter build web --debug` | ✅ compiles |
| Manual smoke test against `npm run dev` (OTP → /me → refresh → replay rejected) | ✅ |

## What was built

### API (`api/`)
- **Skeleton:** Express 5 app (`app.ts`, no listen) and `server.ts` with graceful shutdown. Env config is validated with zod (`config/env.ts`); production refuses the dev OTP code and console messaging. pino JSON logs carry a request id (`X-Request-Id` is accepted or generated). Also: helmet, CORS allow-list, and per-IP rate limiting.
- **Errors:** `AppError(code, status, message, details)`. One middleware returns `{ error: { code, message, details } }`. Zod, malformed-JSON and Prisma unique/not-found errors are mapped to that shape.
- **Route pipeline:** `ModuleRouter.route({...})` (`lib/route.ts`) always applies authenticate → requireRole / requireSuperAdmin → zod validation (body/query/params) → handler. The same call registers the route in the OpenAPI registry.
- **Prisma 7 models:** `Region`, `Depot` (soft delete), `User`, `UserScope`, `OtpChallenge`, `RefreshToken`, `AuditLog`. The migration adds raw-SQL constraints:
  - each scope row has exactly one of region/depot;
  - no duplicate scope rows;
  - phones are stored in E.164.
- **Auth:**
  - `POST /auth/otp/request` always answers 202, with per-IP and per-phone limits and a silent resend cooldown.
  - `POST /auth/otp/verify` locks the challenge after 5 wrong attempts (423 `OTP_LOCKED`) and rejects a code that was already used.
  - Access tokens are HS256 JWTs valid for 15 minutes.
  - `POST /auth/refresh` rotates the refresh token. Re-using an old one revokes the whole session.
  - `POST /auth/logout` revokes the session and can be called repeatedly.
  - OTPs and refresh tokens are stored as HMAC-SHA256 hashes.
- **`GET /me`:** profile, role, and the effective scope (regions + depots; a regional manager gets every depot in their regions). The user and scopes are re-read from the DB on every request.
- **Scope:** `scopeWhere(user, 'region' | 'depot' | 'depotOwned')`, `canAccessDepot` and `assertDepotAccess` (`middleware/scope.ts`). They fail closed: a manager with no scope rows sees nothing.
- **Audit:** `audit.record(tx, ctx, {...})` runs inside the write's transaction and redacts secret fields. Login is audited.
- **Field encryption:** AES-256-GCM helpers (`lib/crypto.ts`) are ready for PAN and bank account in phase 1.
- **Messaging:** a `MessagingService` interface plus a console adapter for dev.
- **Jobs:** BullMQ worker (`worker.ts`) with a nightly IST maintenance job that purges expired OTP challenges and refresh tokens.
- **OpenAPI:** `npm run openapi` writes `openapi/openapi.yaml` (7 paths). `openapi:check` is the CI gate.
- **Seed:** the HR super admin from `SEED_ADMIN_PHONE`, plus, when `SEED_DEMO=true`, a demo org:
  - regions: WEST (depots PUN, MUM) and SOUTH (depot BLR);
  - one manager per role on fictitious numbers `+919000000002` to `+919000000006`.

### Mobile (`mobile/`)
- **Generated client:** `packages/hrms_api`, built from `openapi.yaml` by `tool/gen_api.sh` / `gen_api.ps1` (openapi-generator 7.27, dart-dio + json_serializable).
- **`core/`:**
  - Dio providers.
  - `AuthInterceptor`: adds the bearer token and does a single shared refresh when several requests get 401 at once. It replays requests on a separate Dio so a second 401 can't deadlock it. On a failed refresh it fires a session-expired event.
  - `SecureTokenStorage`, `ApiFailure` and `AppConfig` (`--dart-define=API_BASE_URL`).
- **Auth:**
  - `SessionController` (Riverpod 3) is the single source of truth.
  - The go_router redirect is a pure function: splash → login → role shell. It also blocks destinations outside the user's role.
  - Two-step phone + OTP login with a resend countdown.
- **Role shell:** bottom navigation on phones, `NavigationRail` at ≥ 840 dp. Tabs per role follow CLAUDE.md §9. Each role has its own home card grid; cards get live data in phase 1. Unbuilt destinations show a placeholder naming their phase.
- **More / profile:** role, data scope, pull-to-refresh and logout.
- **Strings:** English ARB in `lib/app/l10n`.
- **Android:** INTERNET permission in release; cleartext HTTP only in debug, for `10.0.2.2`.

### Root
- `docker-compose.yml`: postgres 16, redis, minio (with a private bucket created on start), mailpit. `infra/postgres/init` creates `hrms_test`.
- `.github/workflows/ci.yml`, two jobs:
  - **api:** lint, typecheck, migrate, drift check, OpenAPI check, seed, tests.
  - **mobile:** regenerate the client and code, fail on git diff, then analyze and test.

## Running locally

```
# API (uses the local Postgres; docker compose is the alternative)
cd api && npm i && npm run db:deploy && npm run db:seed && npm run dev
# Login: phone 9000000001 (HR super admin) or 9000000002..06; OTP 123456 (OTP_DEV_FIXED_CODE in .env)

# App
cd mobile && flutter run -d chrome --web-port 8080      # or an Android emulator (uses http://10.0.2.2:3000)
```

## Environment notes (this dev machine)
- **No Docker or git.** The local PostgreSQL 18 service is used instead, with role `hrms` / `hrms` owning databases `hrms` and `hrms_test`.
- **Redis isn't installed**, so `npm run worker` can't run here yet. The API itself doesn't need Redis.
- **Java:** the Java on PATH is 1.8, but openapi-generator needs 11+. Before running `tool\gen_api.ps1`, set `$env:JAVA_HOME = "C:\Program Files\Android\Android Studio\jbr"`.
- **Flutter's `dart.bat` wrapper needs git**, which isn't installed. `gen_api.ps1` therefore calls the Dart SDK bundled with Flutter directly. For build_runner use `C:\flutter\bin\cache\dart-sdk\bin\dart.exe run build_runner build`.
- **Windows desktop builds** need Windows Developer Mode (plugin symlinks).

## Open TODOs added in this phase
- `TODO(business)` — `api/src/lib/messaging.ts`: choose the WhatsApp/SMS provider (and DLT template ids) for OTP and payslip delivery (CLAUDE.md §13).
- `TODO(infra)` — `api/src/middleware/rateLimit.ts`: rate limits are in memory. Move them to a Redis store before running more than one API replica.
- `TODO(l10n)` — `mobile/lib/core/errors/failure_message.dart`: server error messages are shown in English. Map error codes to ARB strings when Hindi and Tamil are added.

## Left for phase 1
- Regions/depots/users admin (`/regions`, `/depots`, `/users`, `/users/:id/scopes`).
- Employees, documents, fleet, roster, attendance with the offline queue, leave, approvals, and push notifications (FCM).
- `scopeWhere` gets an `'employee'` entity, scoped through the current `EmployeeJob` depot, plus scope-isolation tests for each new entity.
- Storage (MinIO presign) and push libs. They are not built yet because nothing in phase 0 uses them.
