                                                               List of databases
      Name       |  Owner   | Encoding | Locale Provider |      Collate       |       Ctype        | Locale | ICU Rules |   Access privileges   
-----------------+----------+----------+-----------------+--------------------+--------------------+--------+-----------+-----------------------
 company         | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =Tc/postgres         +
                 |          |          |                 |                    |                    |        |           | postgres=CTc/postgres+
                 |          |          |                 |                    |                    |        |           | aalekh=c/postgres
 employee_sales  | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 inventory       | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 join_database   | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 postgres        | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 review_database | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 school          | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 shop_database   | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | 
 template0       | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =c/postgres          +
                 |          |          |                 |                    |                    |        |           | postgres=CTc/postgres
 template1       | postgres | UTF8     | libc            | English_India.1252 | English_India.1252 |        |           | =c/postgres          +
                 |          |          |                 |                    |                    |        |           | postgres=CTc/postgres
(10 rows)

          List of relations
 Schema |  Name   | Type  |  Owner   
--------+---------+-------+----------
 public | books   | table | postgres
 public | members | table | postgres
(2 rows)

 book_id | title  |  author  | publication_year |  genre  
---------+--------+----------+------------------+---------
       1 | Book 1 | Author 1 | 2023-01-01       | Genre 1
       2 | Book 2 | Author 2 | 2022-02-02       | Genre 2
       3 | Book 3 | Author 3 | 2020-03-03       | Genre 3
(3 rows)

 member_id | name | address | contact_number 
-----------+------+---------+----------------
(0 rows)

INSERT 0 5
 member_id |   name   |  address  | contact_number 
-----------+----------+-----------+----------------
         1 | Member 1 | Address 1 |      987654321
         2 | Member 2 | Address 2 |      287654321
         3 | Member 3 | Address 3 |      387654321
         4 | Member 4 | Address 4 |      787654321
         5 | Member 5 | Address 5 |      887654321
(5 rows)

CREATE TABLE
INSERT 0 5
 borrowing_id | book_id | member_id | borrow_date |  due_date  | returned_date 
--------------+---------+-----------+-------------+------------+---------------
            1 |       1 |         1 | 2024-01-01  | 2024-01-10 | 2024-01-05
            2 |       2 |         2 | 2025-01-10  | 2025-01-20 | 2025-01-15
            3 |       1 |         3 | 2024-01-20  | 2025-01-30 | 2025-01-25
            4 |       2 |         4 | 2022-02-01  | 2022-02-10 | 2022-02-05
            5 |       3 |         5 | 2022-10-01  | 2022-10-30 | 2022-10-15
(5 rows)

INSERT 0 2
 book_id | title  |  author  | publication_year |  genre  
---------+--------+----------+------------------+---------
       1 | Book 1 | Author 1 | 2023-01-01       | Genre 1
       2 | Book 2 | Author 2 | 2022-02-02       | Genre 2
       3 | Book 3 | Author 3 | 2020-03-03       | Genre 3
       4 | Book 4 | Author 4 | 2020-01-01       | Genre 4
       5 | Book 5 | Author 5 | 2021-02-02       | Genre 5
(5 rows)

Q1. select title from books where author = 'Author 1';
INSERT 0 1
 title  
--------
 Book 1
 Book 6
(2 rows)

Q2.  select distinct m.member_id from members m inner join borrower b on m.member_id = b.member_id where b.book_id = 1;
 member_id 
-----------
         1
         3
(2 rows)

 title 
-------
(0 rows)

INSERT 0 1
 borrowing_id | book_id | member_id | borrow_date |  due_date  | returned_date 
--------------+---------+-----------+-------------+------------+---------------
            1 |       1 |         1 | 2024-01-01  | 2024-01-10 | 2024-01-05
            2 |       2 |         2 | 2025-01-10  | 2025-01-20 | 2025-01-15
            3 |       1 |         3 | 2024-01-20  | 2025-01-30 | 2025-01-25
            4 |       2 |         4 | 2022-02-01  | 2022-02-10 | 2022-02-05
            5 |       3 |         5 | 2022-10-01  | 2022-10-30 | 2022-10-15
            6 |       1 |         1 | 2024-01-01  | 2024-01-10 | 2024-01-12
(6 rows)

