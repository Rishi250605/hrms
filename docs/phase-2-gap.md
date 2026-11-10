# Phase 2 — Gap analysis (M0, 2026-11-09)

Compares the code as of Phase 1 (`docs/phase-1.md`) with `PHASE-2-FEATURES.md` ("the spec"). The spec wins where the two disagree. No application code was changed for M0.

Legend:
- ✅ exists and fits
- 🔧 exists, must change
- ➕ new
- ❌ remove

---

## 0. The five big shifts (read these first)

1. **The hierarchy is inverted.** Phase 1 has RM *above* OM:
   - the operational head approves, the RM is region-scoped and approves, and the OM is depot-scoped, marks attendance and raises requests.

   Phase 2 has OM *above* RM:
   - DIRECTOR → HR → OM → RM. The RM now marks driver attendance and raises requests (the job of today's OM). The OM approves the RM (the job of today's RM).

   So today's role *names* map onto the opposite responsibilities. Every role guard, the seed, the scope tests and the Flutter shells are affected (blocking question Q1).
2. **Scope moves from geography to business unit plus reporting line.**
   - Today: region/depot scope (`UserScope`, `scopeWhere`, `depotIdsInScope`).
   - Spec: the record's `businessUnitId` must be in the user's BUs **and** the subject must be the user or below them in the reporting tree (`canAccess`).

   Depots and regions are not mentioned in the spec, but roster, fleet and documents depend on them (Q2).
3. **Every login is an employee.**
   - Today: `User` is separate and `User.employeeId` is optional. Seeded managers have no `Employee` row and no `empCode`.
   - Spec: you log in with `Employee.empCode`, and `reportingToId` points employee → employee. Every user therefore needs an `Employee` row and an empCode (Q3).
4. **OTP is replaced by empCode + password**, with passwords set by the director and a lockout after failed attempts. JWT and refresh-token rotation stay.
5. **Approval routing becomes reporting-line based.**
   - Today: a generic rule engine whose steps name a *role*, resolved to whoever covers the depot. Self-approval is blocked.
   - Spec: the approver is the subject's `reportingTo`, with a fallback to the same role in a shared BU plus a note to the director. An RM both raises and approves driver leave, which today's engine forbids (Q5).

There is no production data: the app has never been deployed, and only the dev database (`hrms`) holds seed and demo rows. The migration plan in §7 is still written for real data, as the spec asks. §7.0 also offers a "reset and reseed" path for dev.

---

## 1. Roles and users

| Item | Today | Required | Gap |
| --- | --- | --- | --- |
| `Role` enum | `OPERATIONAL_MANAGER, REGIONAL_MANAGER, OPERATIONAL_HEAD, HR` | `DIRECTOR, HR, OPERATIONAL_MANAGER, REGIONAL_MANAGER` | 🔧 add `DIRECTOR`; ❌ `OPERATIONAL_HEAD` (the migration stops if any user still holds it) |
| Super admin | `User.isSuperAdmin` (HR only) gates org/user admin | the `DIRECTOR` role | 🔧 drop the column after converting (Q4); `requireSuperAdmin` becomes `requireRole('DIRECTOR')` |
| Login identity | `User.phone` (E.164, unique) | `Employee.empCode`, unique and case-insensitive | 🔧 every user links to an employee (`User.employeeId` becomes required); add a case-insensitive unique index on `lower(emp_code)` |
| Employee categories | DRIVER, CONDUCTOR, HELPER, MECHANIC, DEPOT_STAFF, OFFICE | + `LOADMAN` | ➕ enum value; flows cover only DRIVER and LOADMAN |
| Reporting line | `EmployeeJob.reportingUserId` → **User**, effective-dated, "operational manager" | `reportingToId` → **Employee** with a login, one role up, sharing a BU; `422 INVALID_REPORTING_LINE` | 🔧 Recommendation: keep it effective-dated on `EmployeeJob` (CLAUDE.md §5) as `reportingToEmployeeId`, with "current" resolved via `getJobAsOf` (Q6) |
| Users with an inactive approver | — | fall back to any active user of the same role sharing the BU, and notify the director | ➕ resolver function |

