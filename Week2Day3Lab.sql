--week2day3Lab  
--1.  
use MyGuitarShop
create nonclustered index IX_Addresses on Addresses(ZipCode);

--2.  
use master;
if DB_ID('MyWebDB') is not null
	drop database MyWebDB
GO

CREATE DATABASE MyWebDB
GO

Use MyWebDB;

CREATE TABLE Users(
UserID int identity primary key,
EmailAddress char(100) not null unique,
FirstName char(20) not null,
LastName char(20) not null
)

Create TABLE Products(
ProductID int not null identity primary key,
ProductName varchar(100) not null
)

CREATE TABLE Downloads(
DownloadID int not null identity primary key,
UserID int not null references Users(UserID),
DownloadDate smalldatetime not null,
FileName varchar(255) not null,
ProductID int not null references Products(ProductID)
--Foreign Key (UserID) references Users(UserID),
--Foreign Key (ProductID) references Products(ProductID)
)

--3.  
ALTER TABLE Products 
Add Price decimal(5, 2) null default 9.99

ALTER TABLE Products
Add DateAdded datetime not null

--4.  
ALTER TABLE Users
ALTER COLUMN FirstName varchar(20) not null
