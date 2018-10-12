Use AP

Select VendorID, VendorName from vendors where VendorID = 123;
Select VendorID, InvoiceID from invoices where VendorID = 123;

SELECT InvoiceNumber, VendorName
FROM Vendors JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID;

SELECT InvoiceNumber, VendorName, InvoiceDueDate,
    InvoiceTotal - PaymentTotal - CreditTotal AS BalanceDue
FROM Vendors AS v JOIN Invoices AS i
    ON v.VendorID = i.VendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY InvoiceDueDate DESC;

SELECT InvoiceNumber, InvoiceLineItemAmount, InvoiceLineItemDescription
FROM Invoices JOIN InvoiceLineItems AS LineItems
    ON Invoices.InvoiceID = LineItems.InvoiceID
WHERE AccountNo = 540
ORDER BY InvoiceDate;


--Add matching row:
INSERT INTO [dbo].[Vendors]
           ([VendorName]
           ,[VendorAddress1]
           ,[VendorAddress2]
           ,[VendorCity]
           ,[VendorState]
           ,[VendorZipCode]
           ,[VendorPhone]
           ,[VendorContactLName]
           ,[VendorContactFName]
           ,[DefaultTermsID]
           ,[DefaultAccountNo])
     VALUES
           ('MyVendor'
           ,'Line1'
           ,'Line2'
           ,'Test City'
           ,'WA'
           ,'98684'
           ,'555-555-1122'
           ,'Mickey'
           ,'Mouse'
           ,1
           ,100)
GO



SELECT VendorName, CustomerLast, CustomerFirst,
    VendorState AS State, VendorCity AS City
FROM AP.dbo.Vendors AS Vendors
    JOIN Examples.dbo.Customers AS Customers
    ON Vendors.VendorZipCode = Customers.CustZip
ORDER BY State, City;

Use AP;
SELECT InvoiceNumber, InvoiceDate,
    InvoiceTotal, InvoiceLineItemAmount
FROM Invoices JOIN InvoiceLineItems AS LineItems
    ON (Invoices.InvoiceID = LineItems.InvoiceID) AND
       (Invoices.InvoiceTotal >
           LineItems.InvoiceLineItemAmount)
ORDER BY InvoiceNumber;

SELECT InvoiceNumber, InvoiceDate,
    InvoiceTotal, InvoiceLineItemAmount
FROM Invoices JOIN InvoiceLineItems AS LineItems
    ON Invoices.InvoiceID = LineItems.InvoiceID
WHERE Invoices.InvoiceTotal >
    LineItems.InvoiceLineItemAmount
ORDER BY InvoiceNumber;

SELECT DISTINCT Vendors1.VendorName, Vendors1.VendorCity,
    Vendors1.VendorState
FROM Vendors AS Vendors1 JOIN Vendors AS Vendors2
    ON (Vendors1.VendorCity = Vendors2.VendorCity) AND
       (Vendors1.VendorState = Vendors2.VendorState) AND
       (Vendors1.VendorID <> Vendors2.VendorID)
ORDER BY Vendors1.VendorState, Vendors1.VendorCity;

SELECT VendorName, InvoiceNumber, InvoiceDate,
    InvoiceLineItemAmount AS LineItemAmount,
    AccountDescription
FROM Vendors
    JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
    JOIN InvoiceLineItems 
      ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
    JOIN GLAccounts
      ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName, LineItemAmount DESC;

SELECT InvoiceNumber, VendorName
FROM Vendors, Invoices
WHERE Vendors.VendorID = Invoices.VendorID;

SELECT VendorName, InvoiceNumber, InvoiceDate,
    InvoiceLineItemAmount AS LineItemAmount,
    AccountDescription
FROM Vendors, Invoices, InvoiceLineItems, GLAccounts
WHERE Vendors.VendorID = Invoices.VendorID
  AND Invoices.InvoiceID = InvoiceLineItems.InvoiceID
  AND InvoiceLineItems.AccountNo = GLAccounts.AccountNo
  AND InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName, LineItemAmount DESC;

SELECT VendorName, InvoiceNumber, InvoiceTotal
FROM Vendors LEFT JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
ORDER BY VendorName;

Use Examples; 
SELECT DeptName, Departments.DeptNo, LastName
FROM Departments LEFT JOIN Employees
    ON Departments.DeptNo = Employees.DeptNo;

Use Examples; 

SELECT DeptName, Employees.DeptNo, LastName
FROM Departments RIGHT JOIN Employees
    ON Departments.DeptNo = Employees.DeptNo;

Use examples;
go
SELECT DeptName, Departments.DeptNo,
    Employees.DeptNo, LastName
FROM Departments FULL JOIN Employees
    ON Departments.DeptNo = Employees.DeptNo;

Use examples;
go
SELECT DeptName, LastName, ProjectNo
FROM Departments
    LEFT JOIN Employees
        ON Departments.DeptNo = Employees.DeptNo
    LEFT JOIN Projects
        ON Employees.EmployeeID = Projects.EmployeeID
ORDER BY DeptName, LastName, ProjectNo;

Use examples
Go
SELECT DeptName, LastName, ProjectNo
FROM Departments
    FULL JOIN Employees
        ON Departments.DeptNo = Employees.DeptNo
    FULL JOIN Projects
        ON Employees.EmployeeID = Projects.EmployeeID
ORDER BY DeptName;

Use examples
Go
SELECT DeptName, LastName, ProjectNo
FROM Departments 
    JOIN Employees
        ON Departments.DeptNo = Employees.DeptNo
    LEFT JOIN Projects
        ON Employees.EmployeeID = Projects.EmployeeID
ORDER BY DeptName;

Use examples
Go
SELECT Departments.DeptNo, DeptName,
    EmployeeID, LastName
FROM Departments CROSS JOIN Employees
ORDER BY Departments.DeptNo;

Use examples
Go
SELECT Departments.DeptNo, DeptName,
    EmployeeID, LastName
FROM Departments, Employees
ORDER BY Departments.DeptNo;

Use examples
Go
 SELECT 'Active' AS Source, InvoiceNumber,
        InvoiceDate, InvoiceTotal
    FROM ActiveInvoices
    WHERE InvoiceDate >= '02/01/2012'
UNION
    SELECT 'Paid' AS Source, InvoiceNumber,
        InvoiceDate, InvoiceTotal
    FROM PaidInvoices
    WHERE InvoiceDate >= '02/01/2012'
ORDER BY InvoiceTotal DESC;

Use AP
Go
 SELECT 'Active' AS Source, InvoiceNumber,
        InvoiceDate, InvoiceTotal
    FROM Invoices
    WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
UNION
    SELECT 'Paid' AS Source, InvoiceNumber,
        InvoiceDate, InvoiceTotal
    FROM Invoices
    WHERE InvoiceTotal - PaymentTotal - CreditTotal <= 0
ORDER BY InvoiceTotal DESC;

Use Examples
Go
 SELECT CustomerFirst, CustomerLast
    FROM Customers
EXCEPT
    SELECT FirstName, LastName
    FROM Employees
ORDER BY CustomerLast;

Use Examples
Go
 SELECT CustomerFirst, CustomerLast 
    FROM Customers
INTERSECT
    SELECT FirstName, LastName 
    FROM Employees;
--Also:
 SELECT CustomerFirst, CustomerLast 
    FROM Customers, Employees
where CustomerFirst = FirstName
and CustomerLast = LastName ;
