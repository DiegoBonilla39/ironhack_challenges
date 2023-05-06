SELECT
  player_name,
  SUM(games) AS games,
  CAST(CAST(CAST(SUM(hits) AS NUMERIC(6,3))/CAST(SUM(at_bats) AS NUMERIC(6,3)) AS NUMERIC(4,3)) AS VARCHAR) AS batting_average
FROM yankees
WHERE at_bats >= 100
GROUP BY 1
ORDER BY 3 DESC