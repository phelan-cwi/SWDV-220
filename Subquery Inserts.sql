Insert into diskHasBorrower(Borrower_ID, Disk_ID, Borrow_Date)
VALUES(
	(SELECT Borrower_ID
	FROM Borrower
	WHERE Borrower_Fname = 'Joe' and Borrower_LName = 'Guy'),

	(select disk_id
	from Disk
	where Disk_Name = 'Something Regular'),

	GetDate()
	)
Select * From diskHasBorrower
