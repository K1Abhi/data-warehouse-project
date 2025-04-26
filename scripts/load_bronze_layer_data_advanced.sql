----------------------------------------------------------------------------------
-- Script:        load_bronze_layer_data_advanced.sql
-- Description:   Truncates and reloads Bronze Layer tables with full transaction 
--                control, error handling, and optional audit logging.
--
-- Author:        Abhishek Kumar
-- Created On:    27/4/2025
--
-- Purpose:
-- - Ensure clean TRUNCATE-AND-LOAD operations for raw ingestion (Bronze Layer).
-- - Capture success/failure status for operational transparency.
-- - Isolate each table's load process inside its own transaction.
--
-- Benefits:
-- - If any error occurs, the specific table's operation is rolled back.
-- - Load success/failure captured for monitoring.
-- - Keeps other table loads unaffected by one table's error.
-- - Easy troubleshooting with audit trail.
--
-- Notes:
-- - Stored in: DATA_WAREHOUSE.BRONZE schema
-- - File Format: CSV with header row, fields optionally enclosed by '"'
-- - Assumes a Snowflake Stage: @my_temp_stage
----------------------------------------------------------------------------------

-- Optional: Create a simple audit table if not exists
CREATE TABLE IF NOT EXISTS DATA_WAREHOUSE.BRONZE.LOAD_AUDIT_LOG (
    table_name      STRING,
    load_timestamp  TIMESTAMP,
    status          STRING,
    error_message   STRING
);

----------------------------------------------------------------------------------
-- Utility Procedure: Log Load Result
----------------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT(
    p_table_name STRING,
    p_status     STRING,
    p_error_msg  STRING
)
RETURNS STRING
LANGUAGE SQL
AS
$$
INSERT INTO DATA_WAREHOUSE.BRONZE.LOAD_AUDIT_LOG
(TABLE_NAME, LOAD_TIMESTAMP, STATUS, ERROR_MESSAGE)
VALUES (p_table_name, CURRENT_TIMESTAMP(), p_status, p_error_msg);

RETURN 'LOGGED';
$$;

----------------------------------------------------------------------------------
-- Step 1: Load Customer Information (crm_cust_info)
----------------------------------------------------------------------------------
BEGIN
    -- Start Transaction
    BEGIN;

    TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.CRM_CUST_INFO;

    COPY INTO DATA_WAREHOUSE.BRONZE.CRM_CUST_INFO
    FROM @my_temp_stage/cust_info.csv
    FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

    COMMIT;

    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('CRM_CUST_INFO', 'SUCCESS', NULL);

EXCEPTION WHEN OTHER THEN
    ROLLBACK;
    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('CRM_CUST_INFO', 'FAILURE', ERROR_MESSAGE());
END;

----------------------------------------------------------------------------------
-- Step 2: Load Product Information (crm_prd_info)
----------------------------------------------------------------------------------
BEGIN
    BEGIN;

    TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.CRM_PRD_INFO;

    COPY INTO DATA_WAREHOUSE.BRONZE.CRM_PRD_INFO
    FROM @my_temp_stage/prd_info.csv
    FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

    COMMIT;

    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('CRM_PRD_INFO', 'SUCCESS', NULL);

EXCEPTION WHEN OTHER THEN
    ROLLBACK;
    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('CRM_PRD_INFO', 'FAILURE', ERROR_MESSAGE());
END;

----------------------------------------------------------------------------------
-- Step 3: Load Sales Details (crm_sales_details)
----------------------------------------------------------------------------------
BEGIN
    BEGIN;

    TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.CRM_SALES_DETAILS;

    COPY INTO DATA_WAREHOUSE.BRONZE.CRM_SALES_DETAILS
    FROM @my_temp_stage/sales_details.csv
    FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

    COMMIT;

    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('CRM_SALES_DETAILS', 'SUCCESS', NULL);

EXCEPTION WHEN OTHER THEN
    ROLLBACK;
    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('CRM_SALES_DETAILS', 'FAILURE', ERROR_MESSAGE());
END;

----------------------------------------------------------------------------------
-- Step 4: Load ERP Customer Demographics (erp_cust_az12)
----------------------------------------------------------------------------------
BEGIN
    BEGIN;

    TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.ERP_CUST_AZ12;

    COPY INTO DATA_WAREHOUSE.BRONZE.ERP_CUST_AZ12
    FROM @my_temp_stage/CUST_AZ12.csv
    FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

    COMMIT;

    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('ERP_CUST_AZ12', 'SUCCESS', NULL);

EXCEPTION WHEN OTHER THEN
    ROLLBACK;
    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('ERP_CUST_AZ12', 'FAILURE', ERROR_MESSAGE());
END;

----------------------------------------------------------------------------------
-- Step 5: Load ERP Customer Location (erp_loc_a101)
----------------------------------------------------------------------------------
BEGIN
    BEGIN;

    TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.ERP_LOC_A101;

    COPY INTO DATA_WAREHOUSE.BRONZE.ERP_LOC_A101
    FROM @my_temp_stage/LOC_A101.csv
    FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

    COMMIT;

    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('ERP_LOC_A101', 'SUCCESS', NULL);

EXCEPTION WHEN OTHER THEN
    ROLLBACK;
    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('ERP_LOC_A101', 'FAILURE', ERROR_MESSAGE());
END;

----------------------------------------------------------------------------------
-- Step 6: Load ERP Product Category Information (erp_px_cat_g1v2)
----------------------------------------------------------------------------------
BEGIN
    BEGIN;

    TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.ERP_PX_CAT_G1V2;

    COPY INTO DATA_WAREHOUSE.BRONZE.ERP_PX_CAT_G1V2
    FROM @my_temp_stage/PX_CAT_G1V2.csv
    FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

    COMMIT;

    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('ERP_PX_CAT_G1V2', 'SUCCESS', NULL);

EXCEPTION WHEN OTHER THEN
    ROLLBACK;
    CALL DATA_WAREHOUSE.BRONZE.LOG_LOAD_RESULT('ERP_PX_CAT_G1V2', 'FAILURE', ERROR_MESSAGE());
END;
