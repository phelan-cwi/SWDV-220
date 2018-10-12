--Week 3 Day 4
-------------------------------------------------------------------
Use AP;
SELECT *
INTO InvoiceCopy2
FROM Invoices;

SELECT *
INTO InvoiceCopy3
FROM Invoices;

SELECT *
INTO OldInvoices2
FROM Invoices
WHERE InvoiceTotal – PaymentTotal – CreditTotal = 0;
-------------------------------------------------------------------
SELECT VendorID, SUM(InvoiceTotal) AS SumOfInvoices
INTO VendorBalances
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal <> 0
GROUP BY VendorID;


DROP TABLE InvoiceCopy2;
-------------------------------------------------------------------
INSERT INTO InvoiceCopy3
VALUES (97, '456789', '2012-04-01', 8344.50, 0, 0, 1,
       '2012-04-30', NULL);

INSERT INTO InvoiceCopy3
    (VendorID, InvoiceNumber, InvoiceTotal,
    PaymentTotal, CreditTotal, TermsID, InvoiceDate,
    InvoiceDueDate)
VALUES
    (97, '456789', 8344.50, 0, 0, 1, '2012-04-01',
    '2012-04-30');
-------------------------------------------------------------------
INSERT INTO InvoiceCopy3
VALUES 
    (95, '111-10098', '2012-04-01', 219.50, 0, 0, 1,
    '2012-04-30', NULL),
    (102, '109596', '2012-04-01', 22.97, 0, 0, 1,
    '2012-04-30', NULL),
    (72, '40319', '2012-04-01', 173.38, 0, 0, 1,
    '2012-04-30', NULL);
-------------------------------------------------------------------
--Create table as specified on page 221 in AP

CREATE TABLE [dbo].[ColorSample](
[ID] [int] NOT NULL identity,
[ColorNumber] [int] DEFAULT 0,
[ColorName] [varchar](10) NULL
) ON [PRIMARY]

GO
-------------------------------------------------------------------
INSERT INTO ColorSample (ColorNumber)
VALUES (606);

INSERT INTO ColorSample (ColorName)
VALUES ('Yellow');

INSERT INTO ColorSample
VALUES (DEFAULT, 'Orange');

INSERT INTO ColorSample
VALUES (808, NULL);

INSERT INTO ColorSample
VALUES (DEFAULT, NULL);

INSERT INTO ColorSample
DEFAULT VALUES;
-------------------------------------------------------------------
INSERT INTO InvoiceArchive
SELECT *
FROM InvoiceCopy3
WHERE InvoiceTotal - PaymentTotal - CreditTotal = 0;
-------------------------------------------------------------------
INSERT INTO InvoiceArchive
    (InvoiceID, VendorID, InvoiceNumber, InvoiceTotal,
    CreditTotal, PaymentTotal, TermsID, InvoiceDate,
    InvoiceDueDate)
SELECT
    InvoiceID, VendorID, InvoiceNumber, InvoiceTotal,
    CreditTotal, PaymentTotal, TermsID, InvoiceDate,
    InvoiceDueDate
FROM InvoiceCopy3
WHERE InvoiceTotal - PaymentTotal - CreditTotal = 0;
-------------------------------------------------------------------
UPDATE InvoiceCopy3
SET PaymentDate = '2012-05-21', 
    PaymentTotal = 19351.18
WHERE InvoiceNumber = '97/522';
-------------------------------------------------------------------
UPDATE InvoiceCopy3
SET TermsID = 1
WHERE VendorID = 95;

UPDATE InvoiceCopy3
SET CreditTotal = CreditTotal + 100
WHERE InvoiceNumber = '97/522';
-------------------------------------------------------------------
SELECT *
INTO VendorCopy
FROM Vendors;

UPDATE InvoiceCopy3
SET TermsID = 1
FROM InvoiceCopy3 JOIN VendorCopy
    ON InvoiceCopy3.VendorID = VendorCopy.VendorID
WHERE VendorName = 'Pacific Bell';
-------------------------------------------------------------------
UPDATE VendorCopy
SET VendorContactLName = LastName,
    VendorContactFName = FirstName
FROM VendorCopy JOIN ContactUpdates
    ON VendorCopy.VendorID = ContactUpdates.VendorID;
-------------------------------------------------------------------
SELECT *
INTO InvoiceCopy
FROM Invoices;

DELETE InvoiceCopy
WHERE InvoiceID = 115;

DELETE InvoiceCopy
WHERE VendorID = 37;

DELETE Vendors
WHERE VendorID = 125;
-------------------------------------------------------------------
DELETE InvoiceCopy
WHERE InvoiceTotal - PaymentTotal - CreditTotal = 0;

DELETE InvoiceCopy3;
-------------------------------------------------------------------
MERGE InvoiceArchive AS ia
USING InvoiceCopy AS ic
ON ic.InvoiceID = ia.InvoiceID
WHEN MATCHED AND 
    ic.PaymentDate IS NOT NULL AND
    ic.PaymentTotal > ia.PaymentTotal
  THEN
  UPDATE SET 
    ia.PaymentTotal = ic.PaymentTotal, 
    ia.CreditTotal = ic.CreditTotal, 
    ia.PaymentDate = ic.PaymentDate
WHEN NOT MATCHED THEN
  INSERT (InvoiceID, VendorID, InvoiceNumber, 
    InvoiceTotal, PaymentTotal, CreditTotal,
    TermsID, InvoiceDate, InvoiceDueDate)
  VALUES (ic.InvoiceID, ic.VendorID, ic.InvoiceNumber, 
    ic.InvoiceTotal, ic.PaymentTotal, ic.CreditTotal,
    ic.TermsID, ic.InvoiceDate, ic.InvoiceDueDate)
;
-------------------------------------------------------------------
