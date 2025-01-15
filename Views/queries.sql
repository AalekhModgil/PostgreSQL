Q1 

create view employee_salaries as select emp_name, dept_id, salary from employees where salary > 50000;
CREATE VIEW
                            View "public.employee_salaries"
  Column  |       Type        | Collation | Nullable | Default | Storage  | Description
----------+-------------------+-----------+----------+---------+----------+-------------
 emp_name | character varying |           |          |         | extended |
 dept_id  | integer           |           |          |         | plain    |
 salary   | integer           |           |          |         | plain    |
View definition:
 SELECT emp_name,
    dept_id,
    salary
   FROM employees
  WHERE salary > 50000;

Q2 

-- Simplifies complex queries by encapsulating them into a reusable object.
-- Enhances data security by restricting direct access to underlying tables.
-- Provides abstraction, shielding users from schema changes

Q3

update employee_salaries set salary = salary + 5000 where emp_id = 101;
UPDATE 0

Q4 

-- Views cannot always be updated, especially if they include joins, aggregations, or complex logic.
-- Performance may be slower for views with complex queries as they execute each time they're queried.
-- Changes in underlying tables may require updating dependent views

Q5 

-- Restrict access to sensitive columns by exposing only necessary data through the view.
-- Use views to enforce row-level security by filtering data based on user roles or conditions.

Q6 

Store a frequently-used complex query in a view and reference it as a table in simpler queries.
create view high_earning_employees as
select emp_name, salary
from employees
where salary > (select avg(salary) from employees);

Q7 

drop view employee_salaries;
DROP VIEW

Q8 

create view top_earners as select * from employee_salaries where salary > 100000;
CREATE VIEW
                               View "public.top_earners"
  Column  |       Type        | Collation | Nullable | Default | Storage  | Description
----------+-------------------+-----------+----------+---------+----------+-------------
 emp_name | character varying |           |          |         | extended |
 dept_id  | integer           |           |          |         | plain    |
 salary   | integer           |           |          |         | plain    |
View definition:
 SELECT emp_name,
    dept_id,
    salary
   FROM employee_salaries
  WHERE salary > 100000;

Q9 

-- Simplifying reporting by encapsulating complex SQL logic.
-- Providing row or column-level access control for security.
-- Creating a stable interface for applications when the database schema evolves.
-- Aggregating data for dashboards or analytics.

Q10 

-- Data virtualization allows users to access and manipulate data from multiple sources as if it resides in a single database, without physically moving or copying it. 
-- Views in PostgreSQL can be used as a lightweight way to achieve data virtualization by abstracting the complexity of underlying data sources.

create view unified_employee_data as select e.emp_name, e.emp_id, d.dept_name from employees e join departments d on e.dept_id = d.dept_id;
CREATE VIEW
                           View "public.unified_employee_data"
  Column   |       Type        | Collation | Nullable | Default | Storage  | Description
-----------+-------------------+-----------+----------+---------+----------+-------------
 emp_name  | character varying |           |          |         | extended |
 emp_id    | integer           |           |          |         | plain    |
 dept_name | character varying |           |          |         | extended |
View definition:
 SELECT e.emp_name,
    e.emp_id,
    d.dept_name
   FROM employees e
     JOIN departments d ON e.dept_id = d.dept_id;