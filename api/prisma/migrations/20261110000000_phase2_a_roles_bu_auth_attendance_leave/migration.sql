-- ─────────────── Phase 2 Stage A (PHASE-2-FEATURES §1–§5; docs/phase-2-gap.md §7) ───────────────
-- Safety checks: this migration only runs on a database without Phase-1 data that needs a manual
-- backfill. With real data, follow docs/phase-2-gap.md §7 first (dev databases are reset and reseeded).
DO $$
BEGIN
  IF EXISTS (SELECT 1 FROM "users" WHERE "role"::text = 'OPERATIONAL_HEAD') THEN
    RAISE EXCEPTION 'Phase 2 migration stopped: users with role OPERATIONAL_HEAD exist (%). Change their role or deactivate them first (PHASE-2-FEATURES §1.1).',
      (SELECT string_agg("phone", ', ') FROM "users" WHERE "role"::text = 'OPERATIONAL_HEAD');
  END IF;
  IF EXISTS (SELECT 1 FROM "users" WHERE "employee_id" IS NULL) THEN
    RAISE EXCEPTION 'Phase 2 migration stopped: every user must be linked to an employee with an employee ID first (docs/phase-2-gap.md §7.4).';
  END IF;
  IF EXISTS (SELECT 1 FROM "depots") THEN
    RAISE EXCEPTION 'Phase 2 migration stopped: existing depots must be mapped to business units first (docs/phase-2-gap.md §7.2).';
  END IF;
  IF EXISTS (SELECT 1 FROM "attendance_marks") OR EXISTS (SELECT 1 FROM "leave_requests") OR EXISTS (SELECT 1 FROM "attendance_corrections") THEN
    RAISE EXCEPTION 'Phase 2 migration stopped: attendance / leave rows need a business-unit backfill first (docs/phase-2-gap.md §7.8).';
  END IF;
END $$;

-- The generic approval engine is retired (decision Q5). Drop it first: approval_steps uses the old Role type.
DROP TABLE "approval_steps";
DROP TABLE "approval_requests";
DROP TABLE "approval_rules";

-- CreateEnum
CREATE TYPE "RequestStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "ApprovalState" AS ENUM ('PENDING_APPROVAL', 'APPROVED', 'REJECTED');

-- CreateEnum
CREATE TYPE "LeaveKind" AS ENUM ('LEAVE', 'OD');

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "AttendanceSource" ADD VALUE 'SELF';
ALTER TYPE "AttendanceSource" ADD VALUE 'SYSTEM';

-- AlterEnum
BEGIN;
CREATE TYPE "AttendanceStatus_new" AS ENUM ('PRESENT', 'ABSENT', 'HALF_DAY', 'ON_LEAVE', 'ON_DUTY', 'WEEKLY_OFF', 'HOLIDAY');
ALTER TABLE "attendance_marks" ALTER COLUMN "status" TYPE "AttendanceStatus_new" USING ("status"::text::"AttendanceStatus_new");
ALTER TABLE "attendance_corrections" ALTER COLUMN "from_status" TYPE "AttendanceStatus_new" USING ("from_status"::text::"AttendanceStatus_new");
ALTER TABLE "attendance_corrections" ALTER COLUMN "to_status" TYPE "AttendanceStatus_new" USING ("to_status"::text::"AttendanceStatus_new");
ALTER TYPE "AttendanceStatus" RENAME TO "AttendanceStatus_old";
ALTER TYPE "AttendanceStatus_new" RENAME TO "AttendanceStatus";
DROP TYPE "public"."AttendanceStatus_old";
COMMIT;

-- AlterEnum
ALTER TYPE "EmployeeCategory" ADD VALUE 'LOADMAN';

-- AlterEnum
BEGIN;
CREATE TYPE "Role_new" AS ENUM ('DIRECTOR', 'HR', 'OPERATIONAL_MANAGER', 'REGIONAL_MANAGER');
ALTER TABLE "users" ALTER COLUMN "role" TYPE "Role_new" USING ("role"::text::"Role_new");
ALTER TYPE "Role" RENAME TO "Role_old";
ALTER TYPE "Role_new" RENAME TO "Role";
DROP TYPE "public"."Role_old";
COMMIT;

-- DropForeignKey
ALTER TABLE "employee_jobs" DROP CONSTRAINT "employee_jobs_reporting_user_id_fkey";

-- DropForeignKey
ALTER TABLE "otp_challenges" DROP CONSTRAINT "otp_challenges_user_id_fkey";

