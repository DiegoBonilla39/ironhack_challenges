-- Replace with your SQL Query

SELECT
  COUNT(pr.name) AS products,
  pr.country
FROM products as pr
WHERE pr.country IN ('United States of America','Canada')
GROUP BY pr.country
ORDER BY 1 DESC;