# Phase 1 — MVP operations (2026-11-09)

Status: **parts A, B and C are built.** All definition-of-done checks pass locally. CI has still not run (the repo is not under git yet).

| Check | Result |
| --- | --- |
| Migrations `phase1a_employees_documents`, `phase1b_fleet_roster`, `phase1c_attendance_leave_approvals` applied (`hrms`, `hrms_test`) | ✅ |
| `npm run db:check` | ✅ no drift |
| `npm run db:seed` (idempotent) | ✅ |
| API lint / typecheck | ✅ |
| API tests (`npm test`) | ✅ 120 passed (17 files: unit + integration, including scope isolation for every new entity) |
| `npm run openapi:check` | ✅ 70 paths |
| Flutter client regenerated (`tool/gen_api`) | ✅ |
| `flutter analyze` / `flutter test` | ✅ no issues / 32 passed |
| `flutter build web --debug` | ✅ compiles |
| Live smoke test against `npm run dev` (scripted HTTP) | ✅ see below |

The smoke test covered: OTP login → create a duty from a template → 409 `DOCUMENT_INVALID` with spares → assign a valid driver → bulk attendance and a replay (`DUPLICATE`) → presign → upload → document create → HR verify (the employee becomes rosterable) → leave → RM inbox → approve. Approving the leave unfilled the duty, notified the operational manager and pre-filled the attendance as `ON_LEAVE`. A Bengaluru manager reading a Pune employee gets 404. The smoke test left a few demo rows in the dev database.

## What was built

### Part A — employees and documents
- **Admin APIs:**
  - `/regions`, `/depots` (list scoped; create, update and archive need the super admin; archiving is refused while staff are assigned).
  - `/users` (list: HR; create/update: super admin), `PUT /users/:id/scopes` (scope rules are role-specific; you cannot lock yourself out; deactivating a user revokes their sessions).
- **Employees:**
  - `Employee`, with PAN and bank account AES-encrypted and Aadhaar kept as the last 4 digits only (enforced by a DB check).
  - `EmployeeJob` history with three guards: a `daterange` **exclusion constraint** (no overlapping rows), a range check, and at most one open row.
  - `getJobAsOf()` returns the job on a date. Job changes close the open row and insert a new one. Exit closes the job row the day after the last working day and sets the status to `ON_NOTICE` (or `EXITED` if the date has passed).
  - Bank details are HR only, masked, and every read is audited.
- **Scope:** `scopeWhere(user, 'employee')`. An employee is visible while they have a current or upcoming job row at a depot in scope.
- **Documents:**
  - Upload: `POST /uploads/presign`, PUT to the signed URL, then `POST /employees/:id/documents`. The file key must belong to that employee and the file must exist.
  - Reading: `GET /documents` (verification queue), `/documents/expiring`, `/documents/:id/file-url` (signed URL, ≤ 10 min).
  - HR actions: `verify` (can correct the expiry date) and `reject` (notifies whoever captured the document).
  - Required documents per category: `DocumentRequirement` and `GET/PUT /document-requirements`. The seed requires DL, PSV badge and medical for drivers.
  - Compliance: per type `VALID / EXPIRING / UNVERIFIED / EXPIRED / REJECTED / MISSING`; per employee a worst-of `overall` and `rosterable`.
- **Storage:**
  - The `s3` driver works with MinIO or AWS.
  - The `local` driver (dev only) serves HMAC-signed URLs from the API. This machine has no MinIO, so `.env` uses `STORAGE_DRIVER=local`.
