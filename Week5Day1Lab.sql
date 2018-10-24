--week 5 day 1 lab
USE AP
GO
IF OBJECT_ID('sp_BalDueByVendor') IS NOT NULL
    DROP PROC sp_BalDueByVendor
GO

CREATE PROC sp_BalDueByVendor
	@VenName varchar(50) = '%'
as

Select VendorName, InvoiceNumber, InvoiceDate, 
InvoiceTotal - PaymentTotal - CreditTotal as BalDue
FROM Invoices JOIN Vendors
ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
and VendorName LIKE @VenName + '%'

sp_BalDueByVendor 'Fed'