/*
 -- Output cities with the number of active and inactive customers (active - customer.active = 1). 
 -- Sort by the number of inactive customers in descending order.
*/
select ci.city,
       count(c.active) filter(where c.active = 1) as active_customers_count,
	   count(c.active) filter(where c.active = 0) as inactive_customers_count
from city ci
join country co
on ci.country_id = co.country_id
join address a
on ci.city_id = a.city_id
join customer c
on a.address_id = c.address_id
group by city
order by count(c.active) filter(where c.active = 0) desc



