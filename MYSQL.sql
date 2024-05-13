-- drop database hotel
create database hotel;
use hotel;

-- tables
CREATE TABLE RoomType (
	RoomTypeID int NOT NULL auto_increment,
	RoomTypeDescription varchar(100),
    NumberOfPeople int NOT NULL,
    PRIMARY KEY (RoomTypeID) );


CREATE TABLE Equipment(
	EquipmentID int NOT NULL auto_increment,
	EquipmentName varchar(100) NOT NULL,
	EquipmentBrand varchar(100) NOT NULL,
	PurchaseDate datetime,
    TypeOfBeds varchar(100),
	TypeOfToilet varchar(100),
	PRIMARY KEY (EquipmentID) );
    
    CREATE TABLE RoomTypeEquipment(
	RoomTypeEquipmentID int NOT NULL auto_increment,
	RoomTypeID int NOT NULL,
	EquipmentID int NOT NULL,
	FOREIGN KEY (RoomTypeID) REFERENCES RoomType(RoomTypeID),
	FOREIGN KEY (EquipmentID) REFERENCES Equipment(EquipmentID),
	PRIMARY KEY (RoomTypeEquipmentID) );

CREATE TABLE RoomLocation(
	RoomlocationID int NOT NULL auto_increment,
	RoomlocationDescription varchar(100),
    PRIMARY KEY (RoomlocationID) );

CREATE TABLE Hotel(
	HotelID int NOT NULL auto_increment,
	HotelName varchar(100) NOT NULL,
	Address varchar(100),
	StarRating int,
    PRIMARY KEY (HotelID) );

CREATE TABLE Service(
	ServiceID int NOT NULL auto_increment,
	ServiceDescription varchar(100) NOT NULL,
	ServiceCost decimal(16,2) NOT NULL,
	PRIMARY KEY (ServiceID) );

CREATE TABLE ExecutionRealization(
	ExecutionRealizationID int NOT NULL auto_increment,
	ExecutionRealizationDescription varchar(100),
	PRIMARY KEY (ExecutionRealizationID) );    

CREATE TABLE Room(
	RoomNumber int NOT NULL ,
	RoomTypeID int NOT NULL,
	RoomlocationID int NOT NULL,
	HotelID int NOT NULL,
	RoomPrice decimal(16,2) NOT NULL,
	Ocupancy bit,
	FOREIGN KEY (RoomTypeID) REFERENCES RoomType(RoomTypeID),
	FOREIGN KEY (RoomlocationID) REFERENCES Roomlocation(RoomlocationID),
	FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
    PRIMARY KEY (RoomNumber) );

CREATE TABLE Role(
	RoleID int NOT NULL auto_increment,
	RoleTitle varchar(100) NOT NULL,
	RoomDescription varchar(100),
    PRIMARY KEY (RoleID) );

CREATE TABLE Employee(
	EmployeeID int NOT NULL auto_increment,
	HotelID int NOT NULL,
	RoleID int NOT NULL,
	FirstName varchar(100) NOT NULL,
	LastName varchar(100) NOT NULL,
	Salary decimal(16,2) NOT NULL,
	HireDate datetime,
	FOREIGN KEY (HotelID) REFERENCES Hotel(HotelID),
	FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
    PRIMARY KEY (EmployeeID) );

CREATE TABLE GuestType(
	GuestTypeID int NOT NULL auto_increment,
	GuestTypeDescription varchar(100),
    PRIMARY KEY (GuestTypeID) );

CREATE TABLE Guest(
	GuestID int NOT NULL auto_increment,
	GuestTypeID int NOT NULL,
	FirstName varchar(100) NOT NULL,
	LastName varchar(100) NOT NULL,
	LastBookingDate datetime, 
	FOREIGN KEY (GuestTypeID) REFERENCES GuestType(GuestTypeID),
    PRIMARY KEY (GuestID) );

CREATE TABLE BookingRealization(
	BookingRealizationID int NOT NULL auto_increment,
	BookingRealizationDescription varchar(100) NOT NULL,
	BookingRealization datetime,
	PRIMARY KEY (BookingRealizationID) );
    
