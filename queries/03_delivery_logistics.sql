-- ================================================
-- QUERY 3: Delivery Performance by State
-- Which states have the worst delivery performance?
-- Author: Abdullah Nasir
-- Dataset: Olist Brazilian E-Commerce (113,390 orders)
-- ================================================

WITH delivery_analysis AS (
    SELECT
        order_id,
        customer_state,
        DATEDIFF(
            STR_TO_DATE(order_delivered_customer_date, '%Y-%m-%d %H:%i:%s'),
            STR_TO_DATE(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s')
        ) AS actual_delivery_days,
        DATEDIFF(
            STR_TO_DATE(order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s'),
            STR_TO_DATE(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s')
        ) AS estimated_delivery_days,
        DATEDIFF(
            STR_TO_DATE(order_delivered_customer_date, '%Y-%m-%d %H:%i:%s'),
            STR_TO_DATE(order_estimated_delivery_date, '%Y-%m-%d %H:%i:%s')
        ) AS delivery_delay_days
    FROM olist
    WHERE order_status = 'delivered'
    AND order_delivered_customer_date != 'N/A'
    AND order_estimated_delivery_date != 'N/A'
)
SELECT
    customer_state,
    COUNT(order_id) AS total_orders,
    ROUND(AVG(actual_delivery_days), 1) AS avg_actual_days,
    ROUND(AVG(estimated_delivery_days), 1) AS avg_estimated_days,
    ROUND(AVG(delivery_delay_days), 1) AS avg_delay_days,
    SUM(CASE WHEN delivery_delay_days > 0 THEN 1 ELSE 0 END) AS late_deliveries,
    ROUND(SUM(CASE WHEN delivery_delay_days > 0 THEN 1 ELSE 0 END) * 100.0 / COUNT(order_id), 1) AS late_delivery_pct
FROM delivery_analysis
GROUP BY customer_state
ORDER BY late_delivery_pct DESC
LIMIT 10;

-- ================================================
-- KEY FINDINGS:
-- 1. Alagoas (AL) worst performer — 21.3% late delivery rate
-- 2. Maranhão (MA) second worst — 18.2% late rate
-- 3. All states show negative avg delay — platform over-estimates delivery time
-- 4. Fix: Recalibrate estimates for northeastern states
-- ================================================
