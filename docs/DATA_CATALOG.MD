Data Catalog
1. gold.dim_customers

Purpose: Stores customer information enriched with demographic and geographic attributes.

Column Name	Data Type	Description
CUSTOMER_KEY	INT	Surrogate key uniquely identifying each customer record.
CST_ID	INT	Original customer ID from the CRM system.
CST_KEY	NVARCHAR(50)	Business customer identifier.
CST_FIRSTNAME	NVARCHAR(50)	Customer's first name.
CST_LASTNAME	NVARCHAR(50)	Customer's last name.
CST_MARITAL_STATUS	NVARCHAR(50)	Customer marital status (Married, Single, etc.).
CST_GENDER	NVARCHAR(50)	Customer gender.
CST_CREATED_DATE	DATE	Date the customer was created in the CRM system.
BDATE	DATE	Customer birth date.
CNTRY	NVARCHAR(50)	Customer country.
2. gold.dim_products

Purpose: Contains master product information with category hierarchy.

Column Name	Data Type	Description
PRD_ID	INT	Product identifier.
PRD_KEY	NVARCHAR(50)	Business product key.
PRD_NM	NVARCHAR(50)	Product name.
CAT_ID	NVARCHAR(20)	Product category identifier.
CATEGORY	NVARCHAR(50)	Product category.
SUBCATEGORY	NVARCHAR(50)	Product subcategory.
MAINTENANCE	NVARCHAR(50)	Maintenance classification.
COST	INT	Product cost.
PRODUCT_LINE	NVARCHAR(50)	Product line.
START_DATE	DATE	Product effective start date.
3. gold.fact_sales

Purpose: Stores transactional sales records linked to customer and product dimensions.

Column Name	Data Type	Description
SLS_ORD_NUM	NVARCHAR(50)	Sales order number.
PRD_KEY	NVARCHAR(50)	Product key linking to dim_products.
CUSTOMER_KEY	INT	Surrogate customer key linking to dim_customers.
SLS_ORDER_DT	DATE	Order date.
SLS_DUE_DT	DATE	Due date.
SLS_SALES	INT	Total sales amount.
SLS_QUANTITY	INT	Quantity sold.
SLS_PRICE	INT	Unit selling price.
