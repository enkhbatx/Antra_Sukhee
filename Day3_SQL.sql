use Northwind;
--1 
SELECT DISTINCT(s.City)
FROM Suppliers s INNER JOIN Employees e ON s.City=e.City


--2a
SELECT c.City
FROM Customers c 
WHERE c.city NOT IN 
	( SELECT City
	  FROM Employees)


--2b
SELECT c.City
FROM Customers c LEFT JOIN Employees e ON c.City = e.City 
WHERE e.city IS NULL 


--3
SELECT p.ProductName, SUM(od.Quantity) AS Sum_Qantity
FROM Products p INNER JOIN [Order Details] od ON p.ProductID = od.ProductID -- INNER JOIN Orders ON od.OrderID = Orders.OrderID
GROUP BY p.ProductName;


--4 
SELECT c.City AS CustomerCity, SUM(od.Quantity) Quantity_Sum
FROM Customers c INNER JOIN
             Orders ON c.CustomerID = Orders.CustomerID INNER JOIN
             [Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY c.City;


--5a --> Why do we need to use union? 
SELECT City, COUNT(CustomerID) 
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2;


--5b --> Why do we need to use subquery and how would we use 
SELECT DISTINCT(City)
FROM Customers
WHERE City IN 
	(SELECT City
	 FROM Customers
	 GROUP BY City
	 HAVING COUNT(CustomerID) > 2)


--6
SELECT c.City, COUNT(od.ProductID) AS ProductCount
FROM   Customers c INNER JOIN
             Orders ON c.CustomerID = Orders.CustomerID INNER JOIN
             [Order Details] od ON Orders.OrderID = od.OrderID
GROUP BY c.City
HAVING  COUNT(od.ProductID) >= 2
ORDER BY ProductCount;


--7
SELECT DISTINCT(c.CustomerID), c.ContactName
FROM Customers c INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City != o.ShipCity;


--8 --> How to get top 5 cities that ordered most? 
SELECT TOP 5 Products.ProductName, AVG(od.UnitPrice) as Average_Price--, Customers.City
FROM Products INNER JOIN
             [Order Details] od ON Products.ProductID = od.ProductID INNER JOIN
             Orders ON od.OrderID = Orders.OrderID INNER JOIN
             Customers ON Orders.CustomerID = Customers.CustomerID
GROUP BY Products.ProductName --, Customers.City
ORDER BY Average_Price DESC


--9a
SELECT Employees.City
FROM Employees
WHERE Employees.City IN
	(SELECT Customers.City
	FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
	WHERE OrderID IS NULL)  
	-- Confirm that this is how to query - (never ordered) 


--9b 
SELECT Employees.City
FROM Employees LEFT JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID LEFT JOIN Customers ON Customers.CustomerID = Orders.CustomerID
WHERE OrderID IS NULL


--10
SELECT Employees.City, MAX(od.ProductID) AS Most_Products
FROM Employees INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID INNER JOIN [Order Details] od ON Orders.OrderID = od.OrderID
WHERE Employees.City IN 
	(
	SELECT TOP 1 c.City AS CustomerCity
	FROM Customers c INNER JOIN
             Orders ON c.CustomerID = Orders.CustomerID INNER JOIN
             [Order Details] od ON Orders.OrderID = od.OrderID
	GROUP BY c.City
	HAVING SUM(od.Quantity) > 0
	ORDER BY SUM(od.Quantity) DESC
	)
GROUP BY Employees.City 

--11
DISTINCT, UNION, GROUP BY,