-- DropForeignKey
ALTER TABLE "user_scopes" DROP CONSTRAINT "user_scopes_depot_id_fkey";

-- DropForeignKey
ALTER TABLE "user_scopes" DROP CONSTRAINT "user_scopes_region_id_fkey";

-- DropForeignKey
ALTER TABLE "user_scopes" DROP CONSTRAINT "user_scopes_user_id_fkey";

-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_employee_id_fkey";

-- DropIndex
DROP INDEX "attendance_corrections_approval_request_id_key";

-- DropIndex
DROP INDEX "attendance_marks_depot_id_date_idx";

-- DropIndex
DROP INDEX "attendance_marks_employee_id_date_source_key";

-- DropIndex
DROP INDEX "leave_requests_approval_request_id_key";

-- DropIndex
DROP INDEX "leave_requests_depot_id_status_idx";

-- AlterTable
ALTER TABLE "attendance_corrections" DROP COLUMN "approval_request_id",
DROP COLUMN "depot_id",
ADD COLUMN     "approver_employee_id" UUID NOT NULL,
ADD COLUMN     "approver_role" "Role" NOT NULL,
ADD COLUMN     "business_unit_id" UUID NOT NULL,
ADD COLUMN     "decided_at" TIMESTAMPTZ(3),
ADD COLUMN     "decided_by_id" UUID,
ADD COLUMN     "rejection_reason" TEXT,
DROP COLUMN "status",
ADD COLUMN     "status" "RequestStatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "attendance_marks" DROP COLUMN "depot_id",
ADD COLUMN     "approval_state" "ApprovalState" NOT NULL,
ADD COLUMN     "approver_employee_id" UUID,
ADD COLUMN     "approver_role" "Role",
ADD COLUMN     "business_unit_id" UUID NOT NULL,
ADD COLUMN     "decided_at" TIMESTAMPTZ(3),
ADD COLUMN     "decided_by_id" UUID,
ADD COLUMN     "leave_request_id" UUID,
ADD COLUMN     "rejection_reason" TEXT,
ALTER COLUMN "source" DROP DEFAULT;

-- AlterTable
ALTER TABLE "depots" ADD COLUMN     "business_unit_id" UUID NOT NULL;

-- AlterTable
ALTER TABLE "employee_jobs" DROP COLUMN "reporting_user_id",
ADD COLUMN     "reporting_to_employee_id" UUID;

-- AlterTable
ALTER TABLE "leave_requests" DROP COLUMN "approval_request_id",
DROP COLUMN "depot_id",
ADD COLUMN     "approver_employee_id" UUID NOT NULL,
ADD COLUMN     "approver_role" "Role" NOT NULL,
ADD COLUMN     "business_unit_id" UUID NOT NULL,
ADD COLUMN     "cancelled_at" TIMESTAMPTZ(3),
ADD COLUMN     "cancelled_by_id" UUID,
ADD COLUMN     "decided_by_id" UUID,
ADD COLUMN     "kind" "LeaveKind" NOT NULL,
ADD COLUMN     "od_from_time" TEXT,
ADD COLUMN     "od_location" TEXT,
ADD COLUMN     "od_purpose" TEXT,
ADD COLUMN     "od_to_time" TEXT,
ADD COLUMN     "rejection_reason" TEXT,
ALTER COLUMN "leave_type_id" DROP NOT NULL,
DROP COLUMN "status",
ADD COLUMN     "status" "RequestStatus" NOT NULL DEFAULT 'PENDING';

-- AlterTable
ALTER TABLE "users" DROP COLUMN "is_super_admin",
ADD COLUMN     "failed_login_count" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "failed_window_started_at" TIMESTAMPTZ(3),
ADD COLUMN     "locked_until" TIMESTAMPTZ(3),
ADD COLUMN     "password_changed_at" TIMESTAMPTZ(3),
ADD COLUMN     "password_hash" TEXT,
ALTER COLUMN "employee_id" SET NOT NULL;

-- DropTable
DROP TABLE "notification_logs";

-- DropTable
DROP TABLE "otp_challenges";

-- DropTable
DROP TABLE "user_scopes";

-- DropEnum
DROP TYPE "ApprovalEntityType";

-- DropEnum
DROP TYPE "ApprovalStatus";

-- DropEnum
DROP TYPE "ApprovalStepStatus";

-- DropEnum
DROP TYPE "NotificationChannel";

