--Create a Database Hotel Management System--
CREATE DATABASE HotelManagement
GO

--crteate log in for Hotel Management Database--
CREATE LOGIN Operator WITH PASSWORD=N'123456', DEFAULT_DATABASE = HotelManagement
GO

ALTER SERVER ROLE dbcreator ADD MEMBER Operator
GO
--create user for  Hotel Management Database--
CREATE USER Operator FOR LOGIN Operator WITH DEFAULT_SCHEMA = dbo
GO

ALTER  ROLE [db_owner] ADD MEMBER Operator
go
GRANT select,insert,update,delete,execute
on schema :: dbo
to Operator
GO

-- Create the Hotel table
CREATE TABLE Hotel (
  hotel_id INT PRIMARY KEY,
  hotel_name VARCHAR(50),
  address VARCHAR(200),
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100)
);

-- Create the Room table
CREATE TABLE Room (
  room_id INT PRIMARY KEY,
  hotel_id INT,
  room_number VARCHAR(50),
  room_type VARCHAR(100),
  price_per_night DECIMAL(10, 2),
  capacity INT,
  CONSTRAINT fk_hotel_room FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id),
  CHECK (price_per_night > 0),
  CHECK (capacity > 0)
);

-- Create the Guest table
CREATE TABLE Guest (
  guest_id INT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(255),
  phone VARCHAR(20)
);

-- Create the Booking table
CREATE TABLE Booking (
  booking_id INT PRIMARY KEY,
  guest_id INT,
  room_id INT,
  check_in_date DATE,
  check_out_date DATE,
  total_cost DECIMAL(10, 2),
  CONSTRAINT fk_guest_booking FOREIGN KEY (guest_id) REFERENCES Guest(guest_id),
  CONSTRAINT fk_room_booking FOREIGN KEY (room_id) REFERENCES Room(room_id),
  CHECK (check_in_date < check_out_date),
  CHECK (total_cost >= 0)
);

-- Create the Payment table
CREATE TABLE Payment (
  payment_id INT PRIMARY KEY,
  booking_id INT,
  payment_date DATE,
  amount DECIMAL(10, 2),
  payment_method VARCHAR(100),
  transaction_id VARCHAR(100),
  CONSTRAINT fk_booking_payment FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
  CHECK (amount >= 0)
);

-- Create the Employee table
CREATE TABLE Employee (
  employee_id INT PRIMARY KEY,
  first_name VARCHAR(100),
  last_name VARCHAR(100),
  email VARCHAR(255),
  phone VARCHAR(20),
  position VARCHAR(100),
  CHECK (position IN ('Manager', 'Receptionist', 'Housekeeping', 'Maintenance'))
);

-- Create the ReservationStatus table
CREATE TABLE ReservationStatus (
  status_id INT PRIMARY KEY,
  status_name VARCHAR(100),
  description VARCHAR(255)
);
-- Insert values into the Hotel table
INSERT INTO Hotel (hotel_id, hotel_name, address, city, state, country)
VALUES
  (1, 'Hotel A', '123 Main Street', 'Dhaka', 'Dhaka', 'Bangladesh'),
  (2, 'Hotel B', '456 Park Road', 'Chittagong', 'Chittagong', 'Bangladesh'),
  (3, 'Hotel C', '789 Avenue', 'Sylhet', 'Sylhet', 'Bangladesh'),
  (4, 'Hotel D', '321 Central Avenue', 'Rajshahi', 'Rajshahi', 'Bangladesh'),
  (5, 'Hotel E', '654 West Street', 'Khulna', 'Khulna', 'Bangladesh'),
  (6, 'Hotel F', '987 North Road', 'Barisal', 'Barisal', 'Bangladesh');

-- Insert values into the Room table
INSERT INTO Room (room_id, hotel_id, room_number, room_type, price_per_night, capacity)
VALUES
  (1, 1, '101', 'Standard', 1000, 2),
  (2, 1, '102', 'Standard', 1000, 2),
  (3, 2, '201', 'Deluxe', 2000, 3),
  (4, 2, '202', 'Deluxe', 2000, 3),
  (5, 3, '301', 'Suite', 3000, 4),
  (6, 3, '302', 'Suite', 3000, 4);

-- Insert values into the Guest table
INSERT INTO Guest (guest_id, first_name, last_name, email, phone)
VALUES
  (1, 'A.S.M', 'Sayem', 'asm.sayem@example.com', '123456789'),
  (2, 'SAIDUL', 'ISLAM', 'saidul.islam@example.com', '987654321'),
  (3, 'Mazhar', 'Raihan', 'mazhar.raihan@example.com', '456789123'),
  (4, 'Sarah', 'Jabin', 'sarah.jabin@example.com', '789123456'),
  (5, 'Mohammad', 'Osman', 'mohammad.osman@example.com', '321654987'),
  (6, 'Nayem', 'Sharif', 'nayem.sharif@example.com', '654987321');

