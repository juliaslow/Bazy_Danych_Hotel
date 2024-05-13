--drop database hotel
--create database hotel

use hotel


-- tables
CREATE TABLE [dbo].[RoomType](
	[RoomTypeID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[RoomTypeDescription] varchar(100),
	 NumberOfPeople int NOT NULL)

	 
CREATE TABLE [dbo].[Equipment](
	[EquipmentID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	EquipmentName varchar(100),
	EquipmentBrand varchar(100),
	PurchaseDate datetime,
	TypeOfBeds varchar(100),
	TypeOfToilet varchar(100))

CREATE TABLE [dbo].[RoomTypeEquipment](
	[RoomTypeEquipmentID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	RoomTypeID int NOT NULL,
	EquipmentID int NOT NULL,
	FOREIGN KEY (RoomTypeID) REFERENCES RoomType(RoomTypeID),
	FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID))

CREATE TABLE [dbo].[RoomLocation](
	[RoomlocationID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[RoomlocationDescription] varchar(100))

CREATE TABLE [dbo].[Hotel](
	[HotelID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	HotelName varchar(100) NOT NULL,
	Address varchar(100),
	StarRating int)

CREATE TABLE  [dbo].[Service](
	[ServiceID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ServiceDescription varchar(100) NOT NULL,
	ServiceCost decimal(16,2) NOT NULL)


CREATE TABLE  [dbo].[ExecutionRealization](
	[ExecutionRealizationID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ExecutionRealizationDescription varchar(100))

	--select RoomNumber,RoomPrice FROM Room

CREATE TABLE [dbo].[Room](
	[RoomNumber] [int] NOT NULL PRIMARY KEY,
	[RoomTypeID] [int] NOT NULL,
	[RoomlocationID] [int] NOT NULL,
	[HotelID] [int] NOT NULL,
	[RoomPrice] money NOT NULL,
	[Ocupancy] bit
	FOREIGN KEY ([RoomTypeID]) REFERENCES [RoomType]([RoomTypeID]),
	FOREIGN KEY ([RoomlocationID]) REFERENCES [Roomlocation]([RoomlocationID]),
	FOREIGN KEY ([HotelID]) REFERENCES Hotel([HotelID]))

CREATE TABLE [dbo].[Role](
	[RoleID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[RoleTitle] varchar(100) NOT NULL,
	[RoomDescription] varchar(100))

CREATE TABLE [dbo].[Employee](
	[EmployeeID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[HotelID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
	FirstName varchar(100) NOT NULL,
	LastName varchar(100) NOT NULL,
	Salary money NOT NULL,
	HireDate datetime
	FOREIGN KEY ([HotelID]) REFERENCES Hotel([HotelID]),
	FOREIGN KEY ([RoleID]) REFERENCES [Role]([RoleID]))

CREATE TABLE [dbo].[GuestType](
	[GuestTypeID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[GuestTypeDescription] varchar(100))

	-- select * FROM Guest

CREATE TABLE [dbo].[Guest](
	[GuestID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[GuestTypeID] int NOT NULL,
	FirstName varchar(100) NOT NULL,
	LastName varchar(100) NOT NULL,
	LastBookingDate datetime 
	FOREIGN KEY ([GuestTypeID]) REFERENCES [GuestType]([GuestTypeID]))

	
CREATE TABLE [dbo].[BookingRealization](
	[BookingRealizationID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	BookingRealizationDescription varchar(100) NOT NULL,
	BookingRealization datetime)

	-- select * FROM Booking

CREATE TABLE [dbo].[Booking](
	[BookingID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[GuestID] [int] NOT NULL,
	[BookingRealizationID] [int] NOT NULL,
	BookingDate datetime NOT NULL,
	FOREIGN KEY ([GuestID]) REFERENCES [Guest]([GuestID]),
	FOREIGN KEY ([BookingRealizationID]) REFERENCES [BookingRealization]([BookingRealizationID]))

	--select BookingDetailsID,BookingID,RoomNumber,NumberOfNights FROM BookingDetails

CREATE TABLE [dbo].[BookingDetails](
	[BookingDetailsID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[BookingID] [int] NOT NULL,
	[RoomNumber] [int] NOT NULL,
	[CheckInDate] datetime NOT NULL,
	[CheckOutDate] datetime NOT NULL,
	[PurchasePrice] decimal(16,2),
	[NumberOfNights] [int],
	FOREIGN KEY ([BookingID]) REFERENCES [Booking]([BookingID]),
	FOREIGN KEY ([RoomNumber]) REFERENCES [Room]([RoomNumber]))

	
CREATE TABLE [dbo].[Execution](
	[ExecutionID] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	ServiceID int NOT NULL ,
	BookingDetailsID int NOT NULL ,
	ExecutionRealizationID int NOT NULL ,
	ExecutionDate datetime,
	FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID),
	FOREIGN KEY (BookingDetailsID) REFERENCES BookingDetails(BookingDetailsID),
	FOREIGN KEY (ExecutionRealizationID) REFERENCES ExecutionRealization(ExecutionRealizationID))


--dane

insert into RoomType (RoomTypeDescription,NumberOfPeople) values ('Budget',1);
insert into RoomType (RoomTypeDescription,NumberOfPeople) values ('Standard',2);

insert into Equipment values ('lózko z pojemnikiem','IDANÄS','20231204','king','privet');
insert into Equipment values ('lózko z pojemnikiem','MALM','20231111','single','privet');

insert into RoomTypeEquipment (RoomTypeID, EquipmentID) values (1,1);
insert into RoomTypeEquipment (RoomTypeID, EquipmentID) values (2,2);

insert into ExecutionRealization (ExecutionRealizationDescription) values ('odwolana');
insert into ExecutionRealization (ExecutionRealizationDescription) values ('w realizacji');
insert into ExecutionRealization (ExecutionRealizationDescription)values ('wykonana');

insert into Service(ServiceDescription,ServiceCost) values ('SPA',150);
insert into Service(ServiceDescription,ServiceCost) values ('Pool',50);
insert into Service(ServiceDescription,ServiceCost) values ('drink mojito',20);
insert into Service(ServiceDescription,ServiceCost) values ('water 500ml',5);
insert into Service(ServiceDescription,ServiceCost) values ('drink cuba libre',20);

insert into [Roomlocation] values ('Garden View');
insert into [Roomlocation] values ('Pool View');

insert into [Hotel] values ('Matiott', 'al. Jerozolimskie 65/79, 00-697 Warszawa', 4)

insert into Room values (101,1,1,1,100,0)
insert into Room values (201,2,1,1,150,0)
insert into Room values (102,1,2,1,150,0)
insert into Room values (202,2,2,1,200,0)

insert into [Role] ([RoleTitle]) values ('Manager')
insert into [Role] ([RoleTitle]) values ('Recepcionist')
insert into [Role] ([RoleTitle]) values ('Hotel Maid')

insert into [Employee] values (1,1,'Kamil','Papaj', 5000, '20200101')
insert into [Employee] values (1,2,'Ilona','Papaj', 3000, '20200101')
insert into [Employee] values (1,3,'Michal','Wilno', 2000, '20210101')

insert into GuestType values ('Corporate');
insert into GuestType values ('Individual');

insert into [Guest]  ([GuestTypeID],FirstName,LastName) values (1,'Karolina','Ciesla')
insert into [Guest]  ([GuestTypeID],FirstName,LastName) values (2,'Piotr','Osiol')
insert into [Guest]  ([GuestTypeID],FirstName,LastName) values (1,'Julia','Slow')
insert into [Guest]  ([GuestTypeID],FirstName,LastName) values (1,'Maja','Branowska')
insert into [Guest]  ([GuestTypeID],FirstName,LastName) values (1,'Karol','Kozol')

insert into BookingRealization (BookingRealizationDescription) values ('oczekujaca na platnosc');
insert into BookingRealization (BookingRealizationDescription) values ('oczekujaca na potwierdzenie');
insert into BookingRealization (BookingRealizationDescription) values ('potwierdzona');
insert into BookingRealization (BookingRealizationDescription) values ('odwolana');
insert into BookingRealization (BookingRealizationDescription) values ('zrealizowana');


insert into [Booking](GuestID, BookingRealizationID,BookingDate)   values (1,5,'20221230')
insert into [Booking](GuestID, BookingRealizationID,BookingDate)   values (2,5, '20221130')
insert into [Booking](GuestID, BookingRealizationID,BookingDate)   values (3,4,'20221120')
insert into [Booking](GuestID, BookingRealizationID,BookingDate)   values (4,3,'20220418')
insert into [Booking](GuestID, BookingRealizationID,BookingDate)   values (5,5,'20220317')


insert into [BookingDetails](BookingID, RoomNumber, CheckInDate, CheckOutDate, NumberOfNights)   values (1,101, '20221230', '20221231',1)
insert into [BookingDetails](BookingID, RoomNumber, CheckInDate, CheckOutDate, NumberOfNights)    values (1,102, '20221230', '20221231',1)
insert into [BookingDetails](BookingID, RoomNumber, CheckInDate, CheckOutDate, NumberOfNights)    values (2,202, '20221229', '20221231',2);
insert into [BookingDetails](BookingID, RoomNumber, CheckInDate, CheckOutDate, NumberOfNights)    values (2,201, '20221229', '20221231',2);

insert into Execution(ServiceID,BookingDetailsID,ExecutionRealizationID) values (1,1,2);
insert into Execution(ServiceID,BookingDetailsID,ExecutionRealizationID) values (3,2,3);
insert into Execution(ServiceID,BookingDetailsID,ExecutionRealizationID) values (5,1,3);

go

--widok1


-- select * from CorporateGuestViews


Create view CorporateGuestViews
as

select FirstName,LastName,BookingDate 
from [Guest] g
join [Booking] b on b.GuestID=g.GuestID
where GuestTypeID=1
go

SET NUMERIC_ROUNDABORT OFF;
SET ANSI_PADDING, ANSI_WARNINGS, CONCAT_NULL_YIELDS_NULL, ARITHABORT,
   QUOTED_IDENTIFIER, ANSI_NULLS ON;
go

--widok2 materialised
--select * from BookedRooms

CREATE or alter VIEW dbo.BookedRooms
   WITH SCHEMABINDING
   AS
      SELECT r.RoomNumber, COUNT_BIG(*) [Number of Bookings]
      FROM dbo.Room AS r
	  join dbo.BookingDetails as bd on r.RoomNumber=bd.RoomNumber
      GROUP BY r.RoomNumber
GO

CREATE UNIQUE CLUSTERED INDEX IDX_V1
   ON dbo.BookedRooms (RoomNumber);
GO

--widok3 funkcyjny

--select * from GuestBookingBucket

CREATE or alter VIEW dbo.GuestBookingBucket
   AS
      SELECT g.FirstName, g.LastName,
	  case when count(b.GuestID) = 0 then 'Not a guest yet' 
	  when count(b.GuestID) <3 then  'Up to 3 booking' 
	  else 'Regular client' end GuestCategory
      FROM Guest g 
	  left join Booking b on b.GuestID=g.GuestID
	  group by g.GuestID ,g.FirstName, g.LastName
GO
	

--trigger 1

create trigger NumberOfNights on BookingDetails
for insert, update
as
begin
update BookingDetails
set NumberOfNights=datediff(day,[CheckInDate],[CheckOutDate])
from BookingDetails
end
go


--UPDATE Employee
--SET Salary=5000
--WHERE EmployeeID=1

--trigger 2

create trigger NoSalaryupdate on [Employee]
for update
as
begin
if update (salary)
begin
Raiserror('Salary update not allowed', 16, 1);
end
end
go
--trigger 3
--INSERT INTO Booking (GuestID, BookingDate,BookingRealizationID)
--VALUES (1, '2022-12-01',5);

--UPDATE Booking
--SET BookingDate = '2022-12-02'
--WHERE GuestID = 1;

--DELETE FROM Booking
--WHERE GuestID = 1;

create trigger LastbookingDate on [Booking]
for insert, update, delete
as
begin

update g
set LastBookingDate=bookingdate
from guest g
join (select guestid, max(bookingdate) bookingdate from  booking group by guestid) b on g.GuestId=b.GuestID

end

-- index

create nonclustered index bookingdateIndex on [Booking](BookingDate)
go

-- procedura

--exec dbo.InsertNewGuest 'Julia','Nowak',1

CREATE PROCEDURE [dbo].[InsertNewGuest]
       
       @FirstName varchar(50),
       @LastName varchar(50),
       @GuestType int
AS
BEGIN
		SET NOCOUNT ON;

       BEGIN TRAN
       BEGIN TRY
              -- Insert into PersonalDetails table first
            INSERT INTO Guest ([GuestTypeID],FirstName, LastName)
				VALUES (@GuestType,@FirstName, @LastName)     
                                  
              -- if not error, commit the transcation
			COMMIT TRANSACTION
		END TRY
       BEGIN CATCH
              -- if error, roll back any chanegs done by any of the sql statements
              ROLLBACK TRANSACTION
       END CATCH

END
go

--procedura z petla 2

exec dbo.ListOfEquipment 

create or alter procedure ListOfEquipment as 

DECLARE @i INT = 1;

WHILE @i <= (select max(EquipmentID) from [dbo].[Equipment])
	BEGIN
		select * from [Equipment] where EquipmentID=@i;
		SET @i = @i + 1
	end
go
--procedura 3

-- exec dbo.RoomPriceRise 5

create or alter procedure RoomPriceRise @kwota money as 

update room
set [RoomPrice]=[RoomPrice]+@kwota
go

--function 1

--select dbo.isoccupied(202,'2022-12-30')

create or alter function isoccupied( @roomnumber int, @roomdate datetime)

returns integer

as
begin

	DECLARE @Occupancy integer


	select @Occupancy=isnull(count(r.RoomNumber),1) from room r
		join bookingdetails bd on bd.RoomNumber=r.RoomNumber
		where r.RoomNumber=@roomnumber and @roomdate between CheckInDate and CheckOutDate;

	return @Occupancy
end

go

--function 2

--select dbo.bookedroomsbyguest(2)

create or ALTER FUNCTION bookedroomsbyguest
    (
      @guestID INT
    )
RETURNS VARCHAR(1000)
AS
    BEGIN
        DECLARE @Bookedrooms VARCHAR(1000)
        DECLARE @ITEM VARCHAR(100)
        SET @Bookedrooms = '';
        DECLARE RoomCursor CURSOR FAST_FORWARD
        FOR
            SELECT ISNULL(RoomNumber,'')
            FROM guest g
            LEFT OUTER JOIN Booking b on g.GuestID=b.GuestID
			left join BookingDetails bd on b.BookingID=bd.BookingID
           WHERE g.GuestID = @guestID

        OPEN RoomCursor

        FETCH NEXT FROM RoomCursor INTO @ITEM

        WHILE @@FETCH_STATUS = 0
            BEGIN
                IF ( @Bookedrooms = '' )
                    BEGIN
                        SET @Bookedrooms = @ITEM;
                    END
                ELSE
                    BEGIN
                        SET @Bookedrooms = @Bookedrooms + ' , ' + @ITEM ;
                    END
                FETCH NEXT FROM RoomCursor INTO @ITEM
            END


        CLOSE RoomCursor
        DEALLOCATE RoomCursor 

        RETURN @Bookedrooms

    END
go

	--function 3

--select dbo.employesalary(2)

create or alter function employesalary( @employeID int)

returns integer

as
begin

DECLARE @salary integer



select @salary=salary from Employee
where EmployeeID=@employeID

return @salary
end