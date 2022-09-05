# Needs the employee table (defined in the triggers section) created and populated.

CREATE TABLE `employees` (
  `employeeNumber` int NOT NULL,
  `lastName` varchar(50) NOT NULL,
  `firstName` varchar(50) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `officeCode` varchar(10) NOT NULL,
  `reportsTo` int DEFAULT NULL,
  `jobTitle` varchar(50) NOT NULL,
  PRIMARY KEY (`employeeNumber`)
);

insert  into `employees`(`employeeNumber`,`lastName`,`firstName`,`extension`,`email`,`officeCode`,`reportsTo`,`jobTitle`) values 

(1002,'Murphy','Diane','x5800','dmurphy@classicmodelcars.com','1',NULL,'President'),

(1056,'Patterson','Mary','x4611','mpatterso@classicmodelcars.com','1',1002,'VP Sales'),

(1076,'Firrelli','Jeff','x9273','jfirrelli@classicmodelcars.com','1',1002,'VP Marketing');

CREATE TABLE employees_audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employeeNumber INT NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    changedat DATETIME DEFAULT NULL,
    action VARCHAR(50) DEFAULT NULL
);

DELIMITER $$
CREATE TRIGGER before_employee_update 
    BEFORE UPDATE ON employees
    FOR EACH ROW 
BEGIN
    INSERT INTO employees_audit
    SET action = 'update',
     employeeNumber = OLD.employeeNumber,
        lastname = OLD.lastname,
        changedat = NOW(); 
END$$
DELIMITER ;

UPDATE employees 
SET 
    lastName = 'Phan'
WHERE
    employeeNumber = 1056;

SELECT 
    *
FROM
    employees_audit;
    
#1) Insert a new employee to , but with an null email. Explain what happens.
insert into employees values (1069, "Menem", "Carlos", "x6969", null, "1", null, "presidente de america");
#!column email cannot be null

#2) Run the first the query
UPDATE employees SET employeeNumber = employeeNumber - 20;
select * from employees;
#esto le resta 20 al numero de empleado de todos

UPDATE employees SET employeeNumber = employeeNumber + 20;
select * from employees;
#no me deja por duplicated entry 1056 for employees.primary key

#3) Add a age column to the table employee
#where and it can only accept values from 16 up to 70 years old.

alter table employees
	add age int check(age >= 16 and age <= 70);

#4) Describe the referential integrity between tables film, actor and film_actor in sakila db.

#la tabla film_actor es una tabla intermedia que sirve para hacer una relación muchos a muchos
#entre las tablas film y actor

#5) Create a new column called lastUpdate to table employee and use trigger(s)
#to keep the date-time updated on inserts and updates operations.

alter table employees
	add lastUpdate datetime;

DELIMITER $$
CREATE TRIGGER before_employees_update
    before UPDATE ON employees
    FOR EACH ROW 
BEGIN
    SET new.lastUpdate = now();
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER before_employees_insert
    before insert ON employees
    FOR EACH ROW 
BEGIN
    SET new.lastUpdate = now();
END$$
DELIMITER ;