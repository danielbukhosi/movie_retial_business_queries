/*
 -- Output the category of movies that have the highest number of total rental hours in the city (customer.address_id in this city) and that start with the letter “a”.
 -- Do the same for cities that have a “-” in them. Write everything in one query.
*/


WITH CategoryRankings_01 AS (
    SELECT 
        ca.name AS category_name,
        ci.city,
        SUM(f.rental_duration) AS total_rental_hours, 
        DENSE_RANK() OVER(PARTITION BY ci.city ORDER BY SUM(f.rental_duration) DESC) AS total_rental_hours_ranking
    FROM category ca
    LEFT JOIN film_category fc ON ca.category_id = fc.category_id
    LEFT JOIN film f ON fc.film_id = f.film_id
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN customer c ON r.customer_id = c.customer_id
    LEFT JOIN address a ON c.address_id = a.address_id
    INNER JOIN city ci ON a.city_id = ci.city_id
    WHERE ca.name ILIKE 'A%'
    GROUP BY ca.name, ci.city
	ORDER BY total_rental_hours DESC
),

CategoryRankings_02 AS (
    SELECT 
        DISTINCT ca.name AS category_name,
        ci.city,
        SUM(f.rental_duration) AS total_rental_hours, 
        DENSE_RANK() OVER(PARTITION BY ci.city ORDER BY SUM(f.rental_duration) DESC) AS total_rental_hours_ranking
    FROM category ca
    LEFT JOIN film_category fc ON ca.category_id = fc.category_id
    LEFT JOIN film f ON fc.film_id = f.film_id
    LEFT JOIN inventory i ON f.film_id = i.film_id
    LEFT JOIN rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN customer c ON r.customer_id = c.customer_id
    LEFT JOIN address a ON c.address_id = a.address_id
    INNER JOIN city ci ON a.city_id = ci.city_id
    WHERE ci.city LIKE '%-%'
    GROUP BY ca.name, ci.city
	ORDER BY total_rental_hours DESC
),

all_category_rankings  AS(

  (
	  SELECT * FROM CategoryRankings_01
	  WHERE total_rental_hours_ranking = 1
  )
  UNION ALL
  (
	  SELECT * FROM CategoryRankings_02
	  WHERE total_rental_hours_ranking = 1
  )
)
SELECT * from all_category_rankings;
   



