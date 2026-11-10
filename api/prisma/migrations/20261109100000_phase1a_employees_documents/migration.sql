-- CreateEnum
CREATE TYPE "NotificationChannel" AS ENUM ('PUSH', 'SMS', 'WHATSAPP');

-- CreateEnum
CREATE TYPE "NotificationStatus" AS ENUM ('QUEUED', 'SENT', 'FAILED', 'STORED');

-- CreateEnum
CREATE TYPE "EmployeeCategory" AS ENUM ('DRIVER', 'CONDUCTOR', 'HELPER', 'MECHANIC', 'DEPOT_STAFF', 'OFFICE');

-- CreateEnum
CREATE TYPE "EmploymentType" AS ENUM ('PERMANENT', 'FIXED_TERM', 'CONTRACT');

-- CreateEnum
CREATE TYPE "EmployeeStatus" AS ENUM ('ACTIVE', 'ON_NOTICE', 'EXITED', 'SUSPENDED');

-- CreateEnum
CREATE TYPE "Gender" AS ENUM ('MALE', 'FEMALE', 'OTHER');

-- CreateEnum
CREATE TYPE "PreferredChannel" AS ENUM ('WHATSAPP', 'SMS');

-- CreateEnum
CREATE TYPE "DocumentType" AS ENUM ('DRIVING_LICENCE', 'PSV_BADGE', 'MEDICAL_FITNESS', 'POLICE_VERIFICATION', 'AADHAAR', 'PAN', 'TRAINING_CERT', 'OTHER');

-- CreateEnum
CREATE TYPE "DocumentStatus" AS ENUM ('PENDING_VERIFICATION', 'VERIFIED', 'REJECTED', 'EXPIRED');

-- CreateTable
CREATE TABLE "settings" (
    "key" TEXT NOT NULL,
    "value" JSONB NOT NULL,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "updated_by_id" UUID,

    CONSTRAINT "settings_pkey" PRIMARY KEY ("key")
);