Where `OPERATIONAL_HEAD` / `isSuperAdmin` appear today (all need changes):
- **API:** `middleware/{scope,requireRole,authenticate}.ts`, `lib/context.ts`, `modules/users/*`, `modules/settings/registry.ts` (9× `editableBy`), `approvals/router.ts`, `employees/router.ts`, `notifications/service.ts` (`usersCoveringDepot`), `prisma/seed.ts`, and tests (`requireRole`, `scope`, `auth`, `leave`, `roster`).
- **Flutter:** `app/destinations.dart`, `core/labels.dart`, `features/auth/domain/current_user.dart`, `home_screen.dart`, `more_screen.dart`, `test/support/fakes.dart`, `router_redirect_test.dart`.

## 2. Authentication

| Item | Today | Required | Gap |
| --- | --- | --- | --- |
| Endpoints | `POST /auth/otp/request`, `/auth/otp/verify`, `/auth/refresh`, `/auth/logout` | `POST /auth/login {empCode, password}`, keep `refresh` / `logout` | ❌ OTP endpoints; ➕ login |
| Models | `OtpChallenge` | `User.passwordHash`, `passwordChangedAt`, `failedLoginCount`, `failedWindowStart`, `lockedUntil` (or a `LoginAttempt` table) | ❌ `otp_challenges` (after the code is gone); ➕ columns |
| Hashing | HMAC for OTP / refresh tokens (`TOKEN_HASH_PEPPER`) | argon2id (or bcrypt cost ≥ 12) for passwords; HMAC stays for refresh tokens | ➕ `argon2` package (native build: add to `allowScripts` in `package.json`; fall back to `bcryptjs` if the prebuilt binary fails on Windows) |
| Lockout | OTP: 5 attempts per challenge | 5 failures in 15 min → locked 15 min; the director can unlock | ➕ |
| Rate limits | `otpRequestIpLimiter`, `otpRequestPhoneLimiter`, `otpVerifyLimiter` | a login limiter per IP and per empCode | 🔧 |
| Tokens | Access JWT (15 min) + rotating refresh, family revocation; user re-read on every request | same; password reset or deactivate revokes all refresh tokens | ✅ (deactivate already revokes) / 🔧 reset |
| Director user management | `POST/PATCH /users`, `PUT /users/:id/scopes` (super admin) | create user (empCode, name, role, phone, reportingTo, BUs, initial password), reset password, unlock, deactivate / reactivate | 🔧 |
| Env / config | `OTP_*`, `OTP_DEV_FIXED_CODE`, the `MessagingService` used for OTP SMS | drop the OTP vars; keep `MessagingService` (unused for login; may serve payslip notices later) | 🔧 `env.ts`, `.env.example`, `env.test.ts` |
| Login screen | 2-step phone → OTP with resend countdown (`login_screen.dart`, `login_controller.dart`) | logo, Employee ID, password with show/hide, Sign in, "Forgot password? Contact your Director.", inline lock message with minutes | 🔧 rewrite; ➕ `assets/branding/logo.png` placeholder plus a `pubspec.yaml` assets entry |
| `GET /me` | profile, role, region/depot scope | + empCode, reporting-to (name, empCode, role), BUs with primary | 🔧 |

## 3. Business units and scope

| Item | Today | Required | Gap |
| --- | --- | --- | --- |
| BU model | none | `BusinessUnit(id, name, code)`, seed NLS / BMS / MOD / AERO, editable by the director | ➕ |
| Membership | `UserScope(regionId \| depotId)` per user | `EmployeeBusinessUnit(employeeId, businessUnitId, isPrimary)`: driver/loadman exactly 1; RM/OM/HR ≥ 1 with exactly one primary; director implicitly all | ➕ plus DB checks (one primary per employee; a partial unique index on `isPrimary`) |
| Scope helper | `scopeWhere(user, 'region'\|'depot'\|'depotOwned'\|'employee')`, `canAccessDepot`, `depotIdsInScope` | `canAccess(user, subjectEmployee, businessUnitId, feature)` plus a Prisma `where` builder: BU match + hierarchy match per feature (§11 matrix) | 🔧 replace. Reporting-tree descendants need a recursive CTE (or a materialised closure table) |
| `businessUnitId` on records | not present (records carry `depotId`) | non-null on attendance, leave/OD, allowances, payslips, tasks, notifications, report rows | 🔧 + backfill (§7) |
| List filters | `depotId` filters on some lists | optional `businessUnitId` on every list | 🔧 |
| Depots / regions | central to roster, fleet, attendance scoping, PT/LWF state | not mentioned | **Q2** |
| Flutter | `DepotSelector` (`core/widgets/depot_selector.dart`), `SelectedDepot` provider | BU switcher in the app bar ("All my BUs" + each BU), persisted locally per user | 🔧 / ➕ (`shared_preferences` is not a dependency yet; drift or secure storage would also work) |

