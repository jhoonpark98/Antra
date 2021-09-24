Use Northwind
GO 

--1
SELECT DISTINCT(City) 
FROM Customers 
WHERE City in(
SELECT City 
FROM Employees)

--2a
SELECT DISTINCT City  
FROM Customers 
WHERE City NOT IN
(SELECT DISTINCT City
FROM employees 
WHERE city IS NOT NULL)

--2b
SELECT DISTINCT City  
FROM Customers 
EXCEPT
SELECT DISTINCT City
FROM Employees 

--3
SELECT ProductID, SUM(Quantity) AS #TotalQuantity
FROM [Order Details]
GROUP BY ProductID

--4
SELECT City,SUM(Quantity) as #TotalQuantity
FROM Orders o 
JOIN [Order Details] od ON o.OrderID=od.OrderID
JOIN customers c ON c.CustomerID=o.CustomerID
GROUP BY City

--5a
SELECT City 
FROM Customers
EXCEPT
SELECT City 
FROM Customers
GROUP BY City
HAVING COUNT(*)=1
UNION 
SELECT City
FROM Customers
GROUP BY City
HAVING COUNT(*)=0

--5b
SELECT City
FROM Customers 
GROUP BY City
HAVING COUNT(CustomerID) >= 2;

--6
SELECT C.City, COUNT(Distinct OD.ProductID) KindsOfProduct 
FROM [Order Details] OD 
LEFT JOIN Orders O ON OD.OrderID = O.OrderID
LEFT JOIN Customers C on C.CustomerID = O.CustomerID
GROUP BY C.City 
HAVING COUNT(Distinct OD.ProductID) >=2;

--7
SELECT CustomerID 
FROM Customers 
WHERE CustomerID 
IN
(SELECT C.CustomerID FROM [Order Details] OD 
LEFT JOIN Orders O ON OD.OrderID = O.OrderID 
LEFT JOIN Customers C ON C.CustomerID = O.CustomerID
WHERE C.City!=O.ShipCity)

--8
SELECT TOP 5 ProductID, AVG(UnitPrice) as AvgPrice,
(SELECT TOP 1 City 
FROM Customers c 
JOIN Orders o ON o.CustomerID=c.CustomerID 
JOIN [Order Details] od2 ON od2.OrderID=o.OrderID
WHERE od2.ProductID=od1.ProductID 
GROUP BY City
ORDER BY SUM(Quantity) DESC) AS City
FROM [Order Details] od1
GROUP BY ProductID 
ORDER BY SUM(Quantity) DESC

--9a
SELECT DISTINCT City 
FROM Employees
WHERE City
NOT IN 
(SELECT ShipCity 
FROM Orders
WHERE ShipCity IS NOT NULL)

--9b
SELECT DISTINCT City 
FROM Employees
WHERE City IS NOT NULL
EXCEPT 
(SELECT ShipCity
FROM Orders
WHERE ShipCity IS NOT NULL)


--10

-- city from where the employee sold most orders 
SELECT TOP 1 City
FROM Orders O
LEFT JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY City
ORDER BY COUNT(O.OrderID) DESC

--the city of most total quantity of products ordered from
SELECT TOP 1 City 
FROM Orders O
LEFT JOIN Customers C ON O.CustomerID = C.CustomerID
LEFT JOIN [Order Details] OD ON O.OrderID = OD.OrderID
GROUP BY City
ORDER BY COUNT(OD.Quantity) DESC 


/*11*/
--Use GROUP BY and COUNT(*), 
--Delete or remove the rows using subquery if COUNT(*)>1 

--12
SELECT empid FROM Employee 
EXCEPT
SELECT mgrid FROM Employee

--13
SELECT deptid 
FROM employee 
GROUP BY deptid
HAVING COUNT(*) = 
(SELECT TOP 1 COUNT(*) 
FROM employee 
GROUP BY deptid
ORDER BY count(*) DESC)

--14
SELECT TOP 3 deptname,empid,salary 
FROM employee e 
JOIN dep d 
ON e.deptid=d.deptid
ORDER BY salary,deptname,empid DESC