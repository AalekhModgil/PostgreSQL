\d students

                                          Table "public.students"
        Column        |         Type          | Collation | Nullable |               Default                
----------------------+-----------------------+-----------+----------+--------------------------------------
 id                   | integer               |           | not null | nextval('students_id_seq'::regclass)
 Gender               | character varying(10) |           |          | 
 Caste                | character varying(20) |           |          | 
 coaching             | character varying(10) |           |          | 
 Class_ten_education  | character varying(30) |           |          | 
 twelve_education     | character varying(30) |           |          | 
 medium               | character varying(20) |           |          | 
 Class_X_Percentage   | character varying(20) |           |          | 
 Class_XII_Percentage | character varying(20) |           |          | 
 Father_occupation    | character varying(30) |           |          | 
 Mother_occupation    | character varying(30) |           |          | 
 time                 | character varying(10) |           |          | 
 Performance          | character varying(20) |           |          | 
Indexes:
    "students_pkey" PRIMARY KEY, btree (id)

select * from students limit 10;


 id | Gender |  Caste  | coaching | Class_ten_education | twelve_education | medium  | Class_X_Percentage | Class_XII_Percentage | Father_occupation | Mother_occupation | time | Performance 
----+--------+---------+----------+---------------------+------------------+---------+--------------------+----------------------+-------------------+-------------------+------+-------------
  1 | male   | General | NO       | SEBA                | AHSEC            | ENGLISH | Excellent          | Excellent            | DOCTOR            | OTHERS            | ONE  | Excellent
  2 | male   | OBC     | WA       | SEBA                | AHSEC            | OTHERS  | Excellent          | Excellent            | SCHOOL_TEACHER    | HOUSE_WIFE        | TWO  | Excellent
  3 | male   | OBC     | OA       | OTHERS              | CBSE             | ENGLISH | Excellent          | Excellent            | BUSINESS          | HOUSE_WIFE        | TWO  | Excellent
  4 | male   | General | WA       | SEBA                | AHSEC            | OTHERS  | Excellent          | Excellent            | SCHOOL_TEACHER    | SCHOOL_TEACHER    | ONE  | Excellent
  5 | male   | General | OA       | SEBA                | CBSE             | ENGLISH | Excellent          | Excellent            | COLLEGE_TEACHER   | HOUSE_WIFE        | TWO  | Excellent
  6 | male   | General | WA       | CBSE                | CBSE             | ENGLISH | Excellent          | Excellent            | COLLEGE_TEACHER   | HOUSE_WIFE        | TWO  | Excellent
  7 | female | General | OA       | CBSE                | CBSE             | ENGLISH | Excellent          | Excellent            | DOCTOR            | DOCTOR            | ONE  | Excellent
  8 | male   | OBC     | NO       | SEBA                | AHSEC            | ENGLISH | Excellent          | Excellent            | OTHERS            | HOUSE_WIFE        | ONE  | Excellent
  9 | female | General | NO       | SEBA                | AHSEC            | ENGLISH | Excellent          | Excellent            | BUSINESS          | HOUSE_WIFE        | ONE  | Excellent
 10 | female | General | OA       | CBSE                | CBSE             | ENGLISH | Excellent          | Excellent            | COLLEGE_TEACHER   | HOUSE_WIFE        | TWO  | Excellent
(10 rows)

Problem 1 :-

-- The school administration wants to update the coaching status to 'YES' for all students from the 'General' caste who currently have 'NO' coaching
-- and ensure that the change is logged with a timestamp update in the time column to 'THREE'.
-- This should be done in a transaction to ensure consistency.

BEGIN;
-- Update coaching and time for General caste students with no coaching
UPDATE students
SET "coaching" = 'YES',
    "time" = 'THREE'
WHERE "Caste" = 'General'
AND "coaching" = 'NO';
-- Verify no errors occurred
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM students WHERE "Caste" = 'General' AND "coaching" = 'NO') THEN
        RAISE NOTICE 'Update successful: No General caste students with NO coaching remain.';
    ELSE
        RAISE EXCEPTION 'Update failed: Some General caste students still have NO coaching.';
    END IF;
END $$;
NOTICE:  Update successful: No General caste students with NO coaching remain.
COMMIT;


UPDATE 70
DO
COMMIT

