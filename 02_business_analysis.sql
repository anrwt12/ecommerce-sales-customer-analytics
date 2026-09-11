-- Real-world business question

-- Q1 What is the overall business performance total orders, customers, units sold, gross order value,
--discounts, shipping cost and net revenue?

SELECT
COUNT(DISTINCT order_id) AS total_orders,
COUNT(DISTINCT customer_id) AS total_customers,
SUM(quantity) AS total_unit_sold,
SUM(order_value) AS gross_order_value,
SUM(coupon_discount) AS Total_coupon_dicount,
SUM(shipping_cost) AS total_shipping_cost,
SUM(total_amount) AS net_revenue
FROM sales;

-- Business Insight

-- The business generated ₹5.93B in net revenue from 250K orders and 39.9K customers, with 312K units sold.

--  Q2 How has the company's revenue and order volume changed
-- month by month, and which month performed best?

SELECT
SUM(total_amount) AS total_company_revenue,
COUNT(DISTINCT order_id) AS total_orders,
EXTRACT(MONTH FROM order_date) AS order_month,
EXTRACT(YEAR FROM order_date) AS order_year
FROM sales
GROUP BY order_month, order_year
ORDER BY total_company_revenue DESC;

-- Q3 Which product categories generate the most revenue,
-- orders, and units sold, and what percentage of total revenue does each contribute?

WITH category_sales AS(
SELECT
p.category ,
sum(s.total_amount)  as Total_sales_amount,
COUNT(DISTINCT s.order_id ) AS orders,
SUM(s.quantity) AS units_sold
FROM products AS p
INNER JOIN  sales AS s
ON p.product_id = s.product_id
group by p.category
order by Total_sales_amount DESC
)

SELECT
category,
total_sales_amount,
orders,
units_sold,
ROUND(Total_sales_amount *100.0/
sum(Total_sales_amount) over(),2)
AS revenue_percentage
FROM category_sales
ORDER BY total_sales_amount DESC;

-- Business Insight



-- Q4 Which brands generate the highest revenue?

SELECT p.brand,
sum(s.total_amount) as total_revenue,
SUM(s.quantity) AS total_quantity
FROM sales AS s
INNER JOIN products AS p
ON p.product_id = s.product_id
GROUP BY p.brand
ORDER BY total_revenue DESC


-- Q5  What percentage of orders are delivered,
-- cancelled, returned, or in other statuses,
-- and which categories have the highest cancellation/return rates?

SELECT
order_status,
COUNT(DISTINCT order_id) AS total_orders,
ROUND(COUNT(DISTINCT order_id) *100.0/
SUM(COUNT(DISTINCT order_id)) OVER(),2) AS order_percentage
FROM sales
GROUP BY ORDER_STATUS
ORDER BY  total_orders DESC



-- count how many Cancelled and Returned orders each category has

WITH category_status AS(
SELECT
p.category,
COUNT(DISTINCT s.order_id) AS total_orders,

 COUNT(DISTINCT CASE
	WHEN s.order_status ='Cancelled'
	THEN s.order_id 
END) AS order_cancelled,

COUNT(DISTINCT CASE
	WHEN s.order_status ='Returned'
	THEN s.order_id 
 END) AS order_Returned
 
		FROM products AS p
		INNER JOIN sales AS s
		ON p.product_id = s.product_id
		GROUP BY p.category

)

SELECT
category,
total_orders,

order_cancelled,
ROUND(order_cancelled *100.0/total_orders ,2)
AS cancellation_rate,
order_Returned,
ROUND(order_Returned *100.0/total_orders ,2)
AS Returned_rate
FROM  category_status
ORDER BY cancellation_rate DESC,
Returned_rate DESC

-- Business Insight

-- Most orders are successfully delivered, while cancellations and returns represent a smaller share.

-- Sports has the highest cancellation rate (5.14%), while Books has the highest return rate (5.13%).

-- Sports and Books need further analysis to identify the reasons for cancellations and returns.

--Q6 Which Indian states and cities generate the most revenue, orders, and customers?

-- STATE
SELECT
State,
COUNT(DISTINCT order_id) AS Total_orders,
SUM(total_amount) AS Total_revenue,
COUNT(DISTINCT customer_id)AS total_customers
FROM sales
GROUP BY state
ORDER BY Total_orders DESC,Total_revenue DESC

--CITY
SELECT
city,
COUNT(DISTINCT order_id) AS Total_orders,
SUM(total_amount) AS Total_revenue,
COUNT(DISTINCT customer_id)AS total_customers
FROM sales
GROUP BY city
ORDER BY Total_orders DESC,Total_revenue DESC



-- Business Insight

-- UP leads at the state level with 32,631 orders and 5,208 customers, generating ₹768.35M in revenue.
-- At the city level, Madurai has the highest order volume and revenue,
-- while New Delhi generates nearly the same revenue with fewer orders, suggesting higher-value purchases.

-- Q7 Who are the top 10 customers by revenue, and what percentage of total revenue do they contribute?

WITH ALL_Customers_revenue AS (
SELECT c.customer_id,c.customer_name,
SUM(s.total_amount) AS customer_revenue
FROM customers AS c
INNER JOIN sales AS s
ON c.customer_id = s.customer_id
GROUP BY c.customer_id,c.customer_name
),
top_10 AS(
select *
FROM ALL_Customers_revenue
order BY customer_revenue DESC
LIMIT 10
)
SELECT
customer_id ,
customer_name,
customer_revenue,
ROUND(
customer_revenue * 100.0 /
(SELECT SUM(total_amount) FROM sales),2) AS revenue_percentage
FROM top_10
order by customer_revenue DESC

--Q8  Which products have high inventory but low sales, indicating potential overstock?

WITH product_sales AS(
select
p.product_name,
p.product_id,
P.stock_quantity,
COALESCE(SUM(s.quantity),0) AS units_sold
FROM products AS p
LEFT JOIN sales AS s
ON p.product_id = s.product_id
GROUP BY
p.product_name,
p.product_id,
P.stock_quantity
),
benchmarks AS(
SELECT
AVG(stock_quantity)as avg_stock,
AVG(units_sold) AS avg_units
FROM product_sales
)
SELECT
ps.product_name,
ps.product_id,
ps.stock_quantity,
ps.units_sold
FROM product_sales AS ps
CROSS JOIN benchmarks AS b
WHERE ps.stock_quantity >b.avg_stock
AND ps.units_sold < b.avg_units
ORDER BY ps.stock_quantity DESC
LIMIT 10;

--Q9 Which products have low inventory but high sales, indicating potential stockout risk?
WITH product_sales AS(
select
p.product_name,
p.product_id,
P.stock_quantity,
COALESCE(SUM(s.quantity),0) AS units_sold
FROM products AS p
LEFT JOIN sales AS s
ON p.product_id = s.product_id
GROUP BY
p.product_name,
p.product_id,
P.stock_quantity
),
benchmarks AS(
SELECT
AVG(stock_quantity)as avg_stock,
AVG(units_sold) AS avg_units
FROM product_sales
)
SELECT
ps.product_name,
ps.product_id,
ps.stock_quantity,
ps.units_sold
FROM product_sales AS ps
CROSS JOIN benchmarks AS b
WHERE ps.stock_quantity < b.avg_stock
AND ps.units_sold > b.avg_units
ORDER BY ps.units_sold DESC
LIMIT 10;
