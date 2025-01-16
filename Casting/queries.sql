select * from persons;

  name  | gender |    dob
--------+--------+------------
 Aalekh | M      | 2003-08-23
 Aryan  | F      | 2003-08-28
 Aman   | M      | 2003-12-28
 Ram    | M      | 2002-06-20
 Priya  | F      | 2000-02-21
 Karan  | M      | 2001-09-15
(6 rows)

Q1.

select (current_date-(dob::date))/365 as age from persons;

 age
-----
  21
  21
  21
  22
  24
  23
(6 rows)


Q2.

select bool_value::boolean,
case
when bool_value = 'Y' then 'true'
else 'false'
end
from boolYN;

 bool_value | case
------------+-------
 t          | true
 t          | true
 f          | false
 t          | true
 f          | false
 t          | true
 f          | false
 t          | true
(8 rows)

