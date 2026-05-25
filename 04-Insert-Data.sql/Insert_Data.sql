-- Ensure using the correct database
USE SkyTrack_Airline_DB;
--fix error 3-B
DELETE FROM FLIGHT_CREW;
DELETE FROM BOOKING;
DELETE FROM FLIGHT;
DELETE FROM CREW_MEMBER;
DELETE FROM PASSENGER;
DELETE FROM AIRCRAFT;
DELETE FROM AIRPORT;
GO -- Error3_A
DBCC CHECKIDENT ('AIRCRAFT', RESEED, 0);
DBCC CHECKIDENT ('PASSENGER', RESEED, 0);
DBCC CHECKIDENT ('CREW_MEMBER', RESEED, 0);
DBCC CHECKIDENT ('FLIGHT', RESEED, 0);
DBCC CHECKIDENT ('BOOKING', RESEED, 0);
GO
-- PART 1: INSERT SAMPLE DATA
-- 1. Insert Airports (5 airports)
INSERT INTO AIRPORT (IATA_Code, Name, City, Country) VALUES 
('DXB', 'Dubai International', 'Dubai', 'UAE'),
('LHR', 'Heathrow', 'London', 'UK'),
('JFK', 'John F. Kennedy', 'New York', 'USA'),
('CDG', 'Charles de Gaulle', 'Paris', 'France'),
('HND', 'Haneda', 'Tokyo', 'Japan');

-- 2. Insert Aircraft (5 aircraft)
INSERT INTO AIRCRAFT (Registration_Number, Model, Manufacturer, Total_Seating_Capacity, Year_Manufacture) VALUES 
('A6-ABC', 'A380', 'Airbus', 500, 2020),
('N123US', 'B777', 'Boeing', 350, 2018),
('F-GHIJ', 'A350', 'Airbus', 300, 2022),
('JA4567', 'B787', 'Boeing', 280, 2019),
('G-KKLM', 'A320', 'Airbus', 180, 2021);

-- 3. Insert Crew Members (6 members)
INSERT INTO CREW_MEMBER (Full_Name, Role, License_Number) VALUES 
('Ahmed Ali', 'Pilot', 'LIC001'),
('Sarah S', 'Flight Attendant', 'LIC002'),
('John Doe', 'Co-Pilot', 'LIC003'),
('Yuki Tanaka', 'Engineer', 'LIC004'),
('Marie Dubois', 'Flight Attendant', 'LIC005'),
('Omar Hassan', 'Pilot', 'LIC006');

-- 4. Insert Flights (8 flights covering all statuses)
INSERT INTO FLIGHT (Flight_Number, Departure_Datetime, Arrival_Datetime, Status, Aircraft_ID, Origin_IATA, Destination_IATA) VALUES 
('SK101', '2026-06-01 08:00:00', '2026-06-01 14:00:00', 'Scheduled', 1, 'DXB', 'LHR'),
('SK102', '2026-06-02 09:00:00', '2026-06-02 18:00:00', 'Delayed', 2, 'LHR', 'JFK'),
('SK103', '2026-06-03 10:00:00', '2026-06-03 20:00:00', 'Cancelled', 3, 'JFK', 'CDG'),
('SK104', '2026-06-04 11:00:00', '2026-06-04 15:00:00', 'Completed', 4, 'CDG', 'HND'),
('SK105', '2026-06-05 07:00:00', '2026-06-05 12:00:00', 'Scheduled', 5, 'HND', 'DXB'),
('SK106', '2026-06-06 12:00:00', '2026-06-06 16:00:00', 'Delayed', 1, 'DXB', 'CDG'),
('SK107', '2026-06-07 14:00:00', '2026-06-07 22:00:00', 'Completed', 2, 'LHR', 'DXB'),
('SK108', '2026-06-08 05:00:00', '2026-06-08 09:00:00', 'Scheduled', 3, 'CDG', 'LHR');

