-- CreateEnum
CREATE TYPE "TaskPriority" AS ENUM ('NORMAL', 'HIGH');

-- CreateEnum
CREATE TYPE "TaskStatus" AS ENUM ('PENDING', 'COMPLETED', 'NOT_DONE');

-- CreateTable
CREATE TABLE "tasks" (
    "id" UUID NOT NULL,
    "group_id" UUID NOT NULL,
    "date" DATE NOT NULL,
    "business_unit_id" UUID NOT NULL,
    "title" TEXT NOT NULL,
    "details" TEXT,
    "priority" "TaskPriority" NOT NULL DEFAULT 'NORMAL',
    "allotted_by_employee_id" UUID NOT NULL,
    "allotted_by_id" UUID NOT NULL,
    "assignee_employee_id" UUID NOT NULL,
    "status" "TaskStatus" NOT NULL DEFAULT 'PENDING',
    "reason" TEXT,
    "comment" TEXT,
    "submitted_at" TIMESTAMPTZ(3),
    "reopened_at" TIMESTAMPTZ(3),
    "reopen_comment" TEXT,
    "reopen_count" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "tasks_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "tasks_assignee_employee_id_date_idx" ON "tasks"("assignee_employee_id", "date");

-- CreateIndex
CREATE INDEX "tasks_allotted_by_employee_id_date_idx" ON "tasks"("allotted_by_employee_id", "date");

-- CreateIndex
CREATE INDEX "tasks_business_unit_id_date_idx" ON "tasks"("business_unit_id", "date");

-- CreateIndex
CREATE INDEX "tasks_group_id_idx" ON "tasks"("group_id");

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_allotted_by_employee_id_fkey" FOREIGN KEY ("allotted_by_employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_assignee_employee_id_fkey" FOREIGN KEY ("assignee_employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- A submitted task carries its submission time; NOT_DONE needs a reason.
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_submission_chk" CHECK (("status" = 'PENDING') = ("submitted_at" IS NULL) OR ("status" = 'PENDING' AND "reopened_at" IS NOT NULL));
ALTER TABLE "tasks" ADD CONSTRAINT "tasks_not_done_reason_chk" CHECK ("status" <> 'NOT_DONE' OR "reason" IS NOT NULL);
