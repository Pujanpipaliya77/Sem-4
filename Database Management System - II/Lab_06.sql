USE CSE_4B_490;

-- Create the Products table
CREATE TABLE Products (
 Product_id INT PRIMARY KEY,
 Product_Name VARCHAR(250) NOT NULL,
 Price DECIMAL(10, 2) NOT NULL
);

-- Insert data into the Products table
INSERT INTO Products (Product_id, Product_Name, Price) VALUES
(1, 'Smartphone', 35000),
(2, 'Laptop', 65000),
(3, 'Headphones', 5500),
(4, 'Television', 85000),
(5, 'Gaming Console', 32000);

-----------PART-A-----------

--1. Create a cursor Product_Cursor to fetch all the rows from a products table.

DECLARE Product_Cursor CURSOR FOR
SELECT * FROM Products 

OPEN Product_Cursor;
DECLARE @Productid INT,@ProductName varchar(50),@Price int;
FETCH NEXT FROM Product_Cursor INTO  @Productid, @ProductName, @Price;

WHILE @@FETCH_STATUS=0
BEGIN
	PRINT 'Product_ID: ' + CAST(@Productid AS VARCHAR(10)) + ', Product_Name: ' + @ProductName + ', Price: ' + CAST(@Price AS VARCHAR(10));

    FETCH NEXT FROM Product_Cursor INTO @Productid, @ProductName, @Price;
END

CLOSE Product_Cursor;
DEALLOCATE Product_Cursor;

--2. Create a cursor Product_Cursor_Fetch to fetch the records in form of ProductID_ProductName.(Example: 1_Smartphone)
DECLARE @ProductID_ProductName VARCHAR(250);

DECLARE Product_Cursor_Fetch CURSOR FOR
(
    SELECT CAST(Product_id AS VARCHAR(10)) + '_' + Product_Name AS ProductID_ProductName
    FROM Products
);

OPEN Product_Cursor_Fetch;

FETCH NEXT FROM Product_Cursor_Fetch INTO @ProductID_ProductName;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'ProductID_ProductName: ' + @ProductID_ProductName;

    FETCH NEXT FROM Product_Cursor_Fetch INTO @ProductID_ProductName;
END

CLOSE Product_Cursor_Fetch;
DEALLOCATE Product_Cursor_Fetch;


--3. Create a Cursor to Find and Display Products Above Price 30,000.

DECLARE @ProductName VARCHAR(255);

DECLARE Product_Cursor_Find CURSOR FOR
SELECT Product_Name FROM Products
WHERE Price > 30000;

OPEN Product_Cursor_Find;

FETCH NEXT FROM Product_Cursor_Find INTO @ProductName;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT 'Product Name: ' + @ProductName;

    FETCH NEXT FROM Product_Cursor_Find INTO @ProductName;
END

CLOSE Product_Cursor_Find;
DEALLOCATE Product_Cursor_Find;

--4. Create a cursor Product_CursorDelete that deletes all the data from the Products table.

DECLARE @ProductID INT;

DECLARE Product_CursorDelete CURSOR FOR
SELECT Product_id FROM Products;

OPEN Product_CursorDelete;

FETCH NEXT FROM Product_CursorDelete INTO @ProductID;

WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM Products WHERE Product_id = @ProductID;

    FETCH NEXT FROM Product_CursorDelete INTO @ProductID;
END

CLOSE Product_CursorDelete;
DEALLOCATE Product_CursorDelete;

-----------PART-B-----------

--5. Create a cursor Product_CursorUpdate that retrieves all the data from the products table and increases the price by 10%.
DECLARE @Product_ID INT, @Product_Name VARCHAR(100), @Price DECIMAL(10,2);

DECLARE Product_CursorUpdate CURSOR FOR
SELECT Product_id, Product_Name, Price
FROM products;

OPEN Product_CursorUpdate;

FETCH NEXT FROM Product_CursorUpdate INTO @Product_ID, @Product_Name, @Price;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE products
    SET Price = @Price * 1.10
    WHERE Product_id = @Product_ID;

    FETCH NEXT FROM Product_CursorUpdate INTO @Product_ID, @Product_Name, @Price;
END;

CLOSE Product_CursorUpdate;
DEALLOCATE Product_CursorUpdate;
 
--6. Create a Cursor to Rounds the price of each product to the nearest whole number.

DECLARE @ProductID INT, @ProductName VARCHAR(100), @Price DECIMAL(10,2), @RoundedPrice INT;

DECLARE Product_CursorRound CURSOR FOR
SELECT Product_id, Product_Name, Price FROM products;

OPEN Product_CursorRound;
FETCH NEXT FROM Product_CursorRound INTO @ProductID, @ProductName, @Price;

WHILE @@FETCH_STATUS = 0
BEGIN
    SET @RoundedPrice = ROUND(@Price, 0);

    UPDATE products
    SET Price = @RoundedPrice
    WHERE Product_id = @ProductID;

    FETCH NEXT FROM Product_CursorRound INTO @ProductID, @ProductName, @Price;
END;

CLOSE Product_CursorRound;
DEALLOCATE Product_CursorRound;
