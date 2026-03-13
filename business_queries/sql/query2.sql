/*
  -- Output the 10 actors whose movies rented the most, sorted in descending order. --
*/

select a.actor_id as actor_id,
       concat(a.first_name,' ',a.last_name) as actor_full_name,
	   count(r.rental_id) as rental_count
from actor a
join film_actor fa 
on a.actor_id = fa.actor_id
join inventory i 
on fa.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
group by a.actor_id, actor_full_name
order by actor_full_name desc
limit 10;