SELECT "id", "Caste", "coaching", "time"
FROM students
WHERE "Caste" = 'General' and id = 1;

 id |  Caste  | coaching | time  
----+---------+----------+-------
  1 | General | YES      | THREE
(1 row)

SELECT "id", "Caste", "coaching", "time"
FROM students
WHERE "Caste" = 'General' and id = 9;

 id |  Caste  | coaching | time  
----+---------+----------+-------
  9 | General | YES      | THREE
(1 row)


Problem 2 :- 

-- The school administration wants to transfer students with Class_ten_education = 'SEBA' and twelve_education = 'AHSEC' to CBSE for both fields,
-- but only if they have 'Excellent' in both Class_X_Percentage and Class_XII_Percentage. This reflects a policy to reward high-performing students with a board change. The transaction should:

-- Check that only qualifying students are updated.
-- Log a notice of success.
-- Roll back if any non-qualifying students (e.g., with 'Vg', 'Good', or 'Average') are accidentally targeted, ensuring data integrity.

BEGIN;
-- Check that no non-qualifying students are targeted
DO $$
BEGIN
    IF EXISTS (
        SELECT 1
        FROM students
        WHERE "Class_ten_education" = 'SEBA'
        AND "twelve_education" = 'AHSEC'
        AND ("Class_X_Percentage" != 'Excellent' OR "Class_XII_Percentage" != 'Excellent')
        AND id IN (
            SELECT id
            FROM students
            WHERE "Class_ten_education" = 'SEBA'
            AND "twelve_education" = 'AHSEC'
            AND "Class_X_Percentage" = 'Excellent'
            AND "Class_XII_Percentage" = 'Excellent'
        )
    ) THEN
        RAISE EXCEPTION 'Error: Non-qualifying students detected in the target set.';
    END IF;
END $$;
-- Perform the update for qualifying students only
UPDATE students
SET "Class_ten_education" = 'CBSE',
    "twelve_education" = 'CBSE'
WHERE "Class_ten_education" = 'SEBA'
AND "twelve_education" = 'AHSEC'
AND "Class_X_Percentage" = 'Excellent'
AND "Class_XII_Percentage" = 'Excellent';
-- Log success
DO $$
BEGIN
    RAISE NOTICE 'High-performing students successfully transferred to CBSE.';
END $$;
NOTICE:  High-performing students successfully transferred to CBSE.
COMMIT;

DO
UPDATE 172
DO
COMMIT

SELECT id, "Class_ten_education", "twelve_education", "Class_X_Percentage", "Class_XII_Percentage"
FROM students
WHERE "Class_ten_education" = 'CBSE'
AND "twelve_education" = 'CBSE' AND id = 1;


 id | Class_ten_education | twelve_education | Class_X_Percentage | Class_XII_Percentage 
----+---------------------+------------------+--------------------+----------------------
  1 | CBSE                | CBSE             | Excellent          | Excellent
(1 row)

Problem 3 :-

-- The school wants to provide additional coaching (coaching = 'OA') to OBC students with Class_ten_education = 'SEBA' and twelve_education = 'AHSEC' 
-- whose Class_XII_Percentage is 'Good' or lower (e.g., 'Good', 'Average') to improve their performance. The transaction should:

-- Update the coaching column for qualifying students.
-- Ensure no students with 'Excellent' or 'Vg' percentages are affected.
-- Log the number of students updated for verification.


BEGIN;
-- Update coaching for underperforming OBC students
UPDATE students
SET "coaching" = 'OA'
WHERE "Caste" = 'OBC'
AND "Class_ten_education" = 'SEBA'
AND "twelve_education" = 'AHSEC'
AND "Class_XII_Percentage" IN ('Good', 'Average');
-- Verify only intended students were updated
DO $$
DECLARE
    updated_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO updated_count
    FROM students
    WHERE "Caste" = 'OBC'
    AND "Class_ten_education" = 'SEBA'
    AND "twelve_education" = 'AHSEC'
    AND "coaching" = 'OA'
    AND "Class_XII_Percentage" IN ('Good', 'Average');
    IF updated_count = 0 THEN
        RAISE EXCEPTION 'No qualifying OBC students were updated.';
    ELSE
        RAISE NOTICE 'Successfully assigned coaching to % underperforming OBC students.', updated_count;
    END IF;
