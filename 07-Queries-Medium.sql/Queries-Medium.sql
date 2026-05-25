-- Use the database
USE SkyTrack_Airline_DB;
GO


-- PART 3: DATA QUERIES (Medium Level)


-- 1. For each flight, show the flight number, the name of the origin airport, and the name of the destination airport.
SELECT F.Flight_Number,
O.Name AS Origin_Airport,
D.Name AS Destination_Airport
FROM FLIGHT F
JOIN AIRPORT O ON F.Origin_IATA = O.IATA_Code
JOIN AIRPORT D ON F.Destination_IATA = D.IATA_Code;

-- 2. Show each booking along with the full name of the passenger who made it and the flight number it belongs to.
SELECT B.Booking_ID, 
P.Full_Name, 
F.Flight_Number
FROM BOOKING B
JOIN PASSENGER P ON B.Passenger_ID = P.Passenger_ID
JOIN FLIGHT F ON B.Flight_ID = F.Flight_ID;

-- 3. List all crew members assigned to flight 'SK101', showing their full name and role.
SELECT C.Full_Name, C.Role
FROM CREW_MEMBER C
JOIN FLIGHT_CREW FC ON C.Crew_ID = FC.Crew_ID
JOIN FLIGHT F ON FC.Flight_ID = F.Flight_ID
WHERE F.Flight_Number = 'SK101';

-- 4. Show all completed flights along with the aircraft model used on each flight.
SELECT F.Flight_Number, A.Model
FROM FLIGHT F
JOIN AIRCRAFT A ON F.Aircraft_ID = A.Aircraft_ID
WHERE F.Status = 'Completed';

-- 5. For each passenger, show their full name and the total number of bookings they have made. 
--    Order by booking count from highest to lowest.
SELECT P.Full_Name, COUNT(B.Booking_ID) AS Total_Bookings
FROM PASSENGER P
LEFT JOIN BOOKING B ON P.Passenger_ID = B.Passenger_ID
GROUP BY P.Full_Name
ORDER BY Total_Bookings DESC;

-- 6. Show the total revenue collected from each booking class.
SELECT Class, SUM(Price) AS Total_Revenue
FROM BOOKING
GROUP BY Class;

-- 7. Count how many flights each aircraft has been assigned to.
SELECT A.Model, A.Registration_Number, COUNT(F.Flight_ID) AS Assigned_Flight_Count
FROM AIRCRAFT A
LEFT JOIN FLIGHT F ON A.Aircraft_ID = F.Aircraft_ID
GROUP BY A.Model, A.Registration_Number;

-- 8. List all flights that have more than one booking.
SELECT F.Flight_Number, COUNT(B.Booking_ID) AS Booking_Count
FROM FLIGHT F
JOIN BOOKING B ON F.Flight_ID = B.Flight_ID
GROUP BY F.Flight_Number
HAVING COUNT(B.Booking_ID) > 1;

-- 9. Show the full details of all bookings — passenger name, flight number, origin airport, 
--    destination airport, class, and price paid.
SELECT P.Full_Name, F.Flight_Number, O.Name AS Origin, D.Name AS Destination, B.Class, B.Price
FROM BOOKING B
JOIN PASSENGER P ON B.Passenger_ID = P.Passenger_ID
JOIN FLIGHT F ON B.Flight_ID = F.Flight_ID
JOIN AIRPORT O ON F.Origin_IATA = O.IATA_Code
JOIN AIRPORT D ON F.Destination_IATA = D.IATA_Code;
GO