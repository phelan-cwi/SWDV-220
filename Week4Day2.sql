Use AP 
Go
Select VendorName, VendorContactLName + ', '
       + LEFT(VendorContactFName, 1)
       + '.' AS ContactName, RIGHT(VendorPhone, 8) AS Phone
FROM Vendors
WHERE SUBSTRING(VendorPhone, 2, 3) = 559
ORDER BY VendorName;

--If data conversion error given, edit data & check that all phone numbers have ()

use Examples
Go
SELECT * FROM StringSample
ORDER BY ID;

use Examples
Go

SELECT * FROM StringSample
ORDER BY CAST(ID AS int);

use Examples
Go
SELECT Name,
    LEFT(Name, CHARINDEX(' ', Name) - 1) AS First,
    RIGHT(Name, LEN(Name) - CHARINDEX(' ', Name) ) AS Last
FROM StringSample;

use Examples
Go
SELECT * FROM RealSample
WHERE R BETWEEN 0.99 AND 1.01;
go
SELECT * FROM RealSample
WHERE ROUND(R,2) = 1;

Use Examples
go
--Space: Returns a string of repeated spaces.

SELECT ID, R, CAST(R AS decimal(9,3)) AS R_decimal,
    CAST(CAST(R AS decimal(9,3)) AS varchar(9))
        AS R_varchar,
    LEN(CAST(CAST(R AS decimal(9,3)) AS varchar(9)))
        AS R_LEN,
    SPACE(9 - LEN(CAST(CAST(R AS decimal(9,3))
                      AS varchar(9)))) +
                  CAST(CAST(R AS decimal(9,3))
                      AS varchar(9))
        AS R_Formatted
--select *
FROM RealSample;

select getdate() as 'Today';

select day(getdate()) as 'Day Part of Today';

select month('2/1/2011') as 'Month Part of 2/1/2011';

select year('2/1/2011') as 'Year Part of 2/1/2011';

select datename(mm,'2/1/2011') as 'Month name of 2/1/2011';



SELECT GETDATE() AS 'Today in ms';
SELECT GETUTCDATE() AS 'GMT in ms';

SELECT SYSDATETIME() AS 'Today in ns';
SELECT SYSUTCDATETIME() AS 'GMT in ns';
SELECT SYSDATETIMEOFFSET() AS 'Local date/time in ns';

SELECT MONTH('9/30/2012') AS 'Numerical Month using Month function';
SELECT DATEPART(month,'2012-09-30') AS 'Numerical Month using Datepart';
SELECT DATENAME(month,'9/30/2012') AS 'Word Month usinge Datename';
SELECT DATENAME(m,'2012-09-30') AS 'Word Month usinge Datename';
select EOMONTH('2-2-2012') AS 'End of February';
select EOMONTH('2-2-2012', 3) AS 'End of FEB + 3';
select DATEFROMPARTS(2012,4,3) AS 'Assembled Date';
select ISDATE('2-29-2012') AS 'Valid Date Part';
select ISDATE('23:99:99') AS 'Invalid Date Part';

select DAY('2-1-1963') AS 'Shows Day';
select MONTH('2-1-1963') AS 'Shows Month';
select YEAR('2-1-1963') AS 'Shows Year'; 

select DATEPART(WEEKDAY,'2-18-1993') AS 'Shows Day of Week';
select DATEPART(WEEK,'2-18-1993') AS 'Shows Week of Year';
select DATEPART(DAYOFYEAR,'2-18-1993') AS 'Shows Day of Year';


select DATENAME(WEEKDAY,'5-21-1996') AS 'Shows Name Day of Week'; 
select DATENAME(WEEK,'1996-5-21') AS 'Shows Week of Year';
select DATENAME(DAYOFYEAR,'5/21/1996') AS 'Shows Day of Year';

select DATEADD(YEAR, 5, '4-2-2003') AS 'Adds 5 Years';
select DATEADD(WEEK, 5, '4/2/2003') AS 'Adds 5 Weeks';
select DATEADD(MONTH, 5 ,'2003-4-2') AS 'Adds 5 Months';

