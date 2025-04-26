/*
----------------------------------------------------------------------------------
-- Script:        create_bronze_layer_tables.sql
-- Description:   Creates Bronze Layer tables to store raw ingestion data for
--                CRM, ERP, and Sales systems.
--
-- Author:        Abhishek Kumar
-- Created On:    27/04/2025
--
-- Notes:
-- - All tables are created under the schema: DATA_WAREHOUSE.BRONZE
-- - This is the raw ingestion layer (Bronze).
-- - Be cautious when using CREATE OR REPLACE as it will DROP existing tables.
----------------------------------------------------------------------------------
*/

----------------------------------------------------------------------------------
-- Step 1: Create Bronze Table - Customer Information
----------------------------------------------------------------------------------
CREATE OR REPLACE TABLE DATA_WAREHOUSE.BRONZE.crm_cust_info (
    cst_id             INT,          -- Customer ID (Primary Identifier)
    cst_key            STRING,       -- Business Key or Alternate Key
    cst_firstname      STRING,       -- Customer First Name
    cst_lastname       STRING,       -- Customer Last Name
    cst_marital_status CHAR(1),      -- Marital Status ('M' - Married, 'S' - Single)
    cst_gndr           CHAR(1),      -- Gender ('M' - Male, 'F' - Female)
    cst_create_date    DATE          -- Customer Creation Date
);

----------------------------------------------------------------------------------
-- Step 2: Create Bronze Table - Product Information
----------------------------------------------------------------------------------
CREATE OR REPLACE TABLE DATA_WAREHOUSE.BRONZE.crm_prd_info (
    prd_id         INT,          -- Product ID (Primary Identifier)
    prd_key        STRING,       -- Product Business Key
    prd_nm         STRING,       -- Product Name
    prd_cost       NUMBER(10,2), -- Product Cost (nullable if missing)
    prd_line       STRING,       -- Product Line (R, S, M, etc.)
    prd_start_dt   DATE,          -- Product Start Date
    prd_end_dt     DATE           -- Product End Date (nullable)
);

----------------------------------------------------------------------------------
-- Step 3: Create Bronze Table - Sales Details
----------------------------------------------------------------------------------
CREATE OR REPLACE TABLE DATA_WAREHOUSE.BRONZE.crm_sales_details (
    sls_ord_num     STRING,      -- Sales Order Number (e.g., SO43697)
    sls_prd_key     STRING,      -- Product Key
    sls_cust_id     INT,         -- Customer ID
    sls_order_dt    NUMBER(8,0), -- Order Date (YYYYMMDD format)
    sls_ship_dt     NUMBER(8,0), -- Ship Date (YYYYMMDD format)
    sls_due_dt      NUMBER(8,0), -- Due Date (YYYYMMDD format)
    sls_sales       NUMBER(10,2),-- Total Sales Amount
    sls_quantity    INT,         -- Quantity Sold
    sls_price       NUMBER(10,2) -- Unit Price
);

----------------------------------------------------------------------------------
-- Step 4: Create Bronze Table - ERP Customer Demographic Information
----------------------------------------------------------------------------------
CREATE OR REPLACE TABLE DATA_WAREHOUSE.BRONZE.erp_cust_az12 (
    cid     STRING, -- Customer Key (e.g., NASAW00011000)
    bdate   DATE,   -- Birth Date
    gen     STRING  -- Gender (Male/Female)
);

----------------------------------------------------------------------------------
-- Step 5: Create Bronze Table - ERP Customer Location Information
----------------------------------------------------------------------------------
CREATE OR REPLACE TABLE DATA_WAREHOUSE.BRONZE.erp_loc_a101 (
    cid     STRING, -- Customer ID (e.g., AW-00011000)
    cntry   STRING  -- Country Name (e.g., Australia)
);

----------------------------------------------------------------------------------
-- Step 6: Create Bronze Table - ERP Product Category Information
----------------------------------------------------------------------------------
CREATE OR REPLACE TABLE DATA_WAREHOUSE.BRONZE.erp_px_cat_g1v2 (
    id            STRING, -- Category ID (e.g., AC_BR)
    cat           STRING, -- Category (e.g., Accessories)
    subcat        STRING, -- Subcategory (e.g., Bike Racks)
    maintenance   STRING  -- Maintenance Required (Yes/No)
);
