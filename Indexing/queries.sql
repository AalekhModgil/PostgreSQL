          List of relations
 Schema |   Name   | Type  |  Owner   
--------+----------+-------+----------
 public | orders   | table | postgres
 public | products | table | postgres
(2 rows)

 order_id | customer_name | order_date | amount 
----------+---------------+------------+--------
        1 | Ram           | 2024-01-01 | 150.00
        2 | Sham          | 2024-01-10 | 200.00
        3 | Ramesh        | 2024-01-15 | 250.00
        4 | Ram           | 2024-02-01 | 100.00
        5 | Ramesh        | 2024-02-05 | 300.00
(5 rows)

 product_id | product_name |               product_description               
------------+--------------+-------------------------------------------------
          1 | Laptop       | A high-performance laptop for gaming and work
          2 | Smartphone   | A smartphone with advanced camera features
          3 | Tablet       | A tablet for media consumption and productivity
(3 rows)

Q1.

create index index_customer_name on orders(customer_name);
CREATE INDEX

create index index_order_date on orders(order_date);
CREATE INDEX

select * from orders where customer_name = 'Ram' and order_date > '2024-01-01';

 order_id | customer_name | order_date | amount
----------+---------------+------------+--------
        4 | Ram           | 2024-02-01 | 100.00
(1 row)


Q2.

create index index_product_description_gin on products using gin(to_tsvector('english',product_description));
CREATE INDEX

select * from products where to_tsvector('english',product_description) @@ to_tsquery('english' , 'laptop & gaming');

 product_id | product_name |              product_description
------------+--------------+-----------------------------------------------
          1 | Laptop       | A high-performance laptop for gaming and work
(1 row)