/********************   Project 3 ************************************
--B
Didn't have some required attributes set right previously such as:

CREATE TABLE diskHasArtist(
Disk_ID int not null REFERENCES Disk(Disk_ID),
Artist_ID int not null REFERENCES Artist(Artist_ID)
);
My disk_ID's are funky because of typos and adding then deleting to make sure it worked. 
If you run it, it may not work for you? I have it all working and setup though.
**********************************************************************/
--C Start of the Inserts, Starting with Disk. Ignore names and what not, completely random.
USE [disk_inventory]
GO
--1
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('Rawr'
           ,'1980-10-11'
           ,'In')
GO
--2
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('Beast'
           ,'1985-9-11'
           ,'In')
GO
--3
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('Megalul'
           ,'1981-12-11'
           , 'In')
GO
--4
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('OmegaLul'
           ,'1982-12-11'
           ,'In')
GO
--5
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('HyperLul'
           ,'1983-12-11'
           ,'In')
GO
--6
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('PepeHands'
           ,'2009-03-11'
           ,'In')
GO
--7
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('PepeRage'
           ,'2015-04-02'
           ,'In')
GO
--8
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('PepeWhy'
           ,'2005-01-23'
           ,'In')
GO
--9
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('FeelsGoodMan'
           ,'2018-10-11'
           ,'In')
GO
--10
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('HeyGuys'
           ,'2015-08-12'
           ,'In')
GO
--11
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('The Way of The Fist'
           ,'2017-9-20'
           , 'Out' )
GO
--12
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('Obvlivion'
           ,'1987-02-20'
           , 'Out')
GO
--13
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('Something Something'
           ,'2013-07-20'
           , 'Out' )
GO
--14
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('The Way of The Fist2'
           ,'2012-09-20'
           , 'In' )
GO
--15
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('The Way of The Fist3'
           ,'2010-09-20'
           , 'Out' )
GO
--16
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('Kung Fuu Chicken'
           ,'2018-9-20'
           , 'Out' )
GO
--17
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('Invisible Man'
           ,'2018-05-20'
           , 'Out' )
GO
--18
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('The Way It Is'
           ,'2013-09-17'
           , 'In' )
GO
--19
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('GreenMile'
           ,'2004-01-20'
           , 'IN' )
GO
--20
INSERT INTO [dbo].[Disk]
           ([Disk_Name]
           ,[Relase_Date]
           ,[LendedStatus])
     VALUES
           ('Something Regular'
           ,'2011-11-12'
           , 'IN' )
GO
--Updates Disk with name of 'The Way It Is" to have a lended status of out instead of in
UPDATE [dbo].[Disk]
   SET [LendedStatus] = 'Out'
 WHERE Disk_Name = 'The Way It Is'
GO

--D Borrower Inerts. LOTS of random people.
--1
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Joe'
		   , 'Guy'
		   ,'Something@gmail.com')
GO
--2
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Sally'
		   , 'Guy'
		   ,'Something2@gmail.com')
GO
--3
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Frank'
		   , 'Guy'
		   ,'Frank@gmail.com')
GO
--4
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Gary'
		   , 'Guy'
		   ,'Gary@gmail.com')
GO
--5
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('John'
		   , 'Schmo'
		   ,'John@gmail.com')
GO
--6
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Someone'
		   , 'Who'
		   ,'Someonewho@gmail.com')
GO
--7
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Johny'
		   , 'McGreg'
		   ,'JohnyMcGreg@gmail.com')
GO
--8
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Tiffany'
		   , 'Steele'
		   ,'TSteele@gmail.com')
GO
--9
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Brittany'
		   , 'Swan'
		   ,'BSwan@gmail.com')
GO
--10
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Monkey'
		   , 'Boy'
		   ,'MBoy@gmail.com')
GO
--11
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Manny'
		   , 'Beans'
		   ,'MBeans@gmail.com')
GO
--12
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Randy'
		   , 'Bean'
		   ,'RBean@gmail.com')
GO
--13
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Dave'
		   , 'Jake'
		   ,'DJake@gmail.com')
GO
--14
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Julie'
		   , 'Jay'
		   ,'JJay@gmail.com')
GO
--15
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Kobe'
		   , 'Jay'
		   ,'KJay@gmail.com')
GO
--16
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('AJ'
		   , 'Stiles'
		   ,'AStiles@gmail.com')
GO
--17
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Bagger'
		   , 'Brown'
		   ,'BBrown@gmail.com')
GO
--18
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Lord'
		   , 'Help'
		   ,'LHelp@gmail.com')
GO
--19
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('Save'
		   , 'Me'
		   ,'SMe@gmail.com')
GO
--20
INSERT INTO [dbo].[Borrower]
           ([Borrower_Fname]
           ,[Borrower_Lname]
           ,[Borrower_Email])
     VALUES
           ('The'
		   , 'End'
		   ,'TheEnd@gmail.com')
