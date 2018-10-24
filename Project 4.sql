--Project 4
/*
I want to preface this by saying, I had no idea that these were supposed to be real disk and what not. I important just random names, dates, artists, and etc.
Step 1 is supposed to show things with first name and last name. Which would just be

SELECT Disk_Name as [Disk Name], Relase_Date as 'Release Date', Arist_FName as 'First Name', Artist_LName as 'Last Name'
FROM Disk 
JOIN diskHasArtist on disk.Disk_ID = diskHasArtist.Disk_ID
JOIN Artist on diskHasArtist.Artist_ID = Artist.Artist_ID

would display what is asked instead of just the artist name which is what my database is. 
*/
--3
use disk_inventory
go

SELECT Disk_Name as [Disk Name], Convert(varchar, Relase_Date, 101) as 'Release Date', Arist_Name as 'Artist Name'
FROM Disk 
join diskHasArtist 
on disk.Disk_ID = diskHasArtist.Disk_ID
JOIN Artist on diskHasArtist.Artist_ID = Artist.Artist_ID
go

--4
/*this would do what 4 is supposed to do if I had first and last name as rows.
USE disk_inventory
go
CREATE VIEW View_individual_Artist
as 
select Artist_ID, Artist_FName as 'First Name', Artist_LName as 'Last Name'
FROM Artist
order by Artist_Fname, Artist_LName
go
Select * FROM View_individual_Artist
go
****However as I stated in the beginning, it won't work due to first and last name not existing.*/
USE disk_inventory
go
CREATE VIEW View_individual_Artist
as
select Artist.Artist_ID, Arist_Name, Disk.Disk_ID, Convert(varchar, Relase_Date, 101) as 'Release Date'
FROM Artist
JOIN diskHasArtist on artist.Artist_ID = diskHasArtist.Artist_ID
JOIN Disk on disk.Disk_ID = diskHasArtist.Disk_ID
go


use disk_inventory
go
Select Arist_Name from View_individual_Artist

--5
Select Disk_Name as 'Disk Name', convert(varchar, Relase_Date, 101) as 'Release Date', Arist_Name as 'Group Name'
FROM View_individual_Artist join Disk on disk.Disk_ID = View_individual_Artist.Disk_ID
ORDER BY  [Group Name], [Disk Name]

--6
select Borrower_LName as 'Last Name', Borrower_FName as 'First Name', Disk_Name as 'Disk Name', convert(varchar, Borrow_Date, 1) as 'Borrowed Date' 
FROM diskHasBorrower 
JOIN Borrower on diskHasBorrower.Borrower_ID = Borrower.Borrower_ID
JOIN Disk on diskHasBorrower.Disk_ID = Disk.Disk_ID
WHERE Return_Date is NOT NULL
ORDER BY [Last Name]
go
--7
select diskHasBorrower.Disk_ID, Disk_Name, count(diskHasBorrower.Disk_ID) as 'Times Borrowed'
FROM DISK JOIN diskHasBorrower on disk.Disk_ID = diskHasBorrower.Disk_ID
group by Disk_Name, diskhasborrower.Disk_ID
go

--8
SELECT Disk_Name as 'Disk Name', Convert(varchar, Borrow_Date, 1) as 'Borrowed', Return_Date as 'Return Date', Borrower_Lname as 'Last Name' 
FROM diskHasBorrower 
join Borrower on Borrower.Borrower_ID = diskHasBorrower.Borrower_ID
join Disk on Disk.Disk_ID = diskHasBorrower.Disk_ID
WHERE Return_Date is NULL
order by Disk_Name
