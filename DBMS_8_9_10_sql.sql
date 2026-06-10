DROP DATABASE IF EXISTS Uni;
CREATE DATABASE Uni;
USE Uni;

CREATE TABLE dept (
    dept_code INT PRIMARY KEY,
    dept_name VARCHAR(50),
    prof_num VARCHAR(10)
);

CREATE TABLE professor (
    prof_num VARCHAR(10) PRIMARY KEY,
    dept_code INT,
    prof_fname VARCHAR(50) NOT NULL,
    prof_email VARCHAR(100),
    salary INT,
    
    FOREIGN KEY (dept_code) REFERENCES dept(dept_code)
);

CREATE TABLE student (
    stu_num INT PRIMARY KEY,
    dept_code INT,
    stu_fname VARCHAR(50) NOT NULL,
    stu_email VARCHAR(100),
    prof_num VARCHAR(10),
    
    FOREIGN KEY (dept_code) REFERENCES dept(dept_code),
    FOREIGN KEY (prof_num) REFERENCES professor(prof_num)
);

INSERT INTO dept VALUES
(1, 'IT', NULL),
(2, 'CS', NULL),
(3, 'EXTC', NULL),
(4, 'MECH', NULL),
(5, 'CIVIL', NULL);

INSERT INTO professor VALUES
('P1', 1, 'Sneha', 's@gmail.com', 30000),
('P2', 2, 'Shraddha', 'sh@gmail.com', 40000),
('P3', 3, 'Amit', 'a@gmail.com', 35000),
('P4', 2, 'Neha', 'n@gmail.com', 45000),
('P5', 5, 'Raj', 'r@gmail.com', 38000);

UPDATE dept SET prof_num = 'P1' WHERE dept_code = 1;
UPDATE dept SET prof_num = 'P2' WHERE dept_code = 2;
UPDATE dept SET prof_num = 'P3' WHERE dept_code = 3;

INSERT INTO student VALUES
(1, 1, 'Ekta', 'e@gmail.com', 'P1'),
(2, 2, 'Riya', 'r@gmail.com', 'P2'),
(3, 3, 'Kiran', 'k@gmail.com', 'P3'),
(4, 2, 'Asha', 'a@gmail.com', 'P4'),
(5, 5, 'Rahul', 'rah@gmail.com', 'P5'),
(6, 1, 'Simran', 's@gmail.com', 'P1');

SELECT * FROM dept;
SELECT * FROM professor;

INSERT INTO dept VALUES (6, 'AI', NULL);

INSERT INTO professor (prof_num, dept_code, prof_fname, prof_email, salary)
VALUES ('P100', NULL, 'Riya', 'r@gmail.com', 25000);

SELECT *
FROM Dept_table d
JOIN Professor_table p
ON d.dept_code = p.dept_code;

SELECT d.dept_code, d.dept_name, p.prof_fname
FROM dept d
INNER JOIN professor p
ON d.dept_code = p.dept_code;

SELECT d.dept_code, d.dept_name, p.prof_fname
FROM dept d
RIGHT JOIN professor p
ON d.dept_code = p.dept_code;

SELECT d.dept_code, d.dept_name, p.prof_fname
FROM dept d
LEFT JOIN professor p
ON d.dept_code = p.dept_code

UNION

SELECT d.dept_code, d.dept_name, p.prof_fname
FROM dept d
RIGHT JOIN professor p
ON d.dept_code = p.dept_code;

SELECT p.prof_num, p.prof_fname, d.dept_name
FROM professor p
INNER JOIN dept d
ON p.dept_code = d.dept_code;

SELECT d.dept_code, d.dept_name, p.prof_fname
FROM dept d
LEFT JOIN professor p
ON d.dept_code = p.dept_code;

SELECT d.dept_code, d.dept_name, p.prof_fname
FROM dept d
RIGHT JOIN professor p
ON d.dept_code = p.dept_code;

SELECT p.prof_num, p.prof_fname, d.dept_name
FROM dept d
RIGHT JOIN professor p
ON d.dept_code = p.dept_code;

SELECT d.dept_code, d.dept_name, p.prof_fname
FROM dept d
LEFT JOIN professor p
ON d.dept_code = p.dept_code

UNION

SELECT d.dept_code, d.dept_name, p.prof_fname
FROM dept d
RIGHT JOIN professor p
ON d.dept_code = p.dept_code;

#PRACTICAL 8 DONE#
#Prac_9

CREATE VIEW prof_dept AS
SELECT p.prof_num, p.prof_fname, p.dept_code, d.dept_name
FROM professor p
JOIN dept d
ON p.dept_code = d.dept_code;

INSERT INTO professor VALUES ('P101', 2, 'Neha', 'neha@gmail.com', 42000);

SELECT * FROM prof_dept;

SELECT *
FROM prof_dept
WHERE dept_code = 3;

CREATE VIEW prof_dept_student AS
SELECT 
    s.stu_num,
    s.stu_fname,
    p.prof_fname,
    d.dept_name
