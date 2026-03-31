-- Insert sample data for Student Complaint System
-- use MIST353_Group4;
-- use [MIST353_Group4];

GO

-- Insert AppUsers first
-- 5 students, 3 RAs, 2 staff
INSERT INTO AppUser (FirstName, LastName, Email, [Password], Phone, UserType)
VALUES
('John', 'Smith', 'john.smith@mix.wvu.edu', 'password123', '555-0101', 'STUDENT'),
('Emily', 'Johnson', 'emily.johnson@mix.wvu.edu', 'password123', '555-0102', 'STUDENT'),
('Michael', 'Williams', 'michael.williams@mix.wvu.edu', 'password123', '555-0103', 'STUDENT'),
('Sarah', 'Brown', 'sarah.brown@mix.wvu.edu', 'password123', '555-0104', 'STUDENT'),
('David', 'Jones', 'david.jones@mix.wvu.edu', 'password123', '555-0105', 'STUDENT'),
('Jessica', 'Davis', 'jessica.davis@mix.wvu.edu', 'ra_pass123', '555-0201', 'RA'),
('Ryan', 'Miller', 'ryan.miller@mix.wvu.edu', 'ra_pass123', '555-0202', 'RA'),
('Amanda', 'Wilson', 'amanda.wilson@mix.wvu.edu', 'ra_pass123', '555-0203', 'RA'),
('Robert', 'Taylor', 'robert.taylor@mix.wvu.edu', 'staff_pass123', '555-0301', 'STAFF'),
('Linda', 'Anderson', 'linda.anderson@mix.wvu.edu', 'staff_pass123', '555-0302', 'STAFF');

GO

-- Insert Students
-- Student AppUserIDs are 1 through 5
INSERT INTO STUDENT (StudentID, SRoomNum, SDorm)
VALUES
(1, '201A', 'Summit Hall'),
(2, '305B', 'Summit Hall'),
(3, '412C', 'Seneca Hall'),
(4, '208A', 'Summit Hall'),
(5, '515D', 'Boreman North');

GO

-- Insert RAs
-- RA AppUserIDs are 6 through 8
INSERT INTO RA (RAID, RASectionNum) --Seciton is floor number
VALUES
(6, 'Section 1'),
(7, 'Section 2'),
(8, 'Section 3');

GO

-- Insert Staff
-- Staff AppUserIDs are 9 through 10
INSERT INTO STAFF (StaffID, StaffPosition)
VALUES
(9, 'Residential Life Coordinator'),
(10, 'Housing Director');

GO

-- Insert Complaints
INSERT INTO COMPLAINT (
    CDescription,
    CDateSubmitted,
    CStatus,
    StudentID,
    RAID,
    StaffID,
    RecurringIssueID
)
VALUES
('Noise complaint - loud music after quiet hours', '2026-03-15 22:30:00', 'Resolved', 1, 6, NULL, NULL),
('Broken heating in room', '2026-03-18 08:15:00', 'In Progress', 2, 6, 9, NULL),
('Water leak in bathroom', '2026-03-20 14:45:00', 'Open', 3, 7, NULL, NULL),
('Roommate conflict', '2026-03-22 10:00:00', 'In Progress', 4, 7, 10, NULL),
('Noise complaint - same issue recurring', '2026-03-25 23:00:00', 'Open', 1, 6, NULL, 1),
('Missing package from mailroom', '2026-03-26 16:20:00', 'Open', 5, 8, NULL, NULL);

GO

-- Test data
SELECT * FROM AppUser;
SELECT * FROM STUDENT;
SELECT * FROM RA;
SELECT * FROM STAFF;
SELECT * FROM COMPLAINT;