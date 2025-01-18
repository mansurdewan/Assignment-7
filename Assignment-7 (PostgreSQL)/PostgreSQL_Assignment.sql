// cSpell:disable


CREATE DATABASE university_db;

--            =====================Table creation =========================

-- Create a "students" table with the following fields:
CREATE TABLE students(
 student_id SERIAL PRIMARY KEY,
 student_name VARCHAR(50) NOT NULL,
 age INTEGER,
 email VARCHAR(200) UNIQUE NOT NULL ,
 frontend_mark INTEGER,
 backend_mark INTEGER,
status VARCHAR(10)
);  


-- Create a "courses" table with the following fields:
CREATE TABLE courses(
 course_id SERIAL PRIMARY KEY,
 course_name VARCHAR(200) NOT NULL,
 credits INTEGER NOT NULL
);  


-- Create an "enrollment" table with the following fields:
CREATE TABLE enrollment(
 enrollment_id SERIAL PRIMARY KEY,
 student_id INTEGER REFERENCES students(student_id),
 course_id INTEGER REFERENCES courses(course_id)
);  




--            =====================Data inserting =========================

-- Insert the following sample data into the "students" table:
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
    ('Rahim', 23, 'rahim.bd@example.com', 72, 85, NULL),
    ('Karim', 22, 'karim.bd@example.com', 55, 65, NULL),
    ('Ayesha', 20, 'ayesha.bd@example.com', 90, 95, NULL),
    ('Farzana', 24, 'farzana.bd@example.com', 40, 50, NULL),
    ('Tanvir', 19, 'tanvir.bd@example.com', 68, 70, NULL),
    ('Nusrat', 22, 'nusrat.bd@example.com', 58, 62, NULL),
    ('Rifat', 23, 'rifat.bd@example.com', 30, 40, NULL);


-- Insert the following sample data into the "courses" table:
INSERT INTO courses ( course_name, credits)
VALUES
    ('Next.js', 3),
    ('React.js', 4),
    ('Databases', 3),
    ('Prisma', 3);
    ('Time Pass', 0);


-- Insert the following sample data into the "enrollment" table: 
INSERT INTO enrollment ( student_id, course_id)
VALUES
    (1, 1),
    (4, 4),
    (2, 3),
    (5, 4),
    (2, 2),
    (3, 1);
DROP TABLE enrollment



-- =====================Run SQL queries to complete the following tasks:==================
-- Query 1
-- insert my data in students table 
INSERT INTO students 
 (student_name, age, email, frontend_mark, backend_mark, status)
 VALUES('Mansur', 25,'mansur@gmail.com',40,58, null);


-- Query 2:
-- Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT s.student_name FROM students AS s 
JOIN enrollment AS e on s.student_id = s.student_id
JOIN courses AS c on e.course_id = c.course_id 
WHERE course_name = 'Next.js';


-- Query 3:
-- Update the status of the student with the highest total (frontend_mark + backend_mark) to 'Awarded'.
UPDATE students
SET status = 'Awarded'
WHERE student_id = (
    SELECT student_id
    FROM students
    ORDER BY (frontend_mark + backend_mark) DESC
    LIMIT 1
);


-- Query 4:
-- Delete all courses that have no students enrolled.
--  // delete Time Pass course 
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id
    FROM enrollment
);


-- Query 5:
-- Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name
FROM students
OFFSET 2
LIMIT 2;


-- Query 6:
-- Retrieve the course names and the number of students enrolled in each course.
SELECT c.course_name, COUNT(e.student_id) AS students_enrolled
FROM courses AS c
JOIN enrollment AS e ON c.course_id = e.course_id
GROUP BY c.course_name;


-- Query 7:
-- Calculate and display the average age of all students.
SELECT round(AVG(age),2) as average_age FROM students;


-- Query 8:
-- Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name
FROM students
WHERE email LIKE '%example.com%';



-- ============================Questions (Answer 10 Questions):======================
-- What is PostgreSQL?
হচ্ছে একটি শক্তিশালী ওপেনসোর্স রিলেশনাল ডাটাবেজ ম্যানেজমেন্ট সিস্টেম


-- What is the purpose of a database schema in PostgreSQL?
Primary Key এর মাধ্যমে টেবিলের নির্দিষ্ট একটি রো বের করে আনা যায় |
 

-- Explain the primary key and foreign key concepts in PostgreSQL.
দুটি টেবিলের মধ্যে সম্পর্ক তৈরি করে, একটি টেবিলের প্রাইমারি কি আরেকটি টেবিলের মাধ্যমে রেফারেন্স করা হয় ।


-- What is the difference between the VARCHAR and CHAR data types?
VARCHAR হলো আমি যতগুলো টেক্সট প্রোভাইড করব শুধু ততটুকুই জায়গা নিবে,
CHAR যতটুক লেন্থ আমি বলে দিব ততটুকু লেন্থ নিবে, যদি আমি টেক্সট কম দেই তাহলে প্যাডিং দিয়ে পরিপূর্ণ করে দেবে |



-- Explain the purpose of the WHERE clause in a SELECT statement.
নির্দিষ্ট কন্ডিশন এর মাধ্যমে ডাটা ফিল্টার করা যায়


-- What are the LIMIT and OFFSET clauses used for?
LIMIT যতগুলো রেকর্ড আমি চাই,
OFFSET  কত থেকে চাই |


-- How can you perform data modification using UPDATE statements?
UPDATE table_name
  SET column_name = new_value
  WHERE condition;


-- What is the significance of the JOIN operation, and how does it work in PostgreSQL?
বিভিন্ন টেবিল কে একত্রিত করতে সাহায্য করে, একটি টেবিল রিটার্ন করে


-- Explain the GROUP BY clause and its role in aggregation operations.
একাধিক রেকর্ডকে নির্দিষ্ট কলামের ভিত্তিতে গ্রুপ করতে ব্যবহৃত হয়,


-- How can you calculate aggregate functions like COUNT, SUM, and AVG in PostgreSQL?
PostgreSQL-এ COUNT, SUM, এবং AVG মত অ্যাগ্রিগেট ফাংশন ব্যবহার করতে SELECT স্টেটমেন্টের সাথে ব্যবহার করতে হয়,
যেমন: 
 SELECT COUNT(*), SUM(column_name), AVG(column_name) FROM table_name;


-- What is the purpose of an index in PostgreSQL, and how does it optimize query performance?
ইনডেক্স হচ্ছে বইয়ের সূচিপত্রের মত, যার মাধ্যমে দ্রুত কোন কিছু খুঁজে বের করা যায়






SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollment;


