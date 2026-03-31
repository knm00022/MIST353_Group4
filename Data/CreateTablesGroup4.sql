-- Create tables for Student Complaint System
-- use MIST353_Group4;
-- use [MIST353_Group4];

GO

-- Drop tables if they already exist
-- Drop child table first because it depends on other tables
IF (OBJECT_ID('COMPLAINT') IS NOT NULL)
    DROP TABLE COMPLAINT;

-- Drop subtype tables before AppUser
IF (OBJECT_ID('STUDENT') IS NOT NULL)
    DROP TABLE STUDENT;

IF (OBJECT_ID('RA') IS NOT NULL)
    DROP TABLE RA;

IF (OBJECT_ID('STAFF') IS NOT NULL)
    DROP TABLE STAFF;

-- Drop parent table last
IF (OBJECT_ID('AppUser') IS NOT NULL)
    DROP TABLE AppUser;

GO

-- Create AppUser table
-- This is the supertype table that stores shared user information
CREATE TABLE AppUser (
    AppUserID INT IDENTITY(1,1)
        CONSTRAINT PK_AppUser PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL
        CONSTRAINT UQ_Email UNIQUE,
    [Password] NVARCHAR(255) NOT NULL,
    Phone NVARCHAR(20) NULL,
    UserType NVARCHAR(20) NOT NULL
        CONSTRAINT CK_UserType CHECK (UserType IN ('STUDENT', 'RA', 'STAFF'))
);

GO

-- Create STUDENT table
-- StudentID is both the primary key and foreign key to AppUser
CREATE TABLE STUDENT (
    StudentID INT
        CONSTRAINT PK_STUDENT PRIMARY KEY
        CONSTRAINT FK_STUDENT_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID),
    SRoomNum NVARCHAR(10) NOT NULL,
    SDorm NVARCHAR(50) NOT NULL
);

GO

-- Create RA table
-- RAID is both the primary key and foreign key to AppUser
CREATE TABLE RA (
    RAID INT
        CONSTRAINT PK_RA PRIMARY KEY
        CONSTRAINT FK_RA_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID),
    RASectionNum NVARCHAR(10) NOT NULL
);

GO

-- Create STAFF table
-- StaffID is both the primary key and foreign key to AppUser
CREATE TABLE STAFF (
    StaffID INT
        CONSTRAINT PK_STAFF PRIMARY KEY
        CONSTRAINT FK_STAFF_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID),
    StaffPosition NVARCHAR(100) NOT NULL
);

GO

-- Create COMPLAINT table
CREATE TABLE COMPLAINT (
    CID INT IDENTITY(1,1)
        CONSTRAINT PK_COMPLAINT PRIMARY KEY,
    CDescription NVARCHAR(MAX) NOT NULL,
    CDateSubmitted DATETIME NOT NULL
        CONSTRAINT DF_CDateSubmitted DEFAULT GETDATE(),
    CDateResolved DATETIME NULL,
    CStatus NVARCHAR(20) NOT NULL
        CONSTRAINT CK_CStatus CHECK (CStatus IN ('Open', 'In Progress', 'Resolved', 'Closed'))
        CONSTRAINT DF_CStatus DEFAULT 'Open',
    StudentID INT NOT NULL
        CONSTRAINT FK_COMPLAINT_STUDENT FOREIGN KEY REFERENCES STUDENT(StudentID),
    RAID INT NULL
        CONSTRAINT FK_COMPLAINT_RA FOREIGN KEY REFERENCES RA(RAID),
    StaffID INT NULL
        CONSTRAINT FK_COMPLAINT_STAFF FOREIGN KEY REFERENCES STAFF(StaffID),
    RecurringIssueID INT NULL
        CONSTRAINT FK_COMPLAINT_RecurringIssue FOREIGN KEY REFERENCES COMPLAINT(CID)
);

GO