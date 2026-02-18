/*
 -- Output the category of movies that have the highest number of total rental hours in the city (customer.address_id in this city) and that start with the letter “a”.
 -- Do the same for cities that have a “-” in them. Write everything in one query.
*/

select sum(f.rental_duration) as total_rental_hours,
       ca.name as category_name,
	   ci.city,
	   dense_rank() over( order by sum(f.rental_duration) desc ) as popularity_rank_by_city
from category ca
left join film_category fc
on ca.category_id = fc.category_id
left join film f
on fc.film_id = f.film_id
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id
left join customer c
on r.customer_id = c.customer_id
left join address a
on c.address_id = a.address_id
inner join city ci
on a.city_id = ci.city_id
where ca.name like '%A%'
group by name, city
having city like '%-%'


