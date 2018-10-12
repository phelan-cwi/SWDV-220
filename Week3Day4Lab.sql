--Week 3 Day 4 Lab
--1
USE MyGuitarShop
INSERT INTO Categories(CategoryName)
VALUES ('Brass')

--2
UPDATE Categories
	SET CategoryName = 'Woodwinds'
	Where CategoryID = 5

--3
DELETE Categories
WHERE CategoryID = 5;

--4
INSERT INTO Products
	(CategoryID, ProductCode, ProductName, Description, ListPrice, DiscountPercent, DateAdded)
VALUES
(4, 'dgx_640', 'Yamaha DGX 640 88-Key Digital Piano', 'Long description to come', 799.99, 0, GETDATE()) --'2018-10-11' also works

--5
UPDATE Products
SET DiscountPercent = 35
WHERE ProductCode = 'dgx_640' --In reality, product code is unique, so I think this works just as well as productID

--6 (5 #2)
DELETE Products
WHERE CategoryID = 4
DELETE Categories
WHERE CategoryID = 4

--7 (6)
INSERT INTO Customers
			(EmailAddress
			, Password
			, FirstName
			, LastName
			, ShippingAddressID
			, BillingAddressID)
		VALUES
			('Rick@Raven.com'
			, ''
			, 'Rick'
			, 'Raven'
			, null
			, null)

--8 (7)
UPDATE Customers
SET Password = 'secret'
Where EmailAddress = 'Rick@Raven.com'

--9 (8)
UPDATE Customers
SET Password = 'reset'

