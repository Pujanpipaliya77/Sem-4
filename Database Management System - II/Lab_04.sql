USE CSE_4B_490;

-- Create Department Table
CREATE TABLE Department (
 DepartmentID INT PRIMARY KEY,
 DepartmentName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Designation Table
CREATE TABLE Designation (
 DesignationID INT PRIMARY KEY,
 DesignationName VARCHAR(100) NOT NULL UNIQUE
);

-- Create Person Table
CREATE TABLE Person (
 PersonID INT PRIMARY KEY IDENTITY(101,1),
 FirstName VARCHAR(100) NOT NULL,
 LastName VARCHAR(100) NOT NULL,
 Salary DECIMAL(8, 2) NOT NULL,
 JoiningDate DATETIME NOT NULL,
 DepartmentID INT NULL,
 DesignationID INT NULL,
 FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
 FOREIGN KEY (DesignationID) REFERENCES Designation(DesignationID)
)

create or alter procedure pr_person_insert
	@FirstName VARCHAR(100),
	@LastName VARCHAR(100),
	@Salary DECIMAL(8, 2),
	@JoiningDate DATETIME,
	@DepartmentID INT,
	@DesignationID INT

	as 
	begin 
	insert into Person
	values(
	@FirstName,
	@LastName,
	@Salary,
	@JoiningDate,
	@DepartmentID,
	@DesignationID
	)
	end
	exec pr_person_insert Rahul,Anshu,56000,'1990-01-01',1,12; 
	exec pr_person_insert Hardik,Hinsu,18000,'1990-09-25',2,11;
	exec pr_person_insert Bhavin,Kamani,25000,'1991-05-14',null,11;
	exec pr_person_insert Bhoomi,Patel,39000,'2014-02-20',1,13;
	exec pr_person_insert Rohit,Rajgor,17000,'1990-07-23',2,15;
	exec pr_person_insert Priya,Mehta,25000,'1990-10-18',2,null;
	exec pr_person_insert Neha,Trivedi,18000,'2014-02-20',3,15;


--1. Write a function to print "hello world".--
create or alter function FN_first()
returns varchar(50)
as
begin
	return ('hello world');
end

select dbo.FN_first();


--2. Write a function which returns addition of two numbers.
create or alter function FN_add(@a int, @b int)
returns int
as 
Begin
	declare @ans int
	set @ans = @a + @b;
	return @ans
end

select dbo.FN_add(5, 3)


--3. Write a function to check whether the given number is ODD or EVEN.--
create or alter function FN_check(@a int)
returns varchar(50)
as 
Begin
	declare @ans varchar(50)
	if @a%2=0
		set @ans = 'even'
	else
		set @ans = 'odd'
	return @ans
end

select dbo.FN_check(9)

--4. Write a function which returns a table with details of a person whose first name starts with B--.
create or alter function FN_find()
returns table
as 
return(select * from Person where FirstName like 'B%');

select * from dbo.FN_find();


--5. Write a function which returns a table with unique first names from the person table.--
create or alter function FN_Unique()
returns table
as 
return(select distinct FirstName from Person);


--6. Write a function to print number from 1 to N. (Using while loop)--
create or alter Function FN_Number(@no int)
returns int
as Begin
	declare @i int, @ans varchar(50)
	set @i = 1
	set @ans = '_'
		while @i<=@no
			begin
				set @ans = @ans + CAST(@i as varchar) + '_'
			end
		return @ans
	end

select dbo.FN_number(9)

--7. Write a function to find the factorial of a given integer.--
create or alter function FN_Fac(@n int)
returns int
as
Begin
	declare @ans int;
	set @ans = 1;
	while @n>@ans
		begin 
			set @ans = @ans * @n;
			set @n = @n + 1;
		end
	return @ans;
end

select dbo.FN_Fac(9)


