-- 4. Find all the film titles that are not in the inventory.

SELECT f.title FROM film f
WHERE f.film_id NOT IN (SELECT f2.film_id   
                        FROM film f2
                        INNER JOIN inventory i using(film_id));

-- 5. Find all the films that are in the inventory but were never rented.
    -- Show title and inventory_id.
    -- This exercise is complicated.
    -- hint: use sub-queries in FROM and in WHERE or use left join
    -- and ask if one of the fields is null
                       
SELECT f.title, i.inventory_id FROM film f
INNER JOIN inventory i USING(film_id)
WHERE f.film_id NOT IN (SELECT f.film_id
                        FROM rental r
                        INNER JOIN inventory i USING(inventory_id)
                        INNER JOIN film f USING(film_id));

-- 6. Generate a report with:
    -- customer (first, last) name, store id, film title,
    -- when the film was rented and returned for each of these customers
    -- order by store_id, customer last_name
                       
SELECT c.first_name, c.last_name, s.store_id, f.title, r.rental_date FROM rental r
INNER JOIN customer c USING(customer_id)
INNER JOIN store s USING(store_id)
INNER JOIN inventory i USING(inventory_id)
INNER JOIN film f USING(film_id)
ORDER BY s.store_id, c.last_name;

-- 7. Show sales per store (money of rented films)
    -- show store's city, country, manager info and total sales (money)
    -- (optional) Use concat to show city and country and manager first and last name
SELECT s.store_id,
        CONCAT(ci.city, ', ', co.country) AS `City and Country`, 
        CONCAT(m.first_name, ' ', m.last_name) AS `First and Last Name`,
        (SELECT SUM(p.amount)
            FROM payment p
            WHERE p.staff_id = s.manager_staff_id) AS `Total money`
FROM staff m INNER JOIN store s ON m.staff_id = s.manager_staff_id
INNER JOIN address a ON s.address_id = a.address_id
INNER JOIN city ci USING(city_id)
INNER JOIN country co USING(country_id);

-- 8. Which actor has appeared in the most films?

SELECT a.first_name, a.last_name, COUNT(fa.film_id) AS `Total films`
FROM actor a
INNER JOIN film_actor fa USING(actor_id)
GROUP BY fa.actor_id
ORDER BY `Total films` DESC
LIMIT 1;