## 4. Data model — module by module

| Model | Status | Change |
| --- | --- | --- |
| `Region`, `Depot`, `UserScope` | 🔧 / ❓ | Q2. If depots stay as places: `Depot.businessUnitId` (or a many-to-many). `UserScope` becomes obsolete once BU + reporting-line scope lands |
| `User` | 🔧 | `employeeId` required + unique; password / lockout columns; drop `isSuperAdmin` |
| `OtpChallenge` | ❌ | drop table |
| `RefreshToken`, `AuditLog`, `Setting`, `DeviceToken` | ✅ | `Setting.editableBy` roles change |
| `NotificationLog` | 🔧 | Spec wants `Notification(recipientUserId, type, title, body, entityType, entityId, businessUnitId, readAt)`. Recommendation: add `Notification` for the in-app feed and keep `NotificationLog` as the delivery (push/SMS) log; migrate existing feed rows |
| `Employee` | 🔧 | `LOADMAN` category; case-insensitive `empCode`; BU membership |
| `EmployeeJob` | 🔧 | `reportingUserId` (User) → `reportingToEmployeeId` (Employee) with validation (Q6) |
| `Document*` | 🔧 | stay; scope through the subject employee's BU + hierarchy |
| `Vehicle`, `Route`, `DutyTemplate`, `Duty`, `DutyAssignment` | 🔧 | stay; need `businessUnitId` (directly or via depot) — Q2; who rosters under the new roles — Q7 |
| `AttendanceMark` | 🔧 | ➕ `businessUnitId`, `approvalStatus` (PENDING_APPROVAL / APPROVED / REJECTED), `approvedById`, `decidedAt`, `rejectionReason`, `markedById` = self for self-marks; status `ON_DUTY_OUTSTATION` → `ON_DUTY`; still one record per employee per date (today unique per employee + date + source — keep, since only MANAGER-source marks exist) |
| `AttendanceCorrection` | 🔧 | approved by the next role up via the reporting line, not by rules |
| `LeaveType`, `LeavePolicy`, `LeaveBalance`, `LeaveAccrualLog` | ✅ / 🔧 | keep (§5.1 "keep balances, deduct on approval"); balance enforcement block-vs-warn becomes a setting; types editable by HR + director; `/leave/types` → `/leave-types` |
| `LeaveRequest` | 🔧 | ➕ `kind` (LEAVE / OD), `odLocation`, `odPurpose`, `odFromTime`, `odToTime`, `businessUnitId`, `approverEmployeeId`, `decidedById`, `rejectionReason`; subjects may now be managers; the "submit and approve" path; `leaveTypeId` nullable for OD |
| `ApprovalRule`, `ApprovalRequest`, `ApprovalStep` | 🔧 / ❓ | Q5: either extend with reporting-line steps or replace with per-entity approval columns |
| Allowances | ➕ | `AllowanceType`, `AllowanceRequest(batchId, raisedById, beneficiaryEmployeeId, businessUnitId, typeId, requestedAmountPaise, approvedAmountPaise, fromDate, toDate, comment, voiceNoteKey, receiptKey, status, approverEmployeeId, decidedById, decisionComment)` |
| Payslips | ➕ | `Payslip(employeeId, period YYYY-MM, businessUnitId, currentVersion)` + `PayslipVersion(payslipId, version, fileKey, sizeBytes, uploadedById)`. The CLAUDE.md payroll engine models (`SalaryStructure`, `PayrollRun`, `StatutoryRate`, …) were never built and are now cancelled |
| Tasks | ➕ | `Task(date, businessUnitId, title, details, priority, allottedById, assignedToEmployeeId, status PENDING / COMPLETED / NOT_DONE, reason, comment, submittedAt, reopenedAt, reopenComment)` |

## 5. API surface

