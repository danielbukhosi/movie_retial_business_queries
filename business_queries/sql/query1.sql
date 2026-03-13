/*
  -- Output the number of movies in each category, sorted descending. --
*/

-- JOIN PLAN
-- category --> film_category --> film(INNER JOIN)
SELECT  c.category_id,
        c.name,
		count(f.film_id) AS movies_in_category
FROM category c
JOIN film_category fc
ON c.category_id = fc.category_id
JOIN film f
ON fc.film_id = f.film_id
GROUP BY c.category_id,c.name
ORDER BY movies_in_category DESC;