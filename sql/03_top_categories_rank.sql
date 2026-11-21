USE olist;

WITH cat AS (
  SELECT COALESCE(t.product_category_name_english, 'unknown') AS category,
         COUNT(DISTINCT i.order_id) AS orders,
         ROUND(SUM(i.price), 2) AS revenue
  FROM order_items i
  JOIN clean_orders o ON i.order_id = o.order_id
  JOIN products p ON i.product_id = p.product_id
  LEFT JOIN category_translation t ON p.product_category_name = t.product_category_name
  GROUP BY category
)
SELECT RANK() OVER (ORDER BY revenue DESC) AS rnk,
       category, orders, revenue,
       ROUND(revenue / SUM(revenue) OVER () * 100, 1) AS pct_of_revenue
FROM cat
ORDER BY rnk
LIMIT 10;