CREATE TABLE Booking(
	BookingID int NOT NULL auto_increment,
	GuestID int NOT NULL,
	BookingRealizationID int NOT NULL,
	BookingDate datetime NOT NULL,
	FOREIGN KEY (GuestID) REFERENCES Guest(GuestID),
	FOREIGN KEY (BookingRealizationID) REFERENCES BookingRealization(BookingRealizationID),
    PRIMARY KEY (BookingID) );
    
     CREATE TABLE BookingDetails(
	BookingDetailsID int NOT NULL auto_increment,
	BookingID int NOT NULL,
	RoomNumber int NOT NULL,
	CheckInDate datetime NOT NULL,
	CheckOutDate datetime NOT NULL,
	PurchasePrice decimal(16,2),
	NumberOfNights int,
	FOREIGN KEY (BookingID) REFERENCES Booking(BookingID),
	FOREIGN KEY (RoomNumber) REFERENCES Room(RoomNumber),
    PRIMARY KEY (BookingDetailsID) );
    
     CREATE TABLE Execution(
	ExecutionID int NOT NULL auto_increment,
	ServiceID int NOT NULL ,
	BookingDetailsID int NOT NULL ,
	ExecutionRealizationID int NOT NULL ,
	ExecutionDate datetime,
	FOREIGN KEY (ServiceID) REFERENCES Service(ServiceID),
	FOREIGN KEY (BookingDetailsID) REFERENCES BookingDetails(BookingDetailsID),
	FOREIGN KEY (ExecutionRealizationID) REFERENCES ExecutionRealization(ExecutionRealizationID),
	PRIMARY KEY (ExecutionID) );



    
-- dane
insert into RoomType (RoomTypeDescription, NumberOfPeople) values ('Budget',1);
insert into RoomType (RoomTypeDescription,NumberOfPeople) values ('Standard',2);

insert into Equipment (EquipmentName, EquipmentBrand) values ('lozko z pojemnikiem','IDANÄS');
insert into Equipment (EquipmentName, EquipmentBrand) values ('lozko z pojemnikiem','MALM');

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

insert into RoomLocation (RoomlocationDescription) values ('Garden View');
insert into RoomLocation (RoomlocationDescription) values ('Pool View');

insert into Hotel (HotelName, Address, StarRating) values ('Matiott', 'al. Jerozolimskie 65/79, 00-697 Warszawa', 4);

insert into Room values (101,1,1,1,100,0);
insert into Room values (201,2,1,1,150,0);
insert into Room values (102,1,2,1,150,0);
insert into Room values (202,2,2,1,200,0);

insert into Role (RoleTitle) values ('Manager');
insert into Role (RoleTitle) values ('Recepcionist');
insert into Role (RoleTitle) values ('Hotel Maid');

insert into Employee (HotelID,RoleID,FirstName, LastName, Salary, HireDate) values (1,1,'Kamil','Papaj', 5000, '20200101');
insert into Employee (HotelID,RoleID,FirstName, LastName, Salary, HireDate) values (1,2,'Ilona','Papaj', 3000, '20200101');
insert into Employee (HotelID,RoleID,FirstName, LastName, Salary, HireDate) values (1,3,'Michal','Wilno', 2000, '20210101');

insert into GuestType (GuestTypeDescription)  values ('Corporate');
insert into GuestType (GuestTypeDescription) values ('Individual');

insert into Guest  (GuestTypeID,FirstName,LastName) values (1,'Karolina','Ciesla');
insert into Guest  (GuestTypeID,FirstName,LastName) values (2,'Piotr','Osiol');
    

insert into BookingRealization (BookingRealizationDescription) values ('oczekujaca na platnosc');
insert into BookingRealization (BookingRealizationDescription) values ('oczekujaca na potwierdzenie');
insert into BookingRealization (BookingRealizationDescription) values ('potwierdzona');
insert into BookingRealization (BookingRealizationDescription) values ('odwoaana');
insert into BookingRealization (BookingRealizationDescription) values ('zrealizowana');


insert into Booking  (GuestID, BookingRealizationID,BookingDate) values (1, 5,'20221230');
insert into Booking  (GuestID, BookingRealizationID, BookingDate) values (2,5, '20221130');


insert into BookingDetails  (BookingID, RoomNumber, CheckInDate, CheckOutDate, NumberOfNights)  values (1,101, '20221230', '20221231',1);
insert into BookingDetails  (BookingID, RoomNumber, CheckInDate, CheckOutDate, NumberOfNights)  values (1,102, '20221230', '20221231',1);
insert into BookingDetails  (BookingID, RoomNumber, CheckInDate, CheckOutDate, NumberOfNights)  values (2,202, '20221229', '20221231',2);
insert into BookingDetails  (BookingID, RoomNumber, CheckInDate, CheckOutDate, NumberOfNights)  values (2,201, '20221229', '20221231',2);


insert into Execution(ServiceID,BookingDetailsID,ExecutionRealizationID) values (1,1,2);
insert into Execution(ServiceID,BookingDetailsID,ExecutionRealizationID) values (3,2,3);
insert into Execution(ServiceID,BookingDetailsID,ExecutionRealizationID) values (5,1,3);


-- widok1
-- select * from corporate_guest_Views
Create view corporate_guest_Views
as

select FirstName,LastName,BookingDate 
	from Guest g
	join Booking b on b.GuestID=g.GuestID
	where GuestTypeID=1;

-- widok2 materialised
-- select * from BookedRooms
CREATE TABLE BookedRooms (
  RoomNumber INT,
  `Number of Bookings` INT
);

