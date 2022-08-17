USE sakila;

#1

SELECT *
FROM address ad
    INNER JOIN city ci USING(city_id)
    INNER JOIN country
WHERE ad.postal_code IN(
        SELECT postal_code
        FROM address
        WHERE
            address LIKE '%y'
            AND postal_code IN(
                SELECT
                    postal_code
                FROM address
                WHERE
                    postal_code LIKE '%9'
            )
    );


CREATE INDEX addressIndex ON address(postal_code);

DROP INDEX addressIndex ON address;

/*The query runs faster once an index is created. 
MySQL uses the indexes to select exact physical corresponding rows of the table
instead of scanning the whole table.*/
#2

SELECT first_name
FROM actor;

SELECT last_name FROM actor;

/*The las_name query is faster, because there is an index in the last_name*/

#3 
CREATE FULLTEXT INDEX descIndex ON film(description);

DROP INDEX descIndex ON film;

#slower
SELECT f.description
FROM film f
WHERE
    f.description LIKE '%Epic%';
#ALVAREZ
#faster
SELECT f.description
FROM film f
WHEREAdds the filetype django-html

    MATCH(f.description) AGAINST('Epic' IN NATURAL LANGUAGE MODE);
    
   
   
   