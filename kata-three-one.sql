--SQL Basics: Group By Day

SELECT
  DATE(events.created_at) AS day,
  events.description,
  COUNT(events.id) AS count
FROM events
WHERE events.name IN ('trained')
GROUP BY 1,2
ORDER BY 1;

--Countries Capitals for Trivia Night (SQL for Beginners #6)

SELECT co.capital 
FROM countries AS co
WHERE
  co.continent IN ('Africa','Afrika') AND
  LEFT(co.country, 1) = 'E'
ORDER BY 1
LIMIT 3;

--SQL Bug Fixing: Fix the QUERY - Totaling

SELECT 
  DATE(s.transaction_date) AS day,
  d.name AS department,
  COUNT(s.id) AS sale_count
FROM department AS d
  JOIN sale AS s on d.id = s.department_id
GROUP BY 2, 1
ORDER BY 1;

