IF  DB_ID('disk_inventory') IS NOT NULL
    DROP DATABASE disk_inventory;
GO

CREATE DATABASE disk_inventory;
GO

use disk_inventory
GO

CREATE TABLE Disk(
Disk_ID	INT	PRIMARY KEY	IDENTITY,
Disk_Name VARCHAR(20) NOT NULL,
Relase_Date datetime not null,
Lended varchar(20) not null
);

CREATE TABLE Borrower(
Borrower_ID int PRIMARY KEY IDENTITY,
Borrower_Fname char(20) not null,
Borrower_Lname char(20) not null,
Borrower_Email char(20) not null
);

CREATE TABLE diskHasBorrower(
Borrow_Date datetime not null,
Return_Date datetime null,
Disk_ID int REFERENCES Disk(Disk_ID),
Borrower_ID int REFERENCES Borrower(Borrower_ID)
);

CREATE TABLE Artist(
Artist_ID int PRIMARY KEY IDENTITY,
Arist_Name char(20) not null
);

CREATE TABLE diskHasArtist(
Disk_ID int REFERENCES Disk(Disk_ID),
Artist_ID int REFERENCES Artist(Artist_ID)
);

