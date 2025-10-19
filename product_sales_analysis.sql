/*Show the first 10 customers from the Customers table*/
SELECT * 
FROM Customers
LIMIT 10;
/*Display the ProductName and UnitPrice from the Products table.*/
SELECT ProductName, Unit AS UnitPrice 
FROM Products;
/*List all categories from the Categories table.*/
SELECT * 
FROM Categories;
/*Show all employees whose LastName starts with “S”.*/
SELECT * 
FROM Employees
WHERE LastName LIKE 'S%';
/*Display all products that cost more than 20.*/
SELECT * 
FROM Products
WHERE Price > 20;
/*List all suppliers from a specific Country (e.g., 'USA').*/
SELECT * 
FROM Suppliers
WHERE Country = 'USA';
/*Find all orders placed after ‘1997-01-01’.*/
SELECT * 
FROM Orders
WHERE OrderDate > '1997-01-01';
/*Show all shippers whose CompanyName contains “Speedy”.*/
SELECT * 
FROM Shippers
WHERE ShipperName LIKE 'Speedy%';

/*Show the total number of customers from each country.*/
SELECT Country, Count(*) as TotalCount 
FROM Customers
GROUP BY Country
ORDER BY TotalCount DESC;
/*Find the average price per unit of all products.*/
SELECT ROUND(AVG(Price), 2) AS AverageUnitPrice
FROM Products;
/*List the total number of orders handled by each employee.*/
SELECT 
e.EmployeeID,
e.FirstName,
e.LastName,
COUNT(o.OrderID) AS TotalOrders
FROM Orders o
JOIN Employees e
On e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalOrders DESC;
/*Display the number of products supplied by each supplier.*/
SELECT 
s.SupplierName,
s.ContactName,
COUNT(p.ProductName) AS NumberofProducts
FROM Suppliers s
JOIN Products p
ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierName, s.ContactName
ORDER BY NumberofProducts DESC;


/*Find the most expensive product in the Products table.*/
SELECT ProductID, ProductName, Price
FROM Products
ORDER BY Price DESC
LIMIT 1;
/*Show the category with the highest number of products.*/
SELECT 
c.CategoryName,
c.Description,
COUNT(p.ProductName) AS NumberOfProducts
FROM Categories c
JOIN Products p
ON p.CategoryID = c. CategoryID
GROUP BY c.CategoryName, c.Description
ORDER BY NumberOfProducts DESC
LIMIT 1;
/*Find the total quantity ordered per product from the OrderDetails table.*/
SELECT 
p.ProductName,
SUM(o.Quantity) AS TotalQuantity
FROM Products p
JOIN OrderDetails o
ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC;
/*Calculate the total sales per order.*/
SELECT 
o.OrderID,
SUM(p.Price * o.Quantity) AS TotalSales
FROM Products p
JOIN OrderDetails o
ON o.ProductID = p.ProductID
GROUP BY o.OrderID
ORDER BY TotalSales DESC;
/*List suppliers who provide more than 4 products.*/
SELECT 
s.SupplierName,
COUNT(p.ProductName) AS TotalProducts
FROM Products p
JOIN Suppliers s
ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierName
HAVING COUNT(p.ProductName) > 4
ORDER BY TotalProducts DESC;
/*Show the top 5 customers with the highest number of orders.*/
SELECT 
c.CustomerID,
c.CustomerName,
c.ContactName,
COUNT(o.OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.CustomerName, c.ContactName
ORDER BY NumberOfOrders DESC
LIMIT 5;
/*List all orders with the customer’s name and order date.*/
SELECT 
c.CustomerName, o.OrderID, o.OrderDate
FROM Orders o
JOIN Customers c
ON c.CustomerID = o.CustomerID
ORDER BY o.OrderDate; 
/*Show all products along with their category names.*/
SELECT p.ProductName, c.CategoryName 
FROM Products p
JOIN Categories c
ON c.CategoryID = p.CategoryID;
/*Display each order along with the employee who processed it.*/
SELECT e.EmployeeID, e.FirstName, e.LastName, o.OrderID 
FROM Orders o
JOIN Employees e
ON e.EmployeeID = o.EmployeeID
ORDER BY e.EmployeeID;
/*List all products, their supplier names, and their category names.*/
SELECT p.ProductID, p.ProductName, s.SupplierName, c.CategoryName 
FROM Categories c
JOIN Products p
ON p.CategoryID = c.CategoryID
JOIN Suppliers s
ON s.SupplierID = p.SupplierID;
/*Show the total quantity ordered per product name.*/
SELECT p.ProductName, SUM(o.Quantity) AS TotalQuantity 
FROM Products p
JOIN OrderDetails o
ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC;
/*Find all customers who have never placed an order.*/
SELECT c.CustomerID, c.ContactName, o.OrderID 
FROM Customers c 
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;
/*Find the total sales made by each employee.*/
SELECT e.EmployeeID, e.FirstName, e.LastName, SUM(od.Quantity * p.Price) AS TotalSales 
FROM Employees e
JOIN Orders o
On e.EmployeeID = o.EmployeeID
JOIN OrderDetails od
ON od.OrderID = o.OrderID
JOIN Products p
ON p.ProductID = od.ProductID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;
/*Show each order’s shipper name and the customer who placed it.*/
SELECT o.OrderID, c.CustomerID, c.CustomerName, s.ShipperName 
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerID
JOIN Shippers s
ON o.ShipperID = s.ShipperID;
/*Display top 3 selling products by total sales amount.*/
SELECT p.ProductName, SUM(o.Quantity * p.Price) AS TotalSales 
FROM OrderDetails o
JOIN Products p
ON o.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalSales DESC
LIMIT 3;
/*List all suppliers and the number of categories of products they supply.*/
SELECT s.SupplierName, COUNT(DISTINCT p.CategoryID) AS NumberOfCategories 
FROM Suppliers s
JOIN Products p
ON s.SupplierID = p.SupplierID
GROUP BY s.SupplierName
ORDER BY NumberOfCategories DESC;
