# CLAUDE.md — Transport HRMS (internal)

This file is the standing spec for this repository. Read it fully at the start of every session.
When a decision here changes, update this file in the same commit and add a line to the Decisions log at the bottom.

---

## 1. What we are building

An **internal HRMS mobile app for a transport services company** (India). One company, one database, not SaaS.

- Most employees are **drivers, conductors, helpers, mechanics and depot staff**. They are **records in the system, not app users**. They never log in.
- Only **four login roles** use the app (see §2): director, HR, operational manager, regional manager.
- **Phase 2 (PHASE-2-FEATURES.md) supersedes the earlier spec where they differ**: business units, reporting-line visibility, employee-code + password login, per-record approvals, allowances, PDF payslips (the in-house payroll engine is cancelled), daily tasks, reports. Progress: `docs/phase-2-progress.md`.
- The app's core loop: **roster → document validity check → attendance (RM marks drivers/loadmen; managers self-mark and are approved up the line) → leave/OD and allowances approved up the line → payslip PDFs uploaded by HR and viewed in the app**.
- What makes it worth building in-house: duty rostering tied to vehicles and routes, licence/medical expiry blocking, allowance-heavy driver pay (batta, night halt, OT), and fast bulk attendance for managers.

### Non-goals (do not build unless this file is updated)
- Multi-tenancy, billing, white-labelling.
- An employee self-service app for drivers.
- A separate web front end (one Flutter app only; Flutter web build may come later from the same code).
- Recruitment/ATS, performance appraisal (phase 4 at earliest).

---

## 2. Users, roles and data scope

Phase 2 (PHASE-2-FEATURES.md §1, §11) — **hierarchy: Director → HR → Operational manager (OM) → Regional manager (RM) → drivers / loadmen** (records only).

| Role (enum) | Main jobs |
| --- | --- |
| `DIRECTOR` | Everything in every business unit; user management (create logins, reset passwords, unlock, deactivate); approves HR self-attendance / leave; company dashboard |
| `HR` | Approves OM attendance, leave/OD and allowances; notified of RM-level events; uploads payslips; manages driver/loadman records and promotions |
| `OPERATIONAL_MANAGER` | Approves RM attendance, leave/OD and allowances; allots daily tasks to RMs; raises own allowances |
| `REGIONAL_MANAGER` | Marks driver/loadman attendance; raises and approves their leave/OD; raises allowances for them and himself; completes daily tasks |

**Business units:** NLS, BMS, MOD, AERO (seeded). Staff belong to exactly one BU, managers to one or more with one primary, the director to all. A manager's own records use the primary BU. Each depot belongs to one BU.

**Bootstrap:** the seeded `DIRECTOR` (`SEED_DIRECTOR_EMP_CODE`, password from env) creates the other logins.

**Scope rules (enforced in the API, never only in the UI):** every record carries `businessUnitId`; access = BU match **and** hierarchy match via `access/scope.ts` (`scopeFor`, `visibleEmployeeIds`, `canAccess`, `employeeWhere`). Depth per role and feature is in `DEPTH` (RM 1; OM 2, except payslips and tasks 1; HR / director all within their BUs). Approvals are per record (`approverEmployeeId` + `approverRole`, with fallback to an active same-role user in the BU). Bank account numbers are stored encrypted and returned masked.

---

## 3. Tech stack (decided)