- **Nightly jobs:**
  - `document-expiry` marks documents `EXPIRED`. It sends alerts at 30/15/7/1 days (from `Setting`), once per threshold and only the nearest one if a night was missed. It skips renewed documents and exited staff, and sends one digest per recipient (reporting OM, or the depot's OMs, plus HR).
  - `employee-exits` moves `ON_NOTICE` employees to `EXITED`.
- **Notifications:** `NotificationLog` doubles as the in-app feed (`GET /notifications`, mark read). FCM HTTP v1 push goes to registered devices (`POST /me/devices`). In dev the push adapter only logs.
- **Settings:** typed keys with defaults (`GET /settings`, `PUT /settings/:key`, editable by HR and the operational head per key).

### Part B — fleet and roster
- **Fleet:** `/vehicles`, `/routes`, `/duty-templates` (scoped CRUD; templates may cross midnight).
- **Duties:** `POST /duties` from a template or explicit IST times; `PATCH /duties/:id` (times, vehicle, route, status). A vehicle cannot be double-booked.
- **Roster day:** `GET /roster?depotId=&date=` returns duties with crew, vehicle, route, and filled/unfilled counts.
- **`POST /duties/:id/assignments`** checks, in order:
  - status and depot as of the duty date, and role → category (`Setting`);
  - **approved leave → 409 `EMPLOYEE_ON_LEAVE`**;
  - **documents on that date → 409 `DOCUMENT_INVALID`**, with the failing documents and up to 5 spares;
  - overlaps → 409 `EMPLOYEE_DOUBLE_BOOKED`;
  - rest rules from `Setting`: daily duty-hour cap, minimum rest across midnight, and no weekly off in N days. Each rule is `WARN` (the warnings are returned and stored on the assignment) or `BLOCK` (409 `ROSTER_RULE_VIOLATION`).
  - Assignments are serialised per employee (row lock).
- **Other roster endpoints:**
  - `GET /roster/spares`: the right category, valid documents, not on leave, free at that time; least-worked first, with any warnings.
  - `POST /roster/copy`: copies a day or a week with crew. It is idempotent per duty and reports crew it skipped, with the reason.

### Part C — attendance, leave, approvals
- **Approval engine:**
  - Rules with a safe JSON condition (`eq/ne/gt/gte/lt/lte/in/nin`, no eval); the most specific matching rule wins.
  - Steps are materialised from the rule; steps for the raiser's own role are skipped (configurable); nobody can decide their own request; decisions take a row lock.
  - Approvers are users of the step's role whose scope covers the depot. They get a push when a step opens.
  - Handlers run inside the decision transaction.
  - Endpoints: `GET /approvals/inbox`, `GET /approvals?mine=true`, `/approvals/:id`, `approve` / `reject` (reject needs a comment) / `cancel`, `GET/POST/PATCH /approval-rules`.
  - The hourly `approval-escalation` job reminds the current approvers and notifies the next role up, once.
- **Attendance:**
  - `GET /attendance?depotId=&date=` pre-fills `PRESENT` for rostered staff and `ON_LEAVE` / `HALF_DAY` for approved leave.
  - `POST /attendance/bulk` is idempotent per `clientMutationId` and reports each mark as `APPLIED` / `DUPLICATE` / `REJECTED`.
  - The edit window runs until 23:59 IST of date + N (`Setting`).
  - `POST /attendance/corrections` creates an approval; approving it applies the mark.
- **Leave:**
  - Types, with an accrual rule of `MONTHLY`, `ANNUAL` or `NONE`, and carry-forward.
  - Policies (category / employment type / state; the most specific wins).
  - Balances (carry-forward when a new year's row is created).
  - Requests: half days; checks against the balance minus pending days and against overlaps.
  - On approval: balance `used`, the employee is removed from duties on fully covered days, and the OM is notified.
  - The monthly `leave-accrual` job is idempotent through `LeaveAccrualLog`.
- **Dashboard:** `GET /reports/dashboard` returns scoped KPIs for each role's home cards plus a per-depot breakdown.
- **Run without Redis:** `npm run job -- <name>` runs any job once.

### Mobile
- **Navigation:** each role has a navigation bar (max 5) plus secondary screens in More (`secondaryDestinationsFor`). The router guard allows both. The HR bar is now Home, Employees, Verify, Approvals, More; Payroll moved to More until phase 2.
- **Employees:**
  - Paged list with search and a compliance filter; list and profile side by side at ≥ 840 dp.
  - Profile: compliance, documents (view the signed file), job history; HR can change job or record an exit.
  - Document capture: camera or gallery → presign → upload → pending verification. Aadhaar takes the last 4 digits only.
  - HR onboarding wizard (stepper), and an HR verification queue (preview the scan, verify with an optional expiry correction, or reject with a reason).
- **Roster:**
  - Day view per depot with a date stepper, defaulting to tomorrow.
  - Add a duty from a template or custom times; the duty sheet shows the crew and lets you assign any role or cancel the duty.
  - Assigning offers spare suggestions plus all employees. 409 `DOCUMENT_INVALID` shows the failing documents and the API's spares inline; warnings appear after a successful assignment.
  - "Copy previous day" shows a summary of what was skipped.
  - Fleet screen: vehicles, routes, templates.
- **Attendance:**
  - Bulk screen: rostered and leave rows pre-filled, "All present", exceptions by chip, one submit.
  - Marks go into a **drift (SQLite) queue** first, then sync. Offline and failed banners and per-row "Pending sync" badges show the state. Retries run every 30 s and on pull-to-refresh.
  - A newer mark replaces a queued one for the same employee and day. Rejected marks are shown until dismissed.
  - Once the window has closed, rows are read-only with "Request correction".
- **Requests:** my requests (status and steps, withdraw); leave form (employee search, balance shown); correction form. The approvals inbox supports swipe right to approve and swipe left to reject with a required comment.
- **Home and notifications:** home cards show live dashboard data and tap through. The depot comparison screen is for RM and head. A notification bell with an unread badge opens the feed, which deep-links to its target.
- **Generated client changes:** `IsoDate` nullability fixed in the spec, and no list/map `default`s (the dart-dio generator emits non-const defaults; a test now guards this).
- **iOS:** camera and photo-library usage strings added.

## Open TODOs added in this phase
- **TODO(business)** — all Setting defaults (`api/src/modules/settings/registry.ts`):
  - daily duty cap of 600 min;
  - minimum rest of 480 min;
  - 6 consecutive work days;
  - all rules WARN;
  - role → category map;
  - edit window of 1 day;
  - escalation chain;
  - skipping the raiser's own-role step.
- **TODO(business)** — required documents for conductors, helpers, mechanics and depot staff (`employees/constants.ts`). Only DRIVER is seeded.
- **TODO(business)** — whether AADHAAR may be a required document type at all (`documents.service.ts`).
- **TODO(business)** — fleet types (`Vehicle.type` is free text); who may edit fleet master data and the roster (`fleet/router.ts`, `roster/router.ts`).
- **TODO(business)** — required crew per duty: "filled" currently means a driver is assigned (`roster/schemas.ts`); borrowing staff across depots (`roster/service.ts`).
- **TODO(business)** — leave:
  - the sandwich rule (weekly offs and holidays inside a leave);
  - leave that crosses calendar years (currently refused);
  - accrual proration and rounding.

  Files: `leave/service.ts`, `jobs/leave.ts`.
- **TODO(business)** — demo leave types and quotas (CL 8, SL 7, EL 15, LOP), and the demo rule "more than 3 days also needs HR". They are seeded only when `SEED_DEMO=true`.
- **TODO(business)** — the attendance % definition on the head's dashboard (`reports/service.ts`).
- **TODO(phase 2)** — refuse attendance marks inside a LOCKED payroll period (`attendance/service.ts`).

## Known gaps / left for later
- **Flutter FCM registration** is not wired: it needs a Firebase project (`google-services.json`, `firebase_messaging`). The API side is ready (`POST /me/devices`, FCM adapter). Until then managers get notifications through the in-app feed.
- **Admin screens** for users, regions, depots, settings, leave policies and approval rules exist only as APIs (HR / super admin). No Flutter UI yet.
- **Flutter web + drift:** `mobile/web/sqlite3.wasm` (sqlite3 3.5.2) and `drift_worker.js` (drift 2.35.4) are committed; update them when those packages are upgraded.
- **pg warning in tests:** pg logs a deprecation warning about concurrent queries in some integration tests. It comes from Prisma's own query interpreter (nested create/include inside an interactive transaction), not from our code.
- **Worker:** still needs Redis on this machine; use `npm run job -- <name>` instead.
