--Week 5 Day 1
USE AP;
GO
CREATE PROC sp_InvoiceReport
AS

SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices JOIN Vendors
     ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
ORDER BY VendorName;
Go

--To call sp:
EXEC sp_InvoiceReport;
-------------------------------------------------------------------------
USE AP;
GO
IF OBJECT_ID('sp_CopyInvoices') IS NOT NULL
    DROP PROC sp_CopyInvoices;
GO

CREATE PROC sp_CopyInvoices
AS
    IF OBJECT_ID('InvoiceCopy') IS NOT NULL
        DROP TABLE InvoiceCopy;
    SELECT *
    INTO InvoiceCopy
    FROM Invoices;
Go

--To exec:
Exec sp_CopyInvoices
Go

select * from InvoiceCopy
----------------------------------------------------------------------------
USE AP;
GO
CREATE PROC sp_InvTotal1
       @DateVar smalldatetime,
       @InvTotal money OUTPUT
AS
SELECT @InvTotal = SUM(InvoiceTotal)
FROM Invoices
WHERE InvoiceDate >= @DateVar;
Go

USE AP;
GO
declare @TheTotal money
exec sp_InvTotal1 '12-24-2011', @TheTotal output
select @TheTotal;
------------------------------------------------------------------------
USE AP;
GO
CREATE PROC sp_InvTotal2
       @DateVar smalldatetime = NULL
AS
IF @DateVar IS NULL
    SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;
SELECT SUM(InvoiceTotal)
FROM Invoices
WHERE InvoiceDate >= @DateVar;
Go

USE AP;
GO
exec sp_InvTotal2;
exec sp_InvTotal2 '12-24-2015';
-------------------------------------------------------------------------
USE AP;
GO
CREATE PROC sp_InvTotal3
       @InvTotal money OUTPUT,
       @DateVar smalldatetime = NULL,
       @VendorVar varchar(40) = '%'
AS

IF @DateVar IS NULL
   SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;

SELECT @InvTotal = SUM(InvoiceTotal)
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= @DateVar) AND
      (VendorName LIKE @VendorVar);
Go

--exec on next slide
--Run individually
DECLARE @MyInvTotal money;
EXEC sp_InvTotal3 @MyInvTotal OUTPUT, '2012-02-01', 'P%';
select @MyInvTotal;
--Code that passes the parameters by name
DECLARE @MyInvTotal money;
EXEC sp_InvTotal3 @DateVar = '2012-02-01',
    @VendorVar = 'P%', @InvTotal = @MyInvTotal OUTPUT;
select @MyInvTotal;
--Code that omits one optional parameter
DECLARE @MyInvTotal money;
EXEC sp_InvTotal3 @VendorVar = 'M%', 
    @InvTotal = @MyInvTotal OUTPUT;
select @MyInvTotal;
--Code that omits both optional parameters
DECLARE @MyInvTotal money;
EXEC sp_InvTotal3 @MyInvTotal OUTPUT;
select @MyInvTotal;
---------------------------------------------------------------------------
use ap
go

CREATE PROC sp_InvCount
       @DateVar smalldatetime = NULL,
       @VendorVar varchar(40) = '%'
AS

IF @DateVar IS NULL
   SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;

DECLARE @InvCount int;
SELECT @InvCount = COUNT(InvoiceID)
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= @DateVar) AND
      (VendorName LIKE @VendorVar);  --exec on next slide

RETURN @InvCount;
go

DECLARE @InvCount int;
EXEC @InvCount = sp_InvCount '2015-02-01', 'P%';
PRINT 'Invoice count: ' + CONVERT(varchar, @InvCount);
---------------------------------------------------------------------------
use AP
go

CREATE PROC sp_InsertInvoice
       @VendorID    int,
       @InvoiceNumber  varchar(50),
       @InvoiceDate smalldatetime,
       @InvoiceTotal   money,
       @TermsID     int,
       @InvoiceDueDate smalldatetime
AS

IF EXISTS(SELECT * FROM Vendors WHERE VendorID = @VendorID)
    INSERT Invoices
    VALUES (@VendorID, @InvoiceNumber,
            @InvoiceDate, @InvoiceTotal, 0, 0,
            @TermsID, @InvoiceDueDate, NULL);
ELSE 
    THROW 50001, 'Not a valid VendorID!', 1;

go

USE AP
GO
BEGIN TRY
    EXEC sp_InsertInvoice 
         799,'ZXK-799','2012-05-01',299.95,1,'2012-06-01';
