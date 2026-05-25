-- Use the database
USE SkyTrack_Airline_DB;
GO

---------------------------------------------------------
-- PART 3: DATA QUERIES (Advanced Level)
---------------------------------------------------------

-- 1. Flights with origin/destination names, aircraft model, and total booking count.
SELECT F.Flight_Number, O.Name AS Origin, D.Name AS Destination, A.Model, COUNT(B.Booking_ID) AS Total_Passengers
FROM FLIGHT F
JOIN AIRPORT O ON F.Origin_IATA = O.IATA_Code
JOIN AIRPORT D ON F.Destination_IATA = D.IATA_Code
JOIN AIRCRAFT A ON F.Aircraft_ID = A.Aircraft_ID
LEFT JOIN BOOKING B ON F.Flight_ID = B.Flight_ID
GROUP BY F.Flight_Number, O.Name, D.Name, A.Model;

-- 2. Passengers who have never made a booking.
SELECT Full_Name FROM PASSENGER
WHERE Passenger_ID NOT IN (SELECT DISTINCT Passenger_ID FROM BOOKING);

-- 3. Flights with revenue > 500. Order highest to lowest.
SELECT F.Flight_Number, SUM(B.Price) AS Total_Revenue
FROM FLIGHT F
JOIN BOOKING B ON F.Flight_ID = B.Flight_ID
GROUP BY F.Flight_Number
HAVING SUM(B.Price) > 500
ORDER BY Total_Revenue DESC;

-- 4. Crew members assigned to more than one flight.
SELECT C.Full_Name, COUNT(FC.Flight_ID) AS Flight_Count
FROM CREW_MEMBER C
JOIN FLIGHT_CREW FC ON C.Crew_ID = FC.Crew_ID
GROUP BY C.Full_Name
HAVING COUNT(FC.Flight_ID) > 1;

-- 5. Flights with avg booking price > overall avg price.
SELECT F.Flight_Number, AVG(B.Price) AS Avg_Price
FROM FLIGHT F
JOIN BOOKING B ON F.Flight_ID = B.Flight_ID
GROUP BY F.Flight_Number
HAVING AVG(B.Price) > (SELECT AVG(Price) FROM BOOKING);

-- 6. Flight with the highest number of bookings.
SELECT TOP 1 F.Flight_Number, O.Name AS Origin, D.Name AS Destination, COUNT(B.Booking_ID) AS Booking_Count
FROM FLIGHT F
JOIN AIRPORT O ON F.Origin_IATA = O.IATA_Code
JOIN AIRPORT D ON F.Destination_IATA = D.IATA_Code
JOIN BOOKING B ON F.Flight_ID = B.Flight_ID
GROUP BY F.Flight_Number, O.Name, D.Name
ORDER BY Booking_Count DESC;

-- 7. Revenue statistics per booking class.
SELECT Class, SUM(Price) AS Total_Revenue, COUNT(Booking_ID) AS Booking_Count, 
       AVG(Price) AS Avg_Price, MAX(Price) AS Max_Price, MIN(Price) AS Min_Price
FROM BOOKING
GROUP BY Class;

-- 8. Passengers who booked a cancelled flight.
SELECT P.Full_Name, F.Flight_Number, B.Booking_Date
FROM PASSENGER P
JOIN BOOKING B ON P.Passenger_ID = B.Passenger_ID
JOIN FLIGHT F ON B.Flight_ID = F.Flight_ID
WHERE F.Status = 'Cancelled';

-- 9. Flights with at least one pilot AND at least one flight attendant.
SELECT F.Flight_Number, COUNT(FC.Crew_ID) AS Total_Crew, F.Departure_Datetime
FROM FLIGHT F
JOIN FLIGHT_CREW FC ON F.Flight_ID = FC.Flight_ID
JOIN CREW_MEMBER C ON FC.Crew_ID = C.Crew_ID
GROUP BY F.Flight_Number, F.Departure_Datetime
HAVING SUM(CASE WHEN C.Role = 'Pilot' THEN 1 ELSE 0 END) >= 1
   AND SUM(CASE WHEN C.Role = 'Flight Attendant' THEN 1 ELSE 0 END) >= 1;

-- 10. FINAL CHALLENGE: Complete flight summary.
SELECT F.Flight_Number, O.City AS Origin_City, D.City AS Destination_City, 
       A.Model, A.Manufacturer, 
       COUNT(DISTINCT B.Booking_ID) AS Total_Passengers,
       COUNT(DISTINCT FC.Crew_ID) AS Total_Crew,
       SUM(B.Price) AS Total_Revenue
FROM FLIGHT F
JOIN AIRPORT O ON F.Origin_IATA = O.IATA_Code
JOIN AIRPORT D ON F.Destination_IATA = D.IATA_Code
JOIN AIRCRAFT A ON F.Aircraft_ID = A.Aircraft_ID
LEFT JOIN BOOKING B ON F.Flight_ID = B.Flight_ID
LEFT JOIN FLIGHT_CREW FC ON F.Flight_ID = FC.Flight_ID
GROUP BY F.Flight_Number, O.City, D.City, A.Model, A.Manufacturer
ORDER BY Total_Revenue DESC;
GO