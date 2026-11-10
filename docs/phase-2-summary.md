# Phase 2 summary (PHASE-2-FEATURES.md, M0–M8)

Built 2026-11-09 → 2026-11-10. Milestone-by-milestone notes are in `docs/phase-2-progress.md`. Migration plan and decisions Q1–Q8 are in `docs/phase-2-gap.md`.

## What the app does now

Four people log in; drivers and loadmen are records only:

```
DIRECTOR → HR → OPERATIONAL MANAGER (OM) → REGIONAL MANAGER (RM) → drivers / loadmen
```

| Who | Day-to-day in the app |
| --- | --- |
| RM | Marks drivers' / loadmen's attendance (offline-capable) and their own; raises and approves their team's leave / OD; raises allowances for the team and self (voice note, receipt); completes daily tasks; sees team payslips |
| OM | Self-attendance; approves RMs' attendance, leave / OD and allowances (batch approve, change amount with a comment); allots daily tasks to RMs; sees RM payslips |
| HR | Approves OM attendance / leave / allowances; uploads payslip PDFs in bulk; manages driver / loadman records and promotions; verifies documents; all records in their business units |
| Director | Company dashboard per business unit; approves HR; creates logins, resets passwords, unlocks, deactivates; sees everything |

Everything is filtered by **business unit** (NLS, BMS, MOD, AERO) and by the **reporting line**. The app has a BU switcher that is remembered per user.

## Decisions that shape the system

**Roles and hierarchy**
- Four roles; `OPERATIONAL_HEAD` and `isSuperAdmin` are removed.
- A role changes only through an HR / director promotion (Q1).
- The reporting line is stored on the effective-dated job history (Q6) and validated: next role up, sharing a BU (`422 INVALID_REPORTING_LINE`).

**Business units**
- Staff belong to one BU; managers to one or more, with one primary; the director to all.
- Depots stay and each belongs to one BU, so roster and fleet stay depot-based (Q2).
- Employee IDs are BU prefix + digits (`NLS001`), assigned by HR, with the next code suggested (Q3).

**Auth**
- Login is employee ID + argon2id password; there is no OTP.
- 5 failures in 15 min lock the account for 15 min.
- Only the director sets or resets passwords, and a reset signs the user out everywhere.
- The director and HR are separate users (Q4).

**Approvals**
- Approvals are per record (Q5 retired the rule engine): the approver is the subject's reporting-to at submission.
- If that approver is inactive, any active user of the same role in the BU can decide, and the director is notified.

**Payroll and payslips**
- The **in-house payroll engine is cancelled**. Payslips are PDFs produced elsewhere and uploaded by HR as `payslip-<empCode>.pdf`.
- A re-upload creates a new version, kept for HR.
- Downloads are signed URLs (≤ 10 min) and audited.

**Audit and privacy**
- Every write is audited, and so is every read of pay data and every export.
- Bank account and PAN are encrypted; only the last 4 digits of Aadhaar are kept.

## M8 — hardening (2026-11-10)

| Check | How | Result |
| --- | --- | --- |
| §11 visibility matrix | `api/src/modules/access/visibility-matrix.int.test.ts` — 9 rows × 4 roles, each with an allowed and a forbidden case. Data is created once through the API (marks, self-marks, OD requests, allowances, payslips, tasks). Where a role sees "All", the forbidden case is a BU outside theirs (HR) or an action the role lacks (director). | 36 / 36 pass. No visibility gaps found. Feature suites add more cases (≈ 80 visibility assertions in total). |
| Every write audited | `api/src/modules/audit/audit-coverage.test.ts` parses services, jobs and lib with the TypeScript compiler API. It fails on any Prisma write whose top-level function doesn't call `audit.record`, and on raw-SQL writes. A fixture self-test keeps the checker honest. | Found 2 gaps: leave-balance opening rows and balance movements were audited only through the parent leave request. Fixed: `leaveBalance.open` and `leaveBalance.adjust` (with a reason). Payslip version-history reads are now audited too. |
| Report load test | `npm run test:perf`: 1,000 staff reporting to one RM, 31 days of marks (31,000 rows) | See the timings below. |
| End-to-end smoke | `npm run smoke` against the running dev API with the demo seed: all four roles log in; attendance, leave / OD, allowance, task, payslip upload + signed download, report Excel / PDF downloads; visibility spot checks | 45 / 45 steps pass (also reachable on the LAN IP) |
| Checks | API: lint, typecheck, `db:check`, `openapi:check`, 179 tests (unit + integration). Flutter: analyze, 42 tests. | All green |

