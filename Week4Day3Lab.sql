--Week 4 Day 3 Lab
--1. 10 rows, because top 10
USE AP
GO

Create View Top10Invoices
AS
SELECT TOP 10 VendorID, InvoiceTotal
FROM  Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY InvoiceTotal desc
go

Select * FROM Top10Invoices

--2. 
use AP 
GO
create view OverDueInvoices
as
select InvoiceID, InvoiceDate, InvoiceTotal
from invoices
where PaymentDate IS null
and InvoiceDueDate < getdate()
go

select * 
from OverDueInvoices 
order by InvoiceTotal desc
go

--3.
CREATE VIEW ChangeTerms
as
select TermsID, TermsDescription, TermsDueDays
from Terms
Go

SELECT * FROM ChangeTerms

insert into ChangeTerms
values ('Net due 110 days', 110)
go

UPDATE ChangeTerms
Set TermsDescription = 'Net due 120 days', TermsDueDays = 120
Where TermsID = 8
SELECT * FROM ChangeTerms
	