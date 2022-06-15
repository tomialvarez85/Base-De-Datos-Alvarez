USE sakila;
/*1 Find the films with less duration, show the title and rating.*/
SELECT title, rating
FROM film f
WHERE `length`=(SELECT MIN(`length`) FROM film f2);
/*2 Write a query that returns the tiltle of the film which duration is the lowest.
	If there are more than one film with the lowest durtation, the query returns an empty resultset.*/
SELECT title
FROM film f
WHERE 1=(SELECT COUNT(*)
			FROM film f2 
			WHERE `length`=(SELECT MIN(`length`) FROM film f3));
/*3 Generate a report with list of customers showing the lowest payments done by each of them.
	Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.*/
SELECT ALL c.customer_id,c.first_name,c.last_name,a.address,
	(SELECT MIN(amount)
		FROM payment p
		WHERE c.customer_id = p.customer_id)
	AS lowest_payment
FROM customer c JOIN address a  ON c.address_id = a.address_id;
/*4 Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.*/
SELECT ALL c.customer_id,c.first_name,c.last_name,
	(SELECT CONCAT( 
	(SELECT MIN(amount)
		FROM payment p
		WHERE c.customer_id = p.customer_id), " / ",
	(SELECT MAX(amount)
		FROM payment p
		WHERE c.customer_id = p.customer_id)
	))AS lowest_highest_paymemt
FROM customer c;