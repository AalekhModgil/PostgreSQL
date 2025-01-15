 product_id |  product_name  
------------+----------------
          1 | Wireless Mouse
          2 | Keyboard
          3 | Laptop
          4 | Laptop Bag
          5 | Headphones
          6 | Monitor
          7 | USB Drive
(7 rows)

 order_id | order_date 
----------+------------
        1 | 2025-01-01
        2 | 2025-01-02
        3 | 2025-01-03
        4 | 2025-01-04
(4 rows)

 order_item_id | order_id | product_id 
---------------+----------+------------
             1 |        1 |          1
             2 |        1 |          2
             3 |        1 |          5
             4 |        2 |          3
             5 |        2 |          4
             6 |        2 |          6
             7 |        3 |          1
             8 |        3 |          2
             9 |        4 |          3
            10 |        4 |          4
            11 |        4 |          7
(11 rows)

Q6. SELECT 
    p1.product_name AS product1_name,
    p2.product_name AS product2_name,
    COUNT(*) AS frequency
FROM 
    order_itemsQ6 o1
INNER JOIN order_itemsQ6 o2
    ON o1.order_id = o2.order_id
   AND o1.product_id < o2.product_id
INNER JOIN productsQ6 p1
    ON o1.product_id = p1.product_id
INNER JOIN productsQ6 p2
    ON o2.product_id = p2.product_id
GROUP BY 
    p1.product_name, p2.product_name
ORDER BY 
    frequency DESC
LIMIT 10;

 product1_name  | product2_name | frequency 
----------------+---------------+-----------
 Laptop         | Laptop Bag    |         2
 Wireless Mouse | Keyboard      |         2
 Laptop         | Monitor       |         1
 Wireless Mouse | Headphones    |         1
 Laptop         | USB Drive     |         1
 Keyboard       | Headphones    |         1
 Laptop Bag     | USB Drive     |         1
 Laptop Bag     | Monitor       |         1
(8 rows)

