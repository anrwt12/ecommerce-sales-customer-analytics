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

-- The business generated ₹5.93B in net revenue from 250K orders and 39.9K custom
