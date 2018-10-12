--Week3 Day2 Lab
--1
USE AP
SELECT InvoiceID, sum(InvoiceLineItemAmount) as AmountDue
FROM InvoiceLineItems
GROUP BY InvoiceID
ORDER BY InvoiceID

--2
SELECT Invoices.InvoiceID, sum(InvoiceLineItemAmount) as AmountDue, InvoiceTotal
FROM InvoiceLineItems 
Join Invoices
on InvoiceLineItems.InvoiceID = Invoices.InvoiceID
GROUP BY Invoices.InvoiceID, InvoiceTotal
ORDER BY Invoices.InvoiceID

--3
Select GLAccounts.AccountDescription, count(*) as NumLineItems
FROM InvoiceLineItems 
Join GLAccounts
ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
GROUP BY GLAccounts.AccountDescription
Order BY GLAccounts.AccountDescription

--4
Select GLAccounts.AccountDescription, count(*) as NumLineItems, cast(avg(InvoiceLineItemAmount)as decimal(12,2)) as InvAvg
FROM InvoiceLineItems 
Join GLAccounts
ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
GROUP BY GLAccounts.AccountDescription
having count(*) > 1
Order BY InvAvg desc
