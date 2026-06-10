# University Database Management System Using MySQL

## Introduction

The University Database Management System is a SQL-based project developed to demonstrate relational database concepts using MySQL.

The project focuses on managing university-related information including departments, professors, and students while maintaining data integrity through relationships and constraints.

---

## Objectives

- Design a relational database structure.
- Create tables using primary and foreign keys.
- Perform CRUD operations.
- Execute SQL queries for data retrieval.
- Apply aggregate, string, and date functions.
- Demonstrate practical database management skills.

---

## Tools Used

- MySQL
- SQL
- MySQL Workbench

---

## Database Entities

### Department

Stores department information.

**Attributes**
- Department ID
- Department Name
- Location

### Professor

Stores professor information.

**Attributes**
- Professor ID
- Professor Name
- Email
- Joining Date
- Department ID

### Student

Stores student information.

**Attributes**
- Student ID
- Student Name
- Email
- Department ID
- Professor ID

---

## Database Relationships

- One Department can have multiple Professors.
- One Department can have multiple Students.
- One Professor can supervise multiple Students.
- Foreign keys maintain relationships between tables.

---

## SQL Concepts Implemented

### Database Operations

- CREATE DATABASE
- USE DATABASE
- DROP DATABASE

### Table Operations

- CREATE TABLE
- ALTER TABLE
- PRIMARY KEY
- FOREIGN KEY

### Data Manipulation

- INSERT
- UPDATE
- DELETE

### Query Operations

- SELECT
- WHERE
- ORDER BY
- GROUP BY
- HAVING

### Functions

- COUNT()
- SUM()
- AVG()
- MIN()
- MAX()
- CONCAT()
- UPPER()
- LOWER()
- DATEDIFF()

### Joins

- INNER JOIN
- LEFT JOIN
- RIGHT JOIN

---

## Sample Query

```sql
SELECT s.StudentName,
       d.DepartmentName
FROM Student s
INNER JOIN Department d
ON s.DepartmentID = d.DepartmentID;
```

---

## Key Learning Outcomes

- Relational Database Design
- SQL Query Writing
- Data Modeling
- Database Administration
- Data Manipulation
- Query Optimization

---

## Skills Demonstrated

- SQL
- MySQL
- Database Design
- Data Modeling
- Data Analysis
- Relational Database Management

---

## Conclusion

This project provided practical exposure to database management concepts using MySQL. Through the implementation of relational tables, key constraints, joins, and SQL functions, the project demonstrated how structured databases can efficiently manage and analyze university-related information.

---

## Author

**Ekta Singh**

M.Sc. Data Analytics

University of Mumbai
