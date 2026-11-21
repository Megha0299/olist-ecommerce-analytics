USE olist;

SELECT RANK() OVER (ORDER BY SUM(i.price) DESC) AS rnk,
       i.seller_id,
       COUNT(DISTINCT i.order_id) AS orders,
       ROUND(SUM(i.price), 2) AS revenue,
       ROUND(AVG(o.is_late) * 100, 1) AS late_pct,
       ROUND(AVG(o.review_score), 2) AS avg_review
FROM order_items i
JOIN clean_orders o ON i.order_id = o.order_id
GROUP BY i.seller_id
ORDER BY rnk
LIMIT 10;