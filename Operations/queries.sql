Q1.

select order_id , sum(product_price*quantity) from order_items group by order_id;

 order_id |   sum
----------+----------
      101 | 76000.00
      103 | 16000.00
      102 |  1500.00
(3 rows)


Q2.

select distinct c.name from customers c inner join orders o on c.customer_id = o.customer_id where current_date-order_date <= 30 and order_date <= current_date;

     name
---------------
 Charlie Davis
 Alice Johnson
 Bob Brown
 John Doe
 Jane Smith
(5 rows)