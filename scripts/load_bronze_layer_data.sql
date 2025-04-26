----------------------------------------------------------------------------------
-- Script:        load_bronze_layer_data.sql
-- Description:   Loads raw CSV files into the Bronze Layer tables.
--
-- Author:        Abhishek Kumar
-- Created On:    27/4/2025
--
-- Notes:
-- - Source Files: Loaded from @my_temp_stage
-- - File Format: CSV, Header Skipped, Fields Optionally Enclosed by '"'
-- - Target Schema: DATA_WAREHOUSE.BRONZE
----------------------------------------------------------------------------------

----------------------------------------------------------------------------------
-- Step 1: Load Customer Information into Bronze Table
----------------------------------------------------------------------------------
COPY INTO DATA_WAREHOUSE.BRONZE.CRM_CUST_INFO
FROM @my_temp_stage/cust_info.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

----------------------------------------------------------------------------------
-- Step 2: Load Product Information into Bronze Table
----------------------------------------------------------------------------------
COPY INTO DATA_WAREHOUSE.BRONZE.CRM_PRD_INFO
FROM @my_temp_stage/prd_info.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

----------------------------------------------------------------------------------
-- Step 3: Load Sales Details into Bronze Table
----------------------------------------------------------------------------------
COPY INTO DATA_WAREHOUSE.BRONZE.CRM_SALES_DETAILS
FROM @my_temp_stage/sales_details.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

----------------------------------------------------------------------------------
-- Step 4: Load ERP Customer Demographics into Bronze Table
----------------------------------------------------------------------------------
COPY INTO DATA_WAREHOUSE.BRONZE.ERP_CUST_AZ12
FROM @my_temp_stage/CUST_AZ12.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

----------------------------------------------------------------------------------
-- Step 5: Load ERP Customer Location into Bronze Table
----------------------------------------------------------------------------------
COPY INTO DATA_WAREHOUSE.BRONZE.ERP_LOC_A101
FROM @my_temp_stage/LOC_A101.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);

----------------------------------------------------------------------------------
-- Step 6: Load ERP Product Category Information into Bronze Table
----------------------------------------------------------------------------------
COPY INTO DATA_WAREHOUSE.BRONZE.ERP_PX_CAT_G1V2
FROM @my_temp_stage/PX_CAT_G1V2.csv
FILE_FORMAT = (TYPE = 'CSV' FIELD_OPTIONALLY_ENCLOSED_BY = '"' SKIP_HEADER = 1);
