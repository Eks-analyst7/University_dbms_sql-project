
#Pract_3

CREATE DATABASE university;
USE university;

CREATE TABLE Dept_table (
    dept_code INT PRIMARY KEY,
    dept_name VARCHAR(50),
    prof_num VARCHAR(10)
);

CREATE TABLE Professor_table (
    prof_num VARCHAR(10) PRIMARY KEY,
    dept_code INT,
    prof_specialty VARCHAR(50),
    prof_lname VARCHAR(50),
    prof_fname VARCHAR(50),
    prof_initial VARCHAR(5),
    prof_email VARCHAR(100),
    FOREIGN KEY (dept_code) REFERENCES Dept_table(dept_code)
);

CREATE TABLE Student_table (
    stu_num INT PRIMARY KEY,
    stu_lname VARCHAR(50),
    stu_fname VARCHAR(50),
    stu_email VARCHAR(100),
    prof_num VARCHAR(10),
    FOREIGN KEY (prof_num) REFERENCES Professor_table(prof_num)
);

SHOW TABLES;

#Practi_4

INSERT INTO Dept_table VALUES
(101, 'Computer Science', NULL),
(102, 'Mechanical Engineering', NULL),
(103, 'Electrical Engineering', NULL),
(104, 'Civil Engineering', NULL),
(105, 'Information Technology', NULL);

INSERT INTO Professor_table VALUES
('PROF001', 101, 'Computer Science', 'Sharma', 'Kumar', 'A.K.', 'amit.sharma@university.edu'),
('PROF002', 102, 'Mechanical Design', 'Verma', 'Singh', 'R.S.', 'rajesh.verma@university.edu'),
('PROF003', 103, 'Electrical Systems', 'Patel', 'Bhai', 'S.B.', 'suresh.patel@university.edu'),
('PROF004', 104, 'Structural Engineering', 'Iyer', 'N', 'Anand', 'anand.iyer@university.edu'),
('PROF005', 105, 'Information Technology', 'Mehta', 'R', 'Neha', 'neha.mehta@university.edu'),

('PROF006', 101, 'Data Science', 'Gupta', 'Amit', 'A.G.', 'amit.gupta@university.edu'),
('PROF007', 102, 'Thermodynamics', 'Reddy', 'Kiran', 'K.R.', 'kiran.reddy@university.edu'),
('PROF008', 103, 'Power Systems', 'Kulkarni', 'Vijay', 'V.K.', 'vijay.kulkarni@university.edu'),
('PROF009', 104, 'Geotechnical', 'Desai', 'Rohit', 'R.D.', 'rohit.desai@university.edu'),
('PROF010', 105, 'Cyber Security', 'Chavan', 'Sneha', 'S.C.', 'sneha.chavan@university.edu');

UPDATE Dept_table SET prof_num='PROF001' WHERE dept_code=101;
UPDATE Dept_table SET prof_num='PROF002' WHERE dept_code=102;
UPDATE Dept_table SET prof_num='PROF003' WHERE dept_code=103;
UPDATE Dept_table SET prof_num='PROF004' WHERE dept_code=104;
UPDATE Dept_table SET prof_num='PROF005' WHERE dept_code=105;

INSERT INTO Student_table VALUES
(1, 'Singh', 'Ekta', 'eku@uni.edu', 'PROF001'),
(2, 'Patil', 'Sneha', 'sneha@uni.edu', 'PROF002'),
(3, 'Khan', 'Aman', 'aman@uni.edu', 'PROF003'),
(4, 'Joshi', 'Riya', 'riya@uni.edu', 'PROF004'),
(5, 'Das', 'Pooja', 'pooja@uni.edu', 'PROF005'),

(6, 'More', 'Ajay', 'ajay@uni.edu', 'PROF006'),
(7, 'Jain', 'Rohit', 'rohit@uni.edu', 'PROF007'),
(8, 'Shaikh', 'Imran', 'imran@uni.edu', 'PROF008'),
(9, 'Kulkarni', 'Neha', 'neha@uni.edu', 'PROF009'),
(10, 'Yadav', 'Priya', 'priya@uni.edu', 'PROF010'),

(11, 'Singh', 'Arjun', 'arjun@uni.edu', 'PROF001'),
(12, 'Nair', 'Anita', 'anita@uni.edu', 'PROF002'),
(13, 'Pawar', 'Kiran', 'kiran@uni.edu', 'PROF003'),
(14, 'Rane', 'Sonal', 'sonal@uni.edu', 'PROF004'),
(15, 'Chopra', 'Vikas', 'vikas@uni.edu', 'PROF005'),

(16, 'Bose', 'Ritu', 'ritu@uni.edu', 'PROF006'),
(17, 'Meena', 'Aakash', 'aakash@uni.edu', 'PROF007'),
(18, 'Ghosh', 'Tina', 'tina@uni.edu', 'PROF008'),
(19, 'Naidu', 'Suresh', 'suresh@uni.edu', 'PROF009'),
(20, 'Kapoor', 'Simran', 'simran@uni.edu', 'PROF010');

CREATE TABLE new_table (
    stu_num INT,
    stu_lname VARCHAR(50),
    stu_fname VARCHAR(50),
    stu_email VARCHAR(100),
    prof_num VARCHAR(10)
);

INSERT INTO new_table
SELECT * FROM Student_table;
SELECT * FROM new_table;

UPDATE Student_table 
SET prof_num = 'PROF001' 
WHERE stu_num = 8;

SELECT * FROM Student_table WHERE stu_num = 8;

#prac_5

SELECT s.*
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.dept_code = 101;

SELECT s.*
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.dept_code IN (101, 105);

SELECT s.stu_fname, p.dept_code
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
ORDER BY p.dept_code ASC;

SELECT prof_fname, prof_email, dept_code
FROM Professor_table
ORDER BY dept_code DESC;

SELECT prof_fname, prof_email, dept_code, prof_num
FROM Professor_table
ORDER BY dept_code DESC, prof_num ASC;

SELECT DISTINCT prof_specialty
FROM Professor_table;

SELECT DISTINCT p.dept_code
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num;

SELECT DISTINCT prof_specialty, dept_code
FROM Professor_table;

SELECT p.prof_num, p.prof_fname, p.prof_email, d.dept_name
FROM Professor_table p
JOIN Dept_table d ON p.dept_code = d.dept_code;

SELECT s.stu_num, s.stu_fname, s.stu_email, d.dept_name
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
JOIN Dept_table d ON p.dept_code = d.dept_code;

SELECT s.stu_num, s.stu_fname, s.stu_email, s.prof_num
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.prof_fname = 'Sneha';

SELECT s.stu_num, s.stu_fname, s.stu_email, s.prof_num
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.dept_code = 105;

SELECT s.stu_num, s.stu_fname, s.stu_email, s.prof_num
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.dept_code = 105 AND p.prof_fname = 'Sneha';

SELECT s.stu_num, s.stu_fname, s.stu_email, s.prof_num, p.dept_code
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.dept_code IN (103,105)
ORDER BY p.dept_code ASC, s.stu_fname ASC;

SELECT s.stu_num, s.stu_fname, s.stu_email, s.prof_num, p.dept_code
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE s.stu_num > 6 AND p.dept_code IN (103,105)
ORDER BY p.dept_code ASC, s.stu_fname ASC;

SELECT s.stu_num, s.stu_fname, s.stu_email, s.prof_num
FROM Student_table s
JOIN Professor_table p ON s.prof_num = p.prof_num
WHERE p.dept_code NOT IN (104);

CREATE TABLE prof_1 AS
SELECT * FROM Professor_table;

#Pract_8




