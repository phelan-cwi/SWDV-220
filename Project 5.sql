--Project 5
--DISK SP's Insert first.
USE disk_inventory
GO

IF OBJECT_ID('sp_InsertDisk') is not null
DROP PROC sp_InsertDisk
go 

CREATE PROC sp_InsertDisk
			@Disk_Name varchar(20)
		,	@Release_Date datetime
		,	@LendedStatus varchar(20)

as 
INSERT INTO Disk(Disk_Name, Relase_Date, LendedStatus)
Values(@Disk_Name, @Release_Date, @LendedStatus)
go

USE disk_inventory
go

BEGIN TRY
EXEC sp_InsertDisk
'Teen Spirit',
'1995-10-11',
'In'
END TRY
BEGIN CATCH
PRINT 'An error occurred.';
	PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
	IF ERROR_NUMBER() >= 50000
		PRINT 'Check your inputs.';
END CATCH

-- DISK Update procedure accepts a primary key value and the disk information for update
use disk_inventory
go

IF OBJECT_ID('sp_UpdateDisk') is not null
DROP PROC sp_UpdateDisk
go 

CREATE PROC sp_UpdateDisk
			@Disk_ID int
		,	@Disk_Name varchar(20)
		,	@Release_Date datetime
		,	@LendedStatus varchar(20)
as
BEGIN 
UPDATE Disk
SET Disk_Name = @Disk_Name, Relase_Date = @Release_Date, LendedStatus = @LendedStatus
where Disk_ID = @Disk_ID
END
go

use disk_inventory
go
BEGIN TRY
exec sp_UpdateDisk 
@disk_id = 27, @disk_name = 'Teen Spirit!', @Release_Date = '1995-10-01', @LendedStatus = 'In'
END TRY
BEGIN CATCH
PRINT 'An error occurred.';
	PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
	IF ERROR_NUMBER() >= 50000
		PRINT 'Check your inputs.';
END CATCH
go

/*****************DELETE SP for disk*******************************/
USE disk_inventory
go

IF OBJECT_ID('sp_DeleteDisk') is not null
DROP PROC sp_DeleteDisk
go

CREATE PROC sp_DeleteDisk
			@Disk_ID int
as
BEGIN 
DELETE Disk
WHERE @Disk_ID = Disk_ID
END 
GO

BEGIN TRY
EXEC sp_DeleteDisk 27
END TRY 
BEGIN CATCH
PRINT 'An error occurred.';
	PRINT Error_Message();
		PRINT 'Check your inputs.';
END CATCH
go

/***************************** INSERT FOR ARTIST ************************************/
USE disk_inventory
GO

IF OBJECT_ID('sp_InsertArtist') is not null
DROP PROC sp_InsertArtist
go 

CREATE PROC sp_InsertArtist
			@Artist_Name char(20)

as 
INSERT INTO Artist(Arist_Name)
Values(@Artist_Name)
go

USE disk_inventory
go

BEGIN TRY
EXEC sp_InsertArtist
'Nirvana'
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT ERROR_MESSAGE();
	PRINT 'Check your inputs.';
END CATCH
GO

/***************************** UPDATE FOR ARTIST ************************************/
use disk_inventory
go

IF OBJECT_ID('sp_UpdateArtist') is not null
DROP PROC sp_UpdateArtist
go 

CREATE PROC sp_UpdateArtist
			@Artist_ID int
		,	@Artist_Name char(20)

as
BEGIN 
UPDATE Artist
SET Arist_Name = @Artist_Name
where Artist_ID = @Artist_ID
END
go

use disk_inventory
go
BEGIN TRY
exec sp_UpdateArtist
21, 'GreenDay'
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT ERROR_Message();
	PRINT 'Check your inputs.';
END CATCH
go

/***************************** Delete FOR ARTIST ************************************/
USE disk_inventory
go

IF OBJECT_ID('sp_DeleteArtist') is not null
DROP PROC sp_DeleteArtist
go

CREATE PROC sp_DeleteArtist
			@Artist_ID int
as
BEGIN 
DELETE Artist
WHERE @Artist_ID = Artist_ID
END 
GO

BEGIN TRY
EXEC sp_DeleteArtist 21
END TRY 
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT ERROR_MESSAGE();
	PRINT 'Check your inputs.';
END CATCH
go

/********************************** INSERT FOR BORROWERS ****************************************/

USE disk_inventory
GO

IF OBJECT_ID('sp_InsertBorrower') is not null
DROP PROC sp_InsertBorrower
go 

CREATE PROC sp_InsertBorrower
			@Borrower_FName char(20)
		,	@Borrower_LName Char(20)
		,	@Borrower_Email char(20)

as 
INSERT INTO Borrower(Borrower_Fname, Borrower_Lname, Borrower_Email)
Values(@Borrower_FName, @Borrower_LName, @Borrower_Email)
go

USE disk_inventory
go

BEGIN TRY
EXEC sp_InsertBorrower
'Bob',
'Dylan',
'Fake@email.com'
END TRY
BEGIN CATCH
PRINT 'An error occurred.';
	PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
	IF ERROR_NUMBER() >= 50000
		PRINT 'Check your inputs.';
END CATCH

/************************** UPDATE FOR BORROWER *****************************/
use disk_inventory
go

IF OBJECT_ID('sp_UpdateBorrower') is not null
DROP PROC sp_UpdateBorrower
go 

CREATE PROC sp_UpdateBorrower
			@Borrower_ID int
		,	@Borrower_FName char(20)
		,	@Borrower_LName Char(20)
		,	@Borrower_Email char(20)

as
BEGIN 
UPDATE Borrower
SET Borrower_Fname = @Borrower_FName, Borrower_Lname = @Borrower_LName, Borrower_Email = @Borrower_Email
where Borrower_ID = @Borrower_ID
END
go

use disk_inventory
go
BEGIN TRY
exec sp_UpdateBorrower
21, 'BOB', 'DYLAN', 'Email@Email.com'
END TRY
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT ERROR_Message();
	PRINT 'Check your inputs.';
END CATCH
go

/************************** DELETE FOR BORROWER *****************************/
use disk_inventory
go

IF OBJECT_ID('sp_DeleteBorrower') is not null
DROP PROC sp_DeleteBorrower
go 

CREATE PROC sp_DeleteBorrower
			@Borrower_ID int
as
BEGIN 
DELETE Borrower
WHERE @Borrower_ID = Borrower_ID
END 
GO

BEGIN TRY
EXEC sp_DeleteBorrower 21
END TRY 
BEGIN CATCH
	PRINT 'An error occurred.';
	PRINT ERROR_MESSAGE();
	PRINT 'Check your inputs.';
END CATCH
go