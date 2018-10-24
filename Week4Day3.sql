CREATE VIEW VendorMin AS
	SELECT VendorName, VendorState, VendorPhone
	FROM Vendors

Use AP
Go
SELECT * FROM VendorsMin
WHERE VendorState = 'CA'
ORDER BY VendorName;

Use examples
Go
--CREATE VIEW InvestorsGeneral
--AS
--SELECT InvestorID, LastName, FirstName, Address, 
--    City, State, ZipCode, Phone
--FROM Investors;
--Go
Select * from InvestorsGeneral

Use AP
Go
--CREATE VIEW VendorShortList
--AS
--SELECT VendorName, VendorContactLName,
--   VendorContactFName, VendorPhone
--FROM Vendors
--WHERE VendorID IN (SELECT VendorID FROM Invoices);
--Go
Select * from vendorShortList;

Use AP
Go
CREATE VIEW TopVendorsNew
AS
SELECT TOP 5 PERCENT VendorID, InvoiceTotal
FROM Invoices
ORDER BY InvoiceTotal DESC;
Go
Select * from TopVendorsNew

Use AP
Go

CREATE VIEW OutstandingInvoicesNew 
    (InvoiceNumber, InvoiceDate, InvoiceTotal, BalanceDue)
AS
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,
    InvoiceTotal - PaymentTotal - CreditTotal
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;
Go
Select * from OutstandingInvoicesNew; 

Use AP
Go

CREATE VIEW OutstandingInvoicesNew2
AS
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,
    InvoiceTotal - PaymentTotal - CreditTotal AS BalanceDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;

Go
Select * from OutstandingInvoicesNew2
 
USE AP
GO

CREATE VIEW InvoiceCreditNew2
AS
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,
    PaymentTotal, CreditTotal
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;
go
UPDATE InvoiceCreditNew2
SET CreditTotal = CreditTotal + 200
WHERE InvoiceTotal - PaymentTotal - CreditTotal >= 200;
Select * FROM InvoiceCreditNew2
ORDER BY CreditTotal

Use AP
Go

CREATE VIEW OutstandingInvoicesNew3
AS
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,
    InvoiceTotal - PaymentTotal - CreditTotal AS BalanceDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;
go

select * from OutstandingInvoicesNew3
Go

UPDATE OutstandingInvoicesNew3
SET InvoiceDate = GETDATE()
WHERE BalanceDue >= 200
go

insert into OutstandingInvoicesNew3
values ('My Test Invoice', GETDATE(), 1234, 0)
go

Use examples
Go

CREATE VIEW Vendors_SWNew
AS
SELECT *
FROM Vendors
WHERE VendorState IN ('CA','AZ');
Go

select * from Vendors_SWNew;

ALTER VIEW Vendors_SWNew
AS
SELECT *
FROM Vendors
WHERE VendorState IN ('CA','AZ','NV','NM','UT','CO');
go
DROP VIEW Vendors_SWNew;

Use AP;
go
CREATE VIEW VendorPayment
AS
SELECT VendorName, InvoiceNumber, InvoiceDate, PaymentDate,
    InvoiceTotal, CreditTotal, PaymentTotal
FROM Invoices JOIN Vendors
  ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;
go
select * from VendorPayment
go

Use AP
Go

UPDATE VendorPayment
SET PaymentTotal = 19351.18, PaymentDate = GETDATE()
WHERE VendorName = 'Malloy Lithographing Inc' AND
      InvoiceNumber = 'P-0608';

select * from invoices where InvoiceNumber = 'P-0608'

Use AP
Go

CREATE VIEW IBM_InvoicesNew
AS
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE VendorID = (SELECT VendorID FROM Vendors
                  WHERE VendorName = 'IBM');
go
select * from IBM_InvoicesNew

Use AP
Go

INSERT INTO IBM_InvoicesNew
    (InvoiceNumber, InvoiceDate, InvoiceTotal)
VALUES ('RA23988', '2012-05-04', 417.34);

Use Ap
Go
--Constraint may be missing
alter table InvoiceLineItems
ADD FOREIGN KEY (InvoiceID) REFERENCES Invoices(InvoiceID);
Go
--Drop cascading delete or delete will not fail
ALTER TABLE [dbo].[InvoiceLineItems]  drop CONSTRAINT [FK_InvoiceLineItems_Invoices]
GO
--Both rows must exist for delete to fail
select * from Invoices where InvoiceNumber = 'Q545443';
go
select * from InvoiceLineItems where InvoiceID = 52
go

DELETE FROM IBM_InvoicesNew
WHERE InvoiceNumber = 'Q545443';