INSERT INTO BookedRooms (RoomNumber, `Number of Bookings`)
SELECT r.RoomNumber, COUNT(*) `Number of Bookings`
FROM Room AS r
JOIN BookingDetails AS bd ON r.RoomNumber=bd.RoomNumber
GROUP BY r.RoomNumber;

CREATE EVENT update_booked_rooms
ON SCHEDULE
  EVERY 1 HOUR
DO
  BEGIN
    TRUNCATE TABLE BookedRooms;
    INSERT INTO BookedRooms (RoomNumber, `Number of Bookings`)
    SELECT r.RoomNumber, COUNT(*) `Number of Bookings`
    FROM Room AS r
    JOIN BookingDetails AS bd ON r.RoomNumber=bd.RoomNumber
    GROUP BY r.RoomNumber;
  END


-- widok3 funkcyjny
-- select * from GuestBookingBucket

CREATE  VIEW GuestBookingBucket
   AS
      SELECT g.FirstName, g.LastName,
	  case when count(b.GuestID) = 0 then 'Not a guest yet' 
	  when count(b.GuestID) <3 then  'Up to 3 booking' 
	  else 'Regular client' end GuestCategory
      FROM Guest g 
	  left join Booking b on b.GuestID=g.GuestID
	  group by g.FirstName, g.LastName;

  
-- trigger 1

create trigger NumberOfNights before update
on BookingDetails
for each row

update BookingDetails
set NumberOfNights=datediff(CheckInDate,CheckOutDate);

-- trigger 2

DELIMITER $$
CREATE trigger NoSalaryupdate before update
on Employee
for each row
begin

if new.salary=old.salary then
  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Salary update not allowed';
  end if;
END$$

-- trigger 3

create trigger LastbookingDate before insert on Booking
for each row

update guest
join (select guestid, max(bookingdate) bookingdate from  booking group by guestid) b on g.GuestId=b.GuestID
set LastBookingDate=bookingdate;

-- index

create index bookingdateIndex on Booking(BookingDate);

-- procedura
--  CALL InsertNewGuest('Julia','Nowak',1)
DELIMITER $$
CREATE PROCEDURE InsertNewGuest ( in PFirstName varchar(50), in PLastName varchar(50), in PGuestType int)
BEGIN

       START TRANSACTION;
                     -- Insert into PersonalDetails table first
                     INSERT INTO Guest
                            (GuestTypeID,FirstName, LastName)
                     VALUES
                            (PGuestType,PFirstName, PLastName);                     
              -- if not error, commit the transcation
	COMMIT;
END$$

-- procedura z petla
-- CALL ListOfEquipment()
DELIMITER $$
create procedure ListOfEquipment()
begin
DECLARE i INT;

set i =1;

loop_label:  LOOP

if i > (select max(EquipmentID) from Equipment) then

			LEAVE  loop_label;
		END  IF;
		select * from Equipment where EquipmentID=i;
		SET i = i + 1;
        
END LOOP;
END$$

CALL ListOfEquipments()

-- procedura 3

create  procedure RoomPriceRise ( in pkwota decimal(16,2) ) 

update room
set RoomPrice=RoomPrice+pkwota;

-- function 1

DELIMITER $$
CREATE FUNCTION `isoccupied` (Proomnumber int, proomdate datetime)
RETURNS INTEGER DETERMINISTIC
BEGIN

 DECLARE POccupancy integer;

select count(r.RoomNumber) into POccupancy from room r
join bookingdetails bd on bd.RoomNumber=r.RoomNumber
where r.RoomNumber=@roomnumber and @roomdate between CheckInDate and CheckOutDate;

RETURN POccupancy;
END$$


-- function 2
DELIMITER $$
create  FUNCTION bookedroomsbyguest
    (
      PguestID INT
    )
RETURNS VARCHAR(1000) DETERMINISTIC
    BEGIN
        DECLARE PBookedrooms VARCHAR(1000);
        DECLARE PITEM VARCHAR(100);
        DECLARE RoomCursor CURSOR FOR
            SELECT RoomNumber
            FROM guest g
            LEFT OUTER JOIN Booking b on g.GuestID=b.GuestID
			left join BookingDetails bd on b.BookingID=bd.BookingID
           WHERE g.GuestID = PguestID;

OPEN RoomCursor;
        
getRoom: LOOP
        FETCH RoomCursor INTO PITEM;
                IF ( PBookedrooms = '' ) then
                        SET @Bookedrooms = PITEM;
                ELSE
                        SET @Bookedrooms = concat(PBookedrooms  + ' , ' + PITEM);
				END IF;
END LOOP getRoom;
        CLOSE RoomCursor;
        RETURN @Bookedrooms;
END$$

-- function 3
DELIMITER $$
CREATE FUNCTION employesalary (PemployeID int)
RETURNS INTEGER DETERMINISTIC
BEGIN

 DECLARE Psalary integer;

select salary into Psalary from Employee
where EmployeeID=PemployeID;

RETURN Psalary;
END$$