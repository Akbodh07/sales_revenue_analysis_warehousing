/*
-- THIS IS PROCEDURE TO DROP AND RECREATE A BRONZE TABLE 
-- IT TAKES APPROX 34 seconds TO LOAD INTO MY SYSTEM 
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze as
BEGIN
    SET NOCOUNT ON;

    DECLARE @batch_start_time DATETIME = GETDATE();
    DECLARE @batch_end_time DATETIME= GETDATE();

    SET @batch_start_time =GETDATE();

    PRINT '===============================================';
    PRINT 'Loadnig Data into bronze.customers';
    PRINT '===============================================';

    
    IF OBJECT_ID('bronze.customers','U') IS NOT NULL
	    DROP TABLE bronze.customers;
    CREATE TABLE bronze.customers (
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

    BULK INSERT bronze.customers
    FROM 'D:\ak files\my desktop data\eccomerce_full_project\data\customers.csv'
    WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK);
    


    PRINT '===============================================';
    PRINT 'Loadnig Data into bronze.payments';
    PRINT '===============================================';

    IF OBJECT_ID('bronze.payments','U') IS NOT NULL
    DROP TABLE bronze.payments;

    CREATE TABLE bronze.payments(
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

    BULK INSERT bronze.payments 
    FROM 'D:\ak files\my desktop data\eccomerce_full_project\data\payments.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK)



    PRINT '===============================================';
    PRINT 'Loadnig Data into bronze.product_reviews';
    PRINT '===============================================';

    IF OBJECT_ID('bronze.product_reviews','U') IS NOT NULL
    DROP TABLE bronze.product_reviews;

    CREATE TABLE bronze.product_reviews(

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

    BULK INSERT bronze.product_reviews
    FROM 'D:\ak files\my desktop data\eccomerce_full_project\data\product_reviews.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK)



    PRINT '===============================================';
    PRINT 'Loadnig Data into bronze.sales_transactions';
    PRINT '===============================================';

    IF OBJECT_ID('bronze.sales_transactions','U') IS NOT NULL
    DROP TABLE bronze.sales_transactions;

    CREATE TABLE bronze.sales_transactions(
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

    BULK INSERT bronze.sales_transactions
    FROM 'D:\ak files\my desktop data\eccomerce_full_project\data\sales_transactions.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK)


    PRINT '===============================================';
    PRINT 'Loadnig Data into bronze.products';
    PRINT '===============================================';

    IF OBJECT_ID('bronze.products','U') IS NOT NULL
    DROP TABLE bronze.products;

    CREATE TABLE bronze.products(
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


    BULK INSERT bronze.products
    FROM 'D:\ak files\my desktop data\eccomerce_full_project\data\products.csv'
    WITH
    (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK)



    PRINT '===============================================';
    PRINT 'Loadnig Data into bronze.shipping';
    PRINT '===============================================';

    IF OBJECT_ID('bronze.shipping','U') IS NOT NULL
    DROP TABLE bronze.shipping;

    CREATE TABLE bronze.shipping (
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

    BULK INSERT bronze.shipping
    FROM 'D:\ak files\my desktop data\eccomerce_full_project\data\shipping.csv'
    WITH ( 
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK
)
    SET @batch_end_time = GETDATE();
PRINT ' ================================================================================================================================';
PRINT 'Loading bronze layer is completed'
PRINT 'Total Duration to load bronze layer is ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + 'seconds'
PRINT ' ================================================================================================================================';
END
GO