-- Insert values into the Booking table
INSERT INTO Booking (booking_id, guest_id, room_id, check_in_date, check_out_date, total_cost)
VALUES
  (1, 1, 1, '2023-06-15', '2023-06-17', 2000),
  (2, 2, 3, '2023-06-16', '2023-06-20', 8000),
  (3, 3, 5, '2023-06-18', '2023-06-22', 12000),
  (4, 4, 2, '2023-06-19', '2023-06-21', 2000),
  (5, 5, 6, '2023-06-20', '2023-06-25', 15000),
  (6, 6, 4, '2023-06-22', '2023-06-24', 4000);

-- Insert values into the Payment table
INSERT INTO Payment (payment_id, booking_id, payment_date, amount, payment_method, transaction_id)
VALUES
  (1, 1, '2023-06-17', 2000, 'Credit Card', 'ABC123'),
  (2, 2, '2023-06-20', 8000, 'Cash', 'DEF456'),
  (3, 3, '2023-06-22', 12000, 'Credit Card', 'GHI789'),
  (4, 4, '2023-06-21', 2000, 'Cash', 'JKL012'),
  (5, 5, '2023-06-25', 15000, 'Debit Card', 'MNO345'),
  (6, 6, '2023-06-24', 4000, 'Credit Card', 'PQR678');

-- Insert values into the Employee table
INSERT INTO Employee (employee_id, first_name, last_name, email, phone, position)
VALUES
  (1, 'Tamzid', 'Ahammad', 'Tamzid.Ahammad@example.com', '123456789', 'Manager'),
  (2, 'Jamir', 'Uddin', 'Jamir.Uddin@example.com', '987654321', 'Receptionist'),
  (3, 'Rezaur', 'Rahman', 'Rezaur.Rahman@example.com', '456789123', 'Housekeeping'),
  (4, 'Jisha', 'Chy', 'Jishan.Chy@example.com', '789123456', 'Maintenance'),
  (5, 'Ahmed', 'Khan', 'Ahmed.Khan@example.com', '321654987', 'Receptionist'),
  (6, 'Niaz', 'Ahmed', 'Niaz.Ahmed@example.com', '654987321', 'Housekeeping');

-- Insert values into the ReservationStatus table
INSERT INTO ReservationStatus (status_id, status_name, description)
VALUES
  (1, 'Confirmed', 'Booking has been confirmed.'),
  (2, 'Pending', 'Booking is awaiting confirmation.'),
  (3, 'Cancelled', 'Booking has been cancelled.'),
  (4, 'Checked-In', 'Guest has checked in.'),
  (5, 'Checked-Out', 'Guest has checked out.'),
  (6, 'No-Show', 'Guest did not show up for the booking.');
  -- Create a stored procedure for creating the Hotel table
CREATE PROCEDURE CreateHotelTable
AS
BEGIN
    CREATE TABLE Hotel (
        hotel_id INT PRIMARY KEY,
        hotel_name VARCHAR(50),
        address VARCHAR(255),
        city VARCHAR(100),
        state VARCHAR(100),
        country VARCHAR(100)
    );
END;

-- Create a stored procedure for creating the Room table
CREATE PROCEDURE CreateRoomTable
AS
BEGIN
    CREATE TABLE Room (
        room_id INT PRIMARY KEY,
        hotel_id INT,
        room_number VARCHAR(50),
        room_type VARCHAR(100),
        price_per_night DECIMAL(10, 2),
        capacity INT,
        CONSTRAINT fk_hotel_room FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id),
        CHECK (price_per_night > 0),
        CHECK (capacity > 0)
    );
END;

-- Create a stored procedure for creating the Guest table
CREATE PROCEDURE CreateGuestTable
AS
BEGIN
    CREATE TABLE Guest (
        guest_id INT PRIMARY KEY,
        first_name VARCHAR(100),
        last_name VARCHAR(100),
        email VARCHAR(255),
        phone VARCHAR(20)
    );
END;

-- Create a stored procedure for creating the Booking table
CREATE PROCEDURE CreateBookingTable
AS
BEGIN
    CREATE TABLE Booking (
        booking_id INT PRIMARY KEY,
        guest_id INT,
        room_id INT,
        check_in_date DATE,
        check_out_date DATE,
        total_cost DECIMAL(10, 2),
        CONSTRAINT fk_guest_booking FOREIGN KEY (guest_id) REFERENCES Guest(guest_id),
        CONSTRAINT fk_room_booking FOREIGN KEY (room_id) REFERENCES Room(room_id),
        CHECK (check_in_date < check_out_date),
        CHECK (total_cost >= 0)
    );
END;

