USE AdventureWorks2019;

-- SQL Day 1 ASsignment
-- 1 
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product;


--2 
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice != 0;

--3 
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL;

--4
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE NOT Color IS NULL;

--5
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE NOT Color IS NULL AND ListPrice > 0;


--6
SELECT Name + ' ' + Color AS Name_Color
FROM Production.Product
WHERE NOT Color IS NULL;

--7
SELECT 'NAME: ' + Name +' -- COLOR: ' + Color
FROM Production.Product
WHERE Name LIKE '%C%' AND Name IS NOT NULL AND Color IS NOT NULL; 



--8
SELECT ProductID, Name
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500;


--9 
SELECT ProductID, Name, Color
FROM Production.Product
WHERE Color IN ('Black', 'Blue')


--10
SELECT Name
FROM Production.Product
WHERE Name LIKE 'S%';


--11
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'S%'
ORDER BY 1;


--12  The products name should start with either 'A' or 'S'
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE '[A, S]%'  
ORDER BY 1;


--13 Name that begins with the letters SPO, but is then not 
--followed by the letter K. After this zero or more letters can exists
SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'  
ORDER BY 1;

--14
SELECT DISTINCT Color 
FROM Production.Product
ORDER BY 1;


--15
SELECT DISTINCT ProductSubcategoryID, Color
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL AND Color IS NOT NULL;
