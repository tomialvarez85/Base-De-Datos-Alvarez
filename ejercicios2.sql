CREATE TABLE IF NOT EXISTS film
(
    film_id INT AUTO_INCREMENT NOT NULL,
    title VARCHAR(20),
    description VARCHAR,
    release_year YEAR,
    CONSTRAINT pk PRIMARY KEY (film_id)
);


CREATE TABLE IF NOT EXISTS actor
(
    actor_id INT AUTO_INCREMENT NOT NULL,
    first_name VARCHAR(20),
    last_name VARCHAR(20),
    CONSTRAINT pk PRIMARY KEY (actor_id)
);

CREATE TABLE if NOT EXISTS film_actor
(
	actor_id INT,
	film_id INT
);

ALTER TABLE film ADD COLUMN last_update DATE;
ALTER TABLE actor ADD COLUMN last_update DATE;
ALTER TABLE film_actor ADD CONSTRAINT fk_film FOREIGN KEY (film_id) REFERENCES film(film_id);
ALTER TABLE film_actor ADD CONSTRAINT fk_autor FOREIGN KEY (actor_id) REFERENCES actor(actor_id);


INSERT INTO film (title, description, release_year) VALUE('Transformers', 'La primera de la saga', '2014');
INSERT INTO film (title, description, release_year) VALUE('Maradona: el documental', 'La película de Diego Maradona', '2011');
INSERT INTO film (title, description, release_year) VALUE('Teodoro', 'El mejor profesor', '1965');

INSERT INTO actor (first_name, last_name) VALUE('Franco', 'Scuvi');
INSERT INTO actor (first_name, last_name) VALUE('Barbie', 'Rivas');
INSERT INTO actor (first_name, last_name) VALUE('Lana', 'Rhoades');
INSERT INTO actor (first_name, last_name) VALUE('Megan', 'Fox');
INSERT INTO actor (first_name, last_name) VALUE('Tomas', 'Houston');
INSERT INTO actor (first_name, last_name) VALUE('Adam', 'Sandler');

INSERT INTO film_actor (actor_id, film_id) VALUE(1, 1);
INSERT INTO film_actor (actor_id, film_id) VALUE(2, 2);
INSERT INTO film_actor (actor_id, film_id) VALUE(3, 2);
INSERT INTO film_actor (actor_id, film_id) VALUE(4, 3);
INSERT INTO film_actor (actor_id, film_id) VALUE(5, 3);
INSERT INTO film_actor (actor_id, film_id) VALUE(6, 3);