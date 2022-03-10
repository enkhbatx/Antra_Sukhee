use AdventureWorks2019;

--1 
SELECT COUNT(ProductID) AS Product_Count
FROM Production.Product;

--2 
SELECT COUNT(ProductID)
FROM Production.Product 
WHERE ProductSubcategoryID IS NOT NULL 


--3 
SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;

--4
SELECT COUNT(ProductID)
FROM Production.Product 
WHERE ProductSubcategoryID IS NULL 

--5
SELECT SUM(Quantity) as InventorySum 
FROM Production.ProductInventory;

--6
SELECT ProductID, SUM(Quantity) as TheSum 
FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP BY ProductID
HAVING SUM(Quantity) < 100 ;

--7
SELECT Shelf, ProductID, SUM(Quantity) as TheSum 
FROM Production.ProductInventory
WHERE LocationID = 40 
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100;

--8 
SELECT ProductID, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY ProductID;


-- 9
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf;

--10
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf;

--11
SELECT Color, Class, COUNT(ProductID) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class;


------JOINS
--12 
SELECT c.Name as Country, p.Name as Province
FROM Person.CountryRegion c INNER JOIN Person.StateProvince p ON c.CountryRegionCode=p.CountryRegionCode


--13
SELECT c.Name as Country, p.Name as Province
FROM Person.CountryRegion c INNER JOIN Person.StateProvince p ON c.CountryRegionCode=p.CountryRegionCode
WHERE c.Name IN ('Germany', 'Canada');


-------------------Northwnd Databse ---------------------
use Northwind

--14 
SELECT p.ProductName, o.OrderDate
FROM Products p INNER JOIN [Order Details] od ON p.ProductID=od.ProductID INNER JOIN Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '1997-03-10' AND '2022-3-10'
order by OrderDate ;


--15 
SELECT TOP 5 p.ProductName, SUM(od.Quantity) as QuantSum
FROM Products p INNER JOIN [Order Details] od ON p.ProductID=od.ProductID
GROUP BY p.ProductName
ORDER BY QuantSum DESC;

----16 
SELECT TOP 5 p.ProductName, SUM(od.Quantity) as QuantSum
FROM Products p INNER JOIN [Order Details] od ON p.ProductID=od.ProductID INNER JOIN Orders o ON od.OrderID = o.OrderID 
WHERE o.OrderDate > '1997-03-10' 
GROUP BY p.ProductName
ORDER BY QuantSum DESC;

--17 
SELECT City, COUNT(CustomerID) AS CustCount
FROM Customers
GROUP BY City;

--18
SELECT City, COUNT(CustomerID) AS CustCount
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2;


--19
SELECT DISTINCT(ContactName)
FROM Customers c INNER JOIN Orders o ON c.CustomerID=o.CustomerID
WHERE o.OrderDate > '1998-01-01';

--20 
SELECT ContactName, o.OrderDate
FROM Customers c INNER JOIN Orders o ON c.CustomerID=o.CustomerID
WHERE o.OrderDate < '2022-03-10'
ORDER BY o.OrderDate DESC;

--21
SELECT c.ContactName, COUNT(od.Quantity) AS 'ProductCount'
FROM Customers c INNER JOIN Orders o ON c.CustomerID=o.CustomerID INNER JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY c.ContactName
ORDER BY 'ProductCount' DESC;

--22
SELECT c.CustomerID, COUNT(od.Quantity) AS 'ProductCount'
FROM Customers c INNER JOIN Orders o ON c.CustomerID=o.CustomerID INNER JOIN [Order Details] od ON o.OrderID=od.OrderID
GROUP BY c.CustomerID
HAVING COUNT(od.Quantity) >100
ORDER BY 'ProductCount';

--23 
SELECT DISTINCT Suppliers.CompanyName AS [Supplier Company Name], Shippers.CompanyName AS [Shipping Company Name]
FROM   Suppliers INNER JOIN
             Products ON Suppliers.SupplierID = Products.SupplierID INNER JOIN
             [Order Details] ON Products.ProductID = [Order Details].ProductID INNER JOIN
             Orders ON [Order Details].OrderID = Orders.OrderID INNER JOIN
             Shippers ON Orders.ShipVia = Shippers.ShipperID
ORDER BY 1;


--24 
SELECT Orders.OrderDate, Products.ProductName
FROM   Products INNER JOIN
             [Order Details] ON Products.ProductID = [Order Details].ProductID INNER JOIN
             Orders ON [Order Details].OrderID = Orders.OrderID;

--25 ------------
SELECT e.FirstName, e2.FirstName, e.Title
FROM Employees e INNER JOIN Employees e2 ON e.EmployeeID != e2.EmployeeID
WHERE e2.Title = e.Title;

--26 
SELECT COUNT(e.EmployeeID) AS Employee_Count, m.FirstName + ' ' + m.LastName AS Manager
FROM Employees e INNER JOIN Employees m ON e.ReportsTo = m.EmployeeID
GROUP BY m.FirstName + ' ' + m.LastName
HAVING COUNT(e.EmployeeID) > 2;

--27  ---------------------------------------------
SELECT c.City, c.ContactName AS 'Name', s.ContactName AS [Contact Name]
FROM Suppliers s, Customers c
