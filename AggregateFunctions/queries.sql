CREATE DATABASE
CREATE TABLE
INSERT 0 5
CREATE TABLE
INSERT 0 5
                   Table "public.sales"
     Column     |  Type   | Collation | Nullable | Default 
----------------+---------+-----------+----------+---------
 sale_id        | integer |           | not null | 
 product_id     | integer |           |          | 
 salesperson_id | integer |           |          | 
 category_id    | integer |           |          | 
 sales_amount   | numeric |           |          | 
 revenue        | numeric |           |          | 
Indexes:
    "sales_pkey" PRIMARY KEY, btree (sale_id)

 sale_id | product_id | salesperson_id | category_id | sales_amount | revenue 
---------+------------+----------------+-------------+--------------+---------
       1 |        101 |              1 |           1 |          500 |    1000
       2 |        102 |              1 |           2 |          300 |     600
       3 |        103 |              2 |           1 |          700 |    1400
       4 |        104 |              3 |           2 |          400 |     800
       5 |        105 |              2 |           3 |          900 |    1800
(5 rows)

Q1. select department_id , avg(salary) as average_salary from employees group by department_id;
 department_id |   average_salary   
---------------+--------------------
             3 | 70000.000000000000
             2 | 47500.000000000000
             1 | 42500.000000000000
(3 rows)

Q2. select category_id , sum(sales_amount) as total_sales from sales group by category_id;
 category_id | total_sales 
-------------+-------------
           3 |         900
           2 |         700
           1 |        1200
(3 rows)

CREATE TABLE
INSERT 0 5
 product_id | product_name | price 
------------+--------------+-------
        101 | Product A    |   150
        102 | Product B    |   120
        103 | Product C    |   200
        104 | Product D    |    80
        105 | Product E    |   250
(5 rows)

Q3. select max(price) as max_price , min(price) as min_price from products;
 max_price | min_price 
-----------+-----------
       250 |        80
(1 row)

CREATE TABLE
INSERT 0 5

Q4. select customer_id , count(order_id) as order_count from orders group by customer_id;
 customer_id | order_count 
-------------+-------------
           3 |           1
           2 |           2
           1 |           2
(3 rows)

Q5. select salesperson_id , sum(revenue) as total_revenue from sales group by salesperson_id;
salesperson_id | total_revenue 
----------------+---------------
              3 |           800
              2 |          3200
              1 |          1600
(3 rows)

