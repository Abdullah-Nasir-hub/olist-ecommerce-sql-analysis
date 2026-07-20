-- ================================================
-- QUERY 2: RFM Customer Segmentation
-- Who are our best vs at-risk customers?
-- Author: Abdullah Nasir
-- Dataset: Olist Brazilian E-Commerce (113,390 orders)
-- ================================================

WITH rfm_base AS (
    SELECT
        customer_unique_id,
        DATEDIFF('2018-12-31', MAX(STR_TO_DATE(order_purchase_timestamp, '%Y-%m-%d %H:%i:%s'))) AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        ROUND(SUM(payment_value), 2) AS monetary
    FROM olist
    WHERE order_status = 'delivered'
    GROUP BY customer_unique_id
),
rfm_scored AS (
    SELECT *,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score
    FROM rfm_base
),
rfm_segments AS (
    SELECT *,
        (r_score + f_score + m_score) AS total_score,
        CASE
            WHEN (r_score + f_score + m_score) >= 13 THEN 'Champions'
            WHEN (r_score + f_score + m_score) >= 10 THEN 'Loyal Customers'
            WHEN (r_score + f_score + m_score) >= 7 THEN 'At Risk'
            ELSE 'Lost Customers'
        END AS segment
    FROM rfm_scored
)
SELECT
    segment,
    COUNT(customer_unique_id) AS total_customers,
    ROUND(AVG(recency), 0) AS avg_recency_days,
    ROUND(AVG(frequency), 2) AS avg_frequency,
    ROUND(AVG(monetary), 2) AS avg_monetary_value,
    ROUND(SUM(monetary), 2) AS total_revenue
FROM rfm_segments
GROUP BY segment
ORDER BY total_revenue DESC;

-- ================================================
-- KEY FINDINGS:
-- 1. Loyal Customers: 35,570 customers driving R$12.29M revenue
-- 2. At Risk: 44,361 customers — R$5.68M recoverable revenue
-- 3. Champions: 1,938 customers spending R$587 avg — VIP segment
-- 4. Win-back opportunity: 10% recovery of At Risk = R$568K
-- ================================================