-- 5. Insert Passengers (8 passengers)
INSERT INTO PASSENGER (National_ID, Full_Name, Email, Nationality, Date_of_Birth) VALUES 
('ID001', 'Ali M', 'ali@test.com', 'Pakistani', '1990-05-15'),
('ID002', 'Bella Ross', 'bella@test.com', 'Italian', '1992-08-20'),
('ID003', 'Chen Wei', 'chen@test.com', 'Chinese', '1985-02-10'),
('ID004', 'David Lee', 'david@test.com', 'Korean', '1995-12-05'),
('ID005', 'Emman', 'emma@test.com', 'Canadian', '1988-04-22'),
('ID006', 'Fadi Said', 'fadi@test.com', 'Lebanese', '1991-09-30'),
('ID007', 'Hamed S', 'gaby@test.com', 'German', '1982-11-12'),
('ID008', 'Hana Noor', 'hana@test.com', 'Omani', '1998-01-25');

-- 6. Insert Bookings (10 bookings)
INSERT INTO BOOKING (Passenger_ID, Flight_ID, Seat_Number, Class, Price) VALUES 
(1, 1, '1A', 'First', 1200.00),
(2, 1, '10B', 'Economy', 400.00),
(3, 2, '5C', 'Business', 800.00),
(4, 2, '20D', 'Economy', 450.00),
(5, 4, '2A', 'First', 1500.00),
(6, 4, '12E', 'Business', 900.00),
(7, 5, '30F', 'Economy', 350.00),
(8, 7, '15A', 'Business', 850.00),
(1, 8, '8C', 'Economy', 420.00),
(2, 6, '2B', 'First', 1100.00);

-- 7. Assign Crew to Flights
INSERT INTO FLIGHT_CREW (Flight_ID, Crew_ID) VALUES 
(1, 1), (1, 2), -- Flight 1: Pilot + Flight Attendant
(2, 6), (2, 5), -- Flight 2: Pilot + Flight Attendant
(3, 1), (3, 2), -- Flight 3
(4, 3), (4, 5), -- Flight 4
(5, 6), (5, 2), -- Flight 5
(6, 1), (6, 5), -- Flight 6
(7, 3), (7, 2), -- Flight 7
(8, 6), (8, 5); -- Flight 8


-- PART 2: UPDATE AND DELETE TASKS
-- UPDATE Tasks
UPDATE FLIGHT SET Status = 'Completed' WHERE Flight_Number = 'SK101';
UPDATE FLIGHT SET Status = 'Cancelled' WHERE Flight_Number = 'SK102';
UPDATE BOOKING SET Price = Price * 1.10 WHERE Class = 'Economy';
UPDATE PASSENGER SET Phone = '123-456-789' WHERE National_ID = 'ID001';
UPDATE CREW_MEMBER SET Role = 'Engineer' WHERE Full_Name = 'Sarah S';

-- DELETE Tasks
-- 1. Delete one cancelled flight
SELECT * FROM FLIGHT WHERE Status = 'Cancelled';
DELETE FROM FLIGHT WHERE Flight_Number = 'SK103';

-- 2. Delete one booking linked to a cancelled flight
SELECT * FROM BOOKING WHERE Flight_ID = (SELECT Flight_ID FROM FLIGHT WHERE Flight_Number = 'SK102');
DELETE FROM BOOKING WHERE Flight_ID = (SELECT Flight_ID FROM FLIGHT WHERE Flight_Number = 'SK102');

-- 3. Try to delete a passenger who has existing bookings
SELECT * FROM PASSENGER WHERE Passenger_ID = 1;
/* COMMENT ON RESULT: 
   The deletion of the passenger is successful because we set 'ON DELETE CASCADE' 
   in the BOOKING table's foreign key constraint. This automatically removes 
   all booking records associated with this passenger.
*/
DELETE FROM PASSENGER WHERE Passenger_ID = 1;

GO