END $$;
NOTICE:  Successfully assigned coaching to 13 underperforming OBC students.
COMMIT;


BEGIN
UPDATE 13
DO
COMMIT

SELECT id, "Caste", "Class_XII_Percentage", "coaching"
FROM students
WHERE "Caste" = 'OBC'
AND "coaching" = 'OA';

 id  | Caste | Class_XII_Percentage | coaching 
-----+-------+----------------------+----------
   3 | OBC   | Excellent            | OA
  66 | OBC   | Average              | OA
  73 | OBC   | Vg                   | OA
  71 | OBC   | Good                 | OA
 127 | OBC   | Excellent            | OA
 160 | OBC   | Excellent            | OA
 190 | OBC   | Vg                   | OA
 199 | OBC   | Excellent            | OA
 252 | OBC   | Excellent            | OA
 273 | OBC   | Excellent            | OA
 278 | OBC   | Good                 | OA
 338 | OBC   | Good                 | OA
 317 | OBC   | Average              | OA
 341 | OBC   | Vg                   | OA
 346 | OBC   | Vg                   | OA
 350 | OBC   | Excellent            | OA
 348 | OBC   | Average              | OA
 376 | OBC   | Good                 | OA
 378 | OBC   | Good                 | OA
 475 | OBC   | Good                 | OA
 479 | OBC   | Average              | OA
 449 | OBC   | Excellent            | OA
 490 | OBC   | Good                 | OA
 503 | OBC   | Good                 | OA
 509 | OBC   | Good                 | OA
 514 | OBC   | Good                 | OA
 521 | OBC   | Average              | OA
 510 | OBC   | Excellent            | OA
 379 | OBC   | Excellent            | OA
 386 | OBC   | Excellent            | OA
 495 | OBC   | Excellent            | OA
(31 rows)

Problem 4 :-

-- Female students with Class_X_Percentage = 'Excellent' but Class_XII_Percentage not 'Excellent' (e.g., 'Vg', 'Good', 'Average') 
-- need extra study time to maintain consistency. Update their time to 'THREE' if it’s currently 'ONE' or 'TWO'. The transaction should:

-- Target only qualifying female students.
-- Prevent updates to students with 'THREE' already.
-- Confirm the update count to ensure it worked.

SELECT id, "Gender", "Class_X_Percentage", "Class_XII_Percentage", "time"
FROM students
WHERE "Gender" = 'female'
AND "Class_X_Percentage" = 'Excellent'
AND "Class_XII_Percentage" != 'Excellent'
AND "time" IN ('ONE', 'TWO');


 id  | Gender | Class_X_Percentage | Class_XII_Percentage | time 
-----+--------+--------------------+----------------------+------
  29 | female | Excellent          | Vg                   | TWO
  81 | female | Excellent          | Vg                   | TWO
 167 | female | Excellent          | Good                 | TWO
 198 | female | Excellent          | Vg                   | TWO
 215 | female | Excellent          | Vg                   | TWO
 232 | female | Excellent          | Vg                   | TWO
 260 | female | Excellent          | Vg                   | TWO
 271 | female | Excellent          | Vg                   | TWO
 281 | female | Excellent          | Vg                   | TWO
 293 | female | Excellent          | Vg                   | TWO
 313 | female | Excellent          | Vg                   | TWO
 337 | female | Excellent          | Vg                   | TWO
 339 | female | Excellent          | Good                 | TWO
 363 | female | Excellent          | Vg                   | TWO
 373 | female | Excellent          | Vg                   | TWO
 397 | female | Excellent          | Good                 | ONE
 415 | female | Excellent          | Vg                   | TWO
 427 | female | Excellent          | Vg                   | TWO
 432 | female | Excellent          | Vg                   | TWO
 438 | female | Excellent          | Vg                   | TWO
 467 | female | Excellent          | Vg                   | ONE
 483 | female | Excellent          | Vg                   | TWO
 527 | female | Excellent          | Vg                   | TWO
 529 | female | Excellent          | Vg                   | TWO
 544 | female | Excellent          | Vg                   | TWO
 549 | female | Excellent          | Vg                   | TWO
 551 | female | Excellent          | Vg                   | TWO
 557 | female | Excellent          | Vg                   | TWO
 564 | female | Excellent          | Vg                   | TWO
 571 | female | Excellent          | Vg                   | ONE
 577 | female | Excellent          | Vg                   | TWO
 589 | female | Excellent          | Vg                   | TWO
 595 | female | Excellent          | Good                 | TWO
 601 | female | Excellent          | Vg                   | TWO
 605 | female | Excellent          | Vg                   | TWO
 606 | female | Excellent          | Vg                   | TWO
 607 | female | Excellent          | Good                 | TWO
 612 | female | Excellent          | Vg                   | TWO
 622 | female | Excellent          | Vg                   | TWO
 624 | female | Excellent          | Vg                   | TWO
 625 | female | Excellent          | Good                 | TWO
 637 | female | Excellent          | Vg                   | TWO
 658 | female | Excellent          | Good                 | TWO
 659 | female | Excellent          | Vg                   | TWO
