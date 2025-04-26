-- ==========================================
-- Academic System: Sample Queries for Report
-- Database: AcademicSystem
-- Author: Group07 - (Academic System)
-- Date: April 17, 2025
-- ==========================================

USE AcademicSystem;

-- 1. Department-wise Course Offering Overview
SELECT 
    d.depName AS Department_Name, 
    COUNT(c.courseID) AS Total_Courses_Offered
FROM 
    Department AS d
JOIN 
    Courses AS c ON d.depCode = c.depCode
GROUP BY 
    d.depName;







-- 2. Instructor Workload: Number of Classes Taught
SELECT 
    st.staffID AS Instructor_ID,
    st.fName AS First_Name,
    st.lName AS Last_Name,
    COUNT(cl.classID) AS Total_Classes_Taught
FROM 
    Staff AS st
JOIN 
    Classes AS cl ON st.staffID = cl.staffID
GROUP BY 
    st.staffID, st.fName, st.lName;











-- 3. Instructors with 'A+' Feedback and Their Department
SELECT 
    st.staffID AS Instructor_ID,
    CONCAT(st.fName, ' ', st.lName) AS Instructor_Name,
    d.depName AS Department_Name
FROM 
    Staff AS st
JOIN 
    ClassFeedback AS cf ON st.staffID = cf.staffID
JOIN 
    Department AS d ON st.depCode = d.depCode
WHERE 
    cf.rating = 'A+'
GROUP BY 
    st.staffID, st.fName, st.lName, d.depName;







-- 4. Class Schedule for Classes Starting at 1PM with Instructor
SELECT 
    c.courseName AS Course_Name,
    cl.sectionNo AS Section_Number,
    cl.classDay AS Class_Day,
    CONCAT(st.fName, ' ', st.lName) AS Instructor_Name
FROM 
    Courses AS c
JOIN 
    Classes AS cl ON c.courseID = cl.courseID
JOIN 
    Staff AS st ON cl.staffID = st.staffID
WHERE 
    cl.timing = '13:00'
ORDER BY 
    c.courseName, cl.sectionNo;



-- 5. Department-wise Average GPA
SELECT 
    d.depName AS Department_Name,
    ROUND(AVG(s.gpa), 2) AS Average_GPA
FROM 
    Department AS d
JOIN 
    Student AS s ON d.depCode = s.depCode
GROUP BY 
    d.depName
ORDER BY 
    Average_GPA DESC;





