                                                            List of databases
   Name    |  Owner   | Encoding | Locale Provider |      Collate       |       Ctype        | Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+--------------------+--------------------+--------+-----------+-----------------------
 company   | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 postgres  | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 template0 | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =c/postgres          +
           |          |          |                 |                    |                    |        |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =c/postgres          +
           |          |          |                 |                    |                    |        |           | postgres=CTc/postgres
(4 rows)

            List of relations
 Schema |    Name     | Type  |  Owner   
--------+-------------+-------+----------
 public | departments | table | postgres
 public | staff       | table | postgres
(2 rows)

ALTER TABLE
            List of relations
 Schema |    Name     | Type  |  Owner   
--------+-------------+-------+----------
 public | departments | table | postgres
 public | employees   | table | postgres
(2 rows)

                     Table "public.employees"
   Column    |       Type        | Collation | Nullable | Default 
-------------+-------------------+-----------+----------+---------
 employee_id | integer           |           |          | 
 first_name  | character varying |           |          | 
 last_name   | character varying |           |          | 
 salary      | numeric           |           | not null | 

Q1. insert into employees (employee_id , first_name , last_name , salary) values (1,'Aalekh','Modgil',50000),(2,'Aryan','Negi',60000),(3,'Chetan','Anand',70000);
    select * from employees;
INSERT 0 3
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           1 | Aalekh     | Modgil    |  50000
           2 | Aryan      | Negi      |  60000
           3 | Chetan     | Anand     |  70000
(3 rows)

Q2.  select first_name, last_name from employees;
 first_name | last_name 
------------+-----------
 Aalekh     | Modgil
 Aryan      | Negi
 Chetan     | Anand
(3 rows)

Q3. update employees set salary = 70000 where employee_id = 1;
    select * from employees;
UPDATE 1
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           2 | Aryan      | Negi      |  60000
           3 | Chetan     | Anand     |  70000
           1 | Aalekh     | Modgil    |  70000
(3 rows)

Q4. delete from employees where employee_id = 3;
    select * from employees;
DELETE 1
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           2 | Aryan      | Negi      |  60000
           1 | Aalekh     | Modgil    |  70000
(2 rows)

Q5. insert into employees (employee_id , first_name , last_name , salary) values (3,'Chetan','Anand',65000);
    select * from employees;
INSERT 0 1
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           2 | Aryan      | Negi      |  60000
           1 | Aalekh     | Modgil    |  70000
           3 | Chetan     | Anand     |  65000
(3 rows)

Q6. select * from employees where salary > 60000;
 employee_id | first_name | last_name | salary 
-------------+------------+-----------+--------
           1 | Aalekh     | Modgil    |  70000
           3 | Chetan     | Anand     |  65000
(2 rows)

CREATE DATABASE

CREATE TABLE
                                                            List of databases
   Name    |  Owner   | Encoding | Locale Provider |      Collate       |       Ctype        | Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+--------------------+--------------------+--------+-----------+-----------------------
 company   | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 inventory | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 postgres  | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 template0 | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =c/postgres          +
           |          |          |                 |                    |                    |        |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =c/postgres          +
           |          |          |                 |                    |                    |        |           | postgres=CTc/postgres
(5 rows)

          List of relations
 Schema |   Name   | Type  |  Owner   
--------+----------+-------+----------
 public | products | table | postgres
(1 row)

                      Table "public.products"
    Column    |       Type        | Collation | Nullable | Default 
--------------+-------------------+-----------+----------+---------
 product_id   | integer           |           |          | 
 product_name | character varying |           |          | 
 price        | numeric           |           |          | 

Q7. insert into products (product_id , product_name , price ) values (1,'T-shirt',2000),(2,'Jeans',1500),(3,'Sneakers',2500),(4,'Pants',1000),(5,'Shirt',3000);
    select * from products;
INSERT 0 5
 product_id | product_name | price 
------------+--------------+-------
          1 | T-shirt      |  2000
          2 | Jeans        |  1500
          3 | Sneakers     |  2500
          4 | Pants        |  1000
          5 | Shirt        |  3000
(5 rows)

Q8. update products set price = 4000 where product_name = 'Sneakers';
    select * from products;
UPDATE 1
 product_id | product_name | price 
------------+--------------+-------
          1 | T-shirt      |  2000
          2 | Jeans        |  1500
          4 | Pants        |  1000
          5 | Shirt        |  3000
          3 | Sneakers     |  4000
(5 rows)

Q9. select * from products where price between 2000 and 3000;

 product_id | product_name | price 
------------+--------------+-------
          1 | T-shirt      |  2000
          5 | Shirt        |  3000
(2 rows)

Q10. delete from products where price < 1500;
     select * from products;
DELETE 1
 product_id | product_name | price 
------------+--------------+-------
          1 | T-shirt      |  2000
          2 | Jeans        |  1500
          5 | Shirt        |  3000
          3 | Sneakers     |  4000
(4 rows)