Q3.  select bk.title from books bk inner join borrower br on bk.book_id = br.book_id where returned_date > due_date;

 title  
--------
 Book 1
(1 row)



Q4. select member_id,  count(borrowing_id) as no_of_books from borrower group by member_id;

 member_id | no_of_books 
-----------+-------------
         3 |           1
         5 |           1
         4 |           1
         2 |           1
         1 |           2
(5 rows)

   name   | no_of_books 
----------+-------------
 Member 5 |           1
 Member 4 |           1
 Member 1 |           2
 Member 3 |           1
 Member 2 |           1
(5 rows)



BEGIN
 book_id | title  |  author  | publication_year |  genre  
---------+--------+----------+------------------+---------
       1 | Book 1 | Author 1 | 2023-01-01       | Genre 1
       2 | Book 2 | Author 2 | 2022-02-02       | Genre 2
       3 | Book 3 | Author 3 | 2020-03-03       | Genre 3
       4 | Book 4 | Author 4 | 2020-01-01       | Genre 4
       5 | Book 5 | Author 5 | 2021-02-02       | Genre 5
       6 | Book 6 | Author 1 | 2020-01-01       | Genre 6
(6 rows)

ERROR:  syntax error at or near "'Book 7'"
LINE 1: insert into books(a ,'Book 7' , 'Author 7' , '2025-10-01' , ...

ROLLBACK
 book_id | title  |  author  | publication_year |  genre  
---------+--------+----------+------------------+---------
       1 | Book 1 | Author 1 | 2023-01-01       | Genre 1
       2 | Book 2 | Author 2 | 2022-02-02       | Genre 2
       3 | Book 3 | Author 3 | 2020-03-03       | Genre 3
       4 | Book 4 | Author 4 | 2020-01-01       | Genre 4
       5 | Book 5 | Author 5 | 2021-02-02       | Genre 5
       6 | Book 6 | Author 1 | 2020-01-01       | Genre 6
(6 rows)

BEGIN
 book_id | title  |  author  | publication_year |  genre  
---------+--------+----------+------------------+---------
       1 | Book 1 | Author 1 | 2023-01-01       | Genre 1
       2 | Book 2 | Author 2 | 2022-02-02       | Genre 2
       3 | Book 3 | Author 3 | 2020-03-03       | Genre 3
       4 | Book 4 | Author 4 | 2020-01-01       | Genre 4
       5 | Book 5 | Author 5 | 2021-02-02       | Genre 5
       6 | Book 6 | Author 1 | 2020-01-01       | Genre 6
(6 rows)

INSERT 0 1
COMMIT

 book_id | title  |  author  | publication_year |  genre  
---------+--------+----------+------------------+---------
       1 | Book 1 | Author 1 | 2023-01-01       | Genre 1
       2 | Book 2 | Author 2 | 2022-02-02       | Genre 2
       3 | Book 3 | Author 3 | 2020-03-03       | Genre 3
       4 | Book 4 | Author 4 | 2020-01-01       | Genre 4
       5 | Book 5 | Author 5 | 2021-02-02       | Genre 5
       6 | Book 6 | Author 1 | 2020-01-01       | Genre 6
       7 | Book 7 | Author 7 | 2025-10-01       | Genre 7
(7 rows)

 member_id |   name   |  address  | contact_number 
-----------+----------+-----------+----------------
         1 | Member 1 | Address 1 |      987654321
         2 | Member 2 | Address 2 |      287654321
         3 | Member 3 | Address 3 |      387654321
         4 | Member 4 | Address 4 |      787654321
         5 | Member 5 | Address 5 |      887654321
(5 rows)

 borrowing_id | book_id | member_id | borrow_date |  due_date  | returned_date 
--------------+---------+-----------+-------------+------------+---------------
            1 |       1 |         1 | 2024-01-01  | 2024-01-10 | 2024-01-05
            2 |       2 |         2 | 2025-01-10  | 2025-01-20 | 2025-01-15
            3 |       1 |         3 | 2024-01-20  | 2025-01-30 | 2025-01-25
            4 |       2 |         4 | 2022-02-01  | 2022-02-10 | 2022-02-05
            5 |       3 |         5 | 2022-10-01  | 2022-10-30 | 2022-10-15
            6 |       1 |         1 | 2024-01-01  | 2024-01-10 | 2024-01-12
(6 rows)

