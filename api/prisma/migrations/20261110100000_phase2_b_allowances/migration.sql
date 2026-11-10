-- CreateTable
CREATE TABLE "allowance_types" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "max_amount_paise" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "allowance_types_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "allowance_requests" (
    "id" UUID NOT NULL,
    "batch_id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "raised_by_employee_id" UUID NOT NULL,
    "raised_by_id" UUID NOT NULL,
    "business_unit_id" UUID NOT NULL,
    "allowance_type_id" UUID NOT NULL,
    "requested_amount_paise" INTEGER NOT NULL,
    "approved_amount_paise" INTEGER,
    "from_date" DATE NOT NULL,
    "to_date" DATE NOT NULL,
    "comment" TEXT,
    "voice_note_key" TEXT,
    "receipt_key" TEXT,
    "status" "RequestStatus" NOT NULL DEFAULT 'PENDING',
    "approver_employee_id" UUID NOT NULL,
    "approver_role" "Role" NOT NULL,
    "decided_by_id" UUID,
    "decided_at" TIMESTAMPTZ(3),
    "decision_comment" TEXT,
    "rejection_reason" TEXT,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "allowance_requests_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "allowance_types_code_key" ON "allowance_types"("code");

-- CreateIndex
CREATE INDEX "allowance_requests_batch_id_idx" ON "allowance_requests"("batch_id");

-- CreateIndex
CREATE INDEX "allowance_requests_approver_employee_id_status_idx" ON "allowance_requests"("approver_employee_id", "status");

-- CreateIndex
CREATE INDEX "allowance_requests_business_unit_id_status_idx" ON "allowance_requests"("business_unit_id", "status");

-- CreateIndex
CREATE INDEX "allowance_requests_employee_id_from_date_idx" ON "allowance_requests"("employee_id", "from_date");

-- CreateIndex
CREATE INDEX "allowance_requests_raised_by_employee_id_idx" ON "allowance_requests"("raised_by_employee_id");

-- AddForeignKey
ALTER TABLE "allowance_requests" ADD CONSTRAINT "allowance_requests_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "allowance_requests" ADD CONSTRAINT "allowance_requests_allowance_type_id_fkey" FOREIGN KEY ("allowance_type_id") REFERENCES "allowance_types"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- ─────────────── Hand-written constraints ───────────────
ALTER TABLE "allowance_requests" ADD CONSTRAINT "allowance_requests_amounts_chk"
    CHECK ("requested_amount_paise" > 0 AND ("approved_amount_paise" IS NULL OR "approved_amount_paise" > 0));
ALTER TABLE "allowance_requests" ADD CONSTRAINT "allowance_requests_dates_chk" CHECK ("to_date" >= "from_date");
-- A comment or a voice note is required (§6.2).
ALTER TABLE "allowance_requests" ADD CONSTRAINT "allowance_requests_explanation_chk"
    CHECK ("comment" IS NOT NULL OR "voice_note_key" IS NOT NULL);