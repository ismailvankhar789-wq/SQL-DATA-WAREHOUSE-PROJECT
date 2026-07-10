/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================

Script Purpose:
    This script creates business-ready views in the Gold layer of the
    data warehouse.

    The Gold layer represents the final presentation layer following
    a Star Schema design. It consists of:
        • Dimension Views
        • Fact Views

    These views combine and enrich data from the Silver layer to provide
    clean, analytics-ready datasets for reporting and business intelligence.

Usage:
    Execute this script after successfully loading the Silver layer.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================

IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS

SELECT
    ROW_NUMBER() OVER (ORDER BY CI.CST_ID) AS CUSTOMER_KEY,
    CI.CST_ID,
    CI.CST_KEY,
    CI.CST_FIRSTNAME,
    CI.CST_LASTNAME,
    CI.CST_MARITAL_STATUS,
    CI.CST_GENDER,
    CI.CST_CREATED_DATE,
    CA.BDATE,
    LA.CNTRY
FROM silver.crm_cust_info CI
LEFT JOIN silver.erp_cust_az12 CA
    ON CI.CST_KEY = CA.CID
LEFT JOIN silver.erp_loc_a101 LA
    ON CI.CST_KEY = LA.CID;
GO


-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================

IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS

SELECT
    PN.PRD_ID,
    PN.PRD_KEY,
    PN.PRD_NM,
    PN.CAT_ID,
    PC.CAT AS CATEGORY,
    PC.SUBCAT AS SUBCATEGORY,
    PC.MAINTENANCE,
    PN.PRD_COST AS COST,
    PN.PRD_LINE AS PRODUCT_LINE,
    PN.PRD_START_DT AS START_DATE
FROM silver.crm_prd_info PN
LEFT JOIN silver.erp_px_cat_g1v2 PC
    ON PN.CAT_ID = PC.ID
WHERE PN.PRD_END_DT IS NULL;
GO


-- =============================================================================
-- Create Fact: gold.fact_sales
-- =============================================================================

IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS

SELECT
    SD.SLS_ORD_NUM,
    RIGHT(PR.PRD_KEY, 2) AS PRD_KEY,
    CU.CUSTOMER_KEY,
    SD.SLS_ORDER_DT,
    SD.SLS_DUE_DT,
    SD.SLS_SALES,
    SD.SLS_QUANTITY,
    SD.SLS_PRICE
FROM silver.crm_sales_details SD
LEFT JOIN gold.dim_products PR
    ON SD.SLS_PRD_KEY = PR.PRD_KEY
LEFT JOIN gold.dim_customers CU
    ON SD.SLS_CUST_ID = CU.cst_id
GO