GO
--Deletes the borrower who's email is "LHelp@gmail.com" because they NEVER return disks. :(
DELETE FROM [dbo].[Borrower]
      WHERE Borrower_Email = 'LHelp@gmail.com'
GO

--E Artist Inserts. Just a bunch of random Arist names. Keep it simple
--1
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('JQuan')
GO
--2
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('M. Night Shamalam')
GO
--3
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Laquanda')
GO
--4
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Manquini')
GO
--5
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('TJ Miller')
GO
--6
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('The Rock')
GO
--7
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Stone Cold')
GO
--8
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Mankind')
GO
--9
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Stone Temple Pilots')
GO
--10
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Man Bun')
GO
--11
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Petty Pablo')
GO
--12
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Jesus')
GO
--13
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Kim Jong Un')
GO
--14
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Some Guy')
GO
--15
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('God Almight')
GO
--16
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('All Mighty Budda')
GO
--17
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Sheva')
GO
--18
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Elephant Man')
GO
--19
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('LaFonda')
GO
--20
INSERT INTO [dbo].[Artist]
           ([Arist_Name])
     VALUES
           ('Sister Mary')
GO

/* F 
Disk has Borrower Table Inserts... Oh boy. 
 20 rows 
,2 different disks
,2 different borrowers 
,1 disk borrowed by same person twice
,1 disk doesn't have related row here?
,1 disk with two different rows E.G: Borrowed by two people?
,1 borrow does not have a related row 
,1 borrow must have two different rows E.G: Two different times he/she borrowed. Done.
*/
--1 F8-1 Same Borrower row 1
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,null
           ,12
           ,2)
GO
--2 F8-2 Same Borrower row 2
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,null
           ,13
           ,2)
GO
--3 F7?
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           (''
           ,null
           ,null
           ,18)
GO
--4 F6
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-09-28'
           ,'2019-09-30'
           ,19
           ,10)
GO
--5 F5?
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           (''
           ,null
           ,20
           ,null)
GO
--6
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,null
           ,14
           ,5)
GO
--7
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,'2018-10-12'
           ,20
           ,11)
GO
--8
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,'2018-10-12'
           ,18
           ,7)
GO
--9
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,null
           ,17
           ,8)
GO
--10
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,null
           ,18
           ,9)
GO

--11
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,null
           ,19
           ,11)
GO
--12
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-10-11'
           ,null
           ,25
           ,1)
GO
--13
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-09-20'
           ,'2018-09-21'
           ,12
           ,2)
GO
--14
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-01-03'
           ,'2018-01-05'
           ,21
           ,12)
GO
--15
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-04-23'
           ,'2018-04-25'
           ,4
           ,20)
GO
--16
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-03-23'
           ,'2018-04-01'
           ,7
           ,16)
GO
--17
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-01-21'
           ,'2018-01-24'
           ,24
           ,12)
GO
--18
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-02-23'
           ,'2018-02-25'
           ,10
           ,3)
GO
--19
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-05-13'
           ,'2018-05-25'
           ,11
           ,17)
GO
--20
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-07-03'
           ,'2018-07-05'
           ,6
           ,9)
GO
INSERT INTO [dbo].[diskHasBorrower]
           ([Borrow_Date]
           ,[Return_Date]
           ,[Disk_ID]
           ,[Borrower_ID])
     VALUES
           ('2018-02-23'
           ,'2018-02-25'
           ,10
           ,10)
GO

/* G diskHasArtist Inserts: 
20 rows
, 1 disk with 2 artists
, 2 artists with 1 disk 
*/
--1
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (25
           ,20)
GO
--2
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (2
           ,19)
GO
--3
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (3
           ,18)
GO
--4
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (4
           ,17)
GO
--5
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (5
           ,15)
GO
--6
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (6
           ,14)
GO
--7
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (7
           ,13)
GO
--8
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (8
           ,12)
GO
--9
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (9
           ,11)
GO
--10
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (10
           ,10)
GO
--11
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (11
           ,9)
GO
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (11
           ,10)
GO
--12
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (12
           ,8)
GO
--13
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (13
           ,7)
GO
--14
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (14
           ,6)
GO
--15
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (17
           ,5)
GO
--16
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (18
           ,4)
GO
--17
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (19
           ,3)
GO
--18
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (20
           ,2)
GO
--19
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (21
           ,1)
GO
--20
INSERT INTO [dbo].[diskHasArtist]
           ([Disk_ID]
           ,[Artist_ID])
     VALUES
           (24
           ,1)
GO

--H
SELECT Borrower_ID, Disk_id, Borrow_Date, Return_Date
FROM diskHasBorrower
WHERE Return_Date is NULL