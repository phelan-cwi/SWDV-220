--Week 3 Day 3 Lab
--1
USE AP
SELECT DISTINCT AccountDescription
FROM GLAccounts
WHERE AccountNo IN 
(SELECT DISTINCT AccountNo 
FROM InvoiceLineItems)
ORDER BY AccountDescription;

--2
SELECT InvoiceNumber, InvoiceTotal
FROM Invoices
WHERE InvoiceTotal > 
    (SELECT AVG(InvoiceTotal)
     FROM Invoices)
ORDER BY InvoiceTotal desc;

--3
USE AP;
SELECT TermsID, TermsDescription
FROM Terms
WHERE TermsID NOT IN
    (SELECT DISTINCT TermsID
    FROM Invoices);
	
--4a
Select DISTINCT AccountNo, AccountDescription
FROM GLAccounts
WHERE NOT EXISTS
(Select AccountNo FROM InvoiceLineItems
WHERE GLAccounts.AccountNo = InvoiceLineItems.AccountNo) 
ORDER BY AccountDescription;

--4b
USE AP
SELECT DISTINCT AccountNo, AccountDescription
FROM GLAccounts
WHERE AccountNo NOT IN 
(SELECT DISTINCT AccountNo 
FROM InvoiceLineItems)
ORDER BY AccountDescription;