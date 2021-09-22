USE AdventureWorks2019
GO

--1.
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product

--2. 
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE ListPrice != 0

--3.
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NULL

--4.
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL

--5
SELECT ProductID, Name, Color, ListPrice
FROM Production.Product
WHERE Color IS NOT NULL
AND ListPrice > 0

--6
SELECT Name + ' - ' + Color AS Name_AND_Color
FROM Production.Product
WHERE color is NOT NULL 

--7
SELECT ('NAME: ' + Name + ' -- ' + ' COLOR: ' + color) AS "Name AND Color"
FROM Production.Product
WHERE color is NOT NULL 

--8 
SELECT Name, ProductID
FROM Production.Product
WHERE ProductID BETWEEN 400 AND 500

--9
SELECT Name, ProductID, color
FROM Production.Product
WHERE color in ('Black', 'Blue')

--10
SELECT Name AS Product
FROM Production.Product
WHERE Name LIKE 'S%'

--11
SELECT Name, ListPrice
FROM Production.Product
ORDER BY Name

--12
SELECT Name, ListPrice
FROM Production.Product
WHERE Name LIKE 'A%' or Name LIKE 'S%'
ORDER BY Name

--13
SELECT Name
FROM Production.Product
WHERE Name LIKE 'SPO[^K]%'
ORDER BY Name

--14
SELECT DISTINCT color
FROM Production.Product
ORDER BY color DESC

--15
SELECT ProductSubcategoryID, Color
FROM Production.Product
Where ProductSubcategoryID IS NOT NULL AND Color IS NOT NULL

--16
SELECT ProductSubCategoryID
	,LEFT([NAME],35) AS [Name]
	,Color, ListPrice
FROM Production.Product
WHERE Color IN ('Red','Black')
	AND ProductSubCategoryID = 1
	AND (ListPrice BETWEEN 1000 AND 2000)
ORDER BY ProductID


