-- CreateEnum
CREATE TYPE "VehicleStatus" AS ENUM ('ACTIVE', 'IN_WORKSHOP', 'RETIRED');

-- CreateEnum
CREATE TYPE "DutyStatus" AS ENUM ('PLANNED', 'CONFIRMED', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "AssignmentRole" AS ENUM ('DRIVER', 'CO_DRIVER', 'CONDUCTOR', 'HELPER');

-- CreateTable
CREATE TABLE "vehicles" (
    "id" UUID NOT NULL,
    "reg_no" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "capacity" INTEGER,
    "depot_id" UUID NOT NULL,
    "status" "VehicleStatus" NOT NULL DEFAULT 'ACTIVE',
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,
    "deleted_at" TIMESTAMPTZ(3),

    CONSTRAINT "vehicles_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "routes" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "origin" TEXT NOT NULL,
    "destination" TEXT NOT NULL,
    "distance_km" DOUBLE PRECISION,
    "standard_minutes" INTEGER NOT NULL,
    "depot_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,
    "deleted_at" TIMESTAMPTZ(3),

    CONSTRAINT "routes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "duty_templates" (
    "id" UUID NOT NULL,
    "depot_id" UUID NOT NULL,
    "name" TEXT NOT NULL,
    "start_time" TEXT NOT NULL,
    "end_time" TEXT NOT NULL,
    "crosses_midnight" BOOLEAN NOT NULL DEFAULT false,
    "route_id" UUID,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,
    "deleted_at" TIMESTAMPTZ(3),

    CONSTRAINT "duty_templates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "duties" (
    "id" UUID NOT NULL,
    "depot_id" UUID NOT NULL,
    "duty_date" DATE NOT NULL,
    "route_id" UUID,
    "vehicle_id" UUID,
    "template_id" UUID,
    "scheduled_start" TIMESTAMPTZ(3) NOT NULL,
    "scheduled_end" TIMESTAMPTZ(3) NOT NULL,
    "status" "DutyStatus" NOT NULL DEFAULT 'PLANNED',
    "notes" TEXT,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "duties_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "duty_assignments" (
    "id" UUID NOT NULL,
    "duty_id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "role" "AssignmentRole" NOT NULL,
    "is_spare" BOOLEAN NOT NULL DEFAULT false,
    "warnings" JSONB,
    "actual_start" TIMESTAMPTZ(3),
    "actual_end" TIMESTAMPTZ(3),
    "km" DOUBLE PRECISION,
    "trip_count" INTEGER,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "duty_assignments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "vehicles_reg_no_key" ON "vehicles"("reg_no");

-- CreateIndex
CREATE INDEX "vehicles_depot_id_idx" ON "vehicles"("depot_id");

-- CreateIndex
CREATE UNIQUE INDEX "routes_code_key" ON "routes"("code");

-- CreateIndex
CREATE INDEX "routes_depot_id_idx" ON "routes"("depot_id");

-- CreateIndex
CREATE INDEX "duty_templates_depot_id_idx" ON "duty_templates"("depot_id");

-- CreateIndex
CREATE INDEX "duties_depot_id_duty_date_idx" ON "duties"("depot_id", "duty_date");

-- CreateIndex
CREATE INDEX "duties_vehicle_id_duty_date_idx" ON "duties"("vehicle_id", "duty_date");

-- CreateIndex
CREATE INDEX "duty_assignments_employee_id_idx" ON "duty_assignments"("employee_id");

-- CreateIndex
CREATE UNIQUE INDEX "duty_assignments_duty_id_employee_id_key" ON "duty_assignments"("duty_id", "employee_id");

-- AddForeignKey
ALTER TABLE "vehicles" ADD CONSTRAINT "vehicles_depot_id_fkey" FOREIGN KEY ("depot_id") REFERENCES "depots"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "routes" ADD CONSTRAINT "routes_depot_id_fkey" FOREIGN KEY ("depot_id") REFERENCES "depots"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "duty_templates" ADD CONSTRAINT "duty_templates_depot_id_fkey" FOREIGN KEY ("depot_id") REFERENCES "depots"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "duty_templates" ADD CONSTRAINT "duty_templates_route_id_fkey" FOREIGN KEY ("route_id") REFERENCES "routes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "duties" ADD CONSTRAINT "duties_depot_id_fkey" FOREIGN KEY ("depot_id") REFERENCES "depots"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "duties" ADD CONSTRAINT "duties_route_id_fkey" FOREIGN KEY ("route_id") REFERENCES "routes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "duties" ADD CONSTRAINT "duties_vehicle_id_fkey" FOREIGN KEY ("vehicle_id") REFERENCES "vehicles"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "duties" ADD CONSTRAINT "duties_template_id_fkey" FOREIGN KEY ("template_id") REFERENCES "duty_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "duty_assignments" ADD CONSTRAINT "duty_assignments_duty_id_fkey" FOREIGN KEY ("duty_id") REFERENCES "duties"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "duty_assignments" ADD CONSTRAINT "duty_assignments_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- ─────────────── Hand-written constraints ───────────────
ALTER TABLE "duties" ADD CONSTRAINT "duties_times_chk" CHECK ("scheduled_end" > "scheduled_start");
ALTER TABLE "duty_templates" ADD CONSTRAINT "duty_templates_time_fmt_chk"
    CHECK ("start_time" ~ '^([01][0-9]|2[0-3]):[0-5][0-9]$' AND "end_time" ~ '^([01][0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE "routes" ADD CONSTRAINT "routes_minutes_chk" CHECK ("standard_minutes" > 0);