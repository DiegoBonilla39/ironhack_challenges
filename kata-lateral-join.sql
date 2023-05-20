SELECT
  categories.id AS category_id,
  categories.category,
  po.title,
  po.views,
  po.id AS post_id
FROM categories 
LEFT JOIN LATERAL (SELECT * 
                     FROM posts 
                     WHERE posts.category_id = categories.id
                     ORDER BY posts.views DESC
                     LIMIT 2) po ON po.category_id = categories.id
ORDER BY
	2,
	4 DESC,
    5;