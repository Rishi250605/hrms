# PHASE-2-FEATURES.md — Feature build spec (overrides CLAUDE.md where they conflict)

Phase 0 and Phase 1 are done (skeleton, auth, employees, documents, roster basics, attendance and leave foundations).
This file defines the **next set of features**. Read `CLAUDE.md` for conventions (stack, folder layout, coding rules, testing, audit log, money in paise, IST dates). Where this file disagrees with `CLAUDE.md`, **this file wins**, and you must update `CLAUDE.md` to match once a change is implemented (sections 1, 2, 7, 8, 9 and the Decisions log).

---

## 0. How to work through this file

1. **Start with a gap analysis.** Read the current code, compare it with this file, and write `docs/phase-2-gap.md`: what exists, what must change, what is new, and a migration plan for existing data. Do not write feature code before this file exists.
2. Build in the order of §12 (Build order). One milestone per session. Each milestone ends with: migrations applied, seed updated, API tests green (including BU-scope and hierarchy tests), OpenAPI and Flutter client regenerated, `flutter analyze` and tests green, and a short note appended to `docs/phase-2-progress.md`.
3. Existing modules that are not mentioned here (documents, vehicles, routes, roster) **stay**, but must become business-unit scoped (§2). Do not delete any module without asking.
4. Any rule not covered here: implement as configuration, mark `TODO(business)`, and list it in the session summary. Never invent business rules.

---

## 1. Changes to the foundation

### 1.1 Roles (replace the old role set)

Only four roles log in. Order of authority, highest first:

```
DIRECTOR  →  HR  →  OPERATIONAL_MANAGER  →  REGIONAL_MANAGER  →  (DRIVER, LOADMAN: records only, no login)
```

| Role | Login | Summary |
| --- | --- | --- |
| `DIRECTOR` | Yes | Super admin. Views all dashboards and reports, approves HR attendance and HR leave/OD, manages users and resets passwords. |
| `HR` | Yes | Approves operational manager attendance, leave/OD and allowances; is notified of everything listed in §10; uploads payslips; manages driver/loadman records. |
| `OPERATIONAL_MANAGER` (OM) | Yes | Approves regional manager attendance, leave/OD and allowances; allots daily tasks to regional managers; raises own allowances. |
| `REGIONAL_MANAGER` (RM) | Yes | Marks attendance for drivers and loadmen; approves their leave/OD; raises allowances for them and for himself; completes daily tasks. |
| `DRIVER`, `LOADMAN` | **No** | Employee records only. Everything about them is done by their RM. |

- **Remove `OPERATIONAL_HEAD` everywhere** (enum, guards, seeds, Flutter role shells, tests). Migration: if any user has `OPERATIONAL_HEAD`, the migration must stop and report them; do not auto-convert.
- Rename any `isSuperAdmin` concept to the `DIRECTOR` role. Seed one `DIRECTOR` user.
- Employee categories: add `LOADMAN`. Keep existing categories in the enum, but the app's flows in this file only cover `DRIVER` and `LOADMAN` as non-login staff.

### 1.2 Reporting line

- Every employee has exactly one `reportingToId` (another employee who has a login):
  - DRIVER / LOADMAN → an RM
  - RM → an OM
  - OM → an HR user
  - HR → a DIRECTOR
  - DIRECTOR → none
- Validation: the reporting target must hold the next role up (as above) and share at least one business unit with the employee (§2). Reject otherwise with `422 INVALID_REPORTING_LINE`.
- "Approver" in this file always means the employee's `reportingTo` user, unless a rule says otherwise. If that user is inactive, the request goes to **any active user with the same role who shares the record's business unit**, and the director is notified.

### 1.3 Authentication: employee ID + password (replace OTP)

- **Remove OTP login entirely** (endpoints, models, Flutter screens, SMS dependency for login).
- Login with **Employee ID + password**. Employee ID is `Employee.empCode`, unique, case-insensitive.
- Passwords are **set by the director** when creating or resetting a user. Users cannot change or reset their own password in the app. The login screen shows: "Forgot password? Contact your Director."
- Hash with argon2id (or bcrypt cost ≥ 12). Never log or return passwords. Store `passwordChangedAt`.
- Lockout: after 5 failed attempts in 15 minutes, lock the account for 15 minutes; the director can unlock immediately.
- Tokens: keep the existing JWT access + rotating refresh token design. Resetting a password revokes all refresh tokens for that user. Deactivating a user revokes all tokens.
- Director endpoints: create user (empCode, name, role, phone, reportingTo, business units, initial password), reset password, unlock, deactivate/reactivate.

