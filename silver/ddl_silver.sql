/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/

PRINT '===============================================';
PRINT 'Loadnig Data into silver.customers';
PRINT '===============================================';


IF OBJECT_ID('silver.customers','U') IS NOT NULL
    DROP TABLE silver.customers;
CREATE TABLE silver.customers (
customer_id INT, 
first_name NVARCHAR(128), 
last_name NVARCHAR(128), 
email NVARCHAR(256), 
phone NVARCHAR(256), 
date_of_birth DATE, 
gender NVARCHAR(32), 
city NVARCHAR(128), 
state NVARCHAR(128), 
country NVARCHAR(128), 
zip_code INT, 
registration_date DATE, 
customer_segment NVARCHAR(64), 
loyalty_points DECIMAL, 
is_active NVARCHAR(32)
);

PRINT '===============================================';
PRINT 'Loadnig Data into silver.payments';
PRINT '===============================================';

IF OBJECT_ID('silver.payments','U') IS NOT NULL
DROP TABLE silver.payments;

CREATE TABLE silver.payments(
payment_id INT, 
transaction_id INT, 
payment_date DATE, 
payment_method NVARCHAR(64),
card_type NVARCHAR(64), 
card_last_4 INT,
payment_amount DECIMAL,
payment_status NVARCHAR(64), 
transaction_fee DECIMAL, 
currency NVARCHAR(16), 
payment_gateway NVARCHAR(64)
)

   
PRINT '===============================================';
PRINT 'Loadnig Data into silver.product_reviews';
PRINT '===============================================';

IF OBJECT_ID('silver.product_reviews','U') IS NOT NULL
DROP TABLE silver.product_reviews;

CREATE TABLE silver.product_reviews(

review_id INT, 
transaction_id INT, 
product_id INT, 
customer_id INT, 
rating INT, 
review_title NVARCHAR(512),
review_text NVARCHAR(MAX), 
review_date DATE, 
verified_purchase NVARCHAR(32), 
helpful_count INT, 
reported_count INT

)

PRINT '===============================================';
PRINT 'Loadnig Data into silver.sales_transactions';
PRINT '===============================================';

IF OBJECT_ID('silver.sales_transactions','U') IS NOT NULL
DROP TABLE silver.sales_transactions;

CREATE TABLE silver.sales_transactions(
    transaction_id INT,
    order_number NVARCHAR(64),
    customer_id INT,
    product_id INT,
    transaction_date DATE,
    quantity INT,
    unit_price DECIMAL,
    discount_percent DECIMAL,
    tax_amount DECIMAL,
    total_amount DECIMAL,
    order_status NVARCHAR(64),
    sales_channel NVARCHAR(64),
    store_id NVARCHAR(64),
    sales_rep_id NVARCHAR(64)

)

PRINT '===============================================';
PRINT 'Loadnig Data into silver.products';
PRINT '===============================================';

IF OBJECT_ID('silver.products','U') IS NOT NULL
DROP TABLE silver.products;

CREATE TABLE silver.products(
    product_id INT,
    product_name NVARCHAR(256),
    category NVARCHAR(128),
    subcategory NVARCHAR(128),
    brand NVARCHAR(128),
    supplier_id NVARCHAR(64),
    unit_cost DECIMAL,
    unit_price DECIMAL,
    sku NVARCHAR(64),
    stock_quantity INT,
    reorder_level INT,
    weight_kg DECIMAL,
    dimensions_cm NVARCHAR(128),
    is_active NVARCHAR(32),
    created_date DATE,
    last_updated DATE
)



PRINT '===============================================';
PRINT 'Loadnig Data into silver.shipping';
PRINT '===============================================';

IF OBJECT_ID('silver.shipping','U') IS NOT NULL
DROP TABLE silver.shipping;

CREATE TABLE silver.shipping (
    shipping_id INT,
    transaction_id INT,
    shipping_date DATE,
    delivery_date DATE,
    estimated_delivery DATE,
    shipping_carrier NVARCHAR(64),
    shipping_method NVARCHAR(64),
    tracking_number NVARCHAR(128),
    shipping_cost DECIMAL,
    shipping_status NVARCHAR(64),
    destination_city NVARCHAR(128),
    destination_state NVARCHAR(128),
    destination_zip INT,
    weight_kg DECIMAL


)
