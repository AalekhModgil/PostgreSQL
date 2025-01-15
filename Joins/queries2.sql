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

 customer_id | customer_name 
-------------+---------------
           1 | Aalekh
           2 | Aryan
           3 | Aman
(3 rows)

 account_id | customer_id | account_balance 
------------+-------------+-----------------
          1 |           1 |            5000
          2 |           2 |            3000
          3 |           3 |            8000
(3 rows)

 transaction_id | account_id |  transaction_date   | transaction_amount 
----------------+------------+---------------------+--------------------
              1 |          1 | 2025-01-01 12:00:00 |               2000
              2 |          1 | 2025-01-05 15:00:00 |               1500
              3 |          2 | 2025-01-02 09:00:00 |              10000
              4 |          3 | 2025-01-03 10:00:00 |               2500
              5 |          2 | 2025-01-04 14:00:00 |                200
(5 rows)

Q7.  select c.customer_name , t.transaction_id , t.transaction_date , t.transaction_amount from customers c inner join accounts a on c.customer_id = a.customer_id 
     inner join transactions t on a.account_id = t.account_id where t.transaction_amount > 2000 order by t.transaction_amount desc;

 customer_name | transaction_id |  transaction_date   | transaction_amount 
---------------+----------------+---------------------+--------------------
 Aryan         |              3 | 2025-01-02 09:00:00 |              10000
 Aman          |              4 | 2025-01-03 10:00:00 |               2500
(2 rows)

 patient_id | first_name | last_name | date_of_birth 
------------+------------+-----------+---------------
          1 | Raj        | Verma     | 1985-05-15
          2 | Suraj      | Singh     | 1990-08-22
          3 | Rakesh     | Sharma    | 1975-02-18
          4 | Ketan      | Kumar     | 2000-12-03
(4 rows)

 appointment_id | patient_id | appointment_date 
----------------+------------+------------------
              1 |          1 | 2024-01-10
              2 |          1 | 2024-06-15
              3 |          2 | 2023-07-01
              4 |          3 | 2023-05-20
(4 rows)

Q8.  select p.patient_id , p.first_name, p.last_name from patients p left join appointments a on p.patient_id = a.patient_id and a.appointment_date >= current_date - interval '1 year' where a.appointment_id is null;

 patient_id | first_name | last_name 
------------+------------+-----------
          2 | Suraj      | Singh
          4 | Ketan      | Kumar
          3 | Rakesh     | Sharma
(3 rows)

 student_id | student_name 
------------+--------------
          1 | Aalekh
          2 | Aryan
          3 | Aman
          4 | Chetan
(4 rows)

 course_id | course_name 
-----------+-------------
         1 | Mathematics
         2 | Science
         3 | History
(3 rows)

 grade_id | student_id | course_id | grade 
----------+------------+-----------+-------
        1 |          1 |         1 |    85
        2 |          2 |         1 |    45
        3 |          3 |         2 |    90
        4 |          4 |         3 |    50
        5 |          1 |         2 |    30
        6 |          2 |         3 |    70
        7 |          3 |         1 |    20
        8 |          4 |         2 |    60
(8 rows)

Q9. SELECT s.student_name, c.course_name, g.grade FROM students s INNER JOIN grades g ON s.student_id = g.student_id INNER JOIN courses c ON g.course_id = c.course_id WHERE c.course_name = 'Mathematics' AND g.grade < 50;

 student_name | course_name | grade 
--------------+-------------+-------
 Aryan        | Mathematics |    45
 Aman         | Mathematics |    20
(2 rows)

 supplier_id | supplier_name 
-------------+---------------
           1 | Supplier A
           2 | Supplier B
           3 | Supplier C
           4 | Supplier D
(4 rows)

 product_id | product_name | supplier_id 
------------+--------------+-------------
          1 | Product 1    |           1
          2 | Product 2    |           2
          3 | Product 3    |           3
          4 | Product 4    |           4
(4 rows)

 order_id | product_id | order_date 
----------+------------+------------
        1 |          1 | 2024-09-15
        2 |          2 | 2024-10-01
        3 |          3 | 2024-11-20
(3 rows)

Q10. SELECT s.supplier_id, s.supplier_name FROM suppliers s LEFT JOIN productsQ10 p ON s.supplier_id = p.supplier_id 
LEFT JOIN ordersQ10 o ON p.product_id = o.product_id WHERE o.order_id IS NULL OR o.order_date NOT BETWEEN '2024-10-01' AND '2024-12-31';

 supplier_id | supplier_name 
-------------+---------------
           1 | Supplier A
           4 | Supplier D
(2 rows)

