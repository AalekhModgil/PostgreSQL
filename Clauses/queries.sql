           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | customers | table | postgres
 public | orders    | table | postgres
 public | products  | table | postgres
(3 rows)

                     Table "public.customers"
   Column    |       Type        | Collation | Nullable | Default 
-------------+-------------------+-----------+----------+---------
 customer_id | integer           |           | not null | 
 first_name  | character varying |           |          | 
 last_name   | character varying |           |          | 
 city        | character varying |           |          | 
Indexes:
    "customers_pkey" PRIMARY KEY, btree (customer_id)
Referenced by:
    TABLE "orders" CONSTRAINT "orders_customer_id_fkey" FOREIGN KEY (customer_id) REFERENCES customers(customer_id)

 customer_id | first_name | last_name |    city     
-------------+------------+-----------+-------------
           1 | Aalekh     | Modgil    | New York
           2 | Aryan      | Negi      | Las Angeles
           3 | Aman       | Sharma    | Chicago
           4 | Prabal     | Negi      | New York
(4 rows)

Q1. select first_name , last_name from customers where city = 'New York';

 first_name | last_name 
------------+-----------
 Aalekh     | Modgil
 Prabal     | Negi
(2 rows)

 order_id | customer_id | order_date | total_amount 
----------+-------------+------------+--------------
        1 |           1 | 2024-01-05 |          120
        2 |           2 | 2024-01-10 |           80
        3 |           1 | 2024-01-15 |          150
        4 |           3 | 2024-01-12 |           60
        5 |           4 | 2024-01-20 |          200
(5 rows)

Q2.  select * from orders where order_date > '2024-01-10';

 order_id | customer_id | order_date | total_amount 
----------+-------------+------------+--------------
        3 |           1 | 2024-01-15 |          150
        4 |           3 | 2024-01-12 |           60
        5 |           4 | 2024-01-20 |          200
(3 rows)

 product_id | product_name | price 
------------+--------------+-------
          1 | Laptop       |  9000
          2 | Phone        |  5000
          3 | Headphones   |  4000
          4 | Tablet       |  3000
          5 | TV           |  2000
(5 rows)

Q3. select product_name , price from products where price between 1500 and 5500;

 product_name | price 
--------------+-------
 Phone        |  5000
 Headphones   |  4000
 Tablet       |  3000
 TV           |  2000
(4 rows)

Q4. select concat(first_name , ' ', last_name) as full_name from customers;

   full_name   
---------------
 Aalekh Modgil
 Aryan Negi
 Aman Sharma
 Prabal Negi
(4 rows)