| Spec route | Today | Gap |
| --- | --- | --- |
| `POST /auth/login` | OTP routes | ➕ / ❌ |
| `GET /me` (+ reporting-to, BUs) | exists | 🔧 |
| Director user management (create, reset password, unlock, deactivate) | `/users` CRUD + scopes | 🔧 |
| `GET /attendance/team`, `POST /attendance/team/bulk` | `GET /attendance?depotId&date`, `POST /attendance/bulk` (idempotent, per-item results) | 🔧 rename and re-scope (RM's own drivers/loadmen + BU); logic reusable |
| `POST /attendance/self`, `GET /attendance/self` | — | ➕ |
| `GET /attendance/approvals`, `POST /attendance/:id/approve\|reject`, `POST /attendance/approvals/bulk-approve` | — (`/attendance/corrections` via the engine) | ➕ |
| `POST /leave-requests` (+ `autoApprove`), `GET /leave-requests?scope=…`, approve / reject / cancel | `/leave/requests` (+ cancel), decisions via `/approvals/:id/*` | 🔧 move to `/leave-requests` with `scope=mine\|team\|approvals\|all` |
| `GET/POST/PATCH /leave-types` | `/leave/types` | 🔧 path + roles |
| `/allowances`, `/allowances/:id/approve\|reject`, `/allowances/batch/:batchId/approve`, `/allowance-types` | — | ➕ |
| `POST /uploads/presign` (+ audio/m4a, audio/aac, image/jpeg) | exists (jpeg/png/webp/pdf; purposes DOCUMENT / PHOTO) | 🔧 add purposes VOICE_NOTE / RECEIPT and audio types; key prefix per subject |
| `POST /payslips/upload?period=` (multipart), `GET /payslips`, `/payslips/:id/download`, `/payslips/:id/versions` | — | ➕ the first multipart route: `multer` + PDF magic-byte check; `ModuleRouter` needs a way to declare a multipart body for OpenAPI |
| `/tasks`, `/tasks/:id/submit`, `/tasks/:id/reopen` | — | ➕ |
| `GET /reports/attendance?format=json\|xlsx\|pdf` | — | ➕ (`exceljs`, `pdfkit`), signed URL delivery, audited |
| `GET /reports/dashboard?businessUnitId=` | exists (role KPIs) | 🔧 director BU cards; the other roles' small homes |
| Notifications (bell, list, read) | `GET /notifications`, read, read-all, `POST /me/devices` | ✅ endpoints / 🔧 backing table + `entityType` / `entityId` deep links |
| `/regions`, `/depots`, `/vehicles`, `/routes`, `/duty-templates`, `/roster`, `/duties`, `/documents`, `/employees` | exist | 🔧 BU scope; role guards (Q2, Q7) |
| `/approvals`, `/approval-rules` | exist | ❓ Q5 |
| `/settings` | exists | 🔧 `editableBy` → HR / DIRECTOR; new keys (attendance window already exists; leave balance enforcement; allowance per-type maximum; payslip max size) |

## 6. Flutter

| Area | Today | Required | Gap |
| --- | --- | --- | --- |
| Roles / shell | `UserRole` {operationalManager, regionalManager, operationalHead, hr}; per-role nav (≤ 5) + secondary destinations | {director, hr, operationalManager, regionalManager} | 🔧 RM needs Home, Attendance, Requests, Allowances, Tasks, Payslips, plus Roster? → more than 5 tabs, so the extras go in More |
| Login | phone + OTP | empCode + password + logo | 🔧 rewrite; delete `phone.dart` OTP helpers (keep phone formatting) |
| My Profile | `MoreScreen` shows profile + scope | avatar → My Profile (empCode, reporting-to, BU chips, app version, password note, sign out) | 🔧 (app version needs `package_info_plus`) |
| BU switcher | `DepotSelector` | app-bar BU selector, persisted | 🔧 |
| Attendance | RM-style bulk screen (built for today's OM), drift offline queue, sync banner | RM team marking (reuse) + "My attendance" card for RM / OM / HR + approvals list (approve all / one / reject with reason) | 🔧 / ➕ |
| Requests | leave form (for an employee), correction form, my requests, approvals inbox (swipe) | Leave / OD unified form, "Submit and approve" for RM team requests, OD fields, HR all-leave list | 🔧 |
| Allowances | — | new request (beneficiary multi-select, type, amount, dates, comment and/or voice note, receipt photo), my / team / approvals grouped by batch with audio playback, HR list with monthly totals | ➕ (`record`, `just_audio`; `image_picker` already present) |
| Payslips | — | month picker, my payslip, team list, in-app PDF viewer, download / share; HR multi-file upload + result screen | ➕ (`file_picker`, `pdfx` or Syncfusion (licence check), `share_plus`) |
| Tasks | — | OM allot + list; RM Allotted / Completed tabs + submit; HR read-only list | ➕ |
| Reports | dashboard cards per role, depot comparison | muster grid + summary, xlsx / pdf download; director BU dashboard | ➕ / 🔧 |
| Employees / documents / roster / fleet | built for depot scope | keep, BU-scoped; onboarding adds BUs + reporting-to; HR manages driver / loadman records only, the director everything | 🔧 |
| Notifications | in-app feed + bell; FCM registration not wired | bell + push + deep links by entity | 🔧 (FCM still needs a Firebase project) |
| Generated client | `packages/hrms_api` | regenerate each milestone | ✅ process |

## 7. Migration plan for existing data

### 7.0 Two paths
- **Dev now (recommended for this repo):** the data is seed/demo only. After M1's migrations, `prisma migrate reset` the dev database and reseed: 4 BUs, one director, and a demo hierarchy DIRECTOR → HR → OM → RM → drivers/loadmen in each BU.
- **Real data (if any exists before M1 ships):** follow 7.1–7.10. Each step is its own migration, or an idempotent script with `--dry-run`, run in order. Scripts write a report to `docs/migration-reports/<timestamp>.md` and exit non-zero on anything unresolved.

### 7.1 Pre-flight check (script, read-only)
- List users with role `OPERATIONAL_HEAD`. **If any exist, stop** (spec §1.1). An operator must change their role or deactivate them by hand.
  - The current dev seed has one: `+919000000002`, "Demo Operational Head".
- List `isSuperAdmin` users, users without `employeeId`, employees without a current job row, and depots without a BU mapping (needs Q2).
- List pending approval requests, leave requests and attendance corrections (they will be re-routed in 7.8).

### 7.2 Business units
- Migration: create `business_units` and seed the 4 BUs (idempotent on code).
- If depots stay (Q2): `depots.business_unit_id` nullable, filled from an operator-supplied CSV mapping (`depotCode,buCode`); then NOT NULL.

### 7.3 Role enum
- Migration A: `ALTER TYPE "Role" ADD VALUE 'DIRECTOR'`. This must be its own migration: Postgres can't use a new enum value in the same transaction.
- Script: per decision Q4, **no conversion**. A new DIRECTOR is seeded and `isSuperAdmin` HR users stay HR.
- Per decision Q1, **no OM ↔ RM swap**. Existing roles are kept as they are; any later change is an HR promotion. The report lists OM/RM users whose Phase-1 responsibilities differ from their Phase-2 meaning, so HR can review them.
- Migration B: recreate the enum without `OPERATIONAL_HEAD` (create the new type, `ALTER COLUMN … TYPE … USING`, drop the old type). It fails by design if any row still holds it.
- Then drop `users.is_super_admin`.

### 7.4 Users become employees
- For each user without `employeeId`: create an `Employee` with an empCode assigned by HR in the format `<BU code><digits>` (decision Q3), supplied via an operator CSV `phone,empCode,buCode`. Users missing from the CSV are reported and can't log in until HR assigns one. Other fields: `category = OFFICE`, `joiningDate` = the user's `createdAt` date, and a job row at the user's first scoped depot (if depots stay).
- Make `users.employee_id` NOT NULL + unique; add a case-insensitive unique index on `lower(employees.emp_code)` (pre-check that no codes collide case-insensitively).

### 7.5 OTP removal and passwords
- Migration: add `password_hash`, `password_changed_at`, lockout columns, all nullable.
- Seed or script: set the director's initial password from `SEED_DIRECTOR_PASSWORD` (env; refuse weak or default values in production). All other users get no password: login answers "Invalid employee ID or password" until the director sets one. The report lists them.
- Revoke all refresh tokens, forcing everyone to log in again with the new method.
- After the OTP code is removed: drop `otp_challenges`; remove the `OTP_*` env vars and limiters.

### 7.6 Reporting line
- Add `employee_jobs.reporting_to_employee_id` (nullable).
- Backfill drivers/loadmen: the old `reporting_user_id` → that user's employee, only if that user's (post-swap) role is RM. Otherwise leave null and report it.
- Backfill managers: no data exists today (users had no reporting line). These come from an operator CSV `empCode,reportsToEmpCode`, validated by the §1.2 rule. Unresolved rows are reported.
- Writes enforce the rule from now on. Proposed DB constraint: none (the director legitimately has none), with the API returning 422. Drop `reporting_user_id` once the backfill report is clean.

### 7.7 BU membership backfill (`employee_business_units`)
- **Drivers/loadmen and other non-login staff:** one row, `isPrimary`. BU = the BU of the depot of their current job row (via 7.2).
- **RM / OM / HR:**
  - one row per BU reachable from their old `UserScope`: depot → BU, region → its depots → BUs; HR/OH previously company-wide → all BUs (reported for review);
  - primary = the BU of their own job depot if known, else the most common one; ties are reported.
- **Director:** no rows (implicit all).
- Checks: drivers/loadmen have exactly 1 row; managers ≥ 1 with exactly 1 primary. Violations are reported and block step 7.9.

### 7.8 Records get `business_unit_id` (add nullable → backfill → verify → NOT NULL)
| Table | Backfill rule |
| --- | --- |
| `attendance_marks` | the subject employee's BU (drivers: their single BU; managers: primary). Also `approval_status = APPROVED` for all existing marks (all were manager-marked driver marks = final) and rename `ON_DUTY_OUTSTATION` → `ON_DUTY` (`ALTER TYPE … RENAME VALUE`) |
| `attendance_corrections` | the subject's BU; pending ones → re-route to the subject's reporting-to approver (or cancel and report, per the Q5 outcome) |
| `leave_requests` | the subject's BU; `kind = LEAVE`; pending ones → `approver_employee_id` = the subject's reporting-to |
| `approval_requests` / `approval_steps` | depends on Q5: keep and add BU, or close (`CANCELLED` with a reason) after the entities are re-routed |
| `notification_logs` → `notifications` | copy feed rows (recipient, template → type, title, body, payload → entity), BU from the entity if resolvable, else the recipient's primary BU |
| `duties`, `vehicles`, `routes`, `duty_templates` | via depot → BU (Q2) |
| `documents` | none needed (scoped through the employee) |

Any row that can't be resolved is listed in the report, and the NOT NULL migration is held until it's fixed.

### 7.9 Scope cut-over
- Ship `canAccess` plus the where-builder, and switch every service from `scopeWhere` / `depotIdsInScope` to it, together with the §11 test matrix.
- Then drop `user_scopes` (and the `region` / `depot` scope code) if Q2 says scope no longer uses geography.

### 7.10 Verification
- Re-run the pre-flight script: it expects zero issues.
- Spot-check counts before and after per table.
- Run the full API tests.

## 8. Tests impact
- The API has 120 tests (17 files). Role/scope tests (`scope.int`, `requireRole`, `auth.int`, `employees.int`, `roster.int`, `leave.int`, `attendance.int`) are written around OH and region/depot scope. Expect to rewrite fixtures (`test/helpers.ts`: `createManager`, `createOrgFixture`) around BUs plus a reporting tree, and to replace the OTP tests with password/lockout tests.
- The spec needs one allowed and one forbidden case per role per §11 cell: roughly 9 data rows × 4 roles × 2, about 70 cases on top of feature tests.
- Flutter: 32 tests. The login flow, router redirect and fakes change with the roles and auth; feature tests get new fakes.

## 9. Things in CLAUDE.md that become obsolete (update in M1 / M8)
- §1 core loop (payroll, WhatsApp payslips).
- §2 roles / hierarchy / scope.
- §6 payroll models.
- §7 payroll rules.
- §8 auth + payroll routes.
- §9 screens by role.
- §10 Phase 2 description.
- §12 kickoff prompts.
- The decision-log entries about OTP auth and employee scope.

---

## 10. Decisions (answers received 2026-11-09)

These override the open questions below and the related parts of §§1–7.

| # | Decision | Effect on the plan |
| --- | --- | --- |
| Q1 | **No automatic role conversion.** A user's role changes only when HR records a **promotion**. | §7.3: the migration keeps existing role values (except removing `OPERATIONAL_HEAD`, which still stops the migration if present) and does **not** swap OM/RM. M1 adds an HR "promote" action. It is audited and recorded as an effective-dated job change (reason "Promotion"). It must leave the reporting line valid: the reporting target is re-picked in the same action, and direct reports who would become invalid are listed for reassignment. Dev data is reset and reseeded (§7.0). Assumption: the director can also do this as super admin (`TODO(business)` to confirm). |
| Q2 | **Depots stay**, as physical locations; **each depot belongs to exactly one BU**; roster, vehicles, routes and duty templates **stay depot-based**, with their BU derived from the depot. | §7.2: `depots.business_unit_id` NOT NULL (single BU). Scope = BU + hierarchy; depot-owned records resolve their BU through the depot. `Region` can stay as an optional grouping; `UserScope` (region/depot rows) is replaced by BU membership and the reporting line. |
| Q3 | **HR assigns employee IDs.** Format: **BU code prefix + digits**, e.g. `NLS001`, `AERO002`. | Validation: `^<BU code>\d{3,}$`, where the prefix must be the code of the employee's (primary) BU at creation. Uniqueness stays case-insensitive. The app suggests the next free number per BU (HR can override). IDs are not renumbered if an employee later changes BU or a BU code is edited. §7.4: existing managers get IDs assigned by HR before they can log in (dev: seeded in this format). |
| Q4 | **Director and HR are separate users.** | Seed a new `DIRECTOR` employee+user (password from `SEED_DIRECTOR_PASSWORD`). The current HR super admin stays `HR`, and `isSuperAdmin` is dropped. |
| Q5 | **Retire the rule-based approval engine.** | Each request type stores its own approval on the record: status, approver = the subject's reporting-to (with the §1.2 fallback), decided by, decided at, reason. `ApprovalRule` / `ApprovalRequest` / `ApprovalStep`, `/approvals*` and `/approval-rules` are removed in M1/M2. Pending Phase-1 requests are cancelled with a reason and reported (dev: reset). The escalation job is replaced by "approver inactive → same role in a shared BU + notify director" (spec §1.2). |
| Q6 | **Reporting line on the effective-dated job history** (my choice, per the existing convention). | `EmployeeJob.reportingToEmployeeId`; the current value comes from `getJobAsOf`. A promotion or transfer closes the row and opens a new one. `GET /me` and lists return the current value. |
| Q7, Q8 | **Left open** (`TODO(business)`). | Until answered: roster and fleet editing is allowed for RM and OM within their BU and hierarchy, and document-expiry blocking stays as built. Bank details stay HR-only (payslip PDFs follow spec §7.2). |

## 11. Original blocking questions (kept for the record)

- **Q1 — Role mapping for existing users.** Phase 1's OM does what Phase 2's RM does, and the reverse.
  - Should existing users swap roles in the migration (OM → RM, RM → OM)? Or is the dev data simply reset, so it doesn't matter?
  - *Blocks M1 migration design (not code).*
- **Q2 — Depots and regions.**
  - Do depots remain physical locations under business units? Is a depot always in exactly one BU?
  - Do the roster, vehicles, routes and duty templates stay depot-based, with BU derived from the depot? Or do depots and regions go away?
  - Is the depot's state still needed for PT/LWF? With the payroll engine cancelled, probably not.
  - *Blocks the BU backfill and the scope helper design.*
- **Q3 — Employee IDs for managers.** Managers today have no employee record or empCode.
  - Who assigns their empCodes, and in what format? (Example in the spec: `NLS1023`. Is the BU prefix meaningful?)
  - *Blocks login for existing managers.*
- **Q4 — Who is the director?** Should the current HR super admin (`+919000000001`) become the DIRECTOR, or stay HR with a separate director seeded?
- **Q5 — Approval engine.** Every Phase-2 flow is a single step to the reporting-to manager.
  - Options: (a) keep the generic engine and add a "reporting line" step type, allowing self-approval only for RM → driver/loadman leave; or (b) retire the rules engine in favour of per-entity status + approver columns (simpler, matches the spec).
  - My recommendation is (b). Retiring the module needs your OK (spec §0.3).
- **Q6 — Effective-dated reporting line.** Keep `reportingTo` on the effective-dated job history (my recommendation; CLAUDE.md convention), or a single column on `Employee` as the spec words it?
- **Q7 — Roster ownership.** The roster, fleet and document-blocking screens were built for Phase-1 OMs (now Phase-2 RMs in function). Who builds the daily roster under the new roles: RM, OM, or both? Does document blocking still apply?
- **Q8 — Payslip privacy.** CLAUDE.md said pay data is HR-only. Phase 2 lets RMs and OMs see team payslips (§7.2). Do bank details stay HR-only (assumed yes)?
- **Non-blocking:** these stay as spec §13 assumptions / `TODO(business)`: director attendance not tracked; a manager's own records use their primary BU; HR doesn't approve driver leave; seed allowance and leave types; the 2-minute voice note limit.
