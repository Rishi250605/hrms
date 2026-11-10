# Phase 2 progress (PHASE-2-FEATURES.md)

## M0 — Gap analysis (2026-11-09)
- Wrote `docs/phase-2-gap.md`: existing vs required data model, API, Flutter, auth, and a step-by-step data-migration plan (roles, OTP removal, business-unit backfill).
- No application code changed.
- Blocking questions Q1–Q8 are listed at the end of the gap document.
- Answers recorded 2026-11-09 (gap doc §10):
  - roles change only via an HR promotion (no auto-swap);
  - depots stay, one BU each, and the roster stays depot-based;
  - HR assigns employee IDs as BU code + digits (`NLS001`);
  - director and HR are separate users;
  - the rule-based approval engine is retired for per-record approvals;
  - the reporting line lives on the effective-dated job history;
  - Q7 and Q8 stay `TODO(business)`.

## M1–M7 — built 2026-11-09 (one session)

M1 was built first because M2–M7 depend on it. All API checks are green:
- lint and typecheck;
- 140 tests;
- `db:check`;
- `openapi:check`.

Flutter is green: `flutter analyze`, 40 tests. The OpenAPI spec and the Dart client (`packages/hrms_api`) are regenerated.

### Migrations
These replace the Phase 1 data; the dev and test databases were reset with consent.

| Migration | Contents |
| --- | --- |
| `20261110000000_phase2_a_roles_bu_auth_attendance_leave` | M1 + M2 + M3 (one migration because they rewrite the same tables) |
| `20261110100000_phase2_b_allowances` | M4 |
| `20261110200000_phase2_c_payslips` | M5 |
| `20261110300000_phase2_d_tasks` | M6 |

M7 needed no schema change.

### M1 — Foundation
**Roles and hierarchy**
- Roles: `DIRECTOR`, `HR`, `OPERATIONAL_MANAGER`, `REGIONAL_MANAGER`. Drivers and loadmen (`LOADMAN` category) are records only.
- Reporting line: `EmployeeJob.reportingToEmployeeId` (effective-dated), validated per level. Descendants are found with a recursive CTE.

**Business units**
- `BusinessUnit` (NLS, BMS, MOD, AERO seeded).
- `EmployeeBusinessUnit` membership: staff have exactly one BU; managers have one or more, with exactly one primary. The director implicitly has all.
- `Depot.businessUnitId`.

**Visibility** — `access/scope.ts`: BU match plus hierarchy depth per role and feature (§11).

**Auth**
- Login with employee code + password (argon2id).
- Lockout: 5 failures in 15 minutes locks the account for 15 minutes (423).
- The director creates users, resets passwords (which revokes sessions), unlocks and deactivates.

**Notifications** — a `Notification` table (in-app feed) plus FCM push.

**Flutter**
- Logo login screen (`assets/branding/logo.png` is a placeholder — replace it).
- BU switcher, remembered per user on the device.
- My Profile, role shells, user management for the director.

### M2 — Attendance
- RM team marking: final, offline queue, idempotent.
- Self-marking routed to the reporting manager: RM → OM → HR → director.
- Bulk approve.
- Edit window and corrections.
- Notifications per §10.
- Flutter tabs:
  - Team (RM);
  - My attendance;
  - Approvals (OM / HR / director).

### M3 — Leave and OD
- Unified requests (`kind` LEAVE / OD) routed per §5.1.
- An RM can raise for their drivers and approve in one step.
- Approval writes `ON_LEAVE` / `HALF_DAY` / `ON_DUTY` attendance and updates balances; cancelling after approval reverses this.
- Flutter tabs: Mine / Team / Approvals / All, and a form with self-or-team and OD fields.

### M4 — Allowances
**API**
- `AllowanceType`: HR / director manage the types; starter types are seeded.
- `AllowanceRequest`: one request per beneficiary, with a shared `batchId`.
- Routing: RM → OM, OM → HR.
- A comment or a voice note is required; the voice note and receipt are uploaded via presign, then the key is checked.
- Approving a different amount requires a comment, and both amounts are kept.
- Batch approve, signed-URL file playback (audited), and HR monthly totals per BU.

**Flutter**
- Tabs per role, with approvals grouped by batch.
- Form: multi-select team members, `record` voice note (≤ 2 min, AAC), receipt photo.
- Detail sheet: `just_audio` playback and approve / reject.

### M5 — Payslips
**Upload (API)**
- `POST /payslips/upload?period=` is multipart. `ModuleRouter` gained an `upload` option (multer, in memory, after authentication), documented as `multipart/form-data` in OpenAPI.
- Files must be named `payslip-<empCode>.pdf`. Each is checked for `%PDF` magic bytes and a size limit (setting, ≤ 10 MB hard cap).
- Only employees in HR's BUs are matched.
- The result lists matched / replaced / unmatched / invalid / duplicates.
- Versions are stored at `payslips/YYYY-MM/<empcode>-vN.pdf` (lower-case empCode — storage keys are lower-case).

