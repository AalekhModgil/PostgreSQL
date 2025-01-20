    create table students(student_id int primary key , first_name varchar(50) , last_name varchar(50) , enrollment_date date , email varchar(100) unique);
    CREATE TABLE

    create table courses(course_id int primary key , course_name varchar(100) , credits int);
    CREATE TABLE

    create table enrollments(enrollment_id int primary key , student_id int , course_id int , grade decimal(3,2) , foreign key(student_id) references students(student_id) , foreign key(course_id) references courses(course_id));
    CREATE TABLE

    insert into students(student_id , first_name , last_name , enrollment_date , email)
    values
    (1,'Aalekh','Modgil','2025-01-01','aalekh8@gmail.com'),
    (2,'Aryan','Negi','2024-12-25','aryan11@gmail.com'),
    (3,'Aman','Sharma','2024-11-20','aman7@gmail.com');
    INSERT 0 3

    insert into courses(course_id , course_name , credits) values
    (100 , 'Physics' , 5),
    (101 , 'Chemistry' , 4),
    (102 , 'Maths' , 6);
    INSERT 0 3

    insert into enrollments(enrollment_id , student_id , course_id , grade) values
    (201 , 1 , 100 , 4.0),
    (200 , 2 ,101 , 3.2),
    (202 , 3 , 102 , 5.1);
    INSERT 0 3

    -- Stored Procedure :- 

    create procedure enrollstudent(enroll_id int, stud_id int, cour_id int, grad decimal(3,2))
    language plpgsql
    as $$
    begin
    if not exists (select 1 from enrollments where student_id = stud_id and course_id = cour_id) then
        insert into enrollments(enrollment_id, student_id, course_id, grade)
        values (enroll_id, stud_id, cour_id, grad);
    else
        if grad is not null then
        update enrollments
        set grade = grad
        where student_id = stud_id and course_id = cour_id;
        end if;
    end if;
    end $$;
    CREATE PROCEDURE
    call enrollstudent(209 , 2 , 102 , 3.2);
    CALL
    select * from enrollments;
    enrollment_id | student_id | course_id | grade
    ---------------+------------+-----------+-------
            201 |          1 |       100 |  4.00
            200 |          2 |       101 |  3.20
            202 |          3 |       102 |  5.10
            209 |          2 |       102 |  3.20
    (4 rows)

    -- Queries :- 

    select * from students where student_id = ( select student_id from enrollments group by student_id having count(course_id) >= 3);

    student_id | first_name | last_name | enrollment_date |       email
    ------------+------------+-----------+-----------------+-------------------
            1 | Aalekh     | Modgil    | 2025-01-01      | aalekh8@gmail.com
    (1 row)


    select * from students where student_id = ( select student_id from enrollments group by student_id having avg(grade)>=8);

    student_id | first_name | last_name | enrollment_date | email
    ------------+------------+-----------+-----------------+-------
    (0 rows)

    --  student_id |        avg
    -- ------------+--------------------
    --       3 | 5.1000000000000000
    --       2 | 3.2000000000000000
    --       1 | 3.5666666666666667
    -- (3 rows)



    -- Indexing :-

    create index index_student_course on enrollments(student_id , course_id);

    CREATE INDEX

    -- Indexing leads to the faster query execution and improves the response time.
    -- By adding the composite index it will reduce the resource consumption.



