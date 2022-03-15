use Northwind

--1
GO
CREATE VIEW view_product_order_Sukhee
AS
SELECT p.ProductName, SUM(od.Quantity) AS QuantitySum
FROM Products p INNER JOIN [Order Details] od ON p.ProductID=od.ProductID
GROUP BY  p.ProductName

GO
select * from view_product_order_Sukhee


--2
GO
CREATE PROC sp_product_order_quantity_Sukhee
@productID int
AS
BEGIN 
DECLARE @totalQuantities int
	SELECT @totalQuantities = od.Quantity
	FROM [Order Details] od
	WHERE od.ProductID = @productID 
RETURN @totalQuantities
END

-----
DECLARE @num int
EXEC @num = sp_product_order_quantity_Sukhee 1
PRINT @num



--3 
GO
CREATE PROC sp_product_order_city__Sukhee
@productName varchar(50),
@topFiveCities varchar (50) out 
AS
BEGIN 
	SELECT TOP 5  @topFiveCities= c.City 
	FROM Products p INNER JOIN
             [Order Details] od ON p.ProductID = od.ProductID INNER JOIN
             Orders ON od.OrderID = Orders.OrderID INNER JOIN
             Customers c ON Orders.CustomerID = c.CustomerID
	WHERE p.ProductName = @productName 
	GROUP BY c.City
	HAVING SUM(od.Quantity) > 0 
	ORDER BY SUM(od.Quantity) DESC

END

DECLARE 
@product varchar(50),
@city varchar (5)
EXEC @city = sp_product_order_city__Sukhee 'Tofu', @city out
PRINT @city



--SELECT TOP 5 c.City --, SUM(od.Quantity) AS Quantity
--FROM Products p INNER JOIN
--             [Order Details] od ON p.ProductID = od.ProductID INNER JOIN
--             Orders ON od.OrderID = Orders.OrderID INNER JOIN
--             Customers c ON Orders.CustomerID = c.CustomerID
--WHERE p.ProductName = 'Tofu' 
--GROUP BY c.City
--HAVING SUM(od.Quantity) > 0 
--ORDER BY SUM(od.Quantity) DESC



--4
CREATE TABLE city_Sukhee(
Id int PRIMARY KEY,
city varchar(20),
)

CREATE TABLE people_Sukhee(
Id int PRIMARY KEY,
PersonName varchar(30),
city int foreign key references city_Sukhee(Id)
);
------------------------
INSERT INTO city_Sukhee VALUES (1, 'Seattle')
INSERT INTO city_Sukhee VALUES (2, 'Green Bay')

INSERT INTO people_Sukhee VALUES (1, 'Aaron Rodgers', 2)
INSERT INTO people_Sukhee VALUES (2, 'Russell Wilson', 1)
INSERT INTO people_Sukhee VALUES (3, 'Jody Nelson', 2)
---------------------------------
UPDATE city_Sukhee
SET city = 'Madisont'
WHERE Id = 1;

------------------------- 
GO
CREATE VIEW Packers_Sukhee
AS
SELECT PersonName
FROM people_Sukhee
WHERE city = 2; 
GO
-------------------------
select * from Packers_Sukhee
-------------------------
DROP TABLE people_Sukhee;
DROP TABLE city_Sukhee;
DROP VIEW Packers_Sukhee;

--5 Create a stored procedure “sp_birthday_employees_[you_last_name]” that creates a new table “birthday_employees_your_last_name” and fill it with all employees 
--that have a birthday on Feb. (Make a screen shot) drop the table. Employee table should not be affected.

GO
CREATE PROC sp_birthday_employees_Sukhee
AS
BEGIN
CREATE TABLE birthday_employees_Sukhee(
name varchar(30)
)
INSERT INTO birthday_employees_Sukhee SELECT LastName + ' ' + FirstName AS Employee FROM Employees WHERE MONTH(BirthDate) = 2;
END

--EXEC sp_birthday_employees_Sukhee
select * from birthday_employees_Sukhee

--6 
-- Use UNION and see if the number of rows remain the same
