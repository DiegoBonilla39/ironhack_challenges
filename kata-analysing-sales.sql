SELECT
  pr.name AS product_name,
  CAST(DATE_PART('YEAR', sa.date) AS int) AS "year",
  CAST(DATE_PART('MONTH', sa.date) AS int) AS "month",
  CAST(DATE_PART('DAY', sa.date) AS int) AS "day",
  SUM(sd.count * pr.price) AS total
FROM sales_details AS sd
	INNER JOIN products AS pr ON sd.product_id = pr.id
	INNER JOIN sales AS sa ON sd.sale_id = sa.id
GROUP BY
  1,
  ROLLUP (2, 3, 4)
ORDER BY 1