-- Use the database
USE SkyTrack_Airline_DB;
GO


-- PART 3: DATA QUERIES (Basic Level)

-- 1. List all flights and their current status, 
--ordered by departure datetime from earliest to latest.
SELECT Flight_Number, Status, Departure_Datetime 
FROM FLIGHT 
ORDER BY Departure_Datetime ASC;

-- 2. Show all passengers, ordered alphabetically by full name.
SELECT * FROM PASSENGER 
ORDER BY Full_Name ASC;

-- 3. List all aircraft and their seating capacity, ordered from largest to smallest.
SELECT Registration_Number, Model, Total_Seating_Capacity 
FROM AIRCRAFT 
ORDER BY Total_Seating_Capacity DESC;

-- 4. Show all bookings and their class. 
--Display only distinct class values that exist in the system.
SELECT DISTINCT Class 
FROM BOOKING;

-- 5. List all flights that have a status of 'Delayed' or 'Cancelled'.
SELECT * FROM FLIGHT 
WHERE Status IN ('Delayed', 'Cancelled');

-- 6. Show all passengers whose nationality is 'Omani'.
SELECT * FROM PASSENGER 
WHERE Nationality = 'Omani';

-- 7. List all airports, ordered by country.
SELECT * FROM AIRPORT 
ORDER BY Country ASC;
GO