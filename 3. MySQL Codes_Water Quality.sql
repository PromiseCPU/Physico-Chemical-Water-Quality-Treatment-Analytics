# DATABASE SETUP IN MYSQL

## Creating the Database & Schema
-- PROJECT: WATER QUALITY TESTING — MySQL Data Cleaning & KPI Script
-- Dataset: 500 Samples | Parameters: pH, Temperature, Turbidity, Dissolved Oxygen (DO), Conductivity
-- Author: Utoh Chukwudi Promise (PromiseCPU) [Analytics Research Project] 
-- Date: 2026
-- Tool: MySQL Workbench


## Creating the Raw Import Table

CREATE DATABASE IF NOT EXISTS water_quality_db;
USE water_quality_db;

DROP TABLE IF EXISTS water_samples;

CREATE TABLE water_samples (
    sample_id       INT PRIMARY KEY,
    pH              DECIMAL(5,2),
    temperature_c   DECIMAL(5,2),
    turbidity_ntu   DECIMAL(5,2),
    dissolved_oxygen_mgl DECIMAL(5,2),
    conductivity_us  INT
);

## Importing my CSV File.
-- 1. Right-clicking the table (water_samples) → Table Data Import Wizard
-- 2. Browse to 'water_quality_testing_clean'  (my .csv file)
-- 3. Match columns, set encoding to 'UTF-8'
-- 4. Click Next → Finish

-- To Verify Import:
SELECT COUNT(*) AS total_rows FROM water_samples;
SELECT * FROM water_samples LIMIT 50;
DESCRIBE water_samples;


# DATA CLEANING IN MYSQL

-- Checking for NULL and Blanks/ Missing Values

SELECT
    SUM(pH IS NULL)               AS null_pH,
    SUM(turbidity_ntu IS NULL)    AS null_turbidity,
    SUM(dissolved_oxygen_mgl IS NULL) AS null_DO,
    SUM(conductivity_us IS NULL)  AS null_conductivity
FROM water_samples;

-- Checking for out-of-range values (World Health Organization (WHO) benchmarks)

SELECT sample_id, pH, turbidity_ntu, dissolved_oxygen_mgl
FROM water_samples
WHERE pH NOT BETWEEN 6.5 AND 8.5
   OR turbidity_ntu > 5.0
   OR dissolved_oxygen_mgl < 6.0;

-- Removing exact duplicates (if any)

DELETE FROM water_samples
WHERE sample_id NOT IN (
    SELECT MIN(sample_id)
    FROM water_samples
    GROUP BY pH, temperature_c, turbidity_ntu, dissolved_oxygen_mgl, conductivity_us
);

## KPI CALCULATIONS

-- KPI 1: Turbidity Reduction (%)
--        Assuming influent benchmark = 10 NTU
SELECT
    sample_id,
    turbidity_ntu AS outlet_turbidity,
    ROUND((10.0 - turbidity_ntu) / 10.0 * 100, 2) AS turbidity_reduction_pct
FROM water_samples;

-- KPI 2: Dissolved Oxygen (DO) Saturation (%)
--        Dissolved Oxygen (DO) saturation at ~22°C = 9.1 mg/L
SELECT
    sample_id,
    dissolved_oxygen_mgl,
    ROUND(dissolved_oxygen_mgl / 9.1 * 100, 2) AS do_saturation_pct
FROM water_samples;

-- KPI 3: pH Compliance Rate (%)
SELECT
    ROUND(
        SUM(pH BETWEEN 6.5 AND 8.5) / COUNT(*) * 100, 2
    ) AS ph_compliance_rate_pct
FROM water_samples;

-- KPI 4: Turbidity Compliance Rate (%)
SELECT
    ROUND(
        SUM(turbidity_ntu <= 5.0) / COUNT(*) * 100, 2
    ) AS turbidity_compliance_rate_pct
FROM water_samples;

-- KPI 5: Overall Compliance Rate (%)
--        All three parameters must be within limits
SELECT
    ROUND(
        SUM(
            pH BETWEEN 6.5 AND 8.5
            AND turbidity_ntu <= 5.0
            AND dissolved_oxygen_mgl >= 6.0
        ) / COUNT(*) * 100, 2
    ) AS overall_compliance_rate_pct
FROM water_samples;

-- KPI 6: Water Quality Index (WQI) — Composite Score (0–100)
SELECT
    sample_id,
    ROUND(
        GREATEST(0, LEAST(1, 1 - ABS(pH - 7.0)))                        * 25 +
        GREATEST(0, LEAST(1, 1 - (turbidity_ntu - 3.0) / 2.0))          * 25 +
        GREATEST(0, LEAST(1, (dissolved_oxygen_mgl - 6.0) / 4.0))       * 25 +
        GREATEST(0, LEAST(1, 1 - ABS(conductivity_us - 350.0) / 50.0))  * 25
    , 2) AS WQI_score
FROM water_samples;




