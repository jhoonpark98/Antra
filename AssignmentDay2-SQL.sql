USE AdventureWorks2019
GO

--To check the Table Column Name
SELECT *
FROM Production.Product

--1. Result = 504
SELECT COUNT(*)
FROM Production.Product

--2. Result = 295

SELECT COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL

--3.

SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) AS TheSum
FROM Production.Product
GROUP BY ProductSubcategoryID


--4. Result = 209
SELECT COUNT(ProductID)
FROM Production.Product
WHERE ProductSubcategoryID IS NULL

--5 Result = 335974
SELECT SUM(Quantity)
FROM Production.ProductInventory

--6
SELECT ProductID, SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Quantity < 100
GROUP BY ProductID

--7 
SELECT Shelf, ProductID, SUM(Quantity) as TheSum
FROM Production.ProductInventory
WHERE LocationID = 40 AND Shelf != 'N/A'
GROUP BY Shelf, ProductID
HAVING SUM(Quantity) < 100

--8 Result: 295
SELECT ProductID, AVG(Quantity) as AverageQuantity
FROM Production.ProductInventory
WHERE LocationID = 10
GROUP BY ProductID

--9 
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
GROUP BY ProductID, Shelf

--10 
SELECT ProductID, Shelf, AVG(Quantity) as TheAvg
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY ProductID, Shelf



--11
SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND CLASS IS NOT NULL
GROUP BY Color, Class

--12
SELECT CR.Name As Country, SP.Name as Province
FROM Person.CountryRegion CR INNER JOIN Person.StateProvince SP 
ON CR.CountryRegionCode = SP.CountryRegionCode

--13
SELECT CR.Name As Country, SP.Name as Province
FROM Person.CountryRegion CR INNER JOIN Person.StateProvince SP 
ON CR.CountryRegionCode = SP.CountryRegionCode
WHERE CR.Name = 'Germany' or CR.Name = 'Canada'

-- Using Northwind Database
USE Northwind
GO
--14 
SELECT ProductID 
FROM Orders O INNER JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
WHERE OrderDate >= DATEADD(YEAR,-25,GETDATE())
AND OrderDate <= GETDATE();

--15
SELECT TOP 5 ShipPostalCode, COUNT(*) AS COUNT
FROM Orders ODE
WHERE ShipPostalCode IS NOT NULL
GROUP BY ShipPostalCode
ORDER BY COUNT(*) DESC

--16
SELECT TOP 5 ShipPostalCode, COUNT(*) AS COUNT
FROM Orders ODE
WHERE ShipPostalCode IS NOT NULL
AND OrderDate >= '2001'
GROUP BY ShipPostalCode
ORDER BY COUNT(*) DESC


--17
SELECT City, COUNT(CustomerID) AS #ofCustomers 
FROM Customers
GROUP BY City

--18
SELECT City, COUNT(CustomerID) AS #ofCustomers 
FROM Customers
GROUP BY City
HAVING COUNT(CustomerID) > 2

--19
SELECT DISTINCT(C.ContactName)
FROM Orders O INNER JOIN Customers C 
ON O.CustomerID = C.CustomerID
WHERE OrderDate > '1998-01-01'

--20
SELECT C.ContactName, OrderDate
FROM Orders O INNER JOIN Customers C
ON O.CustomerID = C.CustomerID
ORDER BY OrderDate DESC

--21
SELECT C.ContactName, COUNT(OrderID) as #ofProductsBought
FROM Orders O INNER JOIN Customers C
ON O.CustomerID = C.CustomerID
GROUP BY C.ContactName

--22
SELECT C.ContactName, COUNT(OrderID) as #ofProductsBought
FROM Orders O INNER JOIN Customers C
ON O.CustomerID = C.CustomerID
GROUP BY C.ContactName
HAVING COUNT(OrderID) > 100

--23
SELECT Suppliers.CompanyName [Supplier Company Name], Shippers.CompanyName[Shippers Company Name]
FROM Suppliers CROSS JOIN Shippers

--24
SELECT OrderDate, ProductName
FROM Orders O INNER JOIN [Order Details] OD 
ON O.OrderID = OD.OrderID INNER JOIN Products P 
ON P.ProductID = OD.ProductID
ORDER BY OrderDate

--25
SELECT E1.LastName, E1.FirstName, E2.LastName, E1.Title
FROM Employees E1 INNER JOIN Employees E2
ON E1.Title = E2.Title
WHERE E1.LastName != E2.LastName

--26
SELECT E1.LastName, E1.FirstName, E2.LastName as ManagerLastName, E2.FirstName as MangerFirstName
FROM Employees E1 LEFT JOIN Employees E2 
ON E2.EmployeeID = E1.ReportsTo

--27
(SELECT S.City, S.CompanyName AS Name, S.ContactName,'Supplier' TypeName FROM Suppliers S)
UNION ALL 
(SELECT C.City, C.CompanyName AS Name, C.ContactName,'Customer' TypeName FROM Customers C)