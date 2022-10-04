-- 1. Write a function that returns the amount of copies of a film in a store in sakila-db. Pass either the film id or the film name and the store id.

DELIMITER $

CREATE FUNCTION get_amount(f_id INT, st_id INT) RETURNS 
INT DETERMINISTIC 
BEGIN 
	DECLARE cant INT;
	SELECT
	    COUNT(i.inventory_id) INTO cant
	FROM film f
	    INNER JOIN inventory i USING(film_id)
	    INNER JOIN store st USING(store_id)
	WHERE
	    f.film_id = f_id
	    AND st.store_id = st_id;
	RETURN (cant);
END $ 

DELIMITER ;

SELECT get_amount(44,2);

-- 2. Write a stored procedure with an output parameter that contains a list of customer first and last names separated by ";", that live in a certain country. You pass the country it gives you the list of people living there. USE A CURSOR, do not use any aggregation function (ike CONTCAT_WS.

DELIMITER $

DROP PROCEDURE IF EXISTS list_procedure $

CREATE PROCEDURE list_procedure(
	IN co_name VARCHAR(250), 
	OUT list VARCHAR(500)
	) 
BEGIN 
	DECLARE finished INT DEFAULT 0;
	DECLARE f_name VARCHAR(250) DEFAULT ''; 
	DECLARE l_name VARCHAR(250) DEFAULT '';
	DECLARE coun VARCHAR(250) DEFAULT '';

	DECLARE cursList CURSOR FOR
	SELECT
	    co.country,
	    c.first_name,
	    c.last_name
	FROM customer c
	    INNER JOIN address USING(address_id)
	    INNER JOIN city USING(city_id)
	    INNER JOIN country co USING(country_id);
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	OPEN cursList;

	looplabel: LOOP
		FETCH cursList INTO coun, f_name, l_name;
		IF finished = 1 THEN
			LEAVE looplabel;
		END IF;

		IF coun = co_name THEN
			SET list = CONCAT(f_name,';',l_name);
		END IF;
		
		
	END LOOP looplabel;
	CLOSE cursList;
	

END $
DELIMITER ;


set @list = '';

CALL list_procedure('Canada',@list);

SELECT @list;

-- 3. Review the function inventory_in_stock and the procedure film_in_stock explain the code, write usage examples.

-- INVENTORY_IN_STOCK
-- Let's get the code of the function inventory_in_stock.
SHOW CREATE FUNCTION inventory_in_stock;
-- The source code is the next one:
/*
CREATE FUNCTION `inventory_in_stock`(p_inventory_id INT) RETURNS tinyint(1)
BEGIN
    DECLARE v_rentals INT;
    DECLARE v_out     INT;
    SELECT COUNT(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;
    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;
    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;
    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END
*/
-- Explaining of the code:
-- This function returns TRUE or FALSE, depending if the inventory has stock or not.
-- To do this, we pass the inventory_id to the function.
-- Internally, the code has 2 variables: v_rentals and v_out.
-- v_rentals is the result of a query that gets the count of rentals where inventory_id matches with the one passed in parameters. If is equal to 0 (there is no rentals), it will throw TRUE (inventory has stock).
-- v_out is the result of a query that also gets the count of rental_id from the table inventory, matching the inventory_id with the one passed in parameters, but with the filter that return_date is null (film not returned). If v_out is greater than 0, returns FALSE, otherwise, TRUE.


-- Examples of usage
SELECT inventory_in_stock(3000); -- This one throws 1 (TRUE, because MySQL detects boolean as 0 for FALSE and 1 for TRUE)

SELECT inventory_in_stock(4568); -- This one throws 0 (FALSE, because MySQL detects boolean as 0 for FALSE and 1 for TRUE)


-- FILM_IN_STOCK
-- Let's get the code of the procedure film_in_stock.
SHOW CREATE PROCEDURE film_in_stock;
-- The source code is the next one:
/*
CREATE PROCEDURE `film_in_stock`(IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
BEGIN
     SELECT inventory_id
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id);
     SELECT COUNT(*)
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id)
     INTO p_film_count;
END
*/
-- Explaining of the code:
-- This procedure, if you call it, it will show you the different inventory_id that has the film_id and store_id that you send in the parameters. It also can return the total of inventories that have that film in that store.
-- Internally, it has 2 "queries". 
-- The first one, is for showing the different inventory_id, matching the film_id and store_id with its respective filters in the WHERE clause.
-- The second one, is for return the total of inventories, considering the parameters you sent. 

-- Example of usage
CALL film_in_stock(2,2,@total);
SELECT @total;