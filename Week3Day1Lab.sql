--1
USE AP
select * 
from Invoices 
join Terms
on Invoices.TermsID = Terms.TermsID

--2
Select InvoiceNumber, InvoiceDate, TermsDueDays, (InvoiceTotal - PaymentTotal - CreditTotal) as Balance
FROM Invoices
INNER JOIN Terms	on Invoices.TermsID = Terms.TermsID
WHERE (InvoiceTotal - PaymentTotal - CreditTotal) > 0
ORDER BY Balance desc

--3
Select GLAccounts.AccountNo, AccountDescription, InvoiceLineItems.AccountNo
FROM GLAccounts
LEFT JOIN InvoiceLineItems
ON GLAccounts.AccountNo = InvoiceLineItems.AccountNo
WHERE InvoiceLineItems.AccountNo is NULL
ORDER BY GLAccounts.AccountNo

--4
SELECT VendorName, DefaultTermsID, TermsDescription
FROM Vendors
JOIN Terms
on DefaultTermsID = TermsID
Order by TermsDescription, VendorName

--5
Select V1.VendorID, V1.VendorName, V1.VendorContactFName + V1.VendorContactLName as Name
FROM Vendors as V1
Inner JOIN Vendors as V2
on V1.VendorContactFName = V2.VendorContactFName
	AND V1.VendorID <> V2.VendorID
ORDER BY Name;