(44 rows)

BEGIN;
-- Update time for qualifying female students
UPDATE students
SET "time" = 'THREE'
WHERE "Gender" = 'female'
AND "Class_X_Percentage" = 'Excellent'
AND "Class_XII_Percentage" != 'Excellent'
AND "time" IN ('ONE', 'TWO');
-- Verify the update
DO $$
DECLARE
    updated_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO updated_count
    FROM students
    WHERE "Gender" = 'female'
    AND "Class_X_Percentage" = 'Excellent'
    AND "Class_XII_Percentage" != 'Excellent'
    AND "time" = 'THREE';

    IF updated_count = 0 THEN
        RAISE NOTICE 'No qualifying female students found to update.';
    ELSE
        RAISE NOTICE 'Updated time to THREE for % female students with mixed performance.', updated_count;
    END IF;
END $$;
NOTICE:  Updated time to THREE for 58 female students with mixed performance.
COMMIT;


BEGIN
UPDATE 44
DO
COMMIT


SELECT id, "Gender", "Class_X_Percentage", "Class_XII_Percentage", "time"
FROM students
WHERE "Gender" = 'female'
AND "time" = 'THREE';


 id  | Gender | Class_X_Percentage | Class_XII_Percentage | time  
-----+--------+--------------------+----------------------+-------
  29 | female | Excellent          | Vg                   | THREE
 622 | female | Excellent          | Vg                   | THREE
 624 | female | Excellent          | Vg                   | THREE
 625 | female | Excellent          | Good                 | THREE
  53 | female | Vg                 | Vg                   | THREE
  81 | female | Excellent          | Vg                   | THREE
 117 | female | Vg                 | Vg                   | THREE
 131 | female | Excellent          | Vg                   | THREE
  77 | female | Excellent          | Excellent            | THREE
 167 | female | Excellent          | Good                 | THREE
 198 | female | Excellent          | Vg                   | THREE
 154 | female | Excellent          | Good                 | THREE
 189 | female | Vg                 | Vg                   | THREE
 190 | female | Good               | Vg                   | THREE
 215 | female | Excellent          | Vg                   | THREE
 232 | female | Excellent          | Vg                   | THREE
 231 | female | Excellent          | Excellent            | THREE
 260 | female | Excellent          | Vg                   | THREE
 271 | female | Excellent          | Vg                   | THREE
 244 | female | Excellent          | Excellent            | THREE
 259 | female | Excellent          | Excellent            | THREE
 205 | female | Excellent          | Excellent            | THREE
 301 | female | Excellent          | Vg                   | THREE
 281 | female | Excellent          | Vg                   | THREE
 293 | female | Excellent          | Vg                   | THREE
 316 | female | Excellent          | Vg                   | THREE
 313 | female | Excellent          | Vg                   | THREE
 337 | female | Excellent          | Vg                   | THREE
 339 | female | Excellent          | Good                 | THREE
 341 | female | Vg                 | Vg                   | THREE
 283 | female | Excellent          | Excellent            | THREE
 376 | female | Good               | Good                 | THREE
 363 | female | Excellent          | Vg                   | THREE
 373 | female | Excellent          | Vg                   | THREE
 397 | female | Excellent          | Good                 | THREE
 415 | female | Excellent          | Vg                   | THREE
 388 | female | Excellent          | Vg                   | THREE
 358 | female | Excellent          | Excellent            | THREE
 427 | female | Excellent          | Vg                   | THREE
 432 | female | Excellent          | Vg                   | THREE
 438 | female | Excellent          | Vg                   | THREE
 467 | female | Excellent          | Vg                   | THREE
 483 | female | Excellent          | Vg                   | THREE
 487 | female | Excellent          | Vg                   | THREE
 489 | female | Excellent          | Vg                   | THREE
 527 | female | Excellent          | Vg                   | THREE
 529 | female | Excellent          | Vg                   | THREE
 544 | female | Excellent          | Vg                   | THREE
 549 | female | Excellent          | Vg                   | THREE
 506 | female | Excellent          | Vg                   | THREE
 551 | female | Excellent          | Vg                   | THREE
 557 | female | Excellent          | Vg                   | THREE
 525 | female | Excellent          | Excellent            | THREE
 530 | female | Vg                 | Vg                   | THREE
 537 | female | Good               | Good                 | THREE
 539 | female | Vg                 | Vg                   | THREE
 555 | female | Good               | Good                 | THREE
 564 | female | Excellent          | Vg                   | THREE
 571 | female | Excellent          | Vg                   | THREE
 577 | female | Excellent          | Vg                   | THREE
 589 | female | Excellent          | Vg                   | THREE
 581 | female | Excellent          | Good                 | THREE
 595 | female | Excellent          | Good                 | THREE
 601 | female | Excellent          | Vg                   | THREE
 605 | female | Excellent          | Vg                   | THREE
 606 | female | Excellent          | Vg                   | THREE
 598 | female | Vg                 | Average              | THREE
 602 | female | Excellent          | Vg                   | THREE
 607 | female | Excellent          | Good                 | THREE
 612 | female | Excellent          | Vg                   | THREE
 637 | female | Excellent          | Vg                   | THREE
 658 | female | Excellent          | Good                 | THREE
 650 | female | Good               | Good                 | THREE
 652 | female | Good               | Good                 | THREE
 654 | female | Average            | Average              | THREE
 659 | female | Excellent          | Vg                   | THREE
  30 | female | Good               | Vg                   | THREE
  31 | female | Excellent          | Excellent            | THREE
  47 | female | Excellent          | Excellent            | THREE
 135 | female | Excellent          | Excellent            | THREE
 153 | female | Excellent          | Excellent            | THREE
 171 | female | Excellent          | Vg                   | THREE
 245 | female | Vg                 | Excellent            | THREE
 305 | female | Excellent          | Excellent            | THREE
 364 | female | Excellent          | Excellent            | THREE
 393 | female | Excellent          | Vg                   | THREE
 431 | female | Excellent          | Excellent            | THREE
 437 | female | Excellent          | Vg                   | THREE
 445 | female | Excellent          | Good                 | THREE
 248 | female | Excellent          | Excellent            | THREE
 395 | female | Excellent          | Excellent            | THREE
 534 | female | Excellent          | Excellent            | THREE
   9 | female | Excellent          | Excellent            | THREE
  33 | female | Excellent          | Excellent            | THREE
 123 | female | Excellent          | Excellent            | THREE
 133 | female | Excellent          | Excellent            | THREE
 158 | female | Excellent          | Excellent            | THREE
 203 | female | Excellent          | Excellent            | THREE
 255 | female | Excellent          | Excellent            | THREE
 257 | female | Excellent          | Excellent            | THREE
 342 | female | Excellent          | Excellent            | THREE
 343 | female | Excellent          | Excellent            | THREE
 362 | female | Excellent          | Excellent            | THREE
 383 | female | Excellent          | Excellent            | THREE
 411 | female | Excellent          | Excellent            | THREE
 440 | female | Excellent          | Excellent            | THREE
