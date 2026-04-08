
--Create the Customers table
CREATE TABLE Customers (
 Customer_id INT PRIMARY KEY,
 Customer_Name VARCHAR(250) NOT NULL,
 Email VARCHAR(50) UNIQUE
);

-- Create the Orders table
CREATE TABLE Orders (
 Order_id INT PRIMARY KEY,
 Customer_id INT,
 Order_date DATE NOT NULL,
 FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id)
);

---------------Part – A---------

--1. Handle Divide by Zero Error and Print message like: Error occurs that is Divide by zero error.
BEGIN TRY
	DECLARE @NUM1 INT=10, @NUM2 INT=0, @ANS INT
	SET @ANS = @NUM1/@NUM2
END TRY
BEGIN CATCH
	PRINT 'Error occurs that is Divide by zero error'
END CATCH


--2. Try to convert string to integer and handle the error using try…catch block.
BEGIN TRY
	DECLARE @STR VARCHAR(10) ='abc', @num int
	SET @num = CAST(@STR AS int)
END TRY
BEGIN CATCH
	PRINT 'Unable to convert string into int'
END CATCH


--3. Create a procedure that prints the sum of two numbers: take both numbers as integer & handle
--exception with all error functions if any one enters string value in numbers otherwise print result.
CREATE OR ALTER PROCEDURE CONVERT_EXCE_SUM
@A VARCHAR(50), @B VARCHAR(50)
AS BEGIN

	BEGIN TRY
	DECLARE @INT1 INT, @INT2 INT
		SET @INT1 = CAST(@A AS INT);
		SET @INT2 = CAST(@B AS INT);
		PRINT CAST((@INT1 + @INT2) AS VARCHAR(50))
	END TRY

	BEGIN CATCH
		PRINT 'Please enter numeric values..'
	END CATCH
END

EXEC CONVERT_EXCE_SUM @A = ABC, @B = ABC 
	


--4. Handle a Primary Key Violation while inserting data into customers table and print the error details
--such as the error message, error number, severity, and state.
BEGIN TRY
	INSERT INTO Customers (Customer_id, Customer_Name) VALUES (1, '');
END TRY 
BEGIN CATCH
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Number' + CAST(ERROR_NUMBER() AS VARCHAR);
	PRINT 'Severity:' + CAST(ERROR_SEVERITY() AS VARCHAR);
	PRINT 'State:' + CAST(ERROR_STATE() AS VARCHAR);
END CATCH

--5. Throw custom exception using stored procedure which accepts Customer_id as input & that throws
--Error like no Customer_id is available in database.
CREATE OR ALTER PROCEDURE CHECKCUSTOMER
	@Customer_id INT
AS
BEGIN
	IF NOT EXISTS (SELECT 1 FROM Customers WHERE Customer_id = @Customer_id)

	BEGIN
		THROW 50002, 'No Customer ID available in database', 1;
	END

	ELSE
	BEGIN
		PRINT 'Customer ID is Exists'
	END
END

----------[PART-B]-------------

--6. Handle a Foreign Key Violation while inserting data into Orders table and print appropriate error message.
BEGIN TRY
	INSERT INTO Orders(Order_date, Order_id) VALUES ('',1);
END TRY 
BEGIN CATCH
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Number' + CAST(ERROR_NUMBER() AS VARCHAR);
	PRINT 'Severity:' + CAST(ERROR_SEVERITY() AS VARCHAR);
	PRINT 'State:' + CAST(ERROR_STATE() AS VARCHAR);
END CATCH


--7. Throw custom exception that throws error if the data is invalid.
CREATE OR ALTER PROCEDURE PR_CUSTOMERORDER
	@Order_id INT
AS
BEGIN
	IF @Order_id<0
	BEGIN
		THROW 50002, 'Order Can Not be negetive', 1;
	END

	ELSE
	BEGIN
		PRINT 'Customer ID is Exists'
	END
END

EXEC PR_CUSTOMERORDER -1


--8. Create a Procedure to Update Customer’s Email with Error HandlingCREATE OR ALTER PROCEDURE PR_EMAIL
	@Email VARCHAR(50)
AS
BEGIN
	IF @Email NOT LIKE '%_@__%.__%'

	BEGIN
		THROW 50002, 'Email is not valid', 1;
	END

	ELSE
	BEGIN
		PRINT 'Email is exists'
	END
END

EXEC PR_EMAIL 'KARGA@ALIHOAHIC'