CREATE DATABASE ORG;

USE ORG;

CREATE TABLE Customers (
CustomerID INT PRIMARY KEY,
Name VARCHAR(255),
Email VARCHAR(255),
JoinDate DATE
);

CREATE TABLE Products (
ProductID INT PRIMARY KEY,
P_Name VARCHAR(255),
Category VARCHAR(255),
Price DECIMAL(10, 2)
);

CREATE TABLE Orders (
OrderId INT PRIMARY KEY,
CustomerId INT,
OrderDate DATE,
TotalAmount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
OrderDetailID INT PRIMARY KEY,
OrderID INT,
ProductID INT,
Quantity INT,
PricePerUnit DECIMAL(10, 2),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Customers (CustomerID, Name, Email, JoinDate) VALUES
(1, 'John Doe', 'johndoe@example.com', '2020-01-10'),
(2, 'Jane Smith', 'janesmith@example.com', '2020-01-15'),
(3, 'Jacob wick', 'jacobwick@example.com', '2018-05-20'),
(4, 'Mandar Mali', 'mandarmali@example.com', '2019-06-29'),
(5, 'Sanjana Chavan', 'sanjanachavan@example.com', '2020-06-01'),
(6, 'Gurmit Singh', 'gurmitsingh@example.com', '2021-01-05'),
(7, 'Dinesh Goyal', 'dineshgoyal@example.com', '2019-05-09'),
(8, 'Neha Kadam', 'nehakadam@example.com', '2022-06-02'),
(9, 'Rinkita Vaidya', 'rinkitavaidya@example.com', '2022-06-02'),
(10, 'Alice Johnson', 'alicejohnson@example.com', '2020-03-05');

INSERT INTO Products (ProductID, P_Name, Category, Price) VALUES
(1, 'Laptop', 'Electronics', 999.99),
(2, 'Smartphone', 'Electronics', 1999.99),
(3, 'Curtains', 'Home Decor', 239.99),
(4, 'Toy Car', 'Toys', 549.99),
(5, 'Tube Light', 'Electronics', 149.99),
(6, 'Soft Toy', 'Toys', 149.99),
(7, 'LED Light', 'Home Decor', 649.99),
(8, 'Wardrobe', 'Furniture', 2049.99),
(9, 'Sofa', 'Furniture', 1259.99),
(10, 'Desk Lamp', 'Home Decor', 29.99);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, '2020-02-15', 1499.98),
(2, 2, '2020-02-17', 499.99),
(3, 3, '2020-02-12', 2499.98),
(4, 4, '2020-03-10', 1099.98),
(5, 5, '2020-04-05', 699.98),
(6, 6, '2020-05-15', 3499.98),
(7, 7, '2020-02-14', 2299.98),
(8, 8, '2020-08-15', 1799.98),
(9, 9, '2020-02-10', 1499.98),
(10, 10, '2020-03-21', 78.99);

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, PricePerUnit) VALUES
(1, 1, 1, 1, 999.99),
(2, 2, 2, 1, 499.99),
(3, 3, 3, 2, 99.99),
(4, 4, 4, 1, 19.99),
(5, 5, 5, 3, 609.99),
(6, 4, 4, 1, 19.99),
(7, 6, 4, 1, 199.99),
(8, 8, 4, 1, 399.99),
(9, 4, 4, 1, 159.99),
(10, 10, 5, 2, 29.99);

1.1. List all customers......
SELECT Name FROM customers;

1.2. Show all products in the 'Electronics' category....
select Category, Name from Products where Category='Electronics'

1.3. Find the total number of orders placed.....
select sum(Quantity) from OrderDetails

1.4. Display the details of the most recent order.
SELECT*FROM Orders ORDER BY OrderDate DESC;

2.1. List all products along with the names of the customers who ordered them....
SELECT Customers.Name, Orders.OrderID,
OrderDetails.ProductID, Products.P_Name 
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
ORDER BY Customers.Name;

2.2. Show orders that include more than one product.......
SELECT Customers.Name, Orders.OrderID,
OrderDetails.ProductID, OrderDetails.Quantity, Products.P_Name 
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
where OrderDetails.Quantity > 1
ORDER BY Customers.Name;

2.3. Find the total sales amount for each customer......
SELECT Customers.Name, Products.P_Name, OrderDetails.Quantity, OrderDetails.PricePerUnit,(Quantity*PricePerUnit) as Total_Sale 
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
ORDER BY Customers.Name;

3.2. Determine the average order value....
SELECT AVG(TotalAmount) FROM orders;


3.3. Find the month with the highest number of orders.....
SELECT MONTH(OrderDate) AS Month,SUM(TotalAmount) 
AS Total_Amount FROM orders   
GROUP BY MONTH(OrderDate);

4.1 Identify customers who have not placed any orders.....
SELECT Customers.Name, Orders.OrderID,
Products.P_Name, OrderDetails.Quantity 
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
where OrderDetails.Quantity < Null
ORDER BY Customers.Name;

4.3. Show the top 3 best-selling products.....
SELECT Products.P_Name, OrderDetails.Quantity
FROM Orders
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
ORDER BY OrderDetails.Quantity desc
limit 3;

5.1. List orders placed in the last month.
SELECT Customers.Name, Orders.OrderDate, Products.P_Name 
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID
JOIN Products ON OrderDetails.ProductID = Products.ProductID
ORDER BY Orders.OrderDate DESC
limit 1;

5.2 Determine the oldest customer in terms of membership duration....
select Name,JoinDate from Customers
ORDER BY JoinDate ASC 
limit 1;

6.1 Rank customers based on their total spending.... 
SELECT CustomerID, OrderID, TotalAmount ,
RANK() OVER (ORDER BY TotalAmount DESC)
FROM Orders;

7.1 Add a new customer to the Customers table....
INSERT INTO Customers (CustomerID, Name, Email, JoinDate) VALUES
(11, 'Ismail Khan', 'ismailkhan@example.com', '2021-11-13');

7.2. Update the price of a specific product....
UPDATE Products SET Price = 139 WHERE ProductID = 5;

