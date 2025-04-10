-- Problem 1 :- 

-- A bank needs to transfer $200 from Account A to Account B. Ensure the transfer only proceeds if Account A has sufficient funds (>= $200). 
-- If not, roll back the transaction and log the failure.

-- Query :-

DO $$
BEGIN
    BEGIN
        IF (SELECT balance FROM accounts WHERE account_id = 'A001') < 200 THEN
            INSERT INTO transfer_logs (account_from, account_to, amount, status)
            VALUES ('A001', 'A002', 200.00, 'FAILED - Low Balance');
            RAISE EXCEPTION 'Insufficient funds in account A001';
        END IF;
        UPDATE accounts
        SET balance = balance - 200
        WHERE account_id = 'A001';
        UPDATE accounts
        SET balance = balance + 200
        WHERE account_id = 'A002';
        INSERT INTO transfer_logs (account_from, account_to, amount, status)
        VALUES ('A001', 'A002', 200.00, 'SUCCESS');
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE NOTICE 'Transaction failed: %', SQLERRM;
    END;
END $$;
NOTICE:  Transaction failed: Insufficient funds in account A001


-- Result :- 

CREATE TABLE
 account_id | balance 
------------+---------
(0 rows)

CREATE TABLE
 log_id | account_from | account_to | amount | status | log_time 
--------+--------------+------------+--------+--------+----------
(0 rows)

INSERT 0 2
 account_id | balance 
------------+---------
 A001       |  150.00
 A002       |  500.00
(2 rows)



-- Problem 2 :- 

-- An online store processes an order for two products.
-- If the first product is in stock, reserve it, but if the second product is out of stock, roll back only the second reservation while keeping the first.

-- Query :- 

BEGIN;
UPDATE products
SET stock = stock - 1
WHERE product_id = 'P001' AND stock > 0;
SAVEPOINT after_first;
DO $$
BEGIN
    IF (SELECT stock FROM products WHERE product_id = 'P002') <= 0 THEN
        RAISE EXCEPTION 'Product P002 out of stock';
    END IF;
    UPDATE products
    SET stock = stock - 1
    WHERE product_id = 'P002' AND stock > 0;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Product P002 reservation failed';
    END IF;
END;
$$;
ERROR:  Product P002 out of stock
CONTEXT:  PL/pgSQL function inline_code_block line 4 at RAISE
COMMIT;
EXCEPTION
   WHEN OTHERS THEN
       ROLLBACK TO SAVEPOINT after_first;
ERROR:  syntax error at or near "EXCEPTION"
LINE 1: EXCEPTION
        ^
        RAISE NOTICE 'Second item failed: %', SQLERRM;
ERROR:  syntax error at or near "RAISE"
LINE 1: RAISE NOTICE 'Second item failed: %', SQLERRM;
        ^
        COMMIT;
WARNING:  there is no transaction in progress
END;
WARNING:  there is no transaction in progress


-- Result :-

CREATE TABLE
INSERT 0 2
BEGIN
UPDATE 1
SAVEPOINT
ROLLBACK
COMMIT
COMMIT



-- Problem 3 :- 

-- Calculate and apply a 10% bonus to all employees in the 'Sales' department.
-- Ensure no other transaction modifies salaries during the calculation and update process.


-- Query :- 

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
WARNING:  SET TRANSACTION can only be used in transaction blocks
BEGIN;
DO $$
DECLARE
    total_salary DECIMAL(10,2);
BEGIN
    SELECT SUM(salary) INTO total_salary
    FROM employees
    WHERE department = 'Sales';
    RAISE NOTICE 'Total Sales salary before: %', total_salary;
END $$;
NOTICE:  Total Sales salary before: 104500.00
UPDATE employees
SET salary = salary * 1.10
WHERE department = 'Sales';
COMMIT;


-- Result :-

CREATE TABLE
INSERT 0 3
SET
BEGIN
DO
UPDATE 2
COMMIT
 emp_id |  name   | department |  salary  
--------+---------+------------+----------
      2 | Bob     | HR         | 60000.00
      1 | Alice   | Sales      | 55000.00
      3 | Charlie | Sales      | 49500.00
(3 rows)

SET
BEGIN
DO
UPDATE 2
COMMIT
 emp_id |  name   | department |  salary  
--------+---------+------------+----------
      2 | Bob     | HR         | 60000.00
      1 | Alice   | Sales      | 60500.00
      3 | Charlie | Sales      | 54450.00
(3 rows)

-- Problem 4 :- 

-- Process a customer order: add the customer if new, then create their order.
-- If the order creation fails (e.g., invalid amount), keep the customer but don’t create the order.

-- Query :-

BEGIN;
INSERT INTO customers (name)
VALUES ('John Doe');
DO $$
DECLARE
    new_customer_id INT;
BEGIN
    new_customer_id := currval('customers_customer_id_seq');
    BEGIN
        IF 0 > 0 THEN
            INSERT INTO orders (customer_id, amount)
            VALUES (new_customer_id, -50.00);
        ELSE
            RAISE EXCEPTION 'Invalid order amount';
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Order failed: %', SQLERRM;
    END;
END $$;
NOTICE:  Order failed: Invalid order amount
COMMIT;

-- Result :-


CREATE TABLE
CREATE TABLE
 customer_id | name 
-------------+------
(0 rows)

 order_id | customer_id | amount 
----------+-------------+--------
(0 rows)

BEGIN
INSERT 0 1
DO
COMMIT
 customer_id |   name   
-------------+----------
           1 | John Doe
(1 row)

 order_id | customer_id | amount 
----------+-------------+--------
(0 rows)

-- Problem 5 :-

-- Two users try to book the last available seat on two flights (F001 and F002).
-- Ensure the transaction locks resources in a consistent order to prevent deadlocks.

-- Query :-

BEGIN;
UPDATE flights
SET seats_available = seats_available - 1
WHERE flight_id = 'F001' AND seats_available > 0;
DO $$
BEGIN
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No seats available on F001';
    END IF;
    UPDATE flights
    SET seats_available = seats_available - 1
    WHERE flight_id = 'F002' AND seats_available > 0;
    IF NOT FOUND THEN
        RAISE EXCEPTION 'No seats available on F002';
    END IF;
END $$;
ERROR:  No seats available on F001
CONTEXT:  PL/pgSQL function inline_code_block line 4 at RAISE
COMMIT;

-- Result :-

CREATE TABLE
INSERT 0 2

 flight_id | seats_available 
-----------+-----------------
 F001      |               1
 F002      |               1
(2 rows)

UPDATE 1
 flight_id | seats_available 
-----------+-----------------
 F001      |               1
 F002      |               0
(2 rows)

BEGIN
UPDATE 1
ROLLBACK
