----------------------------------------------------------------------------------
-- Script:        transactional_truncate_and_load_bronze_layer_data.sql
-- Description:   Truncates Bronze tables and reloads them from raw CSV files,
--                with one transaction per table for safety and isolation.
--
-- Author:        Abhishek Kumar
-- Created On:    27/4/2025
--
-- Notes:
-- - Stored in: DATA_WAREHOUSE.BRONZE schema
-- - File Format: CSV, Header Skipped, Fields Optionally Enclosed by '"'
-- - Approach: Truncate and Load with Transaction Control
--
-- Why Transactions?
-- - Ensures that if any part of the operation (truncate or copy) fails,
--   no partial or corrupted data remains in the table.
-- - Each table load is isolated: failure in one does not affect others.
-- - Provides better reliability and operational safety in the loading process.
-- - Clean rollback to previous stable state if any error happens.
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Step 1: Truncate and Load Customer Information (crm_cust_info)
----------------------------------------------------------------------------------
BEGIN;

TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.CRM_CUST_INFO;

COPY INTO DATA_WAREHOUSE.BRONZE.CRM_CUST_INFO
FROM @my_temp_stage/cust_info.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

COMMIT;

----------------------------------------------------------------------------------
-- Step 2: Truncate and Load Product Information (crm_prd_info)
----------------------------------------------------------------------------------
BEGIN;

TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.CRM_PRD_INFO;

COPY INTO DATA_WAREHOUSE.BRONZE.CRM_PRD_INFO
FROM @my_temp_stage/prd_info.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

COMMIT;

----------------------------------------------------------------------------------
-- Step 3: Truncate and Load Sales Details (crm_sales_details)
----------------------------------------------------------------------------------
BEGIN;

TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.CRM_SALES_DETAILS;

COPY INTO DATA_WAREHOUSE.BRONZE.CRM_SALES_DETAILS
FROM @my_temp_stage/sales_details.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

COMMIT;

----------------------------------------------------------------------------------
-- Step 4: Truncate and Load ERP Customer Demographics (erp_cust_az12)
----------------------------------------------------------------------------------
BEGIN;

TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.ERP_CUST_AZ12;

COPY INTO DATA_WAREHOUSE.BRONZE.ERP_CUST_AZ12
FROM @my_temp_stage/CUST_AZ12.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

COMMIT;

----------------------------------------------------------------------------------
-- Step 5: Truncate and Load ERP Customer Location (erp_loc_a101)
----------------------------------------------------------------------------------
BEGIN;

TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.ERP_LOC_A101;

COPY INTO DATA_WAREHOUSE.BRONZE.ERP_LOC_A101
FROM @my_temp_stage/LOC_A101.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

COMMIT;

----------------------------------------------------------------------------------
-- Step 6: Truncate and Load ERP Product Category Information (erp_px_cat_g1v2)
----------------------------------------------------------------------------------
BEGIN;

TRUNCATE TABLE DATA_WAREHOUSE.BRONZE.ERP_PX_CAT_G1V2;

COPY INTO DATA_WAREHOUSE.BRONZE.ERP_PX_CAT_G1V2
FROM @my_temp_stage/PX_CAT_G1V2.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

COMMIT;
