Use ap
go

SELECT * --COUNT(*) AS NumberOfInvoices
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0; -- if you don't know wtf you're looking at
-----------------------------------------------------------------------------
SELECT COUNT(*) AS NumberOfInvoices,
    SUM(InvoiceTotal - PaymentTotal - CreditTotal)
    AS TotalDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;
-----------------------------------------------------------------------------
SELECT 'After 9/1/2015' AS SelectionDate, COUNT(*) AS NumberOfInvoices,
    AVG(InvoiceTotal) AS AverageInvoiceAmount,
    SUM(InvoiceTotal) AS TotalInvoiceAmount
FROM Invoices
WHERE InvoiceDate > '2015-09-01';
-----------------------------------------------------------------------------
SELECT 'After 9/1/2015' AS SelectionDate,
    COUNT(*) AS NumberOfInvoices,
    MAX(InvoiceTotal) AS HighestInvoiceTotal,
    MIN(InvoiceTotal) AS LowestInvoiceTotal
FROM Invoices
WHERE InvoiceDate > '2015-09-01';
-----------------------------------------------------------------------------
SELECT MIN(VendorName) AS FirstVendor,
    MAX(VendorName) AS LastVendor,
    COUNT(VendorName) AS NumberOfVendors
FROM Vendors;
-----------------------------------------------------------------------------
SELECT COUNT(DISTINCT VendorID) AS NumberOfVendors, --distinct removes repeating numbers aka multiple vendors
    COUNT(VendorID) AS NumberOfInvoices, --counts the number of invoices
    AVG(InvoiceTotal) AS AverageInvoiceAmount, --average amount
    SUM(InvoiceTotal) AS TotalInvoiceAmount --sum amount
FROM Invoices
WHERE InvoiceDate > '2015-09-01';
-----------------------------------------------------------------------------
SELECT VendorID, AVG(InvoiceTotal) AS AverageInvoiceAmount --builds a table showing individual vendors
FROM Invoices											   --from invoices
GROUP BY VendorID										   --grouped by xxxxxx
HAVING AVG(InvoiceTotal) > 2000							   --clause to limit further.
ORDER BY AverageInvoiceAmount DESC;
-----------------------------------------------------------------------------
select VendorID, count(VendorID) as NumInvoices, avg(InvoiceTotal) as InvAvg
FROM Invoices
WHERE InvoiceDate > '2015-09-01'
GROUP BY VendorID
HAVING count(VendorID) = 1								   --same thing as above, grabbing vendors who have 1
ORDER BY NumInvoices desc
-----------------------------------------------------------------------------
SELECT VendorID, COUNT(*) AS InvoiceQty
FROM Invoices
GROUP BY VendorID;
-----------------------------------------------------------------------------
Select VendorState, VendorCity, avg(InvoiceTotal) as InvAvg, sum(InvoiceTotal) as InvTotal
From Invoices
join Vendors 
on Invoices.VendorID = Vendors.VendorID
group by VendorState, VendorCity
order by VendorState, VendorCity
-----------------------------------------------------------------------------
SELECT VendorState, VendorCity, COUNT(*) AS InvoiceQty,
    AVG(InvoiceTotal) AS InvoiceAvg
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
GROUP BY VendorState, VendorCity
having count(*) > 1
ORDER BY VendorState, VendorCity;
-----------------------------------------------------------------------------
SELECT VendorState, VendorCity, COUNT(*) AS InvoiceQty,
    AVG(InvoiceTotal) AS InvoiceAvg
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
GROUP BY VendorState, VendorCity
HAVING COUNT(*) >= 2
ORDER BY VendorState, VendorCity;
-----------------------------------------------------------------------------
SELECT VendorName, COUNT(*) AS InvoiceQty,
    AVG(InvoiceTotal) AS InvoiceAvg
FROM Vendors JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
HAVING AVG(InvoiceTotal) > 500
ORDER BY InvoiceQty DESC;
-----------------------------------------------------------------------------
SELECT VendorName, COUNT(*) AS InvoiceQty,
    AVG(InvoiceTotal) AS InvoiceAvg
FROM Vendors JOIN Invoices
    ON Vendors.VendorID = Invoices.VendorID
WHERE InvoiceTotal > 500
GROUP BY VendorName
ORDER BY InvoiceQty DESC;
-----------------------------------------------------------------------------
SELECT InvoiceDate, COUNT(*) AS InvoiceQty, SUM(InvoiceTotal) AS InvoiceSum
FROM Invoices
GROUP BY InvoiceDate
HAVING InvoiceDate BETWEEN '2016-01-01' AND '2016-01-31'
   AND COUNT(*) > 1
   AND SUM(InvoiceTotal) > 100
ORDER BY InvoiceDate DESC;
-----------------------------------------------------------------------------
SELECT InvoiceDate, COUNT(*) AS InvoiceQty, SUM(InvoiceTotal) AS InvoiceSum
FROM Invoices
WHERE InvoiceDate BETWEEN '2016-01-01' AND '2016-01-31'
GROUP BY InvoiceDate with rollup
HAVING COUNT(*) > 1
   AND SUM(InvoiceTotal) > 100
ORDER BY InvoiceDate DESC;
-----------------------------------------------------------------------------
SELECT VendorID, COUNT(*) AS InvoiceCount,
    SUM(InvoiceTotal) AS InvoiceTotal
FROM Invoices
GROUP BY VendorID WITH ROLLUP;
-----------------------------------------------------------------------------
SELECT VendorState, VendorCity, COUNT(*) AS QtyVendors
FROM Vendors
WHERE VendorState IN ('IA', 'NJ')
GROUP BY VendorState, VendorCity WITH ROLLUP
ORDER BY VendorState DESC, VendorCity DESC;
-----------------------------------------------------------------------------
SELECT VendorID, COUNT(*) AS InvoiceCount,
    SUM(InvoiceTotal) AS InvoiceTotal
FROM Invoices
GROUP BY VendorID WITH CUBE;
-----------------------------------------------------------------------------
SELECT VendorState, VendorCity, COUNT(*) AS QtyVendors
FROM Vendors
WHERE VendorState IN ('IA', 'NJ')
GROUP BY VendorState, VendorCity WITH CUBE
ORDER BY VendorState DESC, VendorCity DESC;
-----------------------------------------------------------------------------
SELECT VendorState, VendorCity, COUNT(*) AS QtyVendors
FROM Vendors
WHERE VendorState IN ('IA', 'NJ')
GROUP BY GROUPING SETS(VendorState, VendorCity)
ORDER BY VendorState DESC, VendorCity DESC;
-----------------------------------------------------------------------------
SELECT VendorState, VendorCity, VendorZipCode, 
       COUNT(*) AS QtyVendors
FROM Vendors
WHERE VendorState IN ('IA', 'NJ')
GROUP BY GROUPING SETS((VendorState, VendorCity), VendorZipCode, ())
ORDER BY VendorState DESC, VendorCity DESC;


