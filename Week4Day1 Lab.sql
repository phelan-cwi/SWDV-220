--Week 4 Day 1 Lab
--1
use MyGuitarShop
SELECT DISTINCT FirstName, LastName, Line1, City, State, ZipCode
FROM Customers
JOIN Addresses on Customers.ShippingAddressID = Addresses.AddressID
and Customers.CustomerID = Addresses.CustomerID


--2
SELECT FirstName as [First Name], LastName as [Last Name], OrderDate as [Date], ProductName as Product, 
	ItemPrice as Price, DiscountAmount as Discount, Quantity
FROM Customers
JOIN Orders on Customers.CustomerID = orders.CustomerID
Join OrderItems on Orders.OrderID = OrderItems.OrderID
Join Products on OrderItems.ProductID = Products.ProductID
ORDER BY LastName, [Date], Product

--3
USE AP
Select VendorName, AccountDescription, count(InvoiceLineItems.AccountNo) as LineItemCount, sum(InvoiceLineItemAmount) as LineItemSum
FROM Vendors
JOIN Invoices on vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems on Invoices.InvoiceID = InvoiceLineItems.InvoiceID
JOIN GLAccounts on InvoiceLineItems.AccountNo = GLAccounts.AccountNo
GROUP BY VendorName, AccountDescription
ORDER BY VendorName

--4
Select VendorName, count(InvoiceLineItems.AccountNo) as [Num of Accounts]
From Vendors
Join Invoices on Vendors.VendorId = Invoices.VendorId 
Join InvoiceLineItems on Invoices.InvoiceID = InvoiceLineItems.InvoiceID
group by VendorName
Having count(distinct InvoiceLineItems.AccountNo) > 1

--5
USE MyGuitarShop
SELECT * FROM Products
WHERE ListPrice > (Select AVG(ListPrice) From Products)
--6 
SELECT CategoryName
FROM Categories
WHERE NOT EXISTS
(SELECT CategoryID
FROM Products
Where products.CategoryID = Categories.CategoryID)
Order by CategoryName