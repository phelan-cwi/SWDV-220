--Week 2 day 4  
CREATE LOGIN [F18Serverb14\BugsBunny] FROM WINDOWS;

CREATE LOGIN [F18Serverb14\FredFlinstone] FROM WINDOWS;

CREATE LOGIN JohnDoe WITH PASSWORD = 'Pa$$w0rd',
    DEFAULT_DATABASE = AP;
CREATE LOGIN JackWilliams WITH PASSWORD = 'Pa$$w0rd',
    DEFAULT_DATABASE = AP;
CREATE LOGIN JaneDoe WITH PASSWORD = 'Pa$$w0rd',
    DEFAULT_DATABASE = AP;

ALTER LOGIN JohnDoe WITH NAME = JackDoe;

ALTER LOGIN JackWilliams WITH PASSWORD = 'Pa$$w0rd';

use AP;
go
CREATE USER JackWilliams;
CREATE USER JaneDoe;

--Creates a database user for a Windows user account
CREATE USER BugsBunny FOR LOGIN [F18ServerB14\BugsBunny];

--Create a database user with a default schema
CREATE USER FredFlinestone 
FOR LOGIN [F18ServerB14\FredFlintstone]
    WITH DEFAULT_SCHEMA = AP;

Use AP;
Go
ALTER USER JackWilliams WITH NAME = JackDoe;

ALTER USER JackDoe WITH DEFAULT_SCHEMA = AP;


DROP USER JackDoe;

Use AP;
Go

CREATE SCHEMA Accounting;
go
CREATE SCHEMA Marketing
    CREATE TABLE Contacts
    (ContactID   INT         NOT NULL IDENTITY
                             PRIMARY KEY,
    ContactName  VARCHAR(50) NOT NULL,
    ContactPhone VARCHAR(50) NULL,
    ContactEmail VARCHAR(50) NULL);
go

Use ap;
Go

GRANT SELECT
ON Invoices
TO BugsBunny;

GRANT SELECT
ON GLAccounts
TO JaneDoe;

REVOKE SELECT
ON Invoices
TO BugsBunny;


GRANT INSERT, UPDATE, DELETE
ON Invoices
TO BugsBunny;

REVOKE DELETE
ON Invoices
FROM BugsBunny;

GRANT ALTER
ON Vendors
To BugsBunny;

GRANT SELECT
ON Vendors (VendorName,VendorAddress1,VendorCity,VendorState,
VendorZipCode)
TO BugsBunny, [F18ServerB14\FredFlintstone];

GRANT CREATE VIEW
TO BugsBunny, FredFlintstone;

USE master;
Go

CREATE USER JackWilliams;
GRANT CREATE DATABASE, CREATE TABLE
TO JackWilliams;


REVOKE CREATE DATABASE, CREATE TABLE
FROM JackWilliams;

GRANT ALTER ANY DATABASE
TO JackWilliams;

REVOKE CREATE SERVER ROLE
FROM [F18ServerB14\BugsBunny];

ALTER SERVER ROLE sysadmin ADD MEMBER JackWilliams;

ALTER SERVER ROLE sysadmin DROP MEMBER JackWilliams;

CREATE SERVER ROLE Consultant;

GRANT ALTER ANY LOGIN
TO Consultant;

ALTER SERVER ROLE Consultant ADD MEMBER JackWilliams;

ALTER SERVER ROLE dbcreator ADD MEMBER Consultant;

ALTER SERVER ROLE Consultant WITH NAME = DBConsultant;

ALTER SERVER ROLE DBConsultant DROP MEMBER JackWilliams;
DROP SERVER ROLE DBConsultant;



EXEC sp_HelpSrvRole;

EXEC sp_HelpSrvRoleMember sysadmin;

ALTER ROLE db_owner ADD MEMBER JackWilliams;

ALTER ROLE db_owner DROP MEMBER JackWilliams;

Use AP
Go

CREATE ROLE InvoiceEntry;

GRANT INSERT, UPDATE
ON Invoices
TO InvoiceEntry;

GRANT INSERT, UPDATE
ON InvoiceLineItems
TO InvoiceEntry;

ALTER ROLE InvoiceEntry ADD MEMBER FredFlintstone;

ALTER ROLE db_datareader ADD MEMBER InvoiceEntry;

ALTER ROLE InvoiceEntry WITH NAME = InvEntry;

EXEC sp_HelpRole;

EXEC sp_HelpRoleMember InvEntry

DENY SELECT
ON GLAccounts
TO JaneDoe;

ALTER ROLE InvEntry DROP MEMBER JaneDoe;
ALTER ROLE InvEntry DROP MEMBER FredFlintstone;
ALTER ROLE InvEntry DROP MEMBER BugsBunny;
DROP ROLE InvEntry;;
