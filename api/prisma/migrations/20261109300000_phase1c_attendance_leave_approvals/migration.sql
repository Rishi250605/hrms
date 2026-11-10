-- CreateEnum
CREATE TYPE "AttendanceStatus" AS ENUM ('PRESENT', 'ABSENT', 'HALF_DAY', 'ON_LEAVE', 'WEEKLY_OFF', 'HOLIDAY', 'ON_DUTY_OUTSTATION');

-- CreateEnum
CREATE TYPE "AttendanceSource" AS ENUM ('MANAGER', 'BIOMETRIC', 'TELEMATICS', 'IMPORT');

-- CreateEnum
CREATE TYPE "ApprovalEntityType" AS ENUM ('LEAVE', 'ADVANCE', 'SWAP', 'ATTENDANCE_CORRECTION', 'RECOVERY', 'POLICY_EXCEPTION');

-- CreateEnum
CREATE TYPE "ApprovalStatus" AS ENUM ('PENDING', 'APPROVED', 'REJECTED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "ApprovalStepStatus" AS ENUM ('WAITING', 'PENDING', 'APPROVED', 'REJECTED', 'SKIPPED', 'CANCELLED');

-- CreateTable
CREATE TABLE "attendance_marks" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "depot_id" UUID NOT NULL,
    "date" DATE NOT NULL,
    "status" "AttendanceStatus" NOT NULL,
    "duty_assignment_id" UUID,
    "marked_by_id" UUID NOT NULL,
    "marked_at" TIMESTAMPTZ(3) NOT NULL,
    "source" "AttendanceSource" NOT NULL DEFAULT 'MANAGER',
    "client_mutation_id" TEXT,
    "note" TEXT,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "attendance_marks_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "attendance_corrections" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "depot_id" UUID NOT NULL,
    "date" DATE NOT NULL,
    "from_status" "AttendanceStatus",
    "to_status" "AttendanceStatus" NOT NULL,
    "note" TEXT,
    "reason" TEXT NOT NULL,
    "status" "ApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "raised_by_id" UUID NOT NULL,
    "approval_request_id" UUID,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "attendance_corrections_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "leave_types" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "paid" BOOLEAN NOT NULL,
    "accrual_rule" JSONB NOT NULL,
    "carry_forward_max" DECIMAL(7,2) NOT NULL DEFAULT 0,
    "encashable" BOOLEAN NOT NULL DEFAULT false,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "leave_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "leave_policies" (
    "id" UUID NOT NULL,
    "leave_type_id" UUID NOT NULL,
    "category" "EmployeeCategory",
    "employment_type" "EmploymentType",
    "state" TEXT,
    "annual_quota" DECIMAL(7,2) NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "leave_policies_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "leave_balances" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "leave_type_id" UUID NOT NULL,
    "year" INTEGER NOT NULL,
    "opening" DECIMAL(7,2) NOT NULL DEFAULT 0,
    "accrued" DECIMAL(7,2) NOT NULL DEFAULT 0,
    "used" DECIMAL(7,2) NOT NULL DEFAULT 0,
    "encashed" DECIMAL(7,2) NOT NULL DEFAULT 0,
    "closing" DECIMAL(7,2) NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "leave_balances_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "leave_accrual_logs" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "leave_type_id" UUID NOT NULL,
    "period" TEXT NOT NULL,
    "days" DECIMAL(7,2) NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "leave_accrual_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "leave_requests" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "depot_id" UUID NOT NULL,
    "leave_type_id" UUID NOT NULL,
    "from_date" DATE NOT NULL,
    "to_date" DATE NOT NULL,
    "from_half" BOOLEAN NOT NULL DEFAULT false,
    "to_half" BOOLEAN NOT NULL DEFAULT false,
    "days" DECIMAL(7,2) NOT NULL,
    "reason" TEXT NOT NULL,
    "status" "ApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "raised_by_id" UUID NOT NULL,
    "approval_request_id" UUID,
    "decided_at" TIMESTAMPTZ(3),
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "leave_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "approval_rules" (
    "id" UUID NOT NULL,
    "entity_type" "ApprovalEntityType" NOT NULL,
    "name" TEXT NOT NULL,
    "condition" JSONB NOT NULL,
    "steps" JSONB NOT NULL,
    "escalate_after_hours" INTEGER NOT NULL DEFAULT 24,
    "priority" INTEGER NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "approval_rules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "approval_requests" (
    "id" UUID NOT NULL,
    "entity_type" "ApprovalEntityType" NOT NULL,
    "entity_id" UUID NOT NULL,
    "employee_id" UUID,
    "depot_id" UUID NOT NULL,
    "rule_id" UUID,
    "status" "ApprovalStatus" NOT NULL DEFAULT 'PENDING',
    "current_step" INTEGER NOT NULL DEFAULT 1,
    "raised_by_id" UUID NOT NULL,
    "summary" TEXT NOT NULL,
    "facts" JSONB,
    "decided_at" TIMESTAMPTZ(3),
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "approval_requests_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "approval_steps" (
    "id" UUID NOT NULL,
    "approval_request_id" UUID NOT NULL,
    "step_order" INTEGER NOT NULL,
    "approver_role" "Role" NOT NULL,
    "approver_user_id" UUID,
    "status" "ApprovalStepStatus" NOT NULL DEFAULT 'WAITING',
    "acted_by_id" UUID,
    "acted_at" TIMESTAMPTZ(3),
    "comment" TEXT,
    "activated_at" TIMESTAMPTZ(3),
    "due_at" TIMESTAMPTZ(3),
    "escalated_at" TIMESTAMPTZ(3),
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "approval_steps_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "attendance_marks_client_mutation_id_key" ON "attendance_marks"("client_mutation_id");

-- CreateIndex
CREATE INDEX "attendance_marks_depot_id_date_idx" ON "attendance_marks"("depot_id", "date");

-- CreateIndex
CREATE UNIQUE INDEX "attendance_marks_employee_id_date_source_key" ON "attendance_marks"("employee_id", "date", "source");

-- CreateIndex
CREATE UNIQUE INDEX "attendance_corrections_approval_request_id_key" ON "attendance_corrections"("approval_request_id");

-- CreateIndex
CREATE INDEX "attendance_corrections_employee_id_date_idx" ON "attendance_corrections"("employee_id", "date");

-- CreateIndex
CREATE UNIQUE INDEX "leave_types_code_key" ON "leave_types"("code");

-- CreateIndex
CREATE INDEX "leave_policies_leave_type_id_idx" ON "leave_policies"("leave_type_id");

-- CreateIndex
CREATE UNIQUE INDEX "leave_balances_employee_id_leave_type_id_year_key" ON "leave_balances"("employee_id", "leave_type_id", "year");

-- CreateIndex
CREATE UNIQUE INDEX "leave_accrual_logs_employee_id_leave_type_id_period_key" ON "leave_accrual_logs"("employee_id", "leave_type_id", "period");

-- CreateIndex
CREATE UNIQUE INDEX "leave_requests_approval_request_id_key" ON "leave_requests"("approval_request_id");

-- CreateIndex
CREATE INDEX "leave_requests_employee_id_from_date_idx" ON "leave_requests"("employee_id", "from_date");

-- CreateIndex
CREATE INDEX "leave_requests_depot_id_status_idx" ON "leave_requests"("depot_id", "status");

-- CreateIndex
CREATE INDEX "approval_rules_entity_type_idx" ON "approval_rules"("entity_type");

-- CreateIndex
CREATE INDEX "approval_requests_status_depot_id_idx" ON "approval_requests"("status", "depot_id");

-- CreateIndex
CREATE INDEX "approval_requests_raised_by_id_status_idx" ON "approval_requests"("raised_by_id", "status");

-- CreateIndex
CREATE UNIQUE INDEX "approval_requests_entity_type_entity_id_key" ON "approval_requests"("entity_type", "entity_id");

-- CreateIndex
CREATE INDEX "approval_steps_status_approver_role_idx" ON "approval_steps"("status", "approver_role");

-- CreateIndex
CREATE UNIQUE INDEX "approval_steps_approval_request_id_step_order_key" ON "approval_steps"("approval_request_id", "step_order");

-- AddForeignKey
ALTER TABLE "attendance_marks" ADD CONSTRAINT "attendance_marks_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "leave_policies" ADD CONSTRAINT "leave_policies_leave_type_id_fkey" FOREIGN KEY ("leave_type_id") REFERENCES "leave_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "leave_balances" ADD CONSTRAINT "leave_balances_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "leave_balances" ADD CONSTRAINT "leave_balances_leave_type_id_fkey" FOREIGN KEY ("leave_type_id") REFERENCES "leave_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "leave_requests" ADD CONSTRAINT "leave_requests_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "leave_requests" ADD CONSTRAINT "leave_requests_leave_type_id_fkey" FOREIGN KEY ("leave_type_id") REFERENCES "leave_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "approval_steps" ADD CONSTRAINT "approval_steps_approval_request_id_fkey" FOREIGN KEY ("approval_request_id") REFERENCES "approval_requests"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ─────────────── Hand-written constraints ───────────────
ALTER TABLE "leave_requests" ADD CONSTRAINT "leave_requests_dates_chk" CHECK ("to_date" >= "from_date" AND "days" > 0);
ALTER TABLE "leave_policies" ADD CONSTRAINT "leave_policies_quota_chk" CHECK ("annual_quota" >= 0);
ALTER TABLE "approval_rules" ADD CONSTRAINT "approval_rules_escalate_chk" CHECK ("escalate_after_hours" > 0);
-- Only one step of a request is pending at a time.
CREATE UNIQUE INDEX "approval_steps_one_pending" ON "approval_steps"("approval_request_id") WHERE "status" = 'PENDING';