END TRY
BEGIN CATCH
    PRINT 'An error occurred.';
    PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
    IF ERROR_NUMBER() >= 50000
        PRINT 'This is a custom error message.';
END CATCH;
-----------------------------------------------------------------------------
USE AP
GO
BEGIN TRY
    DECLARE @InvoiceID int;
    EXEC @InvoiceID = sp_InsertInvoice
         @VendorID = 799,                    -- Change VendorID to 99
         @InvoiceNumber = 'RZ99381',
         @InvoiceDate = '2018-03-12',  -- Change InvoiceDate YYYY to current
 @TermsID = 1,
 @InvoiceDueDate = '2018-04-25',
         @InvoiceTotal = 1292.45;
    PRINT 'Row was inserted.';
    PRINT 'New InvoiceID: ' + CONVERT(varchar, @InvoiceID);
END TRY
BEGIN CATCH
    PRINT 'An error occurred. Row was not inserted.';
    PRINT 'Error number: ' +
        CONVERT(varchar, ERROR_NUMBER());
    PRINT 'Error message: ' +
        CONVERT(varchar, ERROR_MESSAGE());
END CATCH;
---------------------------------------------------------------------------
USE AP
GO
CREATE PROC sp_VendorState
       @State varchar(20)
AS
SELECT VendorName
FROM Vendors
WHERE VendorState = @State;
Go

exec sp_VendorState 'AZ'
go
-------------------------------------------------------------------------------
USE AP
GO

ALTER PROC sp_VendorState
      @State varchar(20) = NULL
AS
IF @State IS NULL
   SELECT VendorName
   FROM Vendors;
ELSE
   SELECT VendorName
   FROM Vendors
   WHERE VendorState = @State;
go

exec sp_VendorState
go

DROP PROC sp_VendorState;
go
--------------------------------------------------------------------------------
sp_Help -- Invoices
sp_HelpText -- sp_InsertInvoice
sp_HelpDb -- AP
sp_Who  --2  sa
sp_Columns Vendors
------------------------------------------------------------------------------
USE AP;
EXEC sp_HelpText sp_InvoiceReport;
--------------------------------------------------------------------------------
USE AP
go
CREATE FUNCTION fn_VendorID
    (@VendorName varchar(50))
    RETURNS int
BEGIN
    RETURN (SELECT VendorID FROM Vendors
            WHERE VendorName = @VendorName);
END;
go

USE AP;
SELECT InvoiceDate, InvoiceTotal
FROM Invoices
WHERE VendorID = dbo.fn_VendorID('IBM');
-----------------------------------------------------------------------------
USE [AP] 
go
CREATE FUNCTION fn_BalanceDue()
    RETURNS money
BEGIN
    RETURN (SELECT SUM(InvoiceTotal - PaymentTotal -
                       CreditTotal)
            FROM Invoices
            WHERE InvoiceTotal - PaymentTotal -
                  CreditTotal > 0);
END;
Go

--USE [AP];
PRINT 'Balance due: $' +
    CONVERT(varchar, dbo.fn_BalanceDue(), 1);
------------------------------------------------------------------------------
USE [AP];
GO
IF OBJECT_ID('Vendors_INSERT_UPDATE') IS NOT NULL
   DROP TRIGGER Vendors_INSERT_UPDATE
GO
CREATE TRIGGER Vendors_INSERT_UPDATE
    ON Vendors
    AFTER INSERT,UPDATE
AS
    UPDATE Vendors
    SET VendorState = UPPER(VendorState)
    WHERE VendorID IN (SELECT VendorID FROM Inserted);
go

USE [AP];
GO
INSERT Vendors
VALUES ('Peerless Uniforms, Inc.', '785 S Pixley Rd', 
        NULL, 'Piqua', 'Oh', '45356', '(937) 555-8845',
        NULL, NULL, 4, 550);


Select * from Vendors;
-------------------------------------------------------------------------------
USE AP;
GO
ALTER TRIGGER Vendors_INSERT_UPDATE
    ON Vendors
    AFTER INSERT,UPDATE
AS
    UPDATE Vendors
    SET VendorState = UPPER(VendorState),
        VendorAddress1 = LTRIM(RTRIM(VendorAddress1)),
        VendorAddress2 = LTRIM(RTRIM(VendorAddress2))
    WHERE VendorID IN (SELECT VendorID FROM Inserted);
go

DROP TRIGGER Vendors_INSERT_UPDATE
go
-----------------------------------------------------------------------------