(106 rows)



Problem 5 :-

-- General caste students whose Father_occupation = 'BUSINESS' and whose Class_XII_Percentage is 'Vg' or lower (e.g., 'Vg', 'Good', 'Average')
-- should switch their medium to 'OTHERS' to align with a new curriculum. The transaction should:

-- Update only qualifying students.
-- Ensure no 'Excellent' students are affected.
-- Log the success with a count of updates.


SELECT id, "Caste", "Father_occupation", "Class_XII_Percentage", "medium"
FROM students
WHERE "Caste" = 'General'
AND "Father_occupation" = 'BUSINESS'
AND "Class_XII_Percentage" IN ('Vg', 'Good', 'Average');

 id  |  Caste  | Father_occupation | Class_XII_Percentage | medium  
-----+---------+-------------------+----------------------+---------
 107 | General | BUSINESS          | Vg                   | ENGLISH
 132 | General | BUSINESS          | Vg                   | OTHERS
 198 | General | BUSINESS          | Vg                   | ENGLISH
 141 | General | BUSINESS          | Vg                   | ENGLISH
 166 | General | BUSINESS          | Vg                   | ENGLISH
 260 | General | BUSINESS          | Vg                   | ENGLISH
 262 | General | BUSINESS          | Good                 | ENGLISH
 274 | General | BUSINESS          | Vg                   | ENGLISH
 289 | General | BUSINESS          | Vg                   | ENGLISH
 316 | General | BUSINESS          | Vg                   | ENGLISH
 323 | General | BUSINESS          | Vg                   | ENGLISH
 328 | General | BUSINESS          | Vg                   | ENGLISH
 397 | General | BUSINESS          | Good                 | ENGLISH
 405 | General | BUSINESS          | Vg                   | ENGLISH
 418 | General | BUSINESS          | Vg                   | ENGLISH
 422 | General | BUSINESS          | Vg                   | OTHERS
 433 | General | BUSINESS          | Vg                   | ENGLISH
 437 | General | BUSINESS          | Vg                   | ENGLISH
 445 | General | BUSINESS          | Good                 | ENGLISH
