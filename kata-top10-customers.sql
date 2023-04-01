-- Replace with your query (in pure SQL)

SELECT
  cu.customer_id AS "customer_id",
  cu.email AS "email",
  COUNT(pa.payment_id) AS "payments_count",
  CAST(SUM(pa.amount) AS float) AS "total_amount"
FROM
  customer as cu
  INNER JOIN payment AS pa ON cu.customer_id = pa.customer_id
GROUP BY cu.customer_id
ORDER BY 4 DESC
LIMIT 10