| Layer | Choice |
| --- | --- |
| Mobile app | **Flutter** (stable channel), Dart 3, Material 3, Android first, tablet-friendly layouts |
| State / routing | Riverpod (with code generation), go_router with a role-based shell |
| Networking | dio + client generated from the API's OpenAPI spec (`openapi-generator`, `dart-dio`) |
| Models | freezed + json_serializable |
| Offline | drift (SQLite) queue for RM team attendance when the network drops; sync on reconnect |
| Device storage | flutter_secure_storage for tokens and small preferences (selected business unit) |
| Media | `record` (voice notes, AAC ≤ 2 min), `just_audio` (playback), `image_picker` (receipts, documents), `file_picker` (payslip PDFs), `url_launcher` (open signed URLs), `package_info_plus` (app version) |
| Push | Firebase Cloud Messaging (managers only), FCM HTTP v1 behind `PushService` |
| API | **Node.js 20+, Express 5, TypeScript (strict)** |
| Validation | zod for every request body, query and params; zod-to-openapi to generate `openapi.yaml` |
| ORM / DB | **Prisma 7 + PostgreSQL 16+** |
| Jobs | BullMQ + Redis (`npm run job -- <name>` runs one without Redis) |
| Files | S3-compatible storage (MinIO locally, or the `local` driver in dev), private bucket, signed URLs ≤ 10 min; `multer` (in memory) for the payslip multipart upload |
| Reports | `exceljs` (xlsx) and `pdfkit` (PDF), generated server-side |
| Auth | **Employee ID + password** (argon2id), lockout after 5 failures / 15 min → short-lived JWT access token + rotating refresh token. OTP login was removed in phase 2 |
| Logging | pino (JSON), request id per request |
| Tests | Vitest + supertest (API; unit, integration against `TEST_DATABASE_URL`, and a separate `perf` project); `flutter test` for unit + widget tests |
| Messaging to drivers | Provider-agnostic `MessagingService` interface (SMS/WhatsApp); console adapter in dev (not used for login any more) |
| Local dev | docker-compose: postgres, redis, minio, mailpit (or a local Postgres + the `local` storage driver) |
| CI | GitHub Actions: lint, typecheck, test, prisma migrate check, openapi check, flutter analyze + test |
| Hosting (later) | Containers on Render/Railway initially; production on AWS or Azure **in an Indian region (Mumbai/Pune)** |

Do not introduce other frameworks (NestJS, GraphQL, Firebase as a database, MongoDB, other state managers) without updating this file.

---

## 4. Repository layout

```
/
├─ CLAUDE.md
├─ PHASE-2-FEATURES.md              # phase 2 spec (overrides this file where they differ)
├─ docker-compose.yml
├─ .github/workflows/
├─ api/
│  ├─ package.json
│  ├─ prisma/ (schema.prisma, migrations/, seed.ts)
│  ├─ openapi/openapi.yaml          # generated, committed
│  ├─ scripts/                      # openapi.ts, smoke.ts (end-to-end smoke against a running API)
│  ├─ test/                         # helpers (org + hierarchy fixtures), global setup, fixtures
│  └─ src/
│     ├─ app.ts / server.ts / worker.ts
│     ├─ config/                    # env parsing with zod
│     ├─ lib/                       # prisma, logger, errors, crypto, password, storage, messaging, push, route (ModuleRouter)
│     ├─ middleware/                # authenticate, requireRole, error handler, request id, rate limit
│     ├─ modules/
│     │  ├─ access/                 # hierarchy (reporting tree, approver resolution) + scope (BU + hierarchy visibility)
│     │  ├─ auth/ users/ org/       # login, director user management, business units / regions / depots
│     │  ├─ employees/              # employees, job history, promotion, documents, uploads
│     │  ├─ fleet/ roster/          # vehicles, routes, duty templates, duties
│     │  ├─ attendance/ leave/      # team + self marking, approvals, corrections; leave / OD
│     │  ├─ allowances/ payslips/ tasks/
│     │  ├─ reports/                # attendance muster / exports, dashboard
│     │  ├─ notifications/ settings/ health/
│     │  └─ audit/                  # audit.record + the static audit-coverage check
│     └─ jobs/                      # document expiry, employee exits, leave accrual, purge auth
│        each module: router.ts, service.ts, schemas.ts (zod), controller.ts (optional), *.test.ts / *.int.test.ts
├─ docs/                            # phase-0.md, phase-1.md, phase-2-gap.md, phase-2-progress.md, phase-2-summary.md
└─ mobile/
   ├─ pubspec.yaml
   ├─ assets/branding/logo.png      # company logo (placeholder — replace)
   ├─ tool/gen_api.sh | gen_api.ps1  # regenerate packages/hrms_api from ../api/openapi/openapi.yaml
   ├─ packages/hrms_api/            # generated OpenAPI client package (do not hand-edit)
   └─ lib/
      ├─ main.dart
      ├─ app/                       # router, theme, role shell, destinations, l10n (ARB files in app/l10n)
      ├─ core/                      # api providers + auth interceptor, session (BU switcher), org, storage, errors, widgets
      └─ features/
         ├─ auth/ home/ settings/   # login, role homes, More + My Profile
         ├─ attendance/ requests/   # team / self / approvals; leave & OD + corrections
         ├─ allowances/ payslips/ tasks/ reports/ users/ notifications/
         └─ employees/ documents/ roster/
         each feature: data/, domain/ (optional), presentation/ (screens, widgets, providers)
```

---

## 5. Engineering conventions

