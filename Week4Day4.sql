--Week 4 day 4
USE ClubRoster;

CREATE TABLE Members
(MemberID int NOT NULL IDENTITY PRIMARY KEY,
LastName varchar(75) NOT NULL,
FirstName varchar(50) NOT NULL,
MiddleName varchar(50) NULL);

CREATE TABLE Committees
(CommitteeID int NOT NULL IDENTITY PRIMARY KEY,
CommitteeName varchar(50) NOT NULL);

CREATE TABLE CommitteeAssignments
(MemberID int NOT NULL REFERENCES Members(MemberID),
CommitteeID int NOT NULL REFERENCES Committees(CommitteeID));


USE AP;
DECLARE @TotalDue money;
SET @TotalDue =
    (SELECT SUM(InvoiceTotal - PaymentTotal - CreditTotal)
     FROM Invoices);
IF @TotalDue > 0
    PRINT 'Total invoices due =
        $' + CONVERT(varchar,@TotalDue,1);
ELSE
    PRINT 'Invoices paid in full';
GO

--Works well in command line and SSMS
USE AP;
DECLARE @MaxInvoice money, @MinInvoice money;
DECLARE @PercentDifference decimal(8,2);
DECLARE @InvoiceCount int, @VendorIDVar int;

SET @VendorIDVar = 95;
SET @MaxInvoice = (SELECT MAX(InvoiceTotal) FROM Invoices
    WHERE VendorID = @VendorIDVar);
SELECT @MinInvoice = MIN(InvoiceTotal), @InvoiceCount = COUNT(*)
FROM Invoices
WHERE VendorID = @VendorIDVar;
SET @PercentDifference = (@MaxInvoice - @MinInvoice) /
                         @MinInvoice * 100;

--Continued on next slide
PRINT 'Maximum invoice is $' + CONVERT(varchar,@MaxInvoice,1) + '.';
PRINT 'Minimum invoice is $' + CONVERT(varchar,@MinInvoice,1) + '.';
PRINT 'Maximum is ' + CONVERT(varchar,@PercentDifference) +
    '% more than minimum.';
PRINT 'Number of invoices: ' + CONVERT(varchar,@InvoiceCount) + '.';
GO


USE AP;

DECLARE @BigVendors table
(VendorID int,
VendorName varchar(50));

INSERT @BigVendors
SELECT VendorID, VendorName
FROM Vendors
WHERE VendorID IN 
    (SELECT VendorID FROM Invoices
     WHERE InvoiceTotal > 5000);

SELECT * FROM @BigVendors;
GO

--Local temporary table exists for the current db session; visible during the current session.

USE AP;

SELECT TOP 1 VendorID, AVG(InvoiceTotal) AS AvgInvoice
INTO #TopVendors
FROM Invoices
GROUP BY VendorID
ORDER BY AvgInvoice DESC;

SELECT Invoices.VendorID, MAX(InvoiceDate) AS LatestInv
FROM Invoices JOIN #TopVendors
    ON Invoices.VendorID = #TopVendors.VendorID
GROUP BY Invoices.VendorID;


--Can re-run select as needed
Select * from #TopVendors


--Global temp table is visible to all sessions.

CREATE TABLE ##RandomSSNs
(SSN_ID int IDENTITY,
SSN char(9) DEFAULT
    LEFT(CAST(CAST(CEILING(RAND()*10000000000) AS bigint)
        AS varchar),9));

INSERT ##RandomSSNs VALUES (DEFAULT);
INSERT ##RandomSSNs VALUES (DEFAULT);

SELECT * FROM ##RandomSSNs;
GO

--Can re-run
SELECT * FROM ##RandomSSNs;
GO

USE AP;

DECLARE @EarliestInvoiceDue smalldatetime;
SELECT @EarliestInvoiceDue = MIN(InvoiceDueDate)
    FROM Invoices 
    WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;
IF @EarliestInvoiceDue < GETDATE()
    PRINT 'Outstanding invoices overdue!';

USE AP;

