USE CSE_4B_490

----------------------------------------------EXTRA TRIGGER--------------------------------

-----AFTER TRIGGER-----

CREATE TABLE EMPLOYEEDETAILS
(
	EmployeeID Int Primary Key,
	EmployeeName Varchar(100) Not Null,
	ContactNo Varchar(100) Not Null,
	Department Varchar(100) Not Null,
	Salary Decimal(10,2) Not Null,
	JoiningDate DateTime Null
)

CREATE TABLE EmployeeLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT NOT NULL,
	EmployeeName VARCHAR(100) NOT NULL,
    ActionPerformed VARCHAR(100) NOT NULL,
    ActionDate DATETIME NOT NULL
);


--1)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to display the message
--"Employee record inserted", "Employee record updated", "Employee record deleted"

CREATE TRIGGER TR_PRINT
ON EMPLOYEEDETAILS
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	SELECT * FROM inserted
		PRINT('Employee record inserted')
	SELECT * FROM inserted
		PRINT('Employee record updated') 
	SELECT * FROM deleted
		PRINT('Employee record deleted') 
END
DROP TRIGGER TR_PRINT

--2)	Create a trigger that fires AFTER INSERT, UPDATE, and DELETE operations on the EmployeeDetails table to log all operations into the 
--EmployeeLog table.

CREATE  TRIGGER TR_EMPLOYEEDETAILS_LOG
ON EMPLOYEEDETAILS
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @ID INT,@NAME VARCHAR(50)

	SELECT @ID=EmployeeID, @NAME=EmployeeName FROM inserted

	INSERT INTO EmployeeLogs
	VALUES(@ID,@NAME,'INSERT',GETDATE())

	INSERT INTO EmployeeLogs
	VALUES(@ID,@NAME,'UPDATE',GETDATE())

	SELECT @ID=EmployeeID, @NAME=EmployeeName FROM deleted

	INSERT INTO EmployeeLogs
	VALUES(@ID,@NAME,'DELETE',GETDATE())

END
DROP TRIGGER TR_EMPLOYEEDETAILS_LOG

--3)	Create a trigger that fires AFTER INSERT to automatically calculate the joining bonus (10% of the salary) for new employees and 
--update a bonus column in the EmployeeDetails table.

CREATE TRIGGER TR_SALARYINCRESE
ON EMPLOYEEDETAILS
AFTER INSERT
AS
BEGIN
	DECLARE @SALARY DECIMAL(10,2)

	UPDATE EMPLOYEEDETAILS
	SET Salary = @SALARY*0.10
	WHERE EmployeeID IN (SELECT EmployeeID FROM inserted)
END
DROP TRIGGER TR_SALARYINCRESE

--4)	Create a trigger to ensure that the JoiningDate is automatically set to the current date if it is NULL during an INSERT operation.

CREATE TRIGGER TR_GETDATE
ON EMPLOYEEDETAILS
AFTER INSERT
AS
BEGIN
	UPDATE EMPLOYEEDETAILS
	SET JoiningDate = GETDATE()
	WHERE JoiningDate IS NULL
END
DROP TRIGGER TR_GETDATE

--5)	Create a trigger that ensure that ContactNo is valid during insert and update (Like ContactNo length is 10)
CREATE TRIGGER TR_CONTACTNO
ON EMPLOYEEDETAILS
AFTER INSERT,UPDATE
AS 
BEGIN
	IF EXISTS 
	(SELECT * FROM inserted WHERE LEN(ContactNo) <> 10)
	BEGIN 
		PRINT('CONTACT NO IS NOT VALID')
	END
END
DROP TRIGGER TR_CONTACTNO

----------------------------INSTEAD OF TRIGGER--------------------
------INSTED OF TRIGGER------

CREATE TABLE Moviess(
    MovieID INT PRIMARY KEY,
    MovieTitle VARCHAR(255) NOT NULL,
    ReleaseYear INT NOT NULL,
    Genre VARCHAR(100) NOT NULL,
    Rating DECIMAL(3, 1) NOT NULL,
    Duration INT NOT NULL
);

CREATE TABLE MoviesLogs
(
	LogID INT PRIMARY KEY IDENTITY(1,1),
	MovieID INT NOT NULL,
	MovieTitle VARCHAR(255) NOT NULL,
	ActionPerformed VARCHAR(100) NOT NULL,
	ActionDate	DATETIME  NOT NULL
);


--6.	Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the Movies table. For that, log all operations performed 
--on the Movies table into MoviesLog.

CREATE  TRIGGER TR_Movies_LOG
ON Moviess
instead of INSERT
AS
BEGIN
	DECLARE @ID INT,@TITLE VARCHAR(50)

	SELECT * FROM inserted

	INSERT INTO MoviesLogs
	VALUES(@ID,@TITLE,'INSERT',GETDATE())
	
	INSERT INTO MoviesLogs
	VALUES(@ID,@TITLE,'UPDATE',GETDATE())

	SELECT * FROM deleted

	INSERT INTO MoviesLogs
	VALUES(@ID,@TITLE,'DELETE',GETDATE())
END

DROP TRIGGER TR_Movies_LOG

--7.	Create a trigger that only allows to insert movies for which Rating is greater than 5.5 .

CREATE TRIGGER TR_GREATER5
ON Moviess
INSTEAD OF INSERT
AS 
BEGIN
	SELECT * FROM inserted
	WHERE Rating>=5.5
END
DROP TRIGGER TR_GREATER5

--8.	Create trigger that prevent duplicate 'MovieTitle' of Movies table and log details of it in MoviesLog table.

--9.	Create trigger that prevents to insert pre-release movies.

--10.	Develop a trigger to ensure that the Duration of a movie cannot be updated to a value greater than 120 minutes (2 hours)
--to prevent unrealistic entries.

