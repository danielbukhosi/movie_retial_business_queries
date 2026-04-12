/*
 -- Output the top 3 actors who have appeared the most in movies in the “Children” category. 
 -- If several actors have the same number of movies, output all of them.
*/
select count(a.actor_id) as number_of_appearances,
       concat(a.first_name,' ',a.last_name) as actor_full_name,
       c.name as category_name,
	   dense_rank() over(order by count(a.actor_id) desc ) as popularity_rank
from actor a
left join film_actor fa
on a.actor_id = fa.actor_id
left join film f
on fa.film_id = f.film_id
left join film_category fc
on f.film_id = fc.film_id
left join category c
on fc.category_id = c.category_id
where c.name = 'Children'
group by actor_full_name, category_name