-- Create a stored procedure for creating the Payment table
CREATE PROCEDURE CreatePaymentTable
AS
BEGIN
    CREATE TABLE Payment (
        payment_id INT PRIMARY KEY,
        booking_id INT,
        payment_date DATE,
        amount DECIMAL(10, 2),
        payment_method VARCHAR(100),
        transaction_id VARCHAR(100),
        CONSTRAINT fk_booking_payment FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
        CHECK (amount >= 0)
    );
END;

-- Create a stored procedure for creating the Employee table
CREATE PROCEDURE CreateEmployeeTable
AS
BEGIN
    CREATE TABLE Employee (
        employee_id INT PRIMARY KEY,
        first_name VARCHAR(100),
        last_name VARCHAR(100),
        email VARCHAR(255),
        phone VARCHAR(20),
        position VARCHAR(100),
        CHECK (position IN ('Manager', 'Receptionist', 'Housekeeping', 'Maintenance'))
    );
END;

-- Create a stored procedure for creating the ReservationStatus table
CREATE PROCEDURE CreateReservationStatusTable
AS
BEGIN
    CREATE TABLE ReservationStatus (
        status_id INT PRIMARY KEY,
        status_name VARCHAR(100),
        description VARCHAR(255)
    );
END;
-- Create a stored procedure for creating the Booking table
CREATE PROCEDURE SP_BookingTable
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        CREATE TABLE Booking (
            booking_id INT PRIMARY KEY,
            guest_id INT,
            room_id INT,
            check_in_date DATE,
            check_out_date DATE,
            total_cost DECIMAL(10, 2),
            CONSTRAINT fk_guest_booking FOREIGN KEY (guest_id) REFERENCES Guest(guest_id),
            CONSTRAINT fk_room_booking FOREIGN KEY (room_id) REFERENCES Room(room_id),
            CHECK (check_in_date < check_out_date),
            CHECK (total_cost >= 0)
        );

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END;

-- Create a stored procedure for creating the Employee table
CREATE PROCEDURE SP_EmployeeTable
AS
BEGIN
    BEGIN TRANSACTION;
    
    BEGIN TRY
        CREATE TABLE Employee (
            employee_id INT PRIMARY KEY,
            first_name VARCHAR(100),
            last_name VARCHAR(100),
            email VARCHAR(255),
            phone VARCHAR(20),
            position VARCHAR(100),
            CHECK (position IN ('Manager', 'Receptionist', 'Housekeeping', 'Maintenance'))
        );

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;
        THROW;
    END CATCH;
END;
-- Create the stored procedure
CREATE PROCEDURE SaveViewToProcedure
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Drop the view if it already exists
    IF OBJECT_ID('dbo.HotelSummaryView', 'V') IS NOT NULL
        DROP VIEW dbo.HotelSummaryView;
    
    -- Recreate the view using dynamic SQL
    DECLARE @sql NVARCHAR(MAX);
    SET @sql = '
        CREATE VIEW HotelSummaryView
        AS
        SELECT
            h.hotel_id,
            h.hotel_name,
            COUNT(r.room_id) AS total_rooms,
            SUM(r.price_per_night) AS total_revenue
        FROM
            Hotel h
            JOIN Room r ON h.hotel_id = r.hotel_id
        GROUP BY
            h.hotel_id,
            h.hotel_name;
    ';
    
    EXEC sp_executesql @sql;
    

    PRINT 'The view has been saved into the stored procedure.';
END;
-- Create the scalar-valued function
CREATE FUNCTION fnGetEmployeeCount()
RETURNS INT
AS
BEGIN
    DECLARE @count INT;


    SELECT @count = COUNT(*) FROM Employee;

    RETURN @count;
END;

-- Create the stored procedure
CREATE PROCEDURE dbo.GetBookingStatistics
AS
BEGIN
    -- Declare variables to store the aggregate results
    DECLARE @AverageTotalCost DECIMAL(10, 2);
    DECLARE @MinTotalCost DECIMAL(10, 2);
    DECLARE @MaxTotalCost DECIMAL(10, 2);
    DECLARE @TotalRevenue DECIMAL(10, 2);
    DECLARE @TotalBookings INT;

    -- Calculate the average total cost
    SELECT @AverageTotalCost = AVG(total_cost)
    FROM Booking;

    -- Calculate the minimum total cost
    SELECT @MinTotalCost = MIN(total_cost)
    FROM Booking;

    -- Calculate the maximum total cost
    SELECT @MaxTotalCost = MAX(total_cost)
    FROM Booking;

    -- Calculate the total revenue
    SELECT @TotalRevenue = SUM(total_cost)
    FROM Booking;

    -- Calculate the total number of bookings
    SELECT @TotalBookings = COUNT(*)
    FROM Booking;

    -- Return the aggregate results
    SELECT @AverageTotalCost AS AverageTotalCost,
           @MinTotalCost AS MinTotalCost,
           @MaxTotalCost AS MaxTotalCost,
           @TotalRevenue AS TotalRevenue,
           @TotalBookings AS TotalBookings;
END;




