CREATE TABLE customers ( 
    customer_id VARCHAR(20) PRIMARY KEY, 
    customer_name VARCHAR(100), 
    gender VARCHAR(10), 
    age INTEGER, 
    age_group VARCHAR(10), 
    date_of_birth DATE, 
    email VARCHAR(150), 
    phone VARCHAR(20), 
    city VARCHAR(50), 
    state VARCHAR(50), 
    pincode INTEGER, 
    registration_date DATE, 
    customer_tier VARCHAR(20), 
    total_orders INTEGER, 
    total_spent NUMERIC(14,2) 
); 
 
 
 
CREATE TABLE products ( 
    product_id VARCHAR(20) PRIMARY KEY, 
    product_name VARCHAR(150), 
    category VARCHAR(50), 
    brand VARCHAR(50), 
    original_price NUMERIC(12,2), 
    discount_percent INTEGER, 
    discount_amount NUMERIC(12,2), 
    selling_price NUMERIC(12,2), 
    stock_quantity INTEGER, 
    weight_kg NUMERIC(8,2), 
    avg_rating NUMERIC(3,2), 
    total_reviews INTEGER 
); 
 
CREATE TABLE sales ( 
    order_id VARCHAR(20) PRIMARY KEY, 
    customer_id VARCHAR(20), 
    product_id VARCHAR(20), 
    order_date DATE, 
    order_time TIME, 
    delivery_date DATE, 
    quantity INTEGER, 
    unit_price NUMERIC(12,2), 
    order_value NUMERIC(14,2), 
    shipping_cost NUMERIC(12,2), 
    coupon_code VARCHAR(30), 
    coupon_discount NUMERIC(12,2), 
    total_amount NUMERIC(14,2), 
    payment_mode VARCHAR(30), 
    order_status VARCHAR(20), 
    rating NUMERIC(2,1), 
    review_text VARCHAR(255), 
    city VARCHAR(50), 
    state VARCHAR(50), 
    customer_age INTEGER, 
    customer_age_group VARCHAR(10), 
 
    CONSTRAINT fk_sales_customer 
        FOREIGN KEY (customer_id) 
        REFERENCES customers(customer_id), 
 
    CONSTRAINT fk_sales_product 
        FOREIGN KEY (product_id) 
        REFERENCES products(product_id) 
); 
 
 
 
select * from customers; 
select* from products ; 
select* from sales; 
 
 
-- Check row counts 
SELECT 'customer_id' AS TABLE_NAME , COUNT(*) as COUNT_ROWS 
FROM customers 
UNION  
SELECT 'product_id' ,COUNT(*) 
FROM products 
UNION  
SELECT 'order_id' , COUNT(*)  
FROM sales; 
 
 
-- Check duplicate customers 
SELECT customer_id , COUNT(*) AS total_count 
FROM customers 
GROUP BY customer_id 
HAVING COUNT(*)>1 
 
-- Check duplicate products 
 
SELECT product_id ,COUNT(*) AS total_count 
FROM products 
GROUP BY product_id 
HAVING COUNT(*)>1 
 
 
-- Check duplicate orders 
SELECT order_id ,COUNT(*) AS total_count 
FROM sales 
GROUP BY order_id 
HAVING COUNT(*)>1 
 
 
-- Are there any sales records with a customer_id 
--or product_id that does not exist in the customers or products table? 
 
-- FOR CUSTOMERS AND SALES RELATIONSHIP  
SELECT s.order_id ,c.customer_id  
FROM sales AS s 
LEFT JOIN customers AS c 
ON s.customer_id = c.customer_id 
WHERE s.customer_id IS NULL; 
 
 
-- FOR PRODUCT AND SALES RELATIONSHIP 
SELECT s.order_id ,p.product_id 
FROM sales AS s 
LEFT JOIN products AS p 
ON s.product_id = p.product_id 
WHERE s.product_id IS NULL; 
 
 
 
-- What is the distribution of orders across each order_status ? 
 
 
SELECT DISTINCT(order_status) AS diff_order_status,  
COUNT(*) AS total_order_status 
FROM sales 
GROUP BY order_status 
ORDER BY total_order_status DESC; 
 
 
-- What is the distribution of orders across each payment_mode 
 
SELECT DISTINCT(payment_mode) AS diff_payment_mode , 
COUNT(*) AS total_count 
FROM sales 
GROUP BY payment_mode 
ORDER BY diff_payment_mode DESC; 








