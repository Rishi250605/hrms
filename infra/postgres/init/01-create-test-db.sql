-- Runs once when the postgres container initialises an empty volume.
-- Separate database for API integration tests (tests truncate tables).
CREATE DATABASE hrms_test OWNER hrms;
