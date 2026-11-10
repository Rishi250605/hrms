-- CreateTable
CREATE TABLE "payslips" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "period" CHAR(7) NOT NULL,
    "business_unit_id" UUID NOT NULL,
    "latest_version" INTEGER NOT NULL,
    "file_key" TEXT NOT NULL,
    "size_bytes" INTEGER NOT NULL,
    "uploaded_by_id" UUID NOT NULL,
    "uploaded_at" TIMESTAMPTZ(3) NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "payslips_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payslip_versions" (
    "id" UUID NOT NULL,
    "payslip_id" UUID NOT NULL,
    "version" INTEGER NOT NULL,
    "file_key" TEXT NOT NULL,
    "size_bytes" INTEGER NOT NULL,
    "original_name" TEXT NOT NULL,
    "uploaded_by_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "payslip_versions_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "payslips_period_business_unit_id_idx" ON "payslips"("period", "business_unit_id");

-- CreateIndex
CREATE UNIQUE INDEX "payslips_employee_id_period_key" ON "payslips"("employee_id", "period");

-- CreateIndex
CREATE UNIQUE INDEX "payslip_versions_payslip_id_version_key" ON "payslip_versions"("payslip_id", "version");

-- AddForeignKey
ALTER TABLE "payslips" ADD CONSTRAINT "payslips_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payslip_versions" ADD CONSTRAINT "payslip_versions_payslip_id_fkey" FOREIGN KEY ("payslip_id") REFERENCES "payslips"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- Pay period is YYYY-MM; versions start at 1.
ALTER TABLE "payslips" ADD CONSTRAINT "payslips_period_chk" CHECK ("period" ~ '^\d{4}-(0[1-9]|1[0-2])$' AND "latest_version" >= 1);
ALTER TABLE "payslip_versions" ADD CONSTRAINT "payslip_versions_version_chk" CHECK ("version" >= 1);
