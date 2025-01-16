           List of relations
 Schema |   Name    | Type  |  Owner   
--------+-----------+-------+----------
 public | customers | table | postgres
 public | employees | table | postgres
 public | orders    | table | postgres
 public | products  | table | postgres
 public | sales     | table | postgres
(5 rows)

Q1. alter table products add constraint chk_price_positive check (price > 0);
ALTER TABLE
                      Table "public.products"
    Column    |       Type        | Collation | Nullable | Default 
--------------+-------------------+-----------+----------+---------
 product_id   | integer           |           | not null | 
 product_name | character varying |           |          | 
 price        | numeric           |           |          | 
Indexes:
    "products_pkey" PRIMARY KEY, btree (product_id)
Check constraints:
    "chk_price_positive" CHECK (price > 0::numeric)

Q2. alter table customers add constraint unique_email unique (email);
ALTER TABLE
                  Table "public.customers"
 Column |       Type        | Collation | Nullable | Default 
--------+-------------------+-----------+----------+---------
 id     | integer           |           | not null | 
 name   | character varying |           | not null | 
 email  | character varying |           | not null | 
Indexes:
    "customers_pkey" PRIMARY KEY, btree (id)
    "unique_email" UNIQUE CONSTRAINT, btree (email)
Referenced by:
    TABLE "orders" CONSTRAINT "fk_customers_orders" FOREIGN KEY (customer_id) REFERENCES customers(id)

 employee_id |   name    | department_id | salary | age 
-------------+-----------+---------------+--------+-----
           1 | Aalekh    |             1 |  60000 |    
           2 | Aryan     |             1 |  25000 |    
           3 | Aman      |             2 |  50000 |    
           4 | Deepanshu |             2 |  45000 |    
           5 | Dinesh    |             3 |  70000 |    
(5 rows)

UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
UPDATE 1
 employee_id |   name    | department_id | salary | age 
-------------+-----------+---------------+--------+-----
           1 | Aalekh    |             1 |  60000 |  25
           2 | Aryan     |             1 |  25000 |  35
           3 | Aman      |             2 |  50000 |  45
           4 | Deepanshu |             2 |  45000 |  20
           5 | Dinesh    |             3 |  70000 |  19
(5 rows)

Q3. alter table employees add constraint chk_age_range check(age between 18 and 65);
ALTER TABLE
                      Table "public.employees"
    Column     |       Type        | Collation | Nullable | Default 
---------------+-------------------+-----------+----------+---------
 employee_id   | integer           |           | not null | 
 name          | character varying |           |          | 
 department_id | integer           |           |          | 
 salary        | numeric           |           |          | 
 age           | integer           |           |          | 
Indexes:
    "employees_pkey" PRIMARY KEY, btree (employee_id)
Check constraints:
    "chk_age_range" CHECK (age >= 18 AND age <= 65)

                 Table "public.orders"
   Column    |  Type   | Collation | Nullable | Default 
-------------+---------+-----------+----------+---------
 order_id    | integer |           | not null | 
 customer_id | integer |           |          | 
 order_date  | date    |           |          | 
Indexes:
    "orders_pkey" PRIMARY KEY, btree (order_id)
Foreign-key constraints:
    "fk_customers_orders" FOREIGN KEY (customer_id) REFERENCES customers(id)

alter table orders drop constraint fk_customers_orders;
ALTER TABLE

Q4. alter table orders add constraint fk_customers_orders foreign key (customer_id) references customers(id) on delete restrict;
ALTER TABLE