-- CreateTable
CREATE TABLE "notification_logs" (
    "id" UUID NOT NULL,
    "recipient_user_id" UUID,
    "recipient_phone" TEXT,
    "channel" "NotificationChannel" NOT NULL,
    "template" TEXT NOT NULL,
    "title" TEXT,
    "body" TEXT,
    "payload" JSONB,
    "status" "NotificationStatus" NOT NULL,
    "provider_ref" TEXT,
    "error" TEXT,
    "read_at" TIMESTAMPTZ(3),
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "notification_logs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "device_tokens" (
    "id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "token" TEXT NOT NULL,
    "platform" TEXT NOT NULL,
    "last_seen_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "device_tokens_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employees" (
    "id" UUID NOT NULL,
    "emp_code" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "alt_phone" TEXT,
    "dob" DATE,
    "gender" "Gender",
    "joining_date" DATE NOT NULL,
    "exit_date" DATE,
    "exit_reason" TEXT,
    "category" "EmployeeCategory" NOT NULL,
    "employment_type" "EmploymentType" NOT NULL,
    "contractor_name" TEXT,
    "status" "EmployeeStatus" NOT NULL DEFAULT 'ACTIVE',
    "photo_key" TEXT,
    "uan" TEXT,
    "esic_no" TEXT,
    "pan_encrypted" TEXT,
    "pan_last4" TEXT,
    "aadhaar_last4" TEXT,
    "bank_account_encrypted" TEXT,
    "bank_account_last4" TEXT,
    "ifsc" TEXT,
    "preferred_channel" "PreferredChannel" NOT NULL DEFAULT 'WHATSAPP',
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,
    "deleted_at" TIMESTAMPTZ(3),

    CONSTRAINT "employees_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "employee_jobs" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "depot_id" UUID NOT NULL,
    "designation" TEXT NOT NULL,
    "grade" TEXT,
    "reporting_user_id" UUID,
    "effective_from" DATE NOT NULL,
    "effective_to" DATE,
    "change_reason" TEXT,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "employee_jobs_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "documents" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "type" "DocumentType" NOT NULL,
    "number" TEXT NOT NULL,
    "licence_class" TEXT,
    "issue_date" DATE,
    "expiry_date" DATE,
    "file_key" TEXT,
    "status" "DocumentStatus" NOT NULL DEFAULT 'PENDING_VERIFICATION',
    "verified_by_id" UUID,
    "verified_at" TIMESTAMPTZ(3),
    "rejection_reason" TEXT,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "documents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_requirements" (
    "id" UUID NOT NULL,
    "category" "EmployeeCategory" NOT NULL,
    "document_type" "DocumentType" NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "document_requirements_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "document_alerts" (
    "id" UUID NOT NULL,
    "document_id" UUID NOT NULL,
    "threshold_days" INTEGER NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "document_alerts_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "notification_logs_recipient_user_id_created_at_idx" ON "notification_logs"("recipient_user_id", "created_at");

-- CreateIndex
CREATE UNIQUE INDEX "device_tokens_token_key" ON "device_tokens"("token");

-- CreateIndex
CREATE INDEX "device_tokens_user_id_idx" ON "device_tokens"("user_id");

-- CreateIndex
CREATE UNIQUE INDEX "employees_emp_code_key" ON "employees"("emp_code");

-- CreateIndex
CREATE INDEX "employees_full_name_idx" ON "employees"("full_name");

-- CreateIndex
CREATE INDEX "employees_status_idx" ON "employees"("status");

-- CreateIndex
CREATE INDEX "employee_jobs_employee_id_effective_from_idx" ON "employee_jobs"("employee_id", "effective_from");

-- CreateIndex
CREATE INDEX "employee_jobs_depot_id_idx" ON "employee_jobs"("depot_id");

-- CreateIndex
CREATE INDEX "documents_employee_id_type_idx" ON "documents"("employee_id", "type");

-- CreateIndex
CREATE INDEX "documents_status_idx" ON "documents"("status");

-- CreateIndex
CREATE INDEX "documents_expiry_date_idx" ON "documents"("expiry_date");

-- CreateIndex
CREATE UNIQUE INDEX "document_requirements_category_document_type_key" ON "document_requirements"("category", "document_type");

-- CreateIndex
CREATE UNIQUE INDEX "document_alerts_document_id_threshold_days_key" ON "document_alerts"("document_id", "threshold_days");

-- CreateIndex
CREATE UNIQUE INDEX "users_employee_id_key" ON "users"("employee_id");

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "device_tokens" ADD CONSTRAINT "device_tokens_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee_jobs" ADD CONSTRAINT "employee_jobs_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee_jobs" ADD CONSTRAINT "employee_jobs_depot_id_fkey" FOREIGN KEY ("depot_id") REFERENCES "depots"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "employee_jobs" ADD CONSTRAINT "employee_jobs_reporting_user_id_fkey" FOREIGN KEY ("reporting_user_id") REFERENCES "users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "document_alerts" ADD CONSTRAINT "document_alerts_document_id_fkey" FOREIGN KEY ("document_id") REFERENCES "documents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- ─────────────── Hand-written constraints (not expressible in Prisma schema) ───────────────

-- Needed for "employee_id WITH =" inside a GiST exclusion constraint (trusted extension since PG 13).
CREATE EXTENSION IF NOT EXISTS btree_gist;

-- Effective-dated job history: [effective_from, effective_to) with effective_to NULL = open.
ALTER TABLE "employee_jobs" ADD CONSTRAINT "employee_jobs_range_chk"
    CHECK ("effective_to" IS NULL OR "effective_to" > "effective_from");
-- No overlapping ranges per employee (CLAUDE.md §5 Effective dating).
ALTER TABLE "employee_jobs" ADD CONSTRAINT "employee_jobs_no_overlap"
    EXCLUDE USING gist ("employee_id" WITH =, daterange("effective_from", "effective_to", '[)') WITH &&);
-- At most one open row per employee.
CREATE UNIQUE INDEX "employee_jobs_one_open_row" ON "employee_jobs"("employee_id") WHERE "effective_to" IS NULL;

-- Phones in E.164; Aadhaar: last 4 digits only, never the full number.
ALTER TABLE "employees" ADD CONSTRAINT "employees_phone_e164_chk" CHECK ("phone" ~ '^\+[1-9][0-9]{7,14}$');
ALTER TABLE "employees" ADD CONSTRAINT "employees_aadhaar_last4_chk" CHECK ("aadhaar_last4" IS NULL OR "aadhaar_last4" ~ '^[0-9]{4}$');
ALTER TABLE "documents" ADD CONSTRAINT "documents_aadhaar_last4_chk" CHECK ("type" <> 'AADHAAR' OR "number" ~ '^[0-9]{4}$');
ALTER TABLE "documents" ADD CONSTRAINT "documents_dates_chk" CHECK ("issue_date" IS NULL OR "expiry_date" IS NULL OR "expiry_date" >= "issue_date");