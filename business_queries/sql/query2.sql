/*
  -- Output the 10 actors whose movies rented the most, sorted in descending order. --
*/

select
       concat(a.first_name,' ',a.last_name) as actor_full_name,
	   count(r.rental_id) as rental_count
from actor a
join film_actor fa 
on a.actor_id = fa.actor_id
join film f 
on fa.film_id = f.film_id
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
group by actor_full_name
order by rental_count desc
limit 10

