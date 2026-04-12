/*
  -- Output the category of movies on which the most money was spent.
*/
select c.category_id,
       c.name,
       sum(p.amount) as amount_spent
from category c
join film_category fc
on c.category_id = fc.category_id
join film f
on fc.film_id = f.film_id
join inventory i
on f.film_id = i.film_id
join rental r
on i.inventory_id = r.inventory_id
join payment p
on r.rental_id = p.rental_id
group by c.name, c.category_id
order by amount_spent desc
limit 1