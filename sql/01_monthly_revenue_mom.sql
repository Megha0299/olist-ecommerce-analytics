USE olist;

WITH monthly AS (
  SELECT DATE_FORMAT(order_purchase_timestamp, '%Y-%m') AS ym,
         COUNT(*) AS orders,
         ROUND(SUM(order_total), 2) AS revenue
  FROM clean_orders
  WHERE order_purchase_timestamp >= '2017-01-01'
    AND order_purchase_timestamp < '2018-09-01'
  GROUP BY ym
)
SELECT ym, orders, revenue,
       ROUND((revenue - LAG(revenue) OVER (ORDER BY ym))
             / LAG(revenue) OVER (ORDER BY ym) * 100, 1) AS mom_growth_pct
FROM monthly
ORDER BY ym;