USE olist;

SELECT CASE WHEN delay_days <= 0 THEN '1. On time / early'
            WHEN delay_days BETWEEN 1 AND 3 THEN '2. 1-3 days late'
            WHEN delay_days BETWEEN 4 AND 7 THEN '3. 4-7 days late'
            ELSE '4. 8+ days late' END AS bucket,
       COUNT(*) AS orders,
       ROUND(AVG(review_score), 2) AS avg_review,
       ROUND(AVG(review_score = 1) * 100, 1) AS one_star_pct
FROM clean_orders
WHERE review_score IS NOT NULL
GROUP BY bucket
ORDER BY bucket;