-- ================================================
-- QUERY 1A: Revenue by Product Category
-- Which categories drive the most revenue?
-- Author: Abdullah Nasir
-- Dataset: Olist Brazilian E-Commerce (113,390 orders)
-- ================================================

SELECT 
    product_category_name,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(AVG(price), 2) AS avg_order_value,
    ROUND(SUM(price) / (SELECT SUM(price) FROM olist) * 100, 2) AS revenue_share_pct
FROM olist
WHERE order_status = 'delivered'
GROUP BY product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

-- ================================================
-- QUERY 1B: Revenue Trend by Year & Month
-- When does the platform make the most money?
-- ================================================

SELECT
    year_of_purchase,
    month_of_purchase,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(payment_value), 2) AS total_revenue,
    ROUND(AVG(payment_value), 2) AS avg_order_value
FROM olist
WHERE order_status = 'delivered'
GROUP BY year_of_purchase, month_of_purchase
ORDER BY year_of_purchase, total_revenue DESC;

-- ================================================
-- KEY FINDINGS:
-- 1. Beauty & Health is #1 revenue category at R$1.27M (9.33% share)
-- 2. Watches & Gifts has highest avg order value at R$200
-- 3. November 2017 peak month at R$1.53M (Black Friday effect)
-- ================================================
