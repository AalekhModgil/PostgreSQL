Q1. CREATE PROCEDURE insert_order(customer_id INT, order_date DATE)
LANGUAGE plpgsql
AS $$
BEGIN
     INSERT INTO orders (customer_id, order_date)
     VALUES (customer_id, order_date);
END;
$$;
CREATE PROCEDURE

CALL insert_order(1, '2024-01-16');
CALL

Q2. CREATE PROCEDURE get_employees_by_department(dept_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    PERFORM * FROM employees WHERE department_id = dept_id;
END;
$$;
CREATE PROCEDURE

CALL get_employees_by_department(2);
CALL



Q3. CREATE FUNCTION get_customer_orders(customer_id INT)
RETURNS TABLE(order_id INT, order_date DATE)
AS $$
BEGIN
  RETURN QUERY
  SELECT orders.order_id, orders.order_date
  FROM orders
  WHERE orders.customer_id = get_customer_orders.customer_id;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION

SELECT * FROM get_customer_orders(1);
 order_id | order_date
----------+------------
        1 | 2024-01-01
        2 | 2024-01-15
        7 | 2024-01-16
(3 rows)

Q4. 

-- Benefits of Using Stored Procedures :-
-- 1. Precompiled, faster execution.
-- 2. Modular and reusable code.
-- 3. Enhanced security through controlled access.
-- 4. Reduced network traffic.

Q5.

-- Drawbacks of Using Stored Procedures :-
-- 1. Vendor-specific, less portable.
-- 2. Debugging can be challenging.
-- 3. Harder to maintain if overused.
-- 4. May consume server resources excessively.

Q6.

-- Debug a stored procedure :-
-- We can use raise statements.
-- We can test with sample data.
-- We can also check logs.
-- We can use explain and explain analyze to analyze SQL queries.

CREATE OR REPLACE FUNCTION debug_employees(dept_id INT)
RETURNS void AS $$
DECLARE
    emp_count INT;
BEGIN
    RAISE NOTICE 'Debug Start: Dept ID = %', dept_id;
    SELECT COUNT(*) INTO emp_count FROM employees WHERE department_id = dept_id;
    RAISE NOTICE 'Employee Count: %', emp_count;
END;
$$ LANGUAGE plpgsql;
CREATE FUNCTION

SELECT debug_employees(1);

NOTICE:  Debug Start: Dept ID = 1
NOTICE:  Employee Count: 2
 debug_employees
-----------------

(1 row)

Q7.

GRANT EXECUTE ON FUNCTION get_customer_orders(integer) TO aalekh;
GRANT

GRANT EXECUTE ON PROCEDURE insert_order TO player;
GRANT


Q8.

-- Stored procedure to improve application performance :- 
-- 1. Use for batch processing.
-- 2. Precompile logic for repeated use.
-- 3. Validate data within the procedure.

Q9.

-- Common Use Cases for Stored Procedures :- 

-- 1. Insert, update, or delete multiple rows at once.
-- 2. Format or calculate data for reports or exports.
-- 3. Automate routine jobs like data cleanup.
-- 4. Limit access by allowing users to execute procedures instead of directly accessing tables.
-- 5. Data Archiving.


Q10.

CREATE PROCEDURE update_employee_salary(employee_id INT, new_salary DECIMAL)
LANGUAGE plpgsql
AS $$
 BEGIN
   UPDATE employees SET salary = new_salary WHERE employee_id = employee_id;
   IF NOT FOUND THEN
     RAISE EXCEPTION 'Employee not found';
   END IF;
EXCEPTION
   WHEN OTHERS THEN
     RAISE NOTICE 'An error occurred: %', SQLERRM;
END;
$$;

CREATE PROCEDURE