Report load-test timings on the dev laptop (Windows, local Postgres 18):

| Request | Budget | Measured |
| --- | --- | --- |
| JSON muster, HR (all) | 3 s | 0.29 s |
| JSON muster, RM (reporting-tree path) | 3 s | 0.34 s |
| Excel export | 15 s | 0.49 s |
| PDF export (A3, ~19 pages) | 20 s | 1.14 s |
| Director dashboard | 3 s | 0.50 s |

**UI pass**
- Material 3 theme: rounded filled inputs, tonal cards, consistent app bar / navigation / tabs / sheets / dialogs.
- Home: hero header with my attendance today, toned to-do cards, per-BU cards with an attendance split bar and per-OM task progress.
- Login: card layout on a branded background with icon banners for errors.
- My Profile (§3), opened from the app-bar avatar: employee ID, reporting-to with role, BU chips with the primary starred, app version, and "To change your password, contact your Director".
- Sign-out asks for confirmation. Empty states are friendlier.
- Login and profile wording now follows the spec.

**Android**
- Added the `RECORD_AUDIO` permission for voice notes.
- Gradle heap lowered from 8 GB to 2 GB (the old value got builds killed on the 8 GB dev machine).

## How to run and check

```
cd api
npm run dev                               # API (local Postgres, local storage driver)
npm run lint && npm run typecheck && npm test && npm run db:check && npm run openapi:check
npm run test:perf                         # load test
npm run smoke                             # end-to-end smoke against the running API

cd mobile
flutter analyze && flutter test
flutter build apk --debug --dart-define=API_BASE_URL=http://<pc-lan-ip>:3000/api/v1
```

**Logins**
- Director: `DIR001` with `SEED_DIRECTOR_PASSWORD` (dev: `Director@123`).
- Demo users, password `Demo@1234`:
  - `NLS001` HR;
  - `NLS002` OM;
  - `NLS003` RM;
  - `BMS001` RM;
  - `MOD001` OM;
  - `MOD002` RM.

Use a **debug** build for a phone on the LAN: only debug builds allow plain HTTP, so a release APK pointed at `http://…:3000` can't connect.

## Deviations from PHASE-2-FEATURES.md

- **Report download** is `GET /reports/attendance/export?format=xlsx|pdf`, not `?format=` on the JSON endpoint, so the generated client has one response type per operation.
- **Payslips** open in the device's PDF viewer via the signed URL (download and share from there); there's no embedded viewer plugin.
- **Storage keys** use the lower-case employee code (`payslips/2026-10/nls001-v1.pdf`).
- **Reports** list people by **primary** BU (a manager's own records belong there).

## Open `TODO(business)` items

**Accounts and people**
- Password policy (minimum 8 characters now).
- Whether a future-dated promotion should change the login role only on its date.
- Aadhaar as a required document.
- Bank-detail privacy (Q8).

**Leave**
- Leave types, quotas and accrual details (proration, rounding).
- Sandwich rule.
- Leave crossing calendar years.

**Allowances, tasks and payslips**
- Real allowance types and per-request limits.
- How far ahead tasks may be allotted (60 days).
- Payslip upload for future months.

**Reports and dashboard**
- Present-% formula.
- Longest report range (62 days).
- Retention / purge of generated report files.

**Settings, fleet and documents**
- All `Setting` defaults (roster caps, rest, edit window, alert days, balance enforcement, payslip size / notice).
- Fleet types and who edits fleet / roster (Q7).
- Document requirements for non-driver categories.

**External**
- WhatsApp / SMS provider for payslip notices.

## Not done / next

- **FCM push** needs a Firebase project (`PUSH_PROVIDER=fcm` + service account); the in-app feed works.
- **Data retention** and the erasure workflow (DPDP) are not built.
- **Phase 3:**
  - incidents and discipline;
  - training records;
  - biometric / GPS import;
  - roster rules switched to blocks.
