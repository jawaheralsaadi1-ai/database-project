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