CREATE DATABASE cafe_analysis;
USE cafe_analysis;

---------------------
-- TABLE1-Customers--
---------------------
CREATE TABLE IF NOT exists Customers (
      Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
      Customer_Name varchar(100),
      Phone varchar(15),
      Email varchar(50) );
      
---------------------
-- TABLE2-Products--
---------------------
CREATE TABLE IF NOT EXISTS Products (
	   Product_ID INT PRIMARY KEY AUTO_INCREMENT,
       Product_Name varchar(50) NOT NULL,
       Category  TEXT,
       Price  DECIMAL(10, 2) NOT NULL );
       
--------------------
-- TABLE3-Orders---
--------------------
CREATE TABLE IF NOT EXISTS Orders (
	  Order_ID INT PRIMARY KEY AUTO_INCREMENT,
      Customer_ID INT,
      Order_Date DATE,
      Total_Amount DECIMAL(10,2),
      foreign key (Customer_ID) REFERENCES Customers(Customer_ID) );
 
 ----------------------
-- TABLE4-Order_Items--
-----------------------
CREATE TABLE IF NOT EXISTS Order_Items (
      Order_Item_ID INT PRIMARY KEY AUTO_INCREMENT,
      Order_ID INT,
      Product_ID INT,
      Quantity INT,
      foreign key(Order_ID)REFERENCES Orders(Order_ID),
      foreign key(Product_ID)REFERENCES Products(Product_ID) );
      
--------------------
-- DATA INSERTION--
--------------------

INSERT INTO Customers (Customer_Name, Phone, Email) 
VALUES('Lily', '987654326', 'lily@gmail.com'),
      ('Olivia', '9123657863', 'olivia@gmail.com'),
      ('Rachel', '9988776655', 'rachel@gmail.com'),
      ('Grace', '9012395674', 'grace@gmail.com'),
      ('Thomas', '7418935682', 'thomas@gmail.com');

INSERT INTO Products (Product_Name, Category, Price)
VALUES('Cappuccino', 'Beverage', 120.00),
      ('Latte','Beverage', 150.00),
      ('Cold Coffee', 'Beverage', 180.00),
      ('Green Tea', 'Beverage', 100.00),
      
      ('Veg Sandwich', 'Food', 140.00),
      ('Chicken Sandwich', 'Food', 180.00),
      ('Croissant', 'Food', 130.00),
      
      ('French Fries', 'Snacks', 120.00),
      ('Burger', 'Snacks', 100.00),
      ('Pizza', 'Snacks', 100.00),
      
      ('Ice cream', 'Dessert', 130.00),
      ('Cheese Cake', 'Dessert', 100.00),
      ('Kunafa', 'Dessert', 80.00);

INSERT INTO Orders (Customer_ID, Order_Date, Total_Amount)
VALUES(1, '2026-01-10', 0),
      (2, '2026-01-10', 0),
      (3, '2026-01-11', 0),
      (5, '2026-01-11', 0),
      (4, '2026-01-11', 0),
      (2, '2026-01-12', 0),
      (3, '2026-01-12', 0),
      (5, '2026-01-12', 0),
      (1, '2026-01-13', 0),
      (4, '2026-01-13', 0),
      (3, '2026-01-13', 0),
      (2, '2026-01-14', 0),
      (1, '2026-01-14', 0);
      
INSERT INTO Order_Items (order_id, product_id, quantity)
VALUES(1, 1, 2),
	  (1, 8, 1),
      (2, 3, 1),
      (3, 2, 1),
      (4, 6, 1),
      (5, 4, 2),
      (6, 7, 1),
      (7, 9, 2),
      (8, 5, 1),
      (9, 8, 1),
      (10, 2, 1);
      
---------------------
-- VIEW BILL---
---------------------

CREATE VIEW Bills AS
select o.order_id, c.customer_name, oi.quantity, p.price, (oi.quantity * p.price) as item_total
from Orders o
     JOIN Customers c ON o.customer_id = c.Customer_id
     JOIN Order_Items oi ON o.order_id = oi.order_id
     JOIN products p ON oi.product_id = p.product_id;
     
---------------------
-- TOTAL_SALES--
---------------------

select SUM(oi.quantity * p.price) AS Total_sales
from Order_Items oi
    join Products p ON oi.product_id = p.product_id;
    
--------------------------
-- TOTAL SALES PER ORDER--
--------------------------

select o.order_id, sum(oi.quantity * p.price) AS order_total
from Orders o
	JOIN Order_Items oi ON o.order_id = oi.order_id
    JOIN Products p ON oi.product_id = p.product_id
    group by o.order_id;
    
---------------------
-- TOP CUSTOMER--
---------------------

select c.Customer_Name, sum(oi.Quantity * p.price) AS Total_spent
FROM Customers c
     JOIN Orders o ON c.customer_id = o.customer_id
     JOIN Order_Items oi ON o.Order_id = oi.Order_id
     JOIN Products p ON oi.Product_id = p.Product_id
     GROUP BY c.customer_name
     ORDER BY Total_spent DESC
     LIMIT 1;
     
------------------------
-- TOP SELLING PRODUCT--
------------------------

select p.product_name, sum(oi.quantity) AS Total_quantity_sold
from products p
     JOIN Order_Items oi ON p.product_id = oi.product_id
     group by p.product_name
     order by Total_quantity_sold DESC;



