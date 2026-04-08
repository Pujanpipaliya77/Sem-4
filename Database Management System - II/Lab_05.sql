USE CSE_4B_490

-- Creating PersonInfo Table
CREATE TABLE PersonInfo (
 PersonID INT PRIMARY KEY,
 PersonName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8,2) NOT NULL,
 JoiningDate DATETIME NULL,
 City VARCHAR(100) NOT NULL,
 Age INT NULL,
 BirthDate DATETIME NOT NULL
);

-- Creating PersonLog Table
CREATE TABLE PersonLog (
 PLogID INT PRIMARY KEY IDENTITY(1,1),
 PersonID INT NOT NULL,
 PersonName VARCHAR(250) NOT NULL,
 Operation VARCHAR(50) NOT NULL,
 UpdateDate DATETIME NOT NULL,
);


--------------------PART-A----------------------

--1. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table to display
--a message “Record is Affected.”
CREATE TRIGGER TR_PERSON_OPERATION
ON PersonInfo
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	PRINT('Record is Afftected');
END


--2. Create a trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo table. For that,
--log all operations performed on the person table into PersonLog.
CREATE  TRIGGER TR_PERSONINFO_LOG
ON PersonInfo
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	DECLARE @ID INT,@NAME VARCHAR(50)

	SELECT @ID=PersonID, @NAME=PersonName FROM inserted

	INSERT INTO PersonLog
	VALUES(@ID,@NAME,'INSERT',GETDATE())

	INSERT INTO PersonLog
	VALUES(@ID,@NAME,'UPDATE',GETDATE())

	SELECT @ID=PersonID, @NAME=PersonName FROM deleted

	INSERT INTO PersonLog
	VALUES(@ID,@NAME,'DELETE',GETDATE())

END
DROP TRIGGER TR_PERSONINFO_LOG


--3. Create an INSTEAD OF trigger that fires on INSERT, UPDATE and DELETE operation on the PersonInfo
--table. For that, log all operations performed on the person table into PersonLog.
CREATE  TRIGGER TR_PERSONINFO_INSTEADOFINSERT
ON PersonInfo
INSTEAD OF INSERT
AS
BEGIN
	DECLARE @ID INT,@NAME VARCHAR(50)

	SELECT @ID=PersonID, @NAME=PersonName FROM inserted

	INSERT INTO PersonLog
	VALUES(@ID,@NAME,'INSERT',GETDATE())
END
DROP TRIGGER TR_PERSONINFO_INSTEADOFTRIGGER

CREATE  TRIGGER TR_PERSONINFO_INSTEADOFUPDATE
ON PersonInfo
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @ID INT,@NAME VARCHAR(50)

	SELECT @ID=PersonID, @NAME=PersonName FROM inserted

	INSERT INTO PersonLog
	VALUES(@ID,@NAME,'INSERT',GETDATE())
END
DROP TRIGGER TR_PERSONINFO_INSTEADOFTRIGGER

CREATE  TRIGGER TR_PERSONINFO_INSTEADOFDELETE
ON PersonInfo
INSTEAD OF DELETE
AS
BEGIN
	DECLARE @ID INT,@NAME VARCHAR(50)

	SELECT @ID=PersonID, @NAME=PersonName FROM deleted

	INSERT INTO PersonLog
	VALUES(@ID,@NAME,'INSERT',GETDATE())
END
DROP TRIGGER TR_PERSONINFO_INSTEADOFTRIGGER

--4. Create a trigger that fires on INSERT operation on the PersonInfo table to convert person name into
--uppercase whenever the record is inserted.
CREATE TRIGGER TR_PERSON_UPPERNAME
ON PersonInfo
AFTER INSERT
AS
BEGIN
	DECLARE @ID INT, @NAME VARCHAR(50)
	SELECT @ID=PersonID, @NAME = PersonName from inserted

	UPDATE PersonInfo
	SET @NAME=UPPER(@NAME) FROM inserted
END
DROP TRIGGER TR_PERSON_UPPERNAME

--5. Create trigger that prevent duplicate entries of person name on PersonInfo table.
CREATE TRIGGER TR_PERSON_DUPLICATE
ON PersonInfo
AFTER INSERT
AS
BEGIN
    DECLARE @NAME VARCHAR(50)
    SELECT @NAME = PersonName FROM inserted

    IF NOT EXISTS (SELECT 1 FROM PersonInfo WHERE PersonName = @NAME)
    BEGIN
        INSERT INTO PersonInfo (PersonName)
        VALUES (@NAME)
    END
    ELSE
    BEGIN
        PRINT 'DUPLICATE NAME IS DETETCTED'
    END
END

--6. Create trigger that prevent Age below 18 years.
CREATE TRIGGER TR_AGEBELOW18
ON PersonInfo
AFTER INSERT
AS
BEGIN
    DECLARE @AGE INT
    SELECT @AGE = Age FROM inserted

	SELECT @AGE from PersonInfo
	where @AGE>=18
END
DROP TRIGGER TR_AGEBELOW18

--------------------------------PART-B------------------------------

