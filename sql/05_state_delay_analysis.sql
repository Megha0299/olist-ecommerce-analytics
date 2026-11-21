USE olist;

SELECT c.customer_state, 
       COUNT(*) AS orders, 
       SUM(o.is_late) AS late_orders,
       ROUND(AVG(o.is_late) * 100, 2) AS late_pct
FROM clean_orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_state
ORDER BY late_orders DESC
LIMIT 10;