# Sales-Customer-Analysis-of-a-Cafe_SQL
Designed and implemented a MYSQL-based sales database system of a cafe with normalized tables for customers, products, orders, and order items. Developed SQL JOINS queries to generate billing reports and calculate order totals using aggregate functions.
# KEY SQL CONCEPTS USED
-Database normalization
-Primary and Foreign Keys
-INNER JOINS across multiple tables
-Aggregate functions (SUM, COUNT, MAX)
-GROUP BY and WHERE Clauses

## PROJECT USE CASE
Analyze cafe sales and generate customer_wise billing reports using SQL.

# DATA SET
-Customers Table:
CREATE TABLE IF NOT exists Customers (
      Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
      Customer_Name varchar(100),
      Phone varchar(15),
      Email varchar(50) );

-Products Table:
CREATE TABLE IF NOT EXISTS Products (
	   Product_ID INT PRIMARY KEY AUTO_INCREMENT,
       Product_Name varchar(50) NOT NULL,
       Category  TEXT,
       Price  DECIMAL(10, 2) NOT NULL );

-Orders Table:
 Order_ID INT PRIMARY KEY AUTO_INCREMENT,
      Customer_ID INT,
      Order_Date DATE,
      Total_Amount DECIMAL(10,2),
      foreign key (Customer_ID) REFERENCES Customers(Customer_ID) );
      
-Order_items Table:
CREATE TABLE IF NOT EXISTS Order_Items (
      Order_Item_ID INT PRIMARY KEY AUTO_INCREMENT,
      Order_ID INT,
      Product_ID INT,
      Quantity INT,
      foreign key(Order_ID)REFERENCES Orders(Order_ID),
      foreign key(Product_ID)REFERENCES Products(Product_ID) );
