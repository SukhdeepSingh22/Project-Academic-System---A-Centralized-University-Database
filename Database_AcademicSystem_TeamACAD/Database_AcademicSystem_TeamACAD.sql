-- Create the database 
CREATE DATABASE AcademicSystem;
 drop database AcademicSystem;
-- Use the database
USE AcademicSystem;

-- Tables--

-- Department table
CREATE TABLE Department (
    depCode VARCHAR(10) NOT NULL,
    officeLocation VARCHAR(100) NOT NULL DEFAULT '',
    depName VARCHAR(100) NOT NULL DEFAULT '',
    PRIMARY KEY (depCode)
);

-- Staff table
CREATE TABLE Staff (
    staffID VARCHAR(10) NOT NULL,
    fName VARCHAR(50) NOT NULL DEFAULT '',
    lName VARCHAR(50) NOT NULL DEFAULT '',
    email VARCHAR(100) NOT NULL,
    DOB DATE,
    depCode VARCHAR(10) NOT NULL DEFAULT '',
    PRIMARY KEY (staffID), 
    FOREIGN KEY (depCode) 
        REFERENCES Department(depCode)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Courses table 
CREATE TABLE Courses (
    courseID VARCHAR(10) NOT NULL,
    courseName VARCHAR(100) NOT NULL DEFAULT '',
    courseCredits VARCHAR(2) NOT NULL, 
    depCode VARCHAR(10) NOT NULL,
    PRIMARY KEY (courseID), 
    FOREIGN KEY (depCode) 
        REFERENCES Department(depCode)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);

-- Classes table 
CREATE TABLE Classes (
    classID VARCHAR(10) NOT NULL,
    CRN VARCHAR(6) NOT NULL, 
    courseID VARCHAR(10) NOT NULL DEFAULT '',
    sectionNo VARCHAR(10) NOT NULL DEFAULT '',
    classDay VARCHAR(10) NOT NULL, 
    timing TIME,
    staffID VARCHAR(10) NOT NULL, 
    PRIMARY KEY (classID), 
    FOREIGN KEY (courseID) 
        REFERENCES Courses(courseID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (staffID) 
        REFERENCES Staff(staffID)
        ON DELETE CASCADE
        ON UPDATE CASCADE 
);

-- Student table
CREATE TABLE Student (
    studentID VARCHAR(10) NOT NULL,
    fName VARCHAR(50) NOT NULL,
    lName VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    gpa VARCHAR(4) NOT NULL, 
    major VARCHAR(50) NOT NULL DEFAULT '',
    totalCredit SMALLINT,
    depCode VARCHAR(10) NULL,
    DOB DATE,
    PRIMARY KEY (studentID), 
    FOREIGN KEY (depCode) 
        REFERENCES Department(depCode)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- Enrollment table 
CREATE TABLE Enrollment (
    enrollID CHAR(8) NOT NULL,
	enrollDate     VARCHAR(9)  NOT NULL,         -- e.g. '23-May-13'
	enrollTime     TIME        NOT NULL,         -- e.g. '09:00:00'
    enrollSemester VARCHAR(10) NOT NULL DEFAULT '',
    studentID VARCHAR(10) NOT NULL,
    status VARCHAR(12) NOT NULL DEFAULT '',
    PRIMARY KEY (enrollID),
    FOREIGN KEY (studentID)
        REFERENCES Student(studentID)
        ON UPDATE CASCADE 
        ON DELETE CASCADE
);

-- Assessment table 
CREATE TABLE Assessment (
    assessmentType VARCHAR(20) NOT NULL,
    classID VARCHAR(10) NOT NULL,
    studentID VARCHAR(10) NOT NULL,
    dueDate DATE,
    grade DECIMAL (5,2) NOT NULL,
    PRIMARY KEY (assessmentType, classID, studentID),
    FOREIGN KEY (classID) 
        REFERENCES Classes(classID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (studentID) 
        REFERENCES Student(studentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ClassFeedback table 
CREATE TABLE ClassFeedback (
    feedbackID VARCHAR(10) NOT NULL,
    staffID VARCHAR(10) NOT NULL,
    studentID VARCHAR(10) NOT NULL,
    rating VARCHAR(2),
    content VARCHAR(500),
    time DATETIME,
    PRIMARY KEY (feedbackID), 
    FOREIGN KEY (staffID) 
        REFERENCES Staff(staffID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (studentID)
        REFERENCES Student(studentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Graduation table 
CREATE TABLE Graduation (
    graduationID CHAR(6) NOT NULL, 
    gradeDate DATE, 
    -- Honor roll: Y or N (1 letter answer)
    honors CHAR(1) DEFAULT 'N', 
    studentID VARCHAR(10) NOT NULL,
    PRIMARY KEY (graduationID),
    FOREIGN KEY (studentID)
        REFERENCES Student(studentID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Inserting values in the table 

-- Insert into Department
INSERT INTO Department (depCode, officeLocation, depName) 
VALUES  
    ('MATH', 'North Wing', 'Mathematics'),
    ('PHIL', 'West Wing', 'Philisophy'),
    ('BUSI', 'North Wing', 'Business'),
    ('HIST', 'West Wing', 'History'),
    ('INFO', 'East Wing', 'Information Technology');
    

-- SELECT * FROM Department;

-- Insert into Staff  
INSERT INTO Staff (staffID, fName, lName, email, DOB, depCode) 
VALUES 
    ('STF100', 'Zachary', 'Erickson', 'Zachary.Erickson@jaegar.ca', '1980-01-15', 'MATH'),
    ('STF101', 'Philip', 'Chambers', 'Philip.Chambers@jaegar.ca', '1975-05-10', 'PHIL'),
    ('STF102', 'Matthew', 'Contreras', 'fishershannon@jaegar.ca', '1982-08-20', 'BUSI'),
    ('STF103', 'Christopher', 'Carpenter', 'Christopher.Carpenter@jaegar.ca', '1978-03-25', 'HIST'),
    ('STF104', 'Pamela', 'Williams', 'Pamela.Williams@jaegar.ca', '1985-11-05', 'INFO'),
    ('STF105', 'Natalie', 'Richards', 'Natalie.Richards@jaegar.ca', '1983-07-30', 'INFO'),
    ('STF106', 'Elizabeth', 'Espinoza', 'Elizabeth.Espinoza@jaegar.ca', '1979-12-12', 'BUSI'),
    ('STF107', 'Erika', 'Green', 'Erika.Green@jaegar.ca', '1981-09-17', 'MATH');
   

-- SELECT * FROM Staff;

-- Insert into Courses 
INSERT INTO Courses (courseID, courseName, courseCredits, depCode) 
VALUES
    ('INFO1111', 'Introduction to Information Systems', '3', 'INFO'),
    ('INFO1112', 'Data Structures in IT', '3', 'INFO'),
    ('INFO1113', 'Database Systems', '3', 'INFO'),
    ('MATH1111', 'Calculus I', '4', 'MATH'),
    ('MATH1112', 'Linear Algebra', '4', 'MATH'),
    ('BUSI1111', 'Principles of Management', '2', 'BUSI'),
    ('BUSI1112', 'Marketing Fundamentals', '3', 'BUSI'),
    ('PHIL1111', 'Introduction to Ethics', '1', 'PHIL'),
    ('HIST1111', 'World History I', '3', 'HIST'),
    ('HIST1112', 'North American History', '3', 'HIST');
    
-- SHOW COLUMNS FROM courses; 


-- Insert into Classes 
INSERT INTO Classes (classID, CRN, courseID, sectionNo, classDay, timing, staffID) 
VALUES
    ('CLS100', '183726', 'INFO1111', 'S10', 'Monday',    '10:00:00', 'STF104'),
    ('CLS101', '294817', 'INFO1112', 'S11', 'Tuesday',   '13:00:00', 'STF104'),
    ('CLS102', '582910', 'INFO1113', 'S15', 'Wednesday', '16:00:00', 'STF105'),
    ('CLS103', '712394', 'MATH1111', 'S20', 'Thursday',  '19:00:00', 'STF100'),
    ('CLS104', '845601', 'MATH1112', 'S21', 'Friday',    '10:00:00', 'STF107'),
    ('CLS105', '392184', 'BUSI1111', 'S30', 'Monday',    '13:00:00', 'STF102'),
    ('CLS106', '261759', 'BUSI1112', 'S31', 'Tuesday',   '16:00:00', 'STF106'),
    ('CLS107', '407825', 'PHIL1111', 'S40', 'Wednesday', '19:00:00', 'STF101'),
    ('CLS108', '978312', 'HIST1111', 'S50', 'Thursday',  '10:00:00', 'STF103'),
    ('CLS109', '610247', 'HIST1112', 'S51', 'Friday',    '13:00:00', 'STF103');


-- Insert into Student 
-- Adjusting columns to match table definition (gpa, totalCredit, and DOB included).
-- We are considering atleast 20 students with randomized IDs, emails, GPAs, and birth dates
INSERT INTO Student (studentID, fName, lName, email, gpa, major, totalCredit, depCode, DOB) 
VALUES
    -- Information Technology (INFO)
    ('100447918', 'Susan', 'Hamilton', 'susan.hamilton@student.jaegar.ca', '3.52', 'Information Technology', 30, 'INFO', '2000-05-21'),
    ('100459012', 'Emily', 'Perez', 'emily.perez@student.jaegar.ca', '3.75', 'Information Technology', 33, 'INFO', '2000-04-26'),
    ('100444555', 'Daniel', 'Smith', 'daniel.smith@student.jaegar.ca', '3.98', 'Information Technology', 24, 'INFO', '2001-08-05'),
    ('100454321', 'Laura', 'Johnson', 'laura.johnson@student.jaegar.ca', '3.60', 'Information Technology', 29, 'INFO', '1999-02-19'),

    -- Mathematics (MATH)
    ('100451234', 'Kimberly', 'Brown',     'kimberly.brown@student.jaegar.ca', '3.80', 'Mathematics', 28, 'MATH', '1999-07-14'),
    ('100446789', 'David', 'Lee',       'david.lee@student.jaegar.ca', '3.49', 'Mathematics', 27, 'MATH', '2000-06-30'),
    ('100451987', 'Natalie', 'Richards',  'natalie.richards@student.jaegar.ca', '3.85', 'Mathematics', 31, 'MATH', '1998-10-22'),
    ('100458123', 'Sophia', 'Martinez',  'sophia.martinez@student.jaegar.ca', '4.00', 'Mathematics', 34, 'MATH', '2000-09-15'),

    -- Business (BUSI)
    ('100462345', 'Julie', 'Horn', 'julie.horn@student.jaegar.ca', '4.01', 'Business', 32, 'BUSI', '2001-11-02'),
    ('100446123', 'Justin', 'Thomas', 'justin.thomas@student.jaegar.ca',  '3.55', 'Business', 30, 'BUSI', '1999-12-01'),
    ('100451001', 'Abigail', 'Turner', 'abigail.turner@student.jaegar.ca', '3.88', 'Business', 32, 'BUSI', '2001-07-07'),
    ('100458001', 'Ryan',  'Clark', 'ryan.clark@student.jaegar.ca', '3.66', 'Business', 29, 'BUSI', '2000-11-23'),

    -- Philosophy (PHIL)
    ('100444678', 'Eric', 'Glass', 'eric.glass@student.jaegar.ca', '3.67', 'Philosophy', 29, 'PHIL', '2000-12-29'),
    ('100447111', 'Rachel', 'Adams', 'rachel.adams@student.jaegar.ca', '2.90', 'Philosophy', 30, 'PHIL', '1999-05-02'),
    ('100453222', 'Brandon', 'Nelson', 'brandon.nelson@student.jaegar.ca', '3.53', 'Philosophy', 28, 'PHIL', '2001-02-28'),
    ('100459333', 'Meghan', 'Wright', 'meghan.wright@student.jaegar.ca', '3.82', 'Philosophy', 31, 'PHIL', '2000-08-19'),

    -- History (HIST)
    ('100459321', 'Robyn', 'Davis', 'robyn.davis@student.jaegar.ca', '3.90', 'History', 31, 'HIST', '1998-03-08'),
    ('100452222', 'Kevin', 'Walker', 'kevin.walker@student.jaegar.ca','3.68', 'History', 26, 'HIST', '2000-12-05'),
    ('100455555', 'Angela', 'Brooks', 'angela.brooks@student.jaegar.ca', '3.77', 'History', 29, 'HIST', '1999-03-23'),
    ('100456666', 'Monica', 'Hall', 'monica.hall@student.jaegar.ca', '3.59', 'History', 28, 'HIST', '2001-11-30');


-- Insert into Enrollment
INSERT INTO Enrollment
  (enrollID, enrollDate, enrollTime, enrollSemester, status, studentID)
VALUES
  ('ENR100','23-May-25','09:00:00','Spring','Inactive','100451987'),
  ('ENR101','15-Jan-25','11:30:00','Spring','Active',  '100458123'),
  ('ENR102','18-Jan-25','13:15:00','Spring','Active',  '100446789'),
  ('ENR103','21-Jan-25','15:45:00','Spring','Active',  '100451234'),
  ('ENR104','24-Jan-25','17:00:00','Spring','Inactive','100444555'),
  ('ENR105','27-Jan-25','09:30:00','Spring','Active',  '100454321'),
  ('ENR106','30-Jan-25','11:00:00','Spring','Active',  '100459012'),
  ('ENR107','02-Feb-25','13:00:00','Spring','Active',  '100447918'),
  ('ENR108','05-Feb-25','15:00:00','Spring','Active',  '100456666'),
  ('ENR109','08-Feb-25','17:30:00','Spring','Active',  '100446123'),
  ('ENR110','11-Feb-25','09:15:00','Spring','Active',  '100455555');




-- Insert into Assessment 
-- Using DECIMAL grade values.
INSERT INTO Assessment (assessmentType, classID, studentID, dueDate, grade) 
VALUES
    ('Project',    'CLS100', '100447918', '2025-04-09', 85.19),
    ('Project',    'CLS101', '100459012', '2025-04-10', 76.84),
    ('Project',    'CLS102', '100444555', '2025-04-11', 61.89),
    ('Project',    'CLS103', '100454321', '2025-04-12', 91.57),
    ('Quiz',       'CLS104', '100451234', '2025-04-13', 87.93),
    ('Project',    'CLS105', '100446789', '2025-04-14', 98.36),
    ('Quiz',       'CLS106', '100451987', '2025-04-15', 78.49),
    ('Assignment', 'CLS107', '100458123', '2025-04-16', 67.39),
    ('Quiz',       'CLS108', '100462345', '2025-04-17', 83.89),
    ('Project',    'CLS109', '100446123', '2025-04-18', 66.26),
    ('Assignment', 'CLS100', '100451001', '2025-04-19', 81.95),
    ('Assignment', 'CLS101', '100458001', '2025-04-20', 75.65),
    ('Project',    'CLS102', '100444678', '2025-04-21', 64.64),
    ('Assignment', 'CLS103', '100447111', '2025-04-22', 88.37),
    ('Assignment', 'CLS104', '100453222', '2025-04-23', 85.46);

-- Insert into ClassFeedback 
-- Columns: feedbackID, staffID, studentID, content, time (DATETIME), rating (NULL or 'A+' … 'F')
INSERT INTO ClassFeedback (feedbackID, staffID, studentID, content, time, rating)
VALUES 
    ('FDB100', 'STF100', '100447918', 'The instructor explained complex topics clearly and made lectures engaging.', '2025-04-09 13:45:58', 'C'),
    ('FDB101', 'STF101', '100459012', 'Excellent teaching style — very organized and approachable in class.', '2025-04-08 17:45:58', 'A+'),
    ('FDB102', 'STF102', '100444555', 'The course felt rushed at times; more in-class examples would be helpful.', '2025-04-07 7:40:58', 'B'),
    ('FDB103', 'STF103', '100454321', 'Instructor encouraged questions and created an inclusive learning space.', '2025-04-06 20:45:58', 'A'),
    ('FDB104', 'STF104', '100451234', 'Good overall, but lectures could benefit from better time management.', '2025-04-05 21:05:58', 'B+'),
    ('FDB105', 'STF105', '100446789', 'Sometimes hard to follow — slides needed more explanation during class.', '2025-04-04 18:45:58', NULL),
    ('FDB106', 'STF106', '100451987', 'The instructor didn’t provide enough support during assessments.', '2025-04-03 12:15:58', 'D'),
    ('FDB107', 'STF107', '100458123', 'I appreciated how the instructor gave regular feedback and stayed interactive.',  '2025-04-02 19:33:58', 'B'),
    ('FDB108', 'STF100', '100462345', 'More enthusiasm during lectures would improve the learning experience.', '2025-04-01 10:19:58', 'C'),
    ('FDB109', 'STF107', '100446123', 'The instructor missed a few classes and didn’t provide make-up material. ', '2025-03-31 17:15:58', 'D'),
    ('FDB110', 'STF105', '100451001', 'Class discussions were encouraged, which made learning more interesting.', '2025-03-30 8:30:58', NULL),
    ('FDB111', 'STF103', '100458001', 'Course content was useful, but delivery was monotonous at times.', '2025-03-29 11:25:58', 'C'),
    ('FDB112', 'STF102', '100444678', 'Best teaching I’ve experienced — passionate and clear throughout the term.', '2025-03-28 12:25:58', 'A'),
    ('FDB113', 'STF106', '100447111', 'The instructor explained every concept with real-world examples. Very helpful.', '2025-03-27 10:22:58', 'B'),
    ('FDB114', 'STF107', '100453222', 'I learned a lot, but wish the pace had been slower during difficult units.', '2025-03-26 19:48:58', 'A-');


-- Insert into Graduation 
INSERT INTO Graduation (graduationID, gradeDate, honors, studentID)
VALUES
    ('GRD001', '2025-04-01', 'Y', '100447918'),
    ('GRD002', '2025-12-15', 'N', '100459333'),
    ('GRD003', '2025-04-15', 'Y', '100451987'),
    ('GRD004', '2025-04-01', 'N', '100459012');

SELECT * FROM Department;
SELECT * FROM Staff;
SELECT * FROM Courses;
SELECT * FROM Classes;
SELECT * FROM Student;
SELECT * FROM Enrollment;
SELECT * FROM Assessment;
SELECT * FROM ClassFeedback;
SELECT * FROM Graduation;
