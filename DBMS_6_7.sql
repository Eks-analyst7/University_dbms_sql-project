#Pract_6

USE university;
SHOW TABLES;


ALTER TABLE Professor_table
ADD doj DATE;

UPDATE Professor_table SET doj='2020-01-10' WHERE prof_num='PROF001';
UPDATE Professor_table SET doj='2019-03-15' WHERE prof_num='PROF002';
UPDATE Professor_table SET doj='2021-06-20' WHERE prof_num='PROF003';
UPDATE Professor_table SET doj='2018-08-25' WHERE prof_num='PROF004';
UPDATE Professor_table SET doj='2022-02-12' WHERE prof_num='PROF005';
UPDATE Professor_table SET doj='2020-11-05' WHERE prof_num='PROF006';
UPDATE Professor_table SET doj='2021-09-18' WHERE prof_num='PROF007';
UPDATE Professor_table SET doj='2019-07-30' WHERE prof_num='PROF008';
UPDATE Professor_table SET doj='2022-04-22' WHERE prof_num='PROF009';
UPDATE Professor_table SET doj='2023-01-01' WHERE prof_num='PROF010';

SELECT prof_num, prof_fname, doj
FROM Professor_table;

SELECT prof_num, prof_fname,
DATEDIFF(CURDATE(), doj)/365 AS experience_years
FROM Professor_table;

SELECT prof_num, prof_fname,
FLOOR(DATEDIFF(CURDATE(), doj)/365) AS experience_years
FROM Professor_table;

select prof_num, prof_fname, (datediff (current_date, doj)/365) as no_of_experience from professor;

SELECT prof_num, prof_fname,
DATEDIFF(CURDATE(), doj)/365 AS no_of_experience
FROM Professor_table;

SELECT prof_num, prof_fname,
FLOOR(DATEDIFF(CURDATE(), doj)/365) AS no_of_experience
FROM Professor_table;

SELECT CURTIME();

SELECT CONCAT(prof_initial, ' ', prof_fname, ' ', prof_lname) AS full_name
FROM Professor_table;

SELECT 
CONCAT(prof_initial, ' ', prof_fname, ' ', prof_lname) AS Name,
LENGTH(prof_fname) AS name_length
FROM Professor_table;

SELECT 
LEFT(prof_fname, 3) AS first_three,
RIGHT(prof_fname, 3) AS last_three
FROM Professor_table;

SELECT LOWER(prof_fname)
FROM Professor_table;

SELECT UPPER(prof_fname)
FROM Professor_table;

SELECT REPLACE(prof_initial, 'mr', 'Mr')
FROM Professor_table;

SELECT REVERSE(prof_fname)
FROM Professor_table;

SELECT SUBSTRING(prof_fname, 2, 5)
FROM Professor_table;

SELECT TRIM(prof_fname)
FROM Professor_table;

SELECT TRIM('   mySQL   ');

#Pract_7

SELECT p.dept_code, COUNT(s.stu_num) AS total_students
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
GROUP BY p.dept_code;

SELECT p.dept_code, COUNT(s.stu_num) AS total_students
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.dept_code IN (103,104,105)
GROUP BY p.dept_code
ORDER BY p.dept_code;

SELECT prof_num, COUNT(stu_num) AS total_students
FROM Student_table
GROUP BY prof_num
ORDER BY prof_num;

SELECT prof_num
FROM Student_table
GROUP BY prof_num
HAVING COUNT(stu_num) > 2;

SELECT *
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.dept_code > 103;

SELECT *
FROM Student_table
WHERE stu_num < (
    SELECT MAX(s.stu_num)
    FROM Student_table s
    JOIN Professor_table p ON s.prof_num = p.prof_num
    WHERE p.dept_code = 103
);

SELECT stu_fname
FROM Student_table s
WHERE EXISTS (
    SELECT 1
    FROM Professor_table p
    WHERE s.prof_num = p.prof_num
    AND p.salary > 25000
);

SELECT salary
FROM Professor_table
WHERE dept_code = 101;

SELECT *
FROM Professor_table
WHERE dept_code IN (101,103,106)
AND salary IS NOT 

SELECT*
FROM Professor_table
WHERE salary < ANY (
    SELECT salary
    FROM Professor_table
    WHERE dept_code IN (101,103,106)
);

SELECT *
FROM Professor_table
WHERE salary = (
    SELECT MAX(salary)
    FROM Professor_table
);

SELECT *
FROM Professor_table
WHERE salary > ALL (
    SELECT salary
    FROM Professor_table
    WHERE dept_code IN (101,103,106)
);

SELECT *
FROM Professor_table
WHERE salary > ANY (
    SELECT salary
    FROM Professor_table
    WHERE dept_code IN (101,103,106)
);

SELECT *
FROM Professor_table
WHERE dept_code NOT IN (103,104);

SELECT *
FROM Professor_table
WHERE dept_code BETWEEN 101 AND 104;

SELECT *
FROM Professor_table
WHERE dept_code NOT BETWEEN 101 AND 104;

SELECT *
FROM Professor_table
WHERE dept_code <> 104;

SELECT COUNT(*)
FROM Professor_table
WHERE salary > 50000;

SELECT *
FROM Professor_table
WHERE salary IS NULL;

SELECT *
FROM Professor_table
WHERE salary IS NOT NULL;

SELECT *
FROM Professor_table
WHERE salary IS NOT NULL
AND dept_code > 103;

SELECT prof_fname, prof_num
FROM Professor_table
WHERE prof_fname LIKE '%sh';

SELECT prof_fname, prof_num
FROM Professor_table
WHERE prof_fname LIKE '%sh'
AND dept_code <> 105;
