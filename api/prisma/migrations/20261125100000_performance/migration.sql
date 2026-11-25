-- CreateTable
CREATE TABLE "performance_metrics" (
    "id" UUID NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "unit" TEXT,
    "sort_order" INTEGER NOT NULL DEFAULT 0,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,
    "created_by_id" UUID,

    CONSTRAINT "performance_metrics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "performance_ratings" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "business_unit_id" UUID NOT NULL,
    "rating" INTEGER NOT NULL,
    "comment" TEXT,
    "rated_by_employee_id" UUID NOT NULL,
    "rated_by_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "performance_ratings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "performance_metric_values" (
    "id" UUID NOT NULL,
    "employee_id" UUID NOT NULL,
    "business_unit_id" UUID NOT NULL,
    "metric_id" UUID NOT NULL,
    "week_start" DATE NOT NULL,
    "value" DECIMAL(14,2) NOT NULL,
    "entered_by_id" UUID NOT NULL,
    "created_at" TIMESTAMPTZ(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMPTZ(3) NOT NULL,

    CONSTRAINT "performance_metric_values_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "performance_metrics_code_key" ON "performance_metrics"("code");

-- CreateIndex
CREATE INDEX "performance_ratings_employee_id_created_at_idx" ON "performance_ratings"("employee_id", "created_at");

-- CreateIndex
CREATE INDEX "performance_ratings_business_unit_id_idx" ON "performance_ratings"("business_unit_id");

-- CreateIndex
CREATE INDEX "performance_metric_values_business_unit_id_week_start_idx" ON "performance_metric_values"("business_unit_id", "week_start");

-- CreateIndex
CREATE UNIQUE INDEX "performance_metric_values_employee_id_metric_id_week_start_key" ON "performance_metric_values"("employee_id", "metric_id", "week_start");

-- AddForeignKey
ALTER TABLE "performance_ratings" ADD CONSTRAINT "performance_ratings_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "performance_ratings" ADD CONSTRAINT "performance_ratings_rated_by_employee_id_fkey" FOREIGN KEY ("rated_by_employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "performance_metric_values" ADD CONSTRAINT "performance_metric_values_employee_id_fkey" FOREIGN KEY ("employee_id") REFERENCES "employees"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "performance_metric_values" ADD CONSTRAINT "performance_metric_values_metric_id_fkey" FOREIGN KEY ("metric_id") REFERENCES "performance_metrics"("id") ON DELETE RESTRICT ON UPDATE CASCADE;


-- Ratings are 1–5 stars.
ALTER TABLE "performance_ratings" ADD CONSTRAINT "performance_ratings_rating_check" CHECK ("rating" BETWEEN 1 AND 5);

-- weekStart is always a Monday (ISODOW 1).
ALTER TABLE "performance_metric_values" ADD CONSTRAINT "performance_metric_values_week_start_monday_check" CHECK (EXTRACT(ISODOW FROM "week_start") = 1);
