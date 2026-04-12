/*
 -- Print the names of movies that are not in the inventory. Write a query without using the IN operator.
*/
select 
       f.title as name_of_movie
from film f
  left join inventory i
on f.film_id = i.film_id
where inventory_id is  null;

-- Second version of the anti join

SELECT f.title AS anem_of_movie
FROM film f
WHERE NOT EXISTS (
      SELECT i.inventory_id
	  FROM inventory i
	  WHERE i.film_id = f.film_id
);