select DATEDIFF(YEAR, '1962-6-1', '2-1-1963') AS 'Calcs Year Diff of 1st Minus 2nd';
select DATEDIFF(DAY, '6-1-1962', '2/1/1963') AS 'Calcs Day Diff of 1st Minus 2nd';
select DATEDIFF(MONTH, '1962/6/1','2-1-1963') AS 'Calcs Month Diff of 1st Minus 2nd';


select CAST('2012-09-30 11:35:00' AS smalldatetime) + 1 AS 'Adds 1 Day';
select CAST('2012/09/30 11:35:00' AS smalldatetime) - 1 AS 'Subtracts 1 Day';
select CAST(CAST('09-30-2012' AS datetime) - CAST('2011-12-01' AS datetime) AS int) AS 'Calcs Diff in Days';


use Examples
Go
SELECT * FROM DateSample
WHERE StartDate = '2011-10-28';

Use examples
go
SELECT * FROM DateSample
WHERE CONVERT(date, StartDate) = '10-28-2011';

SELECT * FROM DateSample
WHERE StartDate >= '2011-10-28' AND
      StartDate < '2011/10/29';

SELECT * FROM DateSample
WHERE MONTH(StartDate) = 10 AND 
      DAY(StartDate) = 28 AND 
      YEAR(StartDate) = 2011;


Use examples
go
SELECT * FROM DateSample
WHERE CAST(CAST(StartDate AS char(11)) AS datetime)
    = '10/28/2011';
--= '2011-10-28';
 
SELECT * FROM DateSample
WHERE CONVERT(datetime, CONVERT(char(10), StartDate, 110)) 
= '2011/10/28';
--= '2011-10-28';


--No date specified just time
Use examples
go

SELECT * FROM DateSample
WHERE StartDate = CAST('10:00:00' AS datetime);

SELECT * FROM DateSample
WHERE StartDate >= '09:00:00' AND
    StartDate < '12:59:59:999';

Use examples
go
SELECT * FROM DateSample
WHERE CONVERT(time, StartDate) >= '09:00:00' AND
      CONVERT(time, StartDate) < '12:59:59:999';

SELECT * FROM DateSample
WHERE CONVERT(datetime, CONVERT(char(12), StartDate, 8))
          >= '09:00:00' AND
      CONVERT(datetime, CONVERT(char(12), StartDate, 8))
          < '12:59:59:999';

use AP
go
select TermsID from terms;

SELECT InvoiceNumber, TermsID,
    CASE TermsID
        WHEN 1 THEN 'Net due 10 days'
        WHEN 2 THEN 'Net due 20 days'
        WHEN 3 THEN 'Net due 30 days'
        WHEN 4 THEN 'Net due 60 days'
        WHEN 5 THEN 'Net due 90 days'
    END AS Terms
FROM Invoices;


use AP
go
SELECT InvoiceNumber, InvoiceTotal, InvoiceDate, InvoiceDueDate,
    CASE
        WHEN DATEDIFF(day, InvoiceDueDate, GETDATE()) > 30
            THEN 'Over 30 days past due'
        WHEN DATEDIFF(day, InvoiceDueDate, GETDATE()) > 0
            THEN '1 to 30 days past due'
        ELSE 'Current'
    END AS Status
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;

--IIF is a shorthand way for writing a CASE expression. Returns one of two values, depending on whether the Boolean expression evaluates to true or false in SQL Server.
--Syntax: IIF ( boolean_expression, true_value, false_value )
--boolean_expression: A valid Boolean expression. If this argument is not a Boolean expression, then a syntax error is raised.
--true_value: Value to return if boolean_expression evaluates to true.
--false_value: Value to return if boolean_expression evaluates to false.
Use AP
go
SELECT InvoiceID, InvoiceDate,
    IIF(InvoiceDate < '2015-07-01', 'Previous Year', 'Current Year') AS 'Fiscal Year'
FROM Invoices
Order By InvoiceDate Desc;

--Returns the item at the specified index from a list of values in SQL Server. Acts like an index into an array, where the array is composed of the arguments that follow the ----index argument. The index argument determines which of the following values will be returned.

SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,
    CHOOSE(TermsID, '10 days', '20 days', '30 days',
        '60 days', '90 days') AS NetDue
FROM Invoices
WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0;
