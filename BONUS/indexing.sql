/*
PART 1: RESEARCH (Conceptual Analysis)


1. What is a database index and what problem does it solve?
   An index is a data structure (like a B-Tree) that provides a fast lookup path 
   to specific rows in a table. Without it, the database performs a "Full Table Scan" 
   (checking every row), which is extremely slow on large datasets. Indexes solve 
   the problem of slow read performance by acting like an index in the back of a book.

2. Clustered vs. Non-Clustered Index:
   - Clustered: Determines the physical order of data in the table. There can be ONLY ONE 
     per table because data can only be stored in one physical order.
   - Non-Clustered: A separate structure that stores pointers to the actual data rows.
     You can have many of these on a single table.

3. Unique Index:
   Ensures no two rows have the same value in the indexed column(s). 
   - Suitable columns in SkyTrack: PASSENGER(Email), CREW_MEMBER(License_Number).

4. Composite Index:
   An index on two or more columns. Useful for queries that filter by multiple columns.
   - Example: A composite index on BOOKING(Passenger_ID, Flight_ID) would speed up 
     queries looking for specific bookings made by a specific passenger on a specific flight.

5. Trade-offs:
   While indexes speed up SELECT queries, they SLOW DOWN INSERT, UPDATE, and DELETE 
   operations. This is because every time data is modified, the database must also 
   update the index structures to keep them in sync.
*/

---------------------------------------------------------
-- PART 2: IMPLEMENTATION
---------------------------------------------------------

-- 1. Index on FLIGHT(Status)
/* - Table: FLIGHT, Column: Status
   - Type: Non-Clustered
   - Related Query: Part 3, Basic Level #5 (Filter by 'Delayed' or 'Cancelled')
   - Justification: This column has low cardinality but is used frequently 
     for filtering status updates in the real-world airline operations.
*/
CREATE INDEX idx_flight_status ON FLIGHT(Status);

-- 2. Index on PASSENGER(Full_Name)
/* - Table: PASSENGER, Column: Full_Name
   - Type: Non-Clustered
   - Related Query: Part 3, Basic Level #2 (Order alphabetically)
   - Justification: Frequently used for searching for passengers by name.
*/
CREATE INDEX idx_passenger_name ON PASSENGER(Full_Name);

-- 3. Composite Index on BOOKING(Class, Price)
/* - Table: BOOKING, Columns: Class, Price
   - Type: Non-Clustered (Composite)
   - Related Query: Part 3, Medium Level #6 (Revenue by class)
   - Justification: Improves performance of aggregate functions (SUM/AVG) grouped by class.
*/
CREATE INDEX idx_booking_class_price ON BOOKING(Class, Price);

-- 4. Unique Index on CREW_MEMBER(License_Number)
/* - Table: CREW_MEMBER, Column: License_Number
   - Type: Unique, Non-Clustered
   - Related Query: Any lookup by crew credentials.
   - Justification: Ensures integrity for unique license numbers.
*/
CREATE UNIQUE INDEX idx_unique_license ON CREW_MEMBER(License_Number);

-- 5. Discussion on Non-Beneficial Indexing:
/* - Column: AIRPORT(Country)
   - Reasoning: If the table size is small (e.g., only 50 airports), the cost of 
     maintaining the index outweighs the benefit. The database optimizer will 
     likely choose a table scan anyway as it is faster for very small tables.
*/

GO