-- Recreate NotificationStatus (its old table notification_logs is dropped above).
DROP TYPE "NotificationStatus";
CREATE TYPE "NotificationStatus" AS ENUM ('STORED', 'SENT', 'FAILED');

-- CreateTable
CREATE TABLE "business_units" (
    "id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "business_units_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "notifications" (
    "id" UUID NOT NULL,
    "recipient_user_id" UUID NOT NULL,
    "type" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "body" TEXT NOT NULL,
    "entity_type" TEXT,
    "entity_id" TEXT,
    "business_unit_id" UUID NOT NULL,
    "push_status" "NotificationStatus" NOT NULL DEFAULT 'STORED',
    "read_at" TIMESTAMPTZ(3),
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "notifications_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employee_business_units" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "business_unit_id" UUID NOT NULL,
    "is_primary" BOOLEAN NOT NULL DEFAULT false,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_by_id" UUID,

    CONSTRAINT "employee_business_units_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "business_units_code_key" ON "business_units"("code");

-- CreateIndex
CREATE INDEX "notifications_recipient_user_id_created_at_idx" ON "notifications"("recipient_user_id", "created_at");

-- CreateIndex
CREATE INDEX "employee_business_units_business_unit_id_idx" ON "employee_business_units"("business_unit_id");

-- CreateIndex
CREATE UNIQUE INDEX "employee_business_units_employee_id_business_unit_id_key" ON "employee_business_units"("employee_id", "business_unit_id");

-- CreateIndex
CREATE INDEX "attendance_corrections_approver_employee_id_status_idx" ON "attendance_corrections"("approver_employee_id", "status");

-- CreateIndex
CREATE INDEX "attendance_marks_business_unit_id_date_idx" ON "attendance_marks"("business_unit_id", "date");

-- CreateIndex
CREATE INDEX "attendance_marks_approver_employee_id_approval_state_idx" ON "attendance_marks"("approver_employee_id", "approval_state");

-- CreateIndex
CREATE UNIQUE INDEX "attendance_marks_employee_id_date_key" ON "attendance_marks"("employee_id", "date");

-- CreateIndex
CREATE INDEX "depots_business_unit_id_idx" ON "depots"("business_unit_id");

-- CreateIndex
CREATE INDEX "employee_jobs_reporting_to_employee_id_idx" ON "employee_jobs"("reporting_to_employee_id");

-- CreateIndex
CREATE INDEX "leave_requests_business_unit_id_status_idx" ON "leave_requests"("business_unit_id", "status");

-- CreateIndex
CREATE INDEX "leave_requests_approver_employee_id_status_idx" ON "leave_requests"("approver_employee_id", "status");

-- AddForeignKey
ALTER TABLE "depots" ADD CONSTRAINT "depots_business_unit_id_fkey" FOREIGN KEY ("business_unit_id") REFERENCES "business_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "notifications" ADD CONSTRAINT "notifications_recipient_user_id_fkey" FOREIGN KEY ("recipient_user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee_business_units" ADD CONSTRAINT "employee_business_units_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee_business_units" ADD CONSTRAINT "employee_business_units_business_unit_id_fkey" FOREIGN KEY ("business_unit_id") REFERENCES "business_units"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee_jobs" ADD CONSTRAINT "employee_jobs_reporting_to_employee_id_fkey" FOREIGN KEY ("reporting_to_employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- ─────────────── Hand-written constraints ───────────────
-- Employee IDs are unique case-insensitively (PHASE-2-FEATURES §1.3).
CREATE UNIQUE INDEX "employees_emp_code_lower_key" ON "employees" (lower("emp_code"));
-- At most one primary business unit per employee.
CREATE UNIQUE INDEX "employee_business_units_one_primary" ON "employee_business_units"("employee_id") WHERE "is_primary";
-- Leave needs a type; OD needs a location and purpose.
ALTER TABLE "leave_requests" ADD CONSTRAINT "leave_requests_kind_fields_chk"
    CHECK (("kind" <> 'LEAVE' OR "leave_type_id" IS NOT NULL) AND ("kind" <> 'OD' OR ("od_location" IS NOT NULL AND "od_purpose" IS NOT NULL)));
-- Self-marks pending approval name their approver.
ALTER TABLE "attendance_marks" ADD CONSTRAINT "attendance_marks_pending_approver_chk"
    CHECK ("approval_state" <> 'PENDING_APPROVAL' OR "approver_employee_id" IS NOT NULL);