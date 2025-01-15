                                                               List of databases
      Name      |  Owner   | Encoding | Locale Provider |      Collate       |       Ctype        | Locale | ICU Rules |   Access privileges   
----------------+----------+----------+-----------------+--------------------+--------------------+--------+-----------+-----------------------
 company        | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =Tc/postgres         +
                |          |          |                 |                    |                    |        |           | postgres=CTc/postgres+
                |          |          |                 |                    |                    |        |           | aalekh=c/postgres
 employee_sales | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 inventory      | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 join_database  | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 postgres       | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 school         | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 shop_database  | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 template0      | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =c/postgres          +
                |          |          |                 |                    |                    |        |           | postgres=CTc/postgres
 template1      | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =c/postgres          +
                |          |          |                 |                    |                    |        |           | postgres=CTc/postgres
(9 rows)

            List of relations
 Schema |     Name     | Type  |  Owner   
--------+--------------+-------+----------
 public | accounts     | table | postgres
 public | customers    | table | postgres
 public | departments  | table | postgres
 public | employees    | table | postgres
 public | inventories  | table | postgres
 public | likes        | table | postgres
 public | orders       | table | postgres
 public | posts        | table | postgres
 public | products     | table | postgres
 public | sales        | table | postgres
 public | sessions     | table | postgres
 public | transactions | table | postgres
 public | users        | table | postgres
 public | warehouses   | table | postgres
(14 rows)

 customer_id | customer_name 
-------------+---------------
           1 | Aalekh
           2 | Aryan
           3 | Aman
(3 rows)

 order_id | order_name | customer_id 
----------+------------+-------------
      101 | T-shirt    |           1
      102 | Shoes      |           2
      103 | Jeans      |           1
(3 rows)

Q1. SELECT distinct c.customer_name FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id WHERE o.order_id IS NOT NULL;

 customer_name 
---------------
 Aalekh
 Aryan
(2 rows)

 product_id | product_name 
------------+--------------
          1 | Laptop
          2 | Smartphone
          3 | Tablet
          4 | Headphones
          5 | Monitor
(5 rows)

 inventory_id | product_id | warehouse_id | quantity 
--------------+------------+--------------+----------
            1 |          1 |            1 |       10
            2 |          2 |            1 |       15
            3 |          3 |            2 |        5
(3 rows)

Q2. select p.product_name from products p left join inventories i on p.product_id = i.product_id where i.product_id is null;

 product_name 
--------------
 Monitor
 Headphones
(2 rows)

 employee_id | employee_name | department_id 
-------------+---------------+---------------
           1 | Aalekh        |             1
           2 | Aryan         |             1
           3 | Aman          |             2
           4 | John          |             3
(4 rows)

 department_id | department_name 
---------------+-----------------
             1 | Sales
             2 | Marketing
             3 | Finance
(3 rows)

 sale_id | employee_id | sale_amount 
---------+-------------+-------------
       1 |           1 |     5000.00
       2 |           2 |     7000.00
       3 |           3 |     6000.00
       4 |           1 |     3000.00
       5 |           4 |     8000.00
(5 rows)

Q3. select d.department_name , sum(s.sale_amount) as total_sales from departments d inner join employees e on d.department_id = e.department_id inner join sales s on e.employee_id = s.employee_id group by d.department_name order by total_sales desc limit 1;

 department_name | total_sales 
-----------------+-------------
 Sales           |    15000.00
(1 row)

 user_id |   name   
---------+----------
       1 | Aalekh
       2 | Aryan
       3 | Aman
       4 | Ashutosh
(4 rows)

 session_id | user_id |     login_time      
------------+---------+---------------------
        101 |       1 | 2025-01-01 10:00:00
        102 |       3 | 2025-01-02 12:30:00
(2 rows)

Q4. select u.user_id , u.name from users u left join sessions s on u.user_id = s.user_id where s.user_id is null;
 user_id |   name   
---------+----------
       2 | Aryan
       4 | Ashutosh
(2 rows)

 post_id | user_id |     content      
---------+---------+------------------
     101 |       1 | Post by Aalekh
     102 |       2 | Post by Aryan
     103 |       3 | Post by Aman
     104 |       4 | Post by Ashutosh
(4 rows)

 like_id | user_id | post_id 
---------+---------+---------
     201 |       2 |     101
     202 |       3 |     101
     203 |       4 |     101
     204 |       1 |     102
     205 |       3 |     102
     206 |       1 |     103
(6 rows)

Q5. select p.post_id , p.content , count(l.like_id) as like_count from posts p inner join likes l on p.post_id = l.post_id group by p.post_id order by like_count desc limit 1;

 post_id |    content     | like_count 
---------+----------------+------------
     101 | Post by Aalekh |          3
(1 row)