DECLARE @MinInvoiceDue money, @MaxInvoiceDue money;
DECLARE @EarliestInvoiceDue smalldatetime,
        @LatestInvoiceDue smalldatetime;
SELECT @MinInvoiceDue =
           MIN(InvoiceTotal - PaymentTotal - CreditTotal),
       @MaxInvoiceDue =
           MAX(InvoiceTotal - PaymentTotal - CreditTotal),
       @EarliestInvoiceDue = MIN(InvoiceDueDate),
       @LatestInvoiceDue = MAX(InvoiceDueDate)
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;

--Continued on next slide
IF @EarliestInvoiceDue < GETDATE()
    BEGIN
        PRINT 'Outstanding invoices overdue!';
        PRINT 'Dated ' +
              CONVERT(varchar,@EarliestInvoiceDue,1) + 
              ' through ' +
              CONVERT(varchar,@LatestInvoiceDue,1) + '.';
        PRINT 'Amounting from $' +
              CONVERT(varchar,@MinInvoiceDue,1) +
              ' to $' + CONVERT(varchar,@MaxInvoiceDue,1) +
              '.';
    END;
ELSE --@EarliestInvoiceDue >= GETDATE()
    PRINT 'No overdue invoices.';


	USE master;
IF DB_ID('TestDB') IS NOT NULL
    DROP DATABASE TestDB;

CREATE DATABASE TestDB;
IF OBJECT_ID('InvoiceCopy3') IS NOT NULL
    DROP TABLE InvoiceCopy3;
--Another way to test for the existence of a table
IF EXISTS (SELECT * FROM sys.tables
           WHERE name = 'InvoiceCopy3')
    DROP TABLE InvoiceCopy3;
--Test for the existence of a temporary table
create table #AllUserTables
	(id char(5));

IF OBJECT_ID('tempdb..#AllUserTables') IS NOT NULL
    DROP TABLE #AllUserTables;
USE AP;
IF OBJECT_ID('tempdb..#InvoiceCopy') IS NOT NULL
    DROP TABLE #InvoiceCopy;

SELECT * INTO #InvoiceCopy FROM Invoices 
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0;

WHILE (SELECT SUM(InvoiceTotal - CreditTotal -
      PaymentTotal) FROM #InvoiceCopy) >= 20000
    BEGIN
        UPDATE #InvoiceCopy
        SET CreditTotal = CreditTotal + .05
        WHERE InvoiceTotal - CreditTotal -
              PaymentTotal > 0;

--Continued on next slide

 IF (SELECT MAX(CreditTotal) FROM #InvoiceCopy)
               > 3000
            BREAK;
        ELSE --(SELECT MAX(CreditTotal) FROM #InvoiceCopy)
             --    <= 3000
            CONTINUE;
    END;

SELECT InvoiceDate, InvoiceTotal, CreditTotal
FROM #InvoiceCopy


BEGIN TRY
    INSERT Invoices
    VALUES (799, 'ZXK-799', '2012-05-07', 299.95, 0, 0,
            1, '2012-06-06', NULL);
    PRINT 'SUCCESS: Record was inserted.';
END TRY
BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.';
    PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) 
        + ': ' + ERROR_MESSAGE();
END CATCH;

USE AP;
DECLARE @MyIdentity int, @MyRowCount int;

INSERT Vendors (VendorName, VendorAddress1, VendorCity,
    VendorState, VendorZipCode, VendorPhone,
    DefaultTermsID, DefaultAccountNo)
VALUES ('Peerless Binding', '1112 S Windsor St',
    'Hallowell', 'ME', '04347', '(207) 555-1555', 4, 400);

SET @MyIdentity = @@IDENTITY;
SET @MyRowCount = @@ROWCOUNT;
IF @MyRowCount = 1
    INSERT Invoices
    VALUES (@MyIdentity, 'BA-0199', '2012-05-01', 4598.23,
        0, 0, 4, '2012-06-30', NULL);

select @MyIdentity, @MyRowCount
go
