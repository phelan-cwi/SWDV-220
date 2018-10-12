--Week 3 Day 3
--------------------------------------------------------------------
USE AP;
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE InvoiceTotal > 
    (SELECT AVG(InvoiceTotal)
     FROM Invoices)
ORDER BY InvoiceTotal;
--------------------------------------------------------------------
USE AP;
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
WHERE VendorState = 'CA'
ORDER BY InvoiceDate;
--------------------------------------------------------------------
USE AP;
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
WHERE VendorID IN
    (SELECT VendorID
    FROM Vendors
    WHERE VendorState = 'CA')
ORDER BY InvoiceDate;
--------------------------------------------------------------------
USE AP;
SELECT VendorID, VendorName, VendorState
FROM Vendors
WHERE VendorID NOT IN
    (SELECT DISTINCT VendorID
    FROM Invoices);
--------------------------------------------------------------------
USE AP;
SELECT Vendors.VendorID, VendorName, VendorState
FROM Vendors LEFT JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
WHERE Invoices.VendorID IS NULL;
--------------------------------------------------------------------
USE AP;
SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,
    InvoiceTotal - PaymentTotal - CreditTotal AS BalanceDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal  > 0 
    AND InvoiceTotal - PaymentTotal - CreditTotal <
    (SELECT AVG(InvoiceTotal - PaymentTotal - CreditTotal)
    FROM Invoices
    WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0)
ORDER BY InvoiceTotal DESC;
--------------------------------------------------------------------
USE AP;
SELECT VendorName, InvoiceNumber, InvoiceTotal
FROM Invoices JOIN Vendors
  ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceTotal > ALL
    (SELECT InvoiceTotal
    FROM Invoices
    WHERE VendorID = 34)
ORDER BY VendorName;

--Alternative:
SELECT VendorName, InvoiceNumber, InvoiceTotal
FROM Invoices JOIN Vendors
  ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceTotal > 
    (SELECT max(InvoiceTotal)
    FROM Invoices
    WHERE VendorID = 34)
ORDER BY VendorName;
--------------------------------------------------------------------
USE AP;
SELECT VendorName, InvoiceNumber, InvoiceTotal
FROM Vendors JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal < ANY
    (SELECT InvoiceTotal
    FROM Invoices
    WHERE VendorID = 115);
--------------------------------------------------------------------
USE AP;
SELECT VendorID, InvoiceNumber, InvoiceTotal
FROM Invoices AS Inv_Main
WHERE InvoiceTotal >
    (SELECT AVG(InvoiceTotal)
    FROM Invoices AS Inv_Sub
    WHERE Inv_Sub.VendorID = Inv_Main.VendorID)
ORDER BY VendorID, InvoiceTotal;
--------------------------------------------------------------------
USE AP;
SELECT VendorID, VendorName, VendorState
FROM Vendors
WHERE NOT EXISTS
    (SELECT *
    FROM Invoices
    WHERE Invoices.VendorID = Vendors.VendorID);
--------------------------------------------------------------------
USE AP;
SELECT Invoices.VendorID, MAX(InvoiceDate) AS LatestInv,
    AVG(InvoiceTotal) AS AvgInvoice
FROM Invoices JOIN
    (SELECT TOP 5 VendorID, AVG(InvoiceTotal) AS AvgInvoice
    FROM Invoices
    GROUP BY VendorID
    ORDER BY AvgInvoice DESC) AS TopVendor
    ON Invoices.VendorID = TopVendor.VendorID
GROUP BY Invoices.VendorID
ORDER BY LatestInv DESC;
--------------------------------------------------------------------
USE AP;
SELECT DISTINCT VendorName,
    (SELECT MAX(InvoiceDate) FROM Invoices
    WHERE Invoices.VendorID = Vendors.VendorID) AS LatestInv
FROM Vendors
ORDER BY LatestInv DESC;
--------------------------------------------------------------------
USE AP;
SELECT VendorName, MAX(InvoiceDate) AS LatestInv
FROM Vendors LEFT JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY LatestInv DESC;
--------------------------------------------------------------------
USE AP;
WITH Summary AS
(
    SELECT VendorState, VendorName, SUM(InvoiceTotal)
        AS SumOfInvoices
    FROM Invoices JOIN Vendors
      ON Invoices.VendorID = Vendors.VendorID
    GROUP BY VendorState, VendorName
),
TopInState AS
(
    SELECT VendorState, MAX(SumOfInvoices) AS SumOfInvoices
    FROM Summary
    GROUP BY VendorState
)
SELECT Summary.VendorState, Summary.VendorName,
    TopInState.SumOfInvoices
FROM Summary JOIN TopInState
    ON Summary.VendorState = TopInState.VendorState AND
       Summary.SumOfInvoices = TopInState.SumOfInvoices
ORDER BY Summary.VendorState;
--------------------------------------------------------------------
