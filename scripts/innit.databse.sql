/*
=========================================================
SQL DATA WAREHOUSE PROJECT
Database Initialization Script
=========================================================

Author  : Ismail Vankhar
Date    : July 2026

Description:
This script initializes the SQL Data Warehouse by:

1. Creating the DATAWAREHOUSE database
2. Creating the BRONZE schema
3. Creating the SILVER schema
4. Creating the GOLD schema

Schemas:
- Bronze : Raw data
- Silver : Cleaned and transformed data
- Gold   : Analytics-ready data

=========================================================
*/

USE master;
GO

IF DB_ID('DATAWAREHOUSE') IS NOT NULL
BEGIN
    DROP DATABASE DATAWAREHOUSE;
END
GO

CREATE DATABASE DATAWAREHOUSE;
GO

USE DATAWAREHOUSE;
GO

CREATE SCHEMA BRONZE;
GO

CREATE SCHEMA SILVER;
GO

CREATE SCHEMA GOLD;
GO

PRINT 'Database initialized successfully.';
