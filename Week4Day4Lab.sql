--Week 4 Day 4 Lab
USE AP;
DECLARE @InvoiceTotal money, @VendorID int = 83
SET @InvoiceTotal =
    (SELECT SUM(InvoiceTotal - PaymentTotal - CreditTotal)
     FROM Invoices
	 WHERE VendorID = @VendorID and InvoiceTotal - PaymentTotal - CreditTotal > 0);
IF @InvoiceTotal > 100
	Select VendorContactFName, @InvoiceTotal as Due
	FROM Vendors
	where VendorID = @VendorID
ELSE
    PRINT 'Balance due is less than $100.00.';
	
GO