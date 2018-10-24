--Week 4 day 1
--Chapter 4 exercises/Review
--2 
select VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - (PaymentTotal + InvoiceTotal) as Balance,
InvoiceTotal - PaymentTotal - CreditTotal as Balance2
From vendors
join invoices on vendors.VendorID = Invoices.VendorID
where InvoiceTotal - (PaymentTotal + CreditTotal) > 0
order by VendorName asc

--4
SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal - (PaymentTotal + InvoiceTotal) as Balance,
InvoiceTotal - PaymentTotal - CreditTotal as Balance2
from vendors, invoices
where vendors.vendorID = invoices.VendorID
	and invoicetotal - (PaymentTotal + CreditTotal) > 0
order by vendorName asc

--5
Select VendorName as Vendor, InvoiceDate as Date, InvoiceNumber as Number, InvoiceSequence as #,
	InvoiceLineItemAmount as LineItem
From Vendors v
Join Invoices i on v.vendorID = i.VendorID
join InvoiceLineItems li on i.InvoiceID = li.InvoiceID
order by Vendor, Date, Number, #

--Chapter 5 page 180
--2
Select top 10 VendorName, sum(PaymentTotal) as PaymentSum
From Vendors
Join Invoices on Vendors.VendorID = Invoices.VendorID
group by VendorName
Order by PaymentSum desc

--3
SELECT VendorName as Vendor, count(InvoiceID) as InvoiceCount, sum(InvoiceTotal) as InvoiceSum
FROM Vendors
Join Invoices on Vendors.VendorID = Invoices.VendorID
GROUP BY VendorName
ORDER BY InvoiceCount desc

--8 THIS ONE IS NO GOOD, NO WORK
--Select VendorName, count(InvoiceLineItems.AccountNo) as [Num of Accounts]
--From Vendors
--Join GLAccounts on DefaultAccountNo = AccountNo 
--Join InvoiceLineItems on GLAccounts.AccountNo = InvoiceLineItems.AccountNo
--group by VendorName

Select VendorName, count(InvoiceLineItems.AccountNo) as [Num of Accounts]
From Vendors
Join Invoices on Vendors.VendorId = Invoices.VendorId 
Join InvoiceLineItems on Invoices.InvoiceID = InvoiceLineItems.InvoiceID
group by VendorName

--Chapter 6 Page 213
--4
Select AccountNo, AccountDescription
From GLAccounts
WHERE NOT EXISTS
	(SELECT AccountNo
	FROM InvoiceLineItems
	WHERE InvoiceLineItems.AccountNo = GLAccounts.AccountNo
	)
Order by AccountNo

--5
Select VendorName, Invoices.InvoiceID, InvoiceSequence, InvoiceLineItemAmount
From Vendors
Join Invoices on Vendors.VendorID = Invoices.VendorID
JOIN InvoiceLineItems on Invoices.InvoiceID = InvoiceLineItems.InvoiceID
where Invoices.InvoiceID IN
(select  DISTINCT InvoiceID
	FROM InvoiceLineItems
	WHERE InvoiceSequence > 1
)
ORDER BY Invoices.InvoiceID