**Login screen (Flutter):** company logo centred at the top, then an "Employee ID" field, a "Password" field with show/hide toggle, and a full-width "Sign in" button. Show inline errors ("Invalid employee ID or password", "Account locked, try again in N minutes or contact your Director"). No sign-up, no OTP. Put the logo at `mobile/assets/branding/logo.png` (use a placeholder until the real file is provided; register it in `pubspec.yaml`).

---

## 2. Business units (applies to everything)

Seed exactly these four business units (codes are suggestions; keep them editable by the director):

| Name | Code |
| --- | --- |
| NLS Enterprises | `NLS` |
| BMS Associates | `BMS` |
| Modern Agency | `MOD` |
| Aerothread Logistics | `AERO` |

### 2.1 Membership

- `EmployeeBusinessUnit(employeeId, businessUnitId, isPrimary)`.
- DRIVER / LOADMAN: exactly one business unit.
- RM, OM, HR: **one or more** business units, exactly one marked primary.
- DIRECTOR: all business units implicitly.

### 2.2 Every record carries a business unit

Attendance marks, leave/OD requests, allowance requests, payslips, tasks, notifications and all report rows must have a non-null `businessUnitId`.

- Records **about a driver/loadman** use that employee's business unit.
- Records **about a manager themself** (own attendance, own leave/OD, own allowance, own payslip) use the manager's **primary** business unit. (Assumption, see §13.)
- Tasks use the business unit chosen by the OM when allotting; it must be one the OM and the RM share.
- Existing records from Phase 1 must be backfilled in the migration (use the employee's primary business unit; report anything that cannot be resolved).

### 2.3 Scope rule (enforced in the API, one helper)

A user may see or act on a record only if **both** are true:

1. **BU match:** the record's `businessUnitId` is in the user's business units (directors: all).
2. **Hierarchy match:** the record's subject is the user themself, or is below the user in the reporting tree, as allowed by the per-feature visibility in §11.

Implement as one function (`canAccess(user, subjectEmployee, businessUnitId, feature)`) plus a query helper that builds the Prisma `where` clause. Every list endpoint takes an optional `businessUnitId` filter; omitted means all of the caller's business units.

### 2.4 Business unit switcher (Flutter)

Users with more than one business unit see a BU selector in the app bar ("All my BUs" plus each BU). It filters every list, dashboard and report. The selection persists locally per user.

---

## 3. My Profile

Screen reachable from the app bar avatar, for every logged-in role. Read-only:

- Employee ID, full name, role, phone
- Reporting to: name, employee ID, role (none for director)
- Business units: chips, primary marked
- App version, Sign out button
- Text: "To change your password, contact your Director."

API: `GET /me` returns all of the above (extend the existing endpoint).

---

## 4. Feature A — Attendance with hierarchical approval

### 4.1 Who marks and who approves

| Whose attendance | Marked by | Approved by | Starting status |
| --- | --- | --- | --- |
| Driver / Loadman | Their RM | No approval needed | `APPROVED` (final) |
| Regional manager | Self | Their OM | `PENDING_APPROVAL` |
| Operational manager | Self | Their HR | `PENDING_APPROVAL` |
| HR | Self | Director | `PENDING_APPROVAL` |
| Director | Not tracked | — | — (assumption, §13) |

- Statuses: `PRESENT`, `ABSENT`, `HALF_DAY`, `ON_LEAVE`, `ON_DUTY` (OD), `WEEKLY_OFF`, `HOLIDAY`.
- Approval states: `PENDING_APPROVAL`, `APPROVED`, `REJECTED` (reason required). A rejected self-mark can be corrected and resubmitted the same day or the next day.
- One record per employee per date. Self-marking stores `markedAt` (server time). Self-marking for a future date is not allowed; for a past date only within the edit window.
- Edit window: an RM can change driver/loadman marks until 23:59 IST on the next day. After that, or after approval, changes go through a correction request approved by the next role up. Window length is a setting.
- Approved leave or OD automatically sets attendance to `ON_LEAVE` / `ON_DUTY` for those dates (already approved, no second approval).
- Keep the existing offline queue and idempotent bulk endpoint for the RM's driver/loadman marking.

### 4.2 Screens

- **RM – Mark team attendance:** date picker (default today), BU filter, list of their drivers and loadmen pre-filled `PRESENT`; tap to change exceptions; "Submit" once. A separate "My attendance" card at the top to mark own status (shows pending/approved/rejected).
- **OM / HR – My attendance** card on home, plus **Attendance approvals** list: pending marks from direct reports, with approve all, approve one, or reject with reason.
- **Director – Attendance approvals** for HR, plus read-only views of everyone.

### 4.3 API (adjust to existing routes)

```
GET   /attendance/team?date=&businessUnitId=          (RM: drivers/loadmen)
POST  /attendance/team/bulk                            (RM, idempotent by clientMutationId)
POST  /attendance/self                                 (RM, OM, HR)
GET   /attendance/self?from=&to=
GET   /attendance/approvals?status=PENDING_APPROVAL    (OM, HR, DIRECTOR: direct reports)
POST  /attendance/:id/approve
POST  /attendance/:id/reject      { reason }
POST  /attendance/approvals/bulk-approve   { ids[] }
```

### 4.4 Acceptance criteria
- An RM cannot mark attendance for a driver who does not report to them or is in a BU the RM does not belong to (403).
- An OM sees pending marks only for RMs who report to them; HR only for OMs reporting to them; director only for HR.
- Approving or rejecting creates an audit log entry and a notification to the person whose attendance it is (§10).

---

## 5. Feature B — Leave and OD requests

Leave and OD (on duty: working away from the usual place, for example a client site or another depot) use the same flow and the same table with `kind = LEAVE | OD`.

### 5.1 Routing

| Requester (subject) | Raised by | Approved by | Notified |
| --- | --- | --- | --- |
| Driver / Loadman | Their RM (on their behalf) | **The same RM** (approve at submission, or later from the list) | HR |
| Regional manager | Self | Their OM | HR, and the RM on decision |
| Operational manager | Self | Their HR | The OM on decision |
| HR | Self | Director | The HR user on decision |

- For drivers/loadmen the RM both raises and approves. Show a single "Submit and approve" action, plus a "Save as pending" option if the RM wants to decide later. HR only gets a notification; HR does not approve.
- Fields: kind (Leave / OD), leave type (for Leave; types configurable by HR, for example Casual, Sick, Earned, Unpaid), from date, to date, half-day on first/last day, reason (required). OD adds: location/purpose (required), optional from/to time.
- Validate: no overlap with another approved or pending request for the same person; to ≥ from; dates not before the attendance edit window unless HR/director.
- If the existing Phase 1 leave module has balances, keep them and deduct on approval; enforcement (block vs warn when balance is short) is a setting.
- Cancellation: requester can cancel while pending; after approval, cancellation needs the approver.
- On approval: update attendance for those dates (§4.1) and the roster availability if the roster module exists.

### 5.2 Screens
- **Requests** tab for every role: "New request" (Leave/OD), "My requests", and for approvers an "Approvals" list with approve/reject (reason required on reject).
- RM gets an extra "Team requests" flow to raise for a driver/loadman (searchable picker, BU-filtered).
- HR sees a read-only "All leave and OD" list across its business units, filterable by BU, date, status and role.

### 5.3 API
```
POST  /leave-requests                    { subjectEmployeeId, kind, ... , autoApprove? }
GET   /leave-requests?scope=mine|team|approvals|all&status=&kind=&businessUnitId=&from=&to=
POST  /leave-requests/:id/approve
POST  /leave-requests/:id/reject   { reason }
POST  /leave-requests/:id/cancel
GET/POST/PATCH /leave-types              (HR, DIRECTOR)
```

---

## 6. Feature C — Allowance requests

Only **RM and OM** can raise allowance requests.

### 6.1 Routing

| Raised by | For whom | Approved by | Notified |
| --- | --- | --- | --- |
| RM | One or more of their drivers/loadmen | Their OM | HR (on submission and decision); RM on decision |
| RM | Himself | Their OM | HR (on submission and decision); RM on decision |
| OM | Himself | Their HR | OM on decision |

### 6.2 Fields
- Beneficiary: self, or one or more drivers/loadmen (multi-select picker for RMs). Multi-select creates **one request per beneficiary**, grouped by a shared `batchId` so the OM can approve the batch in one action.
- Allowance type: configurable list managed by HR/director (seed examples, marked `TODO(business)`: Batta, Night halt, Travel, Food, Fuel, Other).
- Amount (₹, stored in paise, must be > 0; per-type maximum optional setting).
- Date of expense / date range.
- Comments (text) **and/or** a voice note: record in-app (max 2 minutes, AAC/m4a), upload to private storage, playable by the approver and HR. At least one of comment or voice note is required.
- Optional photo of a receipt.
- Approver can approve, reject (reason required), or approve a different amount (store both requested and approved amounts and require a comment).

### 6.3 Screens
- **Allowances** tab for RM and OM: New request, My requests (with status), and for RM a "Team allowances" history.
- **Allowance approvals** for OM (from RMs) and HR (from OMs), grouped by batch, with a play button for voice notes.
- HR read-only list of all allowances across its business units with monthly totals per BU.

### 6.4 API
```
POST  /allowances                 (multipart or presigned upload for voice/receipt)
GET   /allowances?scope=mine|team|approvals|all&status=&businessUnitId=&from=&to=
POST  /allowances/:id/approve     { approvedAmountPaise?, comment? }
POST  /allowances/:id/reject      { reason }
POST  /allowances/batch/:batchId/approve
GET/POST/PATCH /allowance-types   (HR, DIRECTOR)
POST  /uploads/presign            (reuse; add audio/m4a, audio/aac, image/jpeg)
```

---

## 7. Feature D — Payslips (PDF bulk upload, no payroll engine)

The in-house payroll engine from CLAUDE.md Phase 2 is **cancelled**. Payslips are produced outside the app and uploaded as PDFs.

### 7.1 Upload (HR)
- HR chooses the **pay period (month and year)** and selects many PDF files at once.
- File name format: `payslip-<empid>.pdf` (case-insensitive, for example `payslip-NLS1023.pdf`). Parse `<empid>`, match `Employee.empCode`.
- Validate each file: real PDF (check magic bytes), size ≤ 5 MB (setting), employee exists and is in one of HR's business units.
- Result screen after upload: matched (count + list), unmatched file names, invalid files, and duplicates. Nothing unmatched is stored.
- Re-uploading the same employee and period replaces the file as a new version; keep previous versions for HR only.
- Store in the private bucket under `payslips/<YYYY-MM>/<empCode>-v<n>.pdf`. The record's business unit is the employee's (primary) business unit.
- Optional notification to each RM/OM that payslips for the month are available.

### 7.2 Who can view and download

| Viewer | Can see |
| --- | --- |
| Regional manager | Own payslips + payslips of drivers/loadmen reporting to them |
| Operational manager | Own payslips + payslips of RMs reporting to them |
| HR | All payslips in their business units, plus their own |
| Director | All |

All within the BU rule of §2.3. Downloads use short-lived signed URLs (≤ 10 minutes) and are audit-logged.

### 7.3 Screens
- **Payslips** tab: month picker, "My payslip" card, and a "My team" list (name, empCode, role, BU, view/download). View opens an in-app PDF viewer; download saves or shares the file.
- HR: **Upload payslips** screen with period picker, multi-file picker and the result summary.

### 7.4 API
```
POST  /payslips/upload?period=YYYY-MM     (HR; multipart, many files) → { matched[], unmatched[], invalid[], replaced[] }
GET   /payslips?period=&scope=mine|team|all&businessUnitId=
GET   /payslips/:id/download              → { url, expiresAt }
GET   /payslips/:id/versions              (HR)
```

---

## 8. Feature E — Daily task allotment (OM → RM)

### 8.1 Rules
- Only **OMs** create tasks, only for **RMs reporting to them**, in a business unit they share.
- Task fields: date (default today; allow future dates), business unit, title (required), details, priority (Normal/High), assigned RM(s). Assigning to several RMs creates one task per RM.
- RM actions per task: mark **Completed** (comment optional) or **Not done** (reason required), plus optional comment. Then **Submit**.
- On submit: notify the OM and HR (§10). After submission the task is locked; the OM can reopen it with a comment, which notifies the RM.
- Tasks not submitted by end of day stay `PENDING` and show as overdue (red) on both sides.

### 8.2 Screens
- **OM – Tasks:** "Allot task" form; list by date with per-RM status (Pending / Completed / Not done / Overdue) and the RM's reason/comments.
- **RM – My tasks:** two tabs, **Allotted** (pending, today first, overdue highlighted) and **Completed** (submitted history with status, reason and comments). Task detail has the Completed / Not done choice, reason/comment box and Submit.
- **HR – Tasks:** read-only list across its business units, filter by date, BU, OM, RM, status.

### 8.3 API
```
POST  /tasks                                 (OM)
GET   /tasks?scope=allotted|assigned|all&date=&from=&to=&status=&businessUnitId=
POST  /tasks/:id/submit    { status: COMPLETED | NOT_DONE, reason?, comment? }   (RM)
POST  /tasks/:id/reopen    { comment }       (OM)
```

---

## 9. Feature F — Attendance report and director dashboard

### 9.1 Attendance report
- Available to all four roles, scoped by §11.
- Filters: business unit, date range (default current month), role/category (Driver, Loadman, RM, OM, HR), employee, attendance status, approval status.
- **View in app:** (a) monthly muster grid (employees as rows, days as columns, status letters P/A/HD/L/OD/WO/H, colour-coded) and (b) a summary table per employee (present days, absent, half-days, leave, OD, weekly offs, pending approvals).
- **Download:** Excel (.xlsx: sheet 1 muster, sheet 2 summary) and PDF (landscape muster). Files are generated server-side, include the BU name, period and generated-by/at in the header, and are delivered via a signed URL. Every download is audit-logged.

### 9.2 Director dashboard (home screen for DIRECTOR)
Cards per business unit (with BU selector and "All"):
- Today: present %, absent count, on leave, on OD, attendance not yet marked
- Pending approvals: attendance, leave/OD, allowances (counts, tap to open)
- Allowances this month: requested vs approved amount
- Tasks: today's completion rate per OM
- Quick links: attendance report, leave and OD list, allowance list, user management

Other roles get a smaller home with their own pending items and the cards relevant to their scope.

### 9.3 API
```
GET  /reports/attendance?format=json|xlsx|pdf&businessUnitId=&from=&to=&role=&employeeId=&status=
GET  /reports/dashboard?businessUnitId=
```

---

## 10. Notifications

Deliver as in-app notifications (bell icon with unread count and a Notifications screen) **and** FCM push. Store in a `Notification` table (recipientUserId, type, title, body, entityType, entityId, businessUnitId, readAt).

| Event | Notify |
| --- | --- |
| RM self-attendance submitted | Their OM |
| OM self-attendance submitted | Their HR |
| HR self-attendance submitted | Director |
| Self-attendance approved/rejected | The person |
| Driver/loadman leave or OD approved by RM | HR |
| RM leave/OD submitted | Their OM; HR |
| OM leave/OD submitted | Their HR |
| HR leave/OD submitted | Director |
| Any leave/OD approved/rejected | The requester; HR if subject is RM or below |
| RM allowance submitted (self or team) | Their OM; HR |
| OM allowance submitted | Their HR |
| Allowance approved/rejected | Requester; HR for RM requests |
| Task allotted | The RM |
| Task submitted (completed or not done) | The OM; HR |
| Task reopened | The RM |
| Payslips uploaded for a period | Optional: RMs and OMs in those BUs |
| Password reset by director | The user (in-app on next login) |

Tapping a notification opens the related record.

---

## 11. Visibility matrix (summary; enforce in the API)

All rows are also limited to the viewer's business units (director: all).

| Data | RM | OM | HR | Director |
| --- | --- | --- | --- | --- |
| Driver/loadman records | Own reports | Of their RMs (read) | All | All |
| Attendance | Self + own drivers/loadmen | Self + their RMs (+ RMs' teams, read) | All | All |
| Attendance approvals | — | Their RMs | Their OMs | HR |
| Leave/OD | Self + own team | Self + their RMs (+ RMs' teams, read) | All | All |
| Allowances | Self + own team | Self + their RMs' requests | All | All |
| Payslips | Self + own drivers/loadmen | Self + their RMs | All | All |
| Tasks | Assigned to them | Allotted by them | All | All |
| Reports | Self + team | Self + RMs + RMs' teams | All | All |
| User management | — | — | Driver/loadman records only | Everything |

Write API tests for every cell: at least one allowed and one forbidden case per role.

---

## 12. Build order (milestones)

- [x] **M0 – Gap analysis.** Produce `docs/phase-2-gap.md` and the data-migration plan. Stop and summarise.
- [x] **M1 – Foundation changes.** Roles (remove OPERATIONAL_HEAD, add DIRECTOR, LOADMAN), reporting line + validation, business units (seed 4, membership, backfill), `canAccess` + query helper with tests, empID + password auth replacing OTP, lockout, director user management (create, reset password, unlock, deactivate), login screen with logo, BU switcher, My Profile.
- [x] **M2 – Attendance.** Team marking for RM, self-marking with approval chain, approvals screens, edit window and corrections, notifications infrastructure (table, bell, FCM) used by attendance.
- [x] **M3 – Leave and OD.** Unified requests, routing per §5.1, auto-attendance on approval, HR read-only list, notifications.
- [x] **M4 – Allowances.** Types, requests with batch for team, voice note recording and playback, receipt photo, approvals with amount change, notifications.
- [x] **M5 – Payslips.** Bulk upload with filename matching and result report, versioning, visibility per §7.2, in-app PDF viewer and download.
- [x] **M6 – Tasks.** Allotment, RM Allotted/Completed views, submit and reopen, overdue state, notifications.
- [x] **M7 – Reports and dashboard.** Attendance muster and summary, xlsx and PDF export, director dashboard, role home screens.
- [x] **M8 – Hardening.** Full visibility-matrix test suite, audit coverage check, performance check on reports for 1,000 employees × 31 days, update CLAUDE.md, write `docs/phase-2-summary.md`.

Suggested Flutter packages (confirm compatibility before adding): `record` (voice notes), `just_audio` (playback), `file_picker` (multi-PDF upload), `pdfx` or `syncfusion_flutter_pdfviewer` (PDF viewer; check licence), `share_plus`, `image_picker`.
Suggested API packages: `multer` (or presigned uploads), `exceljs` (xlsx), `pdfkit` or `puppeteer` (PDF report; prefer pdfkit to avoid a headless browser), `argon2`.

---

## 13. Assumptions to confirm (keep as settings or TODO(business) until answered)

1. Director's own attendance is not tracked.
2. A manager's own records (attendance, leave, allowance, payslip) belong to their **primary** business unit.
3. An OM sees payslips of their RMs only, not of the drivers/loadmen under those RMs. (Change in §7.2 if OMs should see drivers too.)
4. Drivers and loadmen belong to exactly one business unit and one RM.
5. HR is notified but does not approve driver/loadman leave/OD.
6. Approval for OM items goes to the OM's `reportingTo` HR; if several HR users exist, any HR sharing the BU can act as backup.
7. Allowance types, amount limits, leave types and the attendance edit window are configurable by HR/director; seed values are placeholders.
8. Payslip file name is exactly `payslip-<empid>.pdf`; one file per employee per month.
9. Voice notes are stored as audio only (no speech-to-text) in this phase.
10. Users never change their own password; only the director sets and resets passwords.

---

## 14. Kickoff prompts (paste one per session)

**M0**
> Read CLAUDE.md and PHASE-2-FEATURES.md fully. Do milestone M0 only: analyse the current codebase against PHASE-2-FEATURES.md and write docs/phase-2-gap.md covering existing vs required data model, API, Flutter screens, auth, and a step-by-step migration plan for existing data (roles, OTP removal, business-unit backfill). Do not change application code. End with a summary and any blocking questions.

**M1**
> Read CLAUDE.md, PHASE-2-FEATURES.md and docs/phase-2-gap.md. Implement milestone M1 exactly as specified in §1, §2 and §3. Start with a written plan listing files to change. Include migrations, seed (4 business units, one director), the canAccess helper with tests for every role, employee ID + password login replacing OTP, lockout, director user management endpoints and screens, the login screen with logo placeholder, BU switcher and My Profile. Run all checks, regenerate OpenAPI and the Flutter client, and append to docs/phase-2-progress.md.

**M2 to M7** (change the milestone and sections)
> Read CLAUDE.md, PHASE-2-FEATURES.md and docs/phase-2-progress.md. Implement milestone M<n> (§<sections>). Plan first, then build API, tests (including visibility-matrix cases from §11 for this feature), notifications from §10, and Flutter screens. Run all checks, regenerate OpenAPI and the Flutter client, update docs/phase-2-progress.md, and list any TODO(business) items.

**M8**
> Read all docs. Implement milestone M8: complete the §11 visibility test suite, verify every write is audit-logged, load-test the attendance report, update CLAUDE.md to reflect all Phase 2 decisions (roles, auth, business units, payslip upload, cancelled payroll engine) and write docs/phase-2-summary.md.
