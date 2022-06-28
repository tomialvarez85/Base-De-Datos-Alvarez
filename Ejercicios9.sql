USE sakila;

#1


SELECT c2.country, COUNT(c.city) FROM city c 
JOIN country c2 ON c.country_id = c2.country_id 
GROUP BY c2.country, c2.country_id ORDER BY c2.country_id; 


#2


SELECT c.country, COUNT(c2.city) AS 'Cant Ciud' FROM country c 
JOIN city c2 ON c.country_id = c2.country_id 
GROUP BY c.country, c.country_id HAVING COUNT(DISTINCT city) > 10 ORDER BY COUNT(c2.city) DESC;


#3


SELECT c.first_name, c.last_name, a.address,
(SELECT COUNT(*) FROM rental r WHERE  r.customer_id = c.customer_id) AS 'Total_Films', 
(SELECT SUM(p.amount) FROM payment p WHERE p.customer_id = p.customer_id) AS 'Total_Money_Spent'
FROM customer c JOIN address a ON a.address_id = c.address_id
ORDER BY Total_Films;


#4


SELECT c.name, AVG(f.`length`) FROM film f 
JOIN film_category fc ON f.film_id=fc.film_id 
JOIN category c ON c.category_id=fc.category_id
GROUP BY c.name ORDER BY AVG(f.`length`) DESC;


#5Show sales per film rating


SELECT f.rating, COUNT(p.amount) FROM film f
JOIN inventory i ON f.film_id=i.inventory_id 
JOIN rental r ON i.inventory_id=r.inventory_id 
JOIN payment p ON r.rental_id=p.rental_id
GROUP BY f.rating;