**Visibility and download (API)**
- RM: self + drivers / loadmen; OM: self + RMs; HR: all in their BUs; director: all.
- Downloads are signed URLs and audited. Earlier versions are HR / director only.
- Optional "payslips available" notice to RMs and OMs.

**Flutter**
- Month picker, my payslip, team / all list with search, version history.
- HR upload screen (`file_picker`, multi-PDF, sent in batches of 25).
- PDFs open in the device viewer via the signed URL.

### M6 — Tasks
**API**
- `Task`: an OM allots to direct-report RMs who share the BU (one task per RM, shared `groupId`, today up to 60 days ahead).
- The RM submits Completed, or Not done with a required reason; the task is then locked. The OM can reopen it with a comment.
- Overdue = still PENDING after its date.
- Notifications: allotted → RM; submitted → OM + HR; reopened → RM.
- Visibility: RM assigned, OM allotted, HR / director all.

**Flutter**
- RM: Allotted / Completed tabs.
- OM: list by date and the allot form.
- HR / director: read-only list by date.

### M7 — Reports and dashboard
**Attendance report**
- `GET /reports/attendance`: muster codes per day (P / A / HD / L / OD / WO / H, `*` = pending, `!` = rejected) plus a per-employee summary. Scope follows §11 "Reports"; filters are BU, range (≤ 62 days), role group, employee, status and approval state.
- People are listed by **primary** BU, because a manager's own records belong to it.
- `GET /reports/attendance/export?format=xlsx|pdf`:
  - exceljs workbook (Muster + Summary sheets) or pdfkit landscape A3 muster;
  - header carries BU, period, and generated by / at;
  - stored privately and returned as a signed URL; every export is audited.

**Dashboard** — `GET /reports/dashboard?businessUnitId=` returns, per BU:
- today (headcount, present %, absent, leave, OD, not marked, pending);
- pending approvals;
- allowances this month (requested vs approved);
- today's task completion per OM.

It also returns a `me` section: approvals waiting for me, my open / overdue tasks, my attendance today, unread notifications.

**Flutter** — role home screens (director: company dashboard with quick links), a reports screen (muster grid / summary, Excel / PDF download), and notifications with deep links.

### Deviations from PHASE-2-FEATURES.md
- Report download is a separate endpoint (`/reports/attendance/export`), not `?format=` on the JSON endpoint, because the generated Dart client cannot type a response that is sometimes JSON and sometimes a file link.
- Payslip PDFs open in the device's PDF viewer through the signed URL (download and share happen there) instead of an embedded viewer. This avoids a native PDF plugin; an in-app viewer (`pdfx`) can be added later.
- Payslip storage keys use the lower-case empCode.

### TODO(business) — open items
**Accounts and people**
- Password policy (min 8 characters for now), both API and app.
- Whether a future-dated promotion should change the login role only on its date.
- Aadhaar as a required document type.
- Q8: bank-detail privacy.

**Leave**
- Leave types, quotas and accrual details (proration, rounding).
- Sandwich rule.
- Leave that crosses calendar years.

**Allowances, tasks and payslips**
- Real allowance types and per-request limits.
- How far ahead tasks may be allotted (60 days).
- Whether payslips may be uploaded for a future month.

**Reports and dashboard**
- Present-% formula on the dashboard.
- Longest report range (62 days).
- Retention / purge of generated report files.

**Settings and fleet**
- All settings defaults (roster caps, rest, edit window, alert days, `leave.balanceEnforcement`, payslip size / notice).
- Fleet types and who edits fleet / roster (Q7).
- Document requirements for non-driver categories.

**External**
- WhatsApp / SMS provider.

## M8 — Hardening (2026-11-10)
- **§11 visibility matrix** in one suite (`access/visibility-matrix.int.test.ts`): every row × role, with an allowed and a forbidden case. 36 / 36 pass; no gaps found.
- **Audit coverage** is enforced statically (`audit/audit-coverage.test.ts`): every Prisma write must sit in a function that calls `audit.record`, and there must be no raw-SQL writes.
  - Two gaps were fixed: leave-balance opening rows and movements (`leaveBalance.open`, `leaveBalance.adjust`).
  - Payslip version-history reads are now audited too.
- **Load test** (`npm run test:perf`), 1,000 staff × 31 days: JSON 0.3 s, Excel 0.5 s, PDF 1.1 s, dashboard 0.5 s.
- **End-to-end smoke** (`npm run smoke`) against the running dev API: 45 / 45 steps.
- **UI pass**:
  - theme;
  - Home hero and toned cards;
  - login card;
  - My Profile from the app-bar avatar, with version and BU chips;
  - sign-out confirmation;
  - spec wording.
- **Android**: `RECORD_AUDIO` permission; Gradle heap lowered to 2 GB.
- CLAUDE.md is updated throughout. The summary is in `docs/phase-2-summary.md`.
