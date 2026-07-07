/*
=========================================================
SQL DATA WAREHOUSE PROJECT
Database Initialization Script
=========================================================

Author      : Ismail Vankhar
Project     : SQL Data Warehouse
Description :
    This script initializes the Data Warehouse by:

    1. Dropping the existing database (if it exists)
    2. Creating a new database
    3. Creating the Bronze, Silver and Gold schemas

Warning:
    Running this script will DELETE the existing
    DataWarehouse database and all its data.

=========================================================
*/

USE master;
GO

-- Drop the database if it already exists
IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    ALTER DATABASE DataWarehouse
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END
GO

-- Create a new database
CREATE DATABASE DataWarehouse;
GO

-- Switch to the new database
USE DataWarehouse;
GO

-- Create Bronze schema (Raw Data)
CREATE SCHEMA Bronze;
GO

-- Create Silver schema (Cleaned & Transformed Data)
CREATE SCHEMA Silver;
GO

-- Create Gold schema (Business Ready Data)
CREATE SCHEMA Gold;
GO

PRINT 'Data Warehouse initialized successfully!';
