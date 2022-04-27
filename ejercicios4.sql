/*1*/
select distinct(special_features), title from film where rating = 'PG-13';

/*2*/
select distinct(f1.length) from film f1 order by f1.length;

/*3*/
select title, replacement_cost, rental_rate from film where replacement_cost BETWEEN 20.00 AND 24.00;

/*4*/
select f.title, c.name, f.rating from film f, category c where special_features = 'Behind the Scenes';

/*5*/
select a.first_name, a.last_name, f.title from actor a, film f where f.title = 'ZOOLANDER FICTION';

/*6*/
select a.address, c.city, co.country from store s 
join address a on s.address_id = a.address_id join city c on a.city_id = c.city_id join country co on c.country_id = co.country_id 
where store_id = 1;

/*7*/
select title, rating from film order by rating, title;

/*8*/
select distinct(f.title), st.first_name, st.last_name from inventory i join film f on i.film_id = f.film_id join store s on i.store_id = s.store_id join staff st on s.manager_staff_id = st.staff_id where s.store_id = 2 order by st.first_name;