### General
- Plan before coding: for any task larger than one file, write a short plan (files to touch, schema changes, tests) and then implement.
- Small, focused commits with conventional messages (`feat(roster): ...`, `fix(payslips): ...`).
- Never commit secrets. All config via env vars validated in `api/src/config`. Provide `.env.example`.
- After every change: run lint, typecheck and the relevant tests. Do not mark work done with failing tests.
- When unsure about a business rule, **do not invent it**: implement it as configuration, add a `// TODO(business): ...` comment, and list it in the task summary.

### API
- REST, JSON, base path `/api/v1`. Plural nouns, kebab-case paths.
- Every route: `authenticate` → `requireRole(...)` → zod validation → controller → service. Business logic lives in services only.
- Scope filtering through the helpers in `api/src/modules/access/scope.ts` (`scopeFor`, `employeeWhere`, `canAccess`, `depotWhere`) used by every service query. Write visibility-matrix tests (PHASE-2-FEATURES §11): at least one allowed and one forbidden case per role.
- Errors: throw typed `AppError(code, httpStatus, message, details?)`; one error middleware returns `{ error: { code, message, details } }`.
- Pagination: cursor-based (`?cursor=&limit=`), default 50, max 200.
- Money: **integer paise** (`BigInt`/`Int` in Prisma), never floats. Format only in the app.
- Time: store timestamps in UTC (`timestamptz`). Business dates (duty date, attendance date, leave dates) are `date` columns interpreted in `Asia/Kolkata`.
- IDs: UUID v7 (or cuid2) strings.
- Every write goes through `audit.record(actor, entity, entityId, before, after)` inside the same transaction.
- Soft delete (`deletedAt`) for employees, vehicles, routes, depots. Hard delete nothing that attendance, leave, allowances, payslips or the audit log reference.
- OpenAPI spec regenerated by `npm run openapi` and committed whenever routes or schemas change; the Flutter client is regenerated from it.

### Effective dating
- `employee_job` is a history table (including the reporting line): `effectiveFrom` (inclusive), `effectiveTo` (exclusive, null = open).
- Never update a past row's values; close the open row and insert a new one, in one transaction.
- Read through `getJobAsOf(employeeId, date)`; the reporting tree for a date comes from these rows (`access/hierarchy.ts`).
- DB constraint: no overlapping ranges per employee (Postgres exclusion constraint using `daterange`, added via raw SQL in a migration).

### Flutter
- Feature-first folders; screens never call dio directly, only providers → repositories → generated client.
- One `AppShell` per role decides the bottom navigation and home screen after login (role comes from `/me`).
- Hiding UI is convenience only; the API is the authority.
- Responsive: phone layout by default, list + detail side by side at ≥ 840 dp width.
- Bulk-first UX for managers: attendance for a whole team must be markable in one screen with "all present" + exceptions.
- All strings in ARB files (English first; structure for Hindi/Tamil later).
- Show clear offline state; queued attendance marks display a "pending sync" badge.

---

## 6. Data model (Prisma, as built in phase 2)

`api/prisma/schema.prisma` is authoritative; this is the map. Most tables have `createdAt`, `updatedAt` and `createdById`.

**Org, users and auth**
- `BusinessUnit`: code (NLS, BMS, MOD, AERO), name, isActive.
- `Region` (optional grouping), `Depot`: regionId, **businessUnitId** (one BU per depot), name, code, state.
- `User` (a login): **employeeId (required, unique)**, name, phone, role (`DIRECTOR | HR | OPERATIONAL_MANAGER | REGIONAL_MANAGER`), isActive, passwordHash (argon2id), passwordChangedAt, failedLoginCount, failedWindowStartedAt, lockedUntil, lastLoginAt.
- `RefreshToken` (HMAC-hashed, rotated, family revocation), `DeviceToken` (FCM).

**Employees**
- `Employee`: empCode (BU prefix + digits, unique case-insensitively), fullName, phone, category (`DRIVER | LOADMAN | CONDUCTOR | HELPER | MECHANIC | DEPOT_STAFF | OFFICE`), employmentType, status, joiningDate, exitDate, statutory ids, panEncrypted, aadhaarLast4, bankAccountEncrypted, ifsc.
- `EmployeeBusinessUnit`: employeeId, businessUnitId, isPrimary (staff exactly one; managers ≥ 1 with exactly one primary; the director none = all).
- `EmployeeJob` (effective-dated): depotId, designation, grade, **reportingToEmployeeId** (the reporting line), effectiveFrom, effectiveTo.
- `Document`, `DocumentRequirement`, `DocumentAlert`.

**Fleet and roster** (depot-based; BU through the depot): `Vehicle`, `Route`, `DutyTemplate`, `Duty`, `DutyAssignment`.

**Attendance**
- `AttendanceMark`: one per employee per date; businessUnitId, status (`PRESENT | ABSENT | HALF_DAY | ON_LEAVE | ON_DUTY | WEEKLY_OFF | HOLIDAY`), approvalState (`PENDING_APPROVAL | APPROVED | REJECTED`), source (`MANAGER | SELF | SYSTEM | …`), approverEmployeeId / approverRole, decidedById / decidedAt, rejectionReason, leaveRequestId, clientMutationId.
- `AttendanceCorrection`: from/to status, reason, status, approver, decision.

**Leave / OD**
- `LeaveType`, `LeavePolicy`, `LeaveBalance`, `LeaveAccrualLog`.
- `LeaveRequest`: kind (`LEAVE | OD`), businessUnitId, leaveTypeId (null for OD), from/to + half-day flags, days, reason, OD location / purpose / times, status, raisedById, approverEmployeeId / approverRole, decision fields.

**Allowances**: `AllowanceType` (code, name, maxAmountPaise?) and `AllowanceRequest` (batchId, beneficiary employeeId, raisedByEmployeeId, businessUnitId, requested / approved amount in paise, dates, comment, voiceNoteKey, receiptKey, status, approver, decision comment / reason).

**Payslips**: `Payslip` (employeeId, period YYYY-MM, businessUnitId, latestVersion, fileKey) and `PayslipVersion` (every uploaded file, HR-visible history).

**Tasks**: `Task` (groupId, date, businessUnitId, title, details, priority, allottedBy, assignee, status `PENDING | COMPLETED | NOT_DONE`, reason, comment, submittedAt, reopen fields).

**Cross-cutting**: `AuditLog` (actor, action, entity, before / after, requestId, ip), `Notification` (in-app feed + push status), `Setting` (typed keys in `settings/registry.ts`).

**Removed in phase 2**: `UserScope`, `OtpChallenge`, `NotificationLog`, the approval engine (`ApprovalRule / ApprovalRequest / ApprovalStep`), `User.isSuperAdmin`, role `OPERATIONAL_HEAD`. **Never built and cancelled**: the payroll engine models (`EmployeePay`, `SalaryStructure`, `PayrollRun`, `PayslipLine`, `StatutoryRate`, `AllowanceRule`, `AttendanceDay`), advances / recoveries and incidents (phase 3 at the earliest).

---

## 7. Business rules

Phase 2 rules are specified in PHASE-2-FEATURES.md §1–§11 and built as summarised in `docs/phase-2-summary.md`. In short:

