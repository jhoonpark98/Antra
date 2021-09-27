Use Northwind
GO 

--- Question 1,2,4,7,8 can be skipped

--4
CREATE VIEW view_product_order_Park
AS 
SELECT DISTINCT ProductName, UnitsOnOrder
FROM Products

SELECT * FROM view_product_order_Park

--5
CREATE PROCEDURE sp_product_order_quantity_Park 
	@ProductID int, 
	@TotalOrder int OUT
AS
BEGIN
	SELECT @TotalOrder = SUM(Quantity)
	FROM [Order Details] OD JOIN Products
	ON P.ProductID = OD.ProductID
	WHERE P.ProductID = @ProductID
END

--6
CREATE PROCEDURE sp_product_order_city_Park
    @ProductName NVARCHAR(50)
AS
BEGIN
	SELECT TOP 5 ShipCity, Sum(Quantity)
	FROM [Order Details] OD 
	JOIN Products P ON P.ProductID = OD.ProductID
	JOIN Orders O on O.OrderID = OD.OrderID
	WHERE ProductName = @ProductName
	GROUP BY ProductName, ShipCity
	ORDER BY SUM(Quantity) DESC
END

--9
CREATE TABLE city_Park (Id INT NOT NULL, City VARCHAR(20) NOT NULL)
INSERT INTO city_Park VALUES (1, 'Seattle')
INSERT INTO city_Park VALUES (2, 'Green Bay')

CREATE TABLE people_Park(Id INT NOT NULl, NAME VARCHAR(20) NOT NULL, 
City int not null)
INSERT INTO people_Park VALUES (1, 'Aaron Rodgers', 2)
INSERT INTO people_Park VALUES (2, 'Russell Wilson', 1)
INSERT INTO people_Park VALUES (3, 'Jody Nelson', 2)

DELETE FROM people_Park WHERE City = 'Seattle';
INSERT INTO city_Park VALUES (1,'Madison');

CREATE VIEW Packers_TommyPark AS
SELECT Name from people_Park where City = 'Green Bay';

Drop table people_Park,city_Park

--10
CREATE PROCEDURE sp_birthday_employees_Park
AS
BEGIN
	SELECT *
	INTO #EmployeeTable
	FROM Employees
	WHERE DATEPART(MM,BirthDate) = 02
	SELECT * FROM #EmployeeTable
END

--11

CREATE PROCEDURE sp_Park_1
AS
BEGIN
	SELECT City
	FROM Customers
	GROUP BY City
	HAVING COUNT(*) > 2
	INTERSECT
	SELECT City
	FROM Customers C
	JOIN Orders O ON O.CustomerID = C.CustomerID
	JOIN [Order Details] OD ON O.OrderID = OD.OrderID
	GROUP BY OD.ProductID, C.CustomerId, City
	HAVING COUNT(*) BETWEEN 0 AND 1
END
	

--With subquery
CREATE PROCEDURE sp_Park_2
AS
BEGIN
	SELECT City
	FROM Customers
	WHERE CITY
	IN
	(SELECT City
	FROM Customers C
	JOIN Orders O ON O.CustomerID = C.CustomerID
	JOIN [Order Details] OD ON O.OrderID = OD.OrderID
	GROUP BY OD.ProductID, C.CustomerID, City
	HAVING COUNT(*) 
	BETWEEN 0 AND 1)
	GROUP BY City
	HAVING COUNT(*)>2
END

--Without Subquery

CREATE PROCEDURE sp_Park_2
AS
BEGIN
	SELECT C.City
	FROM Customers C
	LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
	GROUP BY C.City, C.CustomerID, COUNT(*)
	HAVING COUNT(*) <2
END

--12 How do you make sure two tables have the same data?

SELECT * FROM Customers
EXCEPT
SELECT * FROM Customers

--14
SELECT FirstName + ' ' + LastName 
FROM Customer 
WHERE MiddleName IS NULL 
UNION 
SELECT FirstName + ' ' + LastName + ' '+ middelName+'.' 
FROM Customer
WHERE MiddleName IS NOT NULL

--15
SELECT TOP 1 Marks 
FROM StudentMarkTable 
WHERE Sex = 'F'
ORDER BY Marks DESC

--16
SELECT * 
FROM StudentMarkTable
ORDER BY Sex,Marks DESC

