/*
----------------------------------------------------------------------------------
-- Script:        recreate_datawarehouse_layers.sql
-- Description:   Drops the existing Data Warehouse if it exists, recreates it, 
--                and sets up Bronze, Silver, and Gold schemas for data layering.
-- 
-- Author:        [Your Name]
-- Created On:    [Today's Date]
-- 
-- IMPORTANT WARNING:
-- - This script will DROP the existing 'Data_warehouse' database permanently.
-- - All objects and data inside the database will be deleted.
-- - Please ensure that a full backup of the current database exists before running this script.
-- 
-- Notes:
-- - Bronze Layer: Raw ingestion data.
-- - Silver Layer: Cleansed and transformed data.
-- - Gold Layer: Aggregated data ready for analytics and reporting.
----------------------------------------------------------------------------------
*/

-- Step 1: Drop the existing Data Warehouse if it exists
DROP DATABASE IF EXISTS Data_warehouse;

-- Step 2: Create a fresh Data Warehouse
CREATE DATABASE Data_warehouse;

-- Step 3: Switch to the newly created Data Warehouse
USE DATABASE Data_warehouse;

-- Step 4: Create Data Maturity Layers (Schemas)
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
