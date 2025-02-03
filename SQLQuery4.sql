
select * from Customers

select * from Products

select * from Regions

select * from Stores


select * from Calendar

select * from Returns_Data

select * from Transaction_Data


-- Update the data types of key columns in the Customers table
ALTER TABLE Customers
ALTER COLUMN customer_id INT;

ALTER TABLE Customers
ALTER COLUMN customer_acct_num NVARCHAR(255);

ALTER TABLE Customers
ALTER COLUMN customer_postal_code NVARCHAR(255);


-- Create a computed column combining first_name and last_name into full_name
ALTER TABLE Customers ADD full_name AS (first_name + ' ' + last_name);

-- Extract the year from the birthdate column and store it as birth_year
ALTER TABLE Customers ADD birth_year AS FORMAT(birthdate, 'yyyy');

-- Create a column to indicate whether the customer has children
ALTER TABLE Customers ADD has_children AS 
    (CASE WHEN total_children = 0 THEN 'N' ELSE 'Y' END);

-- Update the data types of key columns in the Products table
ALTER TABLE Products
ALTER COLUMN product_id INT;

ALTER TABLE Products
ALTER COLUMN product_sku NVARCHAR(255);

ALTER TABLE Products
ALTER COLUMN product_retail_price DECIMAL(10, 2);

ALTER TABLE Products
ALTER COLUMN product_cost DECIMAL(10, 2);

-- Count the number of distinct product brands
SELECT COUNT(DISTINCT product_brand) AS DistinctBrands FROM Products;

-- Count the number of distinct product names
SELECT COUNT(DISTINCT product_name) AS DistinctProductNames FROM Products;

-- Create a computed column for a 10% discount on the retail price
ALTER TABLE Products ADD discount_price AS 
    ROUND(product_retail_price * 0.9, 2);

-- Calculate the average retail price of products by brand
SELECT product_brand, AVG(product_retail_price) AS AvgRetailPrice
FROM Products
GROUP BY product_brand;

-- Replace NULL values in recyclable and low_fat columns with 0
UPDATE Products
SET recyclable = ISNULL(recyclable, 0),
    low_fat = ISNULL(low_fat, 0);


-- Update the data types of store_id and region_id in the Stores table
ALTER TABLE Stores
ALTER COLUMN store_id INT;

ALTER TABLE Stores
ALTER COLUMN region_id INT;

-- Step 2: Add a calculated column for the full address
-- Combining store_city, store_state, and store_country separated by ", "
ALTER TABLE Stores
ADD full_address AS (store_city + ', ' + store_state + ', ' + store_country);

-- Step 3: Add a calculated column for the area code
-- Extracting characters before the dash "-" in the store_phone field
ALTER TABLE Stores
ADD area_code AS LEFT(store_phone, CHARINDEX('-', store_phone) - 1);

-- Update the data type of region_id in the Regions table
ALTER TABLE Regions
ALTER COLUMN region_id INT;

ALTER TABLE Regions
ADD Region AS (sales_district + ' - ' + sales_region);

-- Update the data types of key columns in the Return_Data table
ALTER TABLE Returns_Data
ALTER COLUMN product_id INT;

ALTER TABLE Returns_Data
ALTER COLUMN store_id INT;

ALTER TABLE Returns_Data
ALTER COLUMN quantity INT;

-- Combine data from Transactions_1997 and Transactions_1998 into Transaction_Data
SELECT *
INTO Transaction_Data
FROM (
    SELECT * FROM Transactions_1997
    UNION ALL
    SELECT * FROM Transactions_1998
) AS CombinedData;

-- Update the data types of key columns in the Transaction_Data table
ALTER TABLE Transaction_Data
ALTER COLUMN Store_id INT;

ALTER TABLE Transaction_Data
ALTER COLUMN product_id INT;

ALTER TABLE Transaction_Data
ALTER COLUMN customer_id INT;

ALTER TABLE Transaction_Data
ALTER COLUMN quantity INT;

ALTER TABLE Transaction_Data
ALTER COLUMN transaction_date DATE;

-- Update the data types of key columns in the Transaction_Data table
ALTER TABLE Transaction_Data
ALTER COLUMN store_id INT;

ALTER TABLE Transaction_Data
ALTER COLUMN product_id INT;

ALTER TABLE Transaction_Data
ALTER COLUMN customer_id INT;

ALTER TABLE Transaction_Data
ALTER COLUMN quantity INT;

ALTER TABLE Transaction_Data
ALTER COLUMN transaction_date DATE;

-- Step 1: Add a column for the start of the week (Sunday)
ALTER TABLE Calendar
ADD start_of_week AS DATEADD(DAY, -(DATEPART(WEEKDAY, DATEFROMPARTS(year, month, date)) - 1), DATEFROMPARTS(year, month, date));

-- Step 2: Add a column for the name of the day
ALTER TABLE Calendar
ADD day_name AS DATENAME(WEEKDAY, DATEFROMPARTS(year, month, date));

-- Step 3: Add a column for the start of the month
ALTER TABLE Calendar
ADD start_of_month AS DATEFROMPARTS(year, month, 1);

-- Step 4: Add a column for the name of the month
ALTER TABLE Calendar
ADD month_name AS DATENAME(MONTH, DATEFROMPARTS(year, month, date));

-- Step 5: Add a column for the quarter of the year
ALTER TABLE Calendar
ADD quarter_of_year AS CEILING(CAST(month AS FLOAT) / 3.0);

-- Step 6: Add a column for the year
ALTER TABLE Calendar
ADD calendar_year AS year;

-- Add a column for the combined date in yyyy/mm/dd format
ALTER TABLE Calendar
ADD formatted_date AS FORMAT(DATEFROMPARTS(year, month, date), 'yyyy/MM/dd');






select 
* from Customers a
 join Transaction_Data b
 on a.customer_id = b.product_id





SELECT
    -- Customers table columns
    C.customer_id,
    C.customer_acct_num,
    C.customer_postal_code,
    C.full_name,
    C.birth_year,
    C.has_children,
    
    -- Products table columns
    P.product_id,
    P.product_sku,
    P.product_name,
    P.product_brand,
    P.product_retail_price,
    P.discount_price,
    
    -- Regions table columns
    R.region_id,
    R.sales_district,
    R.sales_region,
    R.Region AS region_name,
    
    -- Stores table columns
    S.store_id,
    S.store_city,
    S.store_state,
    S.store_country,
    S.full_address,
    S.area_code,
    
    -- Calendar table columns
    Cal.formatted_date,
    Cal.start_of_week,
    Cal.day_name,
    Cal.start_of_month,
    Cal.month_name,
    Cal.quarter_of_year,
    Cal.calendar_year,
    
    -- Returns_Data table columns
    Ret.quantity AS return_quantity,
    
    -- Transaction_Data table columns
    T.transaction_date,
    T.quantity AS transaction_quantity
FROM
    Transaction_Data T
    -- Join Customers table
    LEFT JOIN Customers C ON T.customer_id = C.customer_id
    -- Join Products table
    LEFT JOIN Products P ON T.product_id = P.product_id
    -- Join Stores table
    LEFT JOIN Stores S ON T.store_id = S.store_id
    -- Join Regions table
    LEFT JOIN Regions R ON S.region_id = R.region_id
    -- Join Calendar table
    LEFT JOIN Calendar Cal ON T.transaction_date = Cal.formatted_date
    -- Join Returns_Data table
    LEFT JOIN Returns_Data Ret ON T.product_id = Ret.product_id AND T.store_id = Ret.store_id;