### Hierarchy, business units and visibility
- Reporting line: driver / loadman → RM → OM → HR → director, validated (next role up, sharing a BU; `422 INVALID_REPORTING_LINE`). Roles change only through an HR / director promotion.
- Every record carries `businessUnitId` (a manager's own records use their primary BU). Access needs the BU match **and** the hierarchy match per the §11 matrix (tested in `access/visibility-matrix.int.test.ts`).
- Approver = the subject's reporting-to at submission; if inactive, any active user of that role sharing the BU, and the director is notified.

### Documents and rostering
- Nightly job marks documents `EXPIRED` when `expiryDate < today` and alerts at 30, 15, 7 and 1 days before expiry (the employee's RM and the HR of their BU).
- **An employee cannot be assigned to a duty on a date when any document required for their category is missing, unverified or expired on that date** (`409 DOCUMENT_INVALID`, spares suggested). Roster warnings (duty-hour cap, rest, weekly off) come from `Setting`.

### Attendance
- RMs mark their drivers / loadmen (final, offline queue, idempotent by `clientMutationId`), editable until 23:59 IST the next day (`attendance.editWindowDays`); afterwards, or after approval, through a correction approved by the next role up.
- RM / OM / HR self-mark → approved by their reporting manager (approve one, approve all, or reject with a reason). The director's attendance is not tracked.
- Approved leave / OD writes `ON_LEAVE` / `HALF_DAY` / `ON_DUTY` marks (source SYSTEM).

### Leave / OD
- RM raises for their drivers and approves in the same step (or saves as pending); managers raise for themselves and their reporting manager approves. Balances are deducted on approval (`leave.balanceEnforcement` BLOCK / WARN); cancelling an approved request restores the balance and removes the marks. Monthly accrual job per `LeavePolicy`.

### Allowances, payslips, tasks, reports
- Allowances: RM for self or team (one request per beneficiary, one batch), OM for self; comment and/or voice note required; approver may change the amount only with a comment.
- **Payslips are produced outside the app and uploaded by HR as `payslip-<empCode>.pdf` (the in-house payroll engine is cancelled).** Re-upload = new version; downloads are signed and audited.
- Tasks: OM allots to direct-report RMs in a shared BU; RM submits Completed / Not done (reason); OM may reopen; overdue = pending after its date.
- Reports: muster + summary (JSON, xlsx, PDF), scoped by §11; every export audited. Load-tested at 1,000 employees × 31 days.

### Privacy and security (DPDP Act 2023; core obligations from 13 May 2027)
- Encrypt PAN and bank account at the application level (AES-256-GCM). Store only the last 4 of Aadhaar.
- Signed, short-lived URLs (≤ 10 min) for documents, voice notes, receipts, payslips and reports.
- Login: argon2id passwords set only by the director; 5 failures in 15 min lock the account for 15 min; rate-limited per IP and per employee ID.
- **Every write is audited** (enforced by `audit/audit-coverage.test.ts`); every read of pay data (payslip download / versions, bank details) and every export is audited too.
- Data retention settings per data type; an HR-only erasure workflow for exited employees after the retention period (not built yet).

---

## 8. API surface (v1, phase 2 — the generated `api/openapi/openapi.yaml` is authoritative)

```
POST   /auth/login (empCode + password)      POST /auth/refresh      POST /auth/logout
GET    /me                                   POST/DELETE /me/devices
GET/POST/PATCH      /users  POST /users/:id/reset-password | /unlock          (director; GET also HR, OM)
GET/POST/PATCH      /business-units, /regions, /depots                        (writes: director)

GET/POST            /employees  GET /employees/next-code?businessUnitId=      (scoped; writes HR / director)
GET/PATCH           /employees/:id   POST /employees/:id/job-changes | /promotion | /business-units | /exit
GET/POST            /employees/:id/documents   POST /documents/:id/verify | /reject   POST /uploads/presign

GET/POST/PATCH      /vehicles, /routes, /duty-templates   GET /roster   POST /duties, /duties/:id/assignments, /roster/copy

GET  /attendance/team?date=   POST /attendance/team/bulk (RM, idempotent by clientMutationId)
POST/GET /attendance/self     GET /attendance/approvals   POST /attendance/:id/approve | /reject, /attendance/approvals/bulk-approve
GET  /attendance/marks        POST/GET /attendance/corrections   POST /attendance/corrections/:id/approve | /reject

GET/POST /leave-requests?scope=mine|team|approvals|all   POST /leave-requests/:id/approve | /reject | /cancel
GET/POST/PATCH /leave-types, /leave-policies   GET /leave-balances?employeeId=

GET/POST/PATCH /allowance-types (HR, director)
GET/POST /allowances?scope=mine|team|approvals|all   POST /allowances/:id/approve | /reject, /allowances/batch/:batchId/approve
GET  /allowances/:id/files    GET /allowances/summary?month= (HR, director)

POST /payslips/upload?period= (HR, multipart)   GET /payslips?scope=mine|team|all&period=
GET  /payslips/:id/download   GET /payslips/:id/versions (HR, director)

POST /tasks (OM)   GET /tasks?scope=allotted|assigned|all   POST /tasks/:id/submit (RM) | /reopen (OM)

GET  /reports/attendance   GET /reports/attendance/export?format=xlsx|pdf   GET /reports/dashboard?businessUnitId=
GET  /notifications   POST /notifications/:id/read | /read-all      GET/PUT /settings
```

---

## 9. App screens by role (phase 2)

- **All:** login (employee code + password, company logo), BU switcher (remembered per user), My Profile, notifications (bell + deep links).
- **Regional manager:**
  - Tabs: Home, Attendance (Team bulk marking with offline queue + My attendance), Leave & OD, Allowances, More.
  - More: Tasks (Allotted / Completed), Payslips, Reports, Employees, Roster.
- **Operational manager:**
  - Tabs: Home, Attendance (My attendance + Approvals of RMs), Leave & OD, Tasks (allot + follow by date), More.
  - More: Allowances (incl. batch approvals), Payslips, Reports, Employees, Roster, Fleet.
- **HR:**
  - Tabs: Home, Attendance (mine + OM approvals), Leave & OD, Payslips (incl. bulk upload), More.
  - More: Allowances (approvals + monthly totals), Tasks, Reports, Employees (onboarding), Verify documents, Roster, Fleet.
- **Director:**
  - Tabs: Home (company dashboard per BU + quick links), Attendance (HR approvals), Reports, Users, More.
  - More: everything else, read-only.

---
## 10. Build plan and definition of done

Each milestone ends with: migrations applied, seed updated, API tests green (including the visibility matrix), OpenAPI and Flutter client regenerated, Flutter analyze + tests green, and a note in `docs/phase-2-progress.md` (phase summaries in `docs/phase-N.md`).

- **Phase 0 — Foundations** (done): monorepo, API skeleton, Prisma, auth, audit log, OpenAPI, Flutter skeleton, CI.
- **Phase 1 — MVP operations** (done): employees, documents, fleet, roster, attendance, leave, notifications.
- **Phase 2 — PHASE-2-FEATURES.md M0–M8** (done 2026-11-10, see `docs/phase-2-summary.md`): roles + reporting line, business units, employee-ID + password login, hierarchical attendance, leave / OD, allowances, PDF payslips, tasks, reports and dashboard, hardening.
- ~~Payroll engine~~ — **cancelled** (decision 2026-11-09): payslips are uploaded PDFs.
- **Phase 3 — Operations depth**: incidents and discipline; training records with expiry; GPS / telematics and biometric import adapters (CSV first) to cross-check attendance; duty-hour / rest enforcement switched to blocks where configured.
- **Phase 4 — Insights**: attrition and OT analytics, fatigue-risk alerts, more Excel exports.

---

## 11. Commands (keep updated)

```
# infra
docker compose up -d

# api
cd api
cp .env.example .env   # then fill in secrets; TEST_DATABASE_URL must differ from DATABASE_URL
npm i                  # also runs `prisma generate` (client → src/generated/prisma)
npm run dev            # API with watch
npm run worker         # BullMQ worker (needs Redis)
npm run job -- document-expiry   # run one job once without Redis (also: employee-exits, leave-accrual, purge-expired-auth)
npm run db:migrate     # prisma migrate dev
npm run db:deploy      # prisma migrate deploy
npm run db:check       # fails if migrations and schema.prisma differ
npm run db:seed        # director DIR001 + business units + allowance types (+ demo org/logins when SEED_DEMO=true; demo password Demo@1234)
npm run openapi        # regenerate openapi/openapi.yaml (openapi:check in CI)
npm run lint && npm run typecheck && npm test   # test = unit + integration (integration needs TEST_DATABASE_URL)
npm run test:unit      # no database needed (includes the audit-coverage check)
npm run test:perf      # load test: attendance report at 1,000 employees × 31 days (test database)
npm run smoke          # end-to-end smoke against a running API with the demo seed (API_URL=… to target another host)

# mobile
cd mobile
./tool/gen_api.sh      # (Windows: .\tool\gen_api.ps1) regenerate packages/hrms_api; needs Node + Java 11+
flutter pub get
flutter gen-l10n
dart run build_runner build
flutter analyze && flutter test
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000/api/v1            # Android emulator
flutter build apk --debug --dart-define=API_BASE_URL=http://<pc-lan-ip>:3000/api/v1   # phone on the same Wi-Fi (debug builds allow plain HTTP)
```

---

## 12. Kickoff prompts (paste one per session)

Phase 0 / 1 prompts are historical (they describe the OTP / depot-scope design that phase 2 replaced). Phase 2 prompts are in PHASE-2-FEATURES.md §14.

**Phase 3 (next)**
> Read CLAUDE.md, PHASE-2-FEATURES.md and docs/phase-2-summary.md. Implement Phase 3 part A: incidents and discipline (RM raises, OM / HR review, BU + hierarchy scope per the §11 pattern, audited, notified), with visibility-matrix tests and Flutter screens.

**Any session**
> Before finishing: run all checks (including `npm run smoke` against a running API), update CLAUDE.md if any decision changed, list every TODO(business) you added, and summarise what is left.

---

## 13. Open business questions (fill in as answered)

Answered for phase 2 (docs/phase-2-gap.md §10): reporting line and multiple BUs per manager (yes, one primary); payroll (cancelled — PDF upload); who approves late attendance corrections (next role up); roster stays depot-based.

Still open (all built as settings / `TODO(business)`, listed in docs/phase-2-summary.md):
- Fleet types and headcount; who edits roster and fleet (Q7); bank-detail privacy (Q8).
- Attendance edit window length; leave types, quotas, accrual details, sandwich rule, cross-year leave.
- Allowance types and limits; how far ahead tasks may be allotted; payslip upload for future months.
- Password policy; present-% formula; report range limit and file retention.
- Payslip notice channel and WhatsApp/SMS provider; integrations (biometric, GPS / telematics, Tally, bank file format).

---

## 14. Decisions log

- Stack: Flutter (single app) + Express/TypeScript + Prisma + PostgreSQL + BullMQ/Redis.
- Only four login roles use the app (phase 2: director, HR, OM, RM); drivers and field staff are records, not users.
- One mobile app, no separate web front end.
- Hosting in an Indian cloud region.
- 2026-11-09 (phase 0) Versions: Express 5, zod 4 (+ @asteasolutions/zod-to-openapi 8), Prisma 7 (driver adapter `@prisma/adapter-pg`, `prisma.config.ts`, client generated into `api/src/generated/prisma`, git-ignored), TypeScript 5.9 (typescript-eslint does not support TS 7 yet), Vitest 4, ESLint 10. Flutter 3.47 / Dart 3.13, Riverpod 3 (riverpod_generator 4), freezed 4, go_router 18.
- 2026-11-09 Routes are declared with `ModuleRouter.route({...})` (`api/src/lib/route.ts`), which enforces authenticate → requireRole → zod validation → handler and registers the route in the OpenAPI registry. Do not register Express routes directly.
- 2026-11-09 The generated Flutter client lives in `mobile/packages/hrms_api` (a path package) instead of `mobile/lib/api`, because dart-dio generates a full package with its own pubspec and build_runner step. Generated code (client, `*.g.dart`, `*.freezed.dart`, l10n) is committed; CI regenerates it and fails on diff.
- 2026-11-09 (superseded in phase 2: OTP removed, login = employee ID + password; scopes = BU + hierarchy) Auth: access JWT (HS256, 15 min) + opaque refresh token (30 days) rotated on every refresh; re-use of a rotated token revokes the whole session family. OTPs and refresh tokens are stored as HMAC-SHA256 with `TOKEN_HASH_PEPPER`. OTP request always answers 202 (no account enumeration). The authenticated user and scopes are re-read from the DB on every request, so deactivation and scope changes apply immediately.
- 2026-11-09 Integration tests (`*.int.test.ts`) run against `TEST_DATABASE_URL` only (tables are truncated) and refuse to run if it equals `DATABASE_URL`.
- 2026-11-09 (phase 1; superseded by BU + hierarchy scope in phase 2) Employee scope = a current **or upcoming** job row (`effectiveTo` null or after today, IST) at a depot in scope: managers see staff transferring in, and stop seeing them once a transfer out or an exit takes effect. Tables with a `depotId` column but no depot relation (approval/leave requests, attendance marks) are scoped with `depotIdsInScope` + `depotIdFilter`.
- 2026-11-09 Business dates in the API are plain `YYYY-MM-DD` strings (`IsoDate`, no `format: date`) so the Dart client never shifts them through a timezone.
- 2026-11-09 Document storage has two drivers: `s3` (MinIO / AWS S3) and `local` (files under `api/.storage`, HMAC-signed URLs served by the API at `/api/v1/storage/local/*`, dev only, refused in production). The local routes are the one deliberate exception to "routes only via ModuleRouter" (raw bodies, signature-authorised, not part of the API spec).
- 2026-11-09 Push uses FCM HTTP v1 directly (service-account JWT via `jose`, no firebase-admin) behind a `PushService` interface; `PUSH_PROVIDER=console` in dev. Every notice is also stored in `NotificationLog`, which doubles as the manager's in-app feed (`GET /notifications`).
- 2026-11-09 Business numbers (roster caps, rest minutes, edit window, alert days, escalation chain, role→category mapping) are typed `Setting` keys with defaults in `api/src/modules/settings/registry.ts`; all defaults are `TODO(business)`.
- 2026-11-09 Approval engine: steps for the raiser's own role are skipped (`approvals.skipStepsOfRaiserRole`, default true); nobody can decide a request they raised; escalation notifies the next role up once and does not re-route the step.
- 2026-11-09 Attendance bulk API applies and reports each mark independently (APPLIED / DUPLICATE / REJECTED) so one bad mark never blocks an offline batch. One manager mark per employee/day/source; a replayed `clientMutationId` is a no-op.
- 2026-11-09 Jobs can be run once without Redis: `npm run job -- <name>` (same processors as the worker).
- 2026-11-09 Flutter repositories return the generated `hrms_api` models directly; app-side domain classes exist only where the app adds logic (session, offline queue). Navigation has per-role bar destinations plus secondary destinations opened from More (`secondaryDestinationsFor`); the router allows both.
- 2026-11-09 (phase 2) PHASE-2-FEATURES.md supersedes the earlier spec where they differ (decisions Q1–Q8 in `docs/phase-2-gap.md` §10). Roles DIRECTOR / HR / OPERATIONAL_MANAGER / REGIONAL_MANAGER; `OPERATIONAL_HEAD`, `isSuperAdmin`, `UserScope`, OTP login and the rule-based approval engine are removed. The in-house payroll engine is cancelled (payslips are uploaded PDFs).
- 2026-11-09 Login = employee code (case-insensitive, BU prefix + digits) + argon2id password. 5 failures in 15 min lock the account for 15 min (423 `ACCOUNT_LOCKED`, `details.minutes`). Only the director sets and resets passwords; a reset revokes all sessions.
- 2026-11-09 Visibility = BU match + hierarchy match, computed in `api/src/modules/access/scope.ts` from the effective-dated reporting line (`EmployeeJob.reportingToEmployeeId`, recursive CTE) with a depth per role and feature. Every phase-2 record stores `businessUnitId`; a manager's own records use their primary BU, and reports list people by primary BU.
- 2026-11-09 Approvals are per record (`approverEmployeeId` + `approverRole`, resolved from the reporting line at submission). If that approver is inactive, any active user of the same role in the BU may decide, and the director is notified.
- 2026-11-09 `ModuleRouter.route` has an `upload` option (multer, in memory, after authentication, field `files` or `files[]`) documented as `multipart/form-data`; used by `POST /payslips/upload`. Storage gained `putObject` for server-written files (payslips, report exports).
- 2026-11-09 Report downloads are a separate endpoint (`GET /reports/attendance/export?format=xlsx|pdf`, exceljs / pdfkit) returning a signed URL, so the Dart client keeps one response type per operation. Payslip PDFs and receipts open in the device viewer via signed URLs (no embedded PDF plugin yet).
- 2026-11-09 Flutter: the selected business unit is remembered per user in secure storage (`Preferences`); voice notes use `record` (AAC, ≤ 2 min) and `just_audio`; HR picks payslip PDFs with `file_picker` and uploads in batches of 25. The theme gives filled buttons full width, so use text/outlined buttons (or `Expanded`) inside `ListTile.trailing` and `Row`s.
- 2026-11-10 (M8) The §11 visibility matrix lives in one suite (`access/visibility-matrix.int.test.ts`: every row × role, one allowed and one forbidden case each), seeded once through the API.
- 2026-11-10 Audit coverage is enforced statically: `audit/audit-coverage.test.ts` parses services, jobs and lib with the TypeScript compiler API and fails on any Prisma write whose top-level function does not call `audit.record` (opt-outs: `audit: by-caller` / `audit: exempt` comments; log / session tables are exempt by model), and on raw SQL writes. Leave-balance movements are audited individually (`leaveBalance.open`, `leaveBalance.adjust` with a reason).
- 2026-11-10 Load test: `npm run test:perf` (separate vitest project) seeds 1,000 staff × 31 days of marks; budgets JSON 3 s, xlsx 15 s, PDF 20 s, dashboard 3 s. Measured on the dev laptop: JSON 0.3 s, xlsx 0.5 s, PDF 1.1 s, dashboard 0.5 s.
- 2026-11-10 `npm run smoke` drives the main flows end to end (every role logs in; attendance, leave, allowance, task, payslip upload + download, report exports, visibility spot checks) against a running API with the demo seed.
- 2026-11-10 Flutter UI: themed Material 3 (rounded filled inputs, tonal cards, hero header on Home, app-bar avatar → My Profile with app version, sign-out confirmation). Spec wording for login errors and the password note. Gradle heap lowered to 2 GB (the 8 GB template default got builds killed on the 8 GB dev machine); `RECORD_AUDIO` permission added for voice notes.