(19 rows)

BEGIN;
-- Update medium for qualifying General caste students
UPDATE students
SET "medium" = 'OTHERS'
WHERE "Caste" = 'General'
AND "Father_occupation" = 'BUSINESS'
AND "Class_XII_Percentage" IN ('Vg', 'Good', 'Average');
-- Verify the update
DO $$
DECLARE
    updated_count INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO updated_count
    FROM students
    WHERE "Caste" = 'General'
    AND "Father_occupation" = 'BUSINESS'
    AND "medium" = 'OTHERS'
    AND "Class_XII_Percentage" IN ('Vg', 'Good', 'Average');
    IF updated_count = 0 THEN
        RAISE NOTICE 'No qualifying General caste students with BUSINESS fathers found.';
    ELSE
        RAISE NOTICE 'Updated medium to OTHERS for % General caste students with BUSINESS fathers.', updated_count;
    END IF;
END $$;
NOTICE:  Updated medium to OTHERS for 19 General caste students with BUSINESS fathers.
COMMIT;

BEGIN
UPDATE 19
DO
COMMIT

SELECT id, "Caste", "Father_occupation", "Class_XII_Percentage", "medium"
FROM students
WHERE "Caste" = 'General'
AND "Father_occupation" = 'BUSINESS'
AND "medium" = 'OTHERS';

 id  |  Caste  | Father_occupation | Class_XII_Percentage | medium 
-----+---------+-------------------+----------------------+--------
 107 | General | BUSINESS          | Vg                   | OTHERS
 132 | General | BUSINESS          | Vg                   | OTHERS
 109 | General | BUSINESS          | Excellent            | OTHERS
 198 | General | BUSINESS          | Vg                   | OTHERS
 141 | General | BUSINESS          | Vg                   | OTHERS
 166 | General | BUSINESS          | Vg                   | OTHERS
 260 | General | BUSINESS          | Vg                   | OTHERS
 262 | General | BUSINESS          | Good                 | OTHERS
 274 | General | BUSINESS          | Vg                   | OTHERS
 289 | General | BUSINESS          | Vg                   | OTHERS
 316 | General | BUSINESS          | Vg                   | OTHERS
 323 | General | BUSINESS          | Vg                   | OTHERS
 328 | General | BUSINESS          | Vg                   | OTHERS
 397 | General | BUSINESS          | Good                 | OTHERS
 405 | General | BUSINESS          | Vg                   | OTHERS
 418 | General | BUSINESS          | Vg                   | OTHERS
 422 | General | BUSINESS          | Vg                   | OTHERS
 433 | General | BUSINESS          | Vg                   | OTHERS
 437 | General | BUSINESS          | Vg                   | OTHERS
 445 | General | BUSINESS          | Good                 | OTHERS
(20 rows)

