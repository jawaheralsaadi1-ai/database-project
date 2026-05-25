\#Database-Skytrack-Airline-System-project
#Database-Skytrack-Airline-System



\# SkyTrack Airline System – README



\## 1. Project Description

SkyTrack Airline System is a relational database project that simulates basic airline operations.  

It manages flights, passengers, aircraft, airports, bookings, and crew members.



The system is designed to practice:

\- Database design (ERD → tables)

\- Relationships using Primary \& Foreign Keys

\- Data integrity using constraints

\- SQL queries for real-world airline operations



\---



\## 2. ERD Summary



\### Main Entities

\- AIRPORT

\- AIRCRAFT

\- FLIGHT

\- PASSENGER

\- BOOKING

\- CREW\_MEMBER

\- FLIGHT\_CREW



\### Key Relationships

\- Each FLIGHT has:

&#x20; - One origin AIRPORT

&#x20; - One destination AIRPORT

&#x20; - One AIRCRAFT



\- Each PASSENGER can have many BOOKING records



\- Each BOOKING belongs to:

&#x20; - One PASSENGER

&#x20; - One FLIGHT



\- Each FLIGHT can have many CREW\_MEMBER through FLIGHT\_CREW (Many-to-Many)



\### Design Decisions

\- Used surrogate keys (IDENTITY) for most tables for simplicity

\- Used IATA\_Code (3 letters) as Primary Key for AIRPORT

\- Used junction table (FLIGHT\_CREW) to handle many-to-many relationship

\- Applied constraints (UNIQUE, CHECK, FOREIGN KEY) to ensure data validity



\---



\## 3. Mapping Decisions (Foreign Keys)



Foreign keys were placed based on real-world airline logic:



\- FLIGHT.Aircraft\_ID → AIRCRAFT.Aircraft\_ID  

&#x20; Reason: each flight uses one aircraft



\- FLIGHT.Origin\_IATA → AIRPORT.IATA\_Code  

\- FLIGHT.Destination\_IATA → AIRPORT.IATA\_Code  

&#x20; Reason: each flight has departure and arrival airports



\- BOOKING.Passenger\_ID → PASSENGER.Passenger\_ID  

&#x20; Reason: each booking belongs to one passenger



\- BOOKING.Flight\_ID → FLIGHT.Flight\_ID  

&#x20; Reason: each booking is for one flight



\- FLIGHT\_CREW:

&#x20; - Flight\_ID → FLIGHT

&#x20; - Crew\_ID → CREW\_MEMBER  

&#x20; Reason: many-to-many relationship between flights and crew



\---



\## 4. Errors Faced and How They Were Fixed



\### 1. Duplicate Key Errors

Problem:

\- Same data inserted multiple times



Fix:

\- Added DELETE statements before INSERT

\- Used DBCC CHECKIDENT to reset IDENTITY columns



\---



\### 2. Foreign Key Conflicts

Problem:

\- Inserting records before parent tables existed



Fix:

\- Fixed insert order (AIRPORT → AIRCRAFT → FLIGHT → BOOKING)



\---



\### 3. Identity Value Issues

Problem:

\- IDs did not reset after DELETE



Fix:

\- Used:

&#x20; ```sql

&#x20; DBCC CHECKIDENT ('TABLE\_NAME', RESEED, 0);





\####Index



error1

Column 'AIRPORT.IATA\_Code' is not the same data type as referencing column 'FLIGHT.Origin\_IATA' in foreign key 'FK\_Flight\_Origin'.

Column 'AIRPORT.IATA\_Code' is not the same data type as referencing column 'FLIGHT.Destination\_IATA' in foreign key 'FK\_Flight\_Dest'.

\-----------------------------------------

error2

error2-A

Msg 1801, Level 16, State 3, Line 2

Database 'SkyTrack\_Airline\_DB' already exists. Choose a different database name.

Msg 2714, Level 16, State 6, Line 9

There is already an object named 'AIRPORT' in the database.

\-----

error2-b

Msg 3702, Level 16, State 3, Line 3

Cannot drop database "SkyTrack\_Airline\_DB" because it is currently in use.





\---------------------------------------------------

error3-A

Msg 2627, Level 14, State 1, Line 6

Violation of PRIMARY KEY constraint 'PK\_\_AIRPORT\_\_2DF559713E77F03C'. Cannot insert duplicate key in object 'dbo.AIRPORT'. The duplicate key value is (DXB).

The statement has been terminated.

Msg 2627, Level 14, State 1, Line 14

Violation of UNIQUE KEY constraint 'UQ\_\_AIRCRAFT\_\_2F8BEE8F40247D38'. Cannot insert duplicate key in object 'dbo.AIRCRAFT'. The duplicate key value is (A6-ABC).

The statement has been terminated.

Msg 2627, Level 14, State 1, Line 22

Violation of UNIQUE KEY constraint 'UQ\_\_CREW\_MEM\_\_9ED5EDA2E3929EC6'. Cannot insert duplicate key in object 'dbo.CREW\_MEMBER'. The duplicate key value is (LIC001).

The statement has been terminated.

Msg 2627, Level 14, State 1, Line 31

Violation of UNIQUE KEY constraint 'UQ\_\_FLIGHT\_\_F93DD763BF580BB8'. Cannot insert duplicate key in object 'dbo.FLIGHT'. The duplicate key value is (SK101).

The statement has been terminated.

Msg 2627, Level 14, State 1, Line 42

Violation of UNIQUE KEY constraint 'UQ\_\_PASSENGE\_\_A9D105343D41A76E'. Cannot insert duplicate key in object 'dbo.PASSENGER'. The duplicate key value is (bella@test.com).

The statement has been terminated.

Msg 547, Level 16, State 0, Line 53

The INSERT statement conflicted with the FOREIGN KEY constraint "FK\_Booking\_Passenger". The conflict occurred in database "SkyTrack\_Airline\_DB", table "dbo.PASSENGER", column 'Passenger\_ID'.

The statement has been terminated.

Msg 2627, Level 14, State 1, Line 66

Violation of PRIMARY KEY constraint 'PK\_\_FLIGHT\_C\_\_A1F9DB8A93D604F4'. Cannot insert duplicate key in object 'dbo.FLIGHT\_CREW'. The duplicate key value is (1, 1).

The statement has been terminated.



\---------------error3-B

Msg 547, Level 16, State 0, Line 40

The INSERT statement conflicted with the FOREIGN KEY constraint "FK\_Flight\_Aircraft". The conflict occurred in database "SkyTrack\_Airline\_DB", table "dbo.AIRCRAFT", column 'Aircraft\_ID'.

The statement has been terminated.



(8 rows affected)

Msg 547, Level 16, State 0, Line 62

The INSERT statement conflicted with the FOREIGN KEY constraint "FK\_Booking\_Passenger". The conflict occurred in database "SkyTrack\_Airline\_DB", table "dbo.PASSENGER", column 'Passenger\_ID'.

The statement has been terminated.

Msg 547, Level 16, State 0, Line 75

The INSERT statement conflicted with the FOREIGN KEY constraint "FK\_FC\_Flight". The conflict occurred in database "SkyTrack\_Airline\_DB", table "dbo.FLIGHT", column 'Flight\_ID'.

The statement has been terminated.





Completion time: 2026-05-26T00:49:21.8663460+04:00