FROM student s
JOIN professor p ON s.prof_num = p.prof_num
JOIN dept d ON p.dept_code = d.dept_code;

INSERT INTO student VALUES (21, 3, 'Asha', 'asha@gmail.com', 'P4');

SELECT * FROM prof_dept_student;

SELECT *
FROM prof_dept_student
WHERE stu_num > 14;

#prac 9 compl
#prac 10

CREATE TABLE salary_change_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    prof_num VARCHAR(10),
    old_salary INT,
    new_salary INT,
    salary_diff INT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DELIMITER $$

CREATE TRIGGER display_salary_insert
AFTER INSERT ON professor
FOR EACH ROW
BEGIN
    INSERT INTO salary_change_log
    (prof_num, old_salary, new_salary, salary_diff)
    VALUES (NEW.prof_num, 0, NEW.salary, NEW.salary);
END$$

DELIMITER ;

INSERT INTO professor VALUES ('P200', 1, 'Ankit', 'ankit@gmail.com', 50000);

SELECT * FROM salary_change_log;



DELIMITER $$

CREATE TRIGGER display_salary_update
AFTER UPDATE ON professor
FOR EACH ROW
BEGIN
    INSERT INTO salary_change_log
    (prof_num, old_salary, new_salary, salary_diff)
    VALUES (OLD.prof_num, OLD.salary, NEW.salary, NEW.salary - OLD.salary);
END$$

DELIMITER ;

UPDATE professor
SET salary = 55000
WHERE prof_num = 'P200';

SELECT * FROM salary_change_log;

DELIMITER $$

CREATE TRIGGER display_salary_delete
AFTER DELETE ON professor
FOR EACH ROW
BEGIN
    INSERT INTO salary_change_log
    (prof_num, old_salary, new_salary, salary_diff)
    VALUES (OLD.prof_num, OLD.salary, 0, -OLD.salary);
END$$

DELIMITER ;

DELETE FROM professor
WHERE prof_num = 'P200';

SELECT * FROM salary_change_log;

DELIMITER $$

CREATE FUNCTION tax(salary INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN salary * 0.10;
END$$

DELIMITER ;

SELECT prof_num, salary, tax(salary) AS tax_amount
FROM professor;

DELIMITER $$

CREATE FUNCTION annual_salary(salary INT)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN salary * 12;
END$$

DELIMITER ;
SELECT prof_num, salary, annual_salary(salary) AS annual_salary
FROM professor;

SELECT 
    prof_num,
    tax(annual_salary(salary)) AS annual_tax
FROM professor;

DELIMITER $$

CREATE PROCEDURE calculate_annual_salary(IN sal INT)
BEGIN
    SELECT sal * 12 AS annual_salary;
END$$

DELIMITER ;

CALL calculate_annual_salary(30000);


DELIMITER $$

CREATE PROCEDURE get_annual_salary(IN sal INT, OUT annual INT)
BEGIN
    SET annual = sal * 12;
END$$

DELIMITER ;
 
CALL get_annual_salary(30000, @result);
SELECT @result;

#pract_6

USE university;
SHOW TABLES;

ALTER TABLE Professor_table
ADD salary INT;

UPDATE Professor_table SET salary=50000 WHERE prof_num='PROF001';
UPDATE Professor_table SET salary=60000 WHERE prof_num='PROF002';
UPDATE Professor_table SET salary=55000 WHERE prof_num='PROF003';
UPDATE Professor_table SET salary=70000 WHERE prof_num='PROF004';
UPDATE Professor_table SET salary=65000 WHERE prof_num='PROF005';
UPDATE Professor_table SET salary=80000 WHERE prof_num='PROF006';
UPDATE Professor_table SET salary=75000 WHERE prof_num='PROF007';
UPDATE Professor_table SET salary=90000 WHERE prof_num='PROF008';
UPDATE Professor_table SET salary=85000 WHERE prof_num='PROF009';
UPDATE Professor_table SET salary=95000 WHERE prof_num='PROF010';

SELECT MIN(salary) FROM Professor_table;

SELECT MAX(salary) FROM Professor_table;

SELECT AVG(salary) FROM Professor_table;

SELECT COUNT(*) FROM Professor_table;

SELECT SUM(salary) FROM Professor_table;

SELECT SUM(salary)
FROM Professor_table
WHERE dept_code = 105;

SELECT SUM(salary)
FROM Professor_table
WHERE dept_code = 101;

SELECT AVG(salary)
FROM Professor_table
WHERE dept_code = 105;

SELECT dept_code, AVG(salary)
FROM Professor_table
GROUP BY dept_code;

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
DATEDIFF(CURDATE(), doj)/365 AS no_of_experience
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

SELECT SUBSTRING(prof_fname, 102, 105)
FROM Professor_table;

SELECT TRIM(prof_fname)
FROM Professor_table;

SELECT TRIM('   mySQL   ');

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








