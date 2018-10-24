--Week 4 Day 2 Lab
--1
USE AP
GO
SELECT LEFT(VendorContactFName, 1) + '.' + VendorContactLName as Name
	,SUBSTRING(VendorPhone, 2, 3) as 'Area Code'
FROM Vendors
WHERE LEFT(VendorZipCode, 1) = 9
ORDER BY 'Area Code';

--2
SELECT datename(dw, '03/27/1990') as 'Day name of 03/27/1990';

--3
SELECT VendorID, VendorName, VendorAddress1,
	IIF(VendorAddress1 IS NULL, 'No Address on File', VendorAddress1) as Address
FROM Vendors
ORDER BY VendorAddress1;

-- also works for 3
SELECT VendorID, VendorName, VendorAddress1,
	CASE WHEN VendorAddress1 IS NULL
		THEN 'No Address on file'
		ELSE VendorAddress1
		END as Address
	FROM VENDORS
ORDER BY VendorAddress1;

