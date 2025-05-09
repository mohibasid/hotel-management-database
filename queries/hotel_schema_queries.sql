/* 14 SQL Queries */

-- Q1: Select all columns and all rows from one table
SELECT * from employee;

-- Q2: Select five columns and all rows from one table
SELECT roomid, resid, roomtype, roomview, maxoccupancy 
FROM room;

-- Q3: Select all columns from all rows from one view
CREATE VIEW Room_Description AS
SELECT r.roomview, r.floor, r.roomtype
FROM room r
WHERE r.maxoccupancy >= 4;

SELECT * from Room_Description;

DROP VIEW Room_Description;

-- Q4: Using a join on 2 tables, select all columns and all rows from the tables without the use of a Cartesian product
SELECT * 
FROM reservation re 
LEFT OUTER JOIN room r
ON re.resid=r.resid;

-- Q5: Select and order data retrieved from one table
SELECT * from payment
ORDER BY totalamount;

-- Q6: Using a join on 3 tables, select 5 columns from the 3 tables. 
  --Use syntax that would limit the output to 3 rows
SELECT p.receiptid, re.resid, re.accountid, r.roomid, r.roomtype
FROM payment p
LEFT OUTER JOIN reservation re
ON p.resid=re.resid
LEFT OUTER JOIN room r
ON re.resid=r.resid
LIMIT 3;

-- Q7: Select distinct rows using joins on 3 tables
-- Customers who have notes added to their reservation
SELECT DISTINCT *
FROM customer c
LEFT JOIN reservation re
ON c.accountid = re.accountid
LEFT JOIN payment p
ON re.resid = p.resid
WHERE p.notes IS NOT NULL AND p.notes != '';

-- Q8: Use GROUP BY and HAVING in a select statement using one or more tables
--Filter the information of departments with fewer than 5 employees 
--Display the department id, department name, number of employees 
SELECT d.departmentid, 
               d.departmentname, 	
               COUNT(e.employeeid) 
FROM department d 

LEFT OUTER JOIN employee e 
ON d.departmentid=e.departmentid 

GROUP BY d.departmentid, d.departmentname 
HAVING COUNT(e.employeeid)<5;

-- Q9: Use IN clause to select data from one or more tables
-- Find rooms that have reservations
SELECT * FROM room r
WHERE r.resid IN
  (SELECT re.resid FROM customer c
  LEFT JOIN reservation re
  ON c.accountid = re.accountid);

-- Q10: Select length of one column from one table (use LENGTH function)
SELECT LENGTH(firstname)
FROM employee;

-- Q11: Delete one record from one table.
  -- Use select statements to demonstrate the table contents before and after the DELETE statement
  -- Make sure you use ROLLBACK afterwards so that the data will not be physically removed
-- Begin the transaction

BEGIN;

SELECT * FROM customer ORDER BY accountid;

DELETE FROM customer
WHERE accountid = (
    SELECT accountid
    FROM customer
    WHERE accountid NOT IN (SELECT accountid FROM reservation)
    LIMIT 1
);

SELECT * FROM customer ORDER BY accountid;

ROLLBACK;

-- Q12: Update one record from one table.
-- Use select statements to demonstrate the table contents before and after the UPDATE statement
-- Make sure you use ROLLBACK afterwards so that the data will not be physically removed
-- Start a transaction and show contents before update 
BEGIN; 
SELECT * FROM room; 

-- Update table 
UPDATE room 
SET maxoccupancy = 2
WHERE roomtype='Double'; 

-- Show contents after update 
SELECT * FROM room; 

-- Revert back to before update 
ROLLBACK; 
SELECT * FROM room;

-- Q13: Additional Advanced Queries
/* Identify customers based on total payments, and classify them by spending amount. 
Only include customer who has spent more than the average total spending */
CREATE VIEW Advanced_Customer_Analytics AS
SELECT 
    CONCAT(c.firstname, ' ', c.lastname) AS CustomerName,
    COUNT(DISTINCT r.resid) AS TotalReservations,
    MAX(r.checkin) AS LatestReservation,
    SUM(p.totalamount) AS TotalSpent,
    ROUND(SUM(p.totalamount) / NULLIF(COUNT(DISTINCT r.resid), 0), 2) AS AvgPaymentPerReservation,
    CASE 
        WHEN SUM(p.totalamount) >= 400 THEN 'Platinum'
        WHEN SUM(p.totalamount) >= 200 THEN 'Gold'
        WHEN SUM(p.totalamount) >= 100 THEN 'Silver'
        ELSE 'Bronze'
    END AS SpendingTier
FROM customer c
JOIN reservation r ON c.accountid = r.accountid
JOIN payment p ON r.resid = p.resid
WHERE c.accountid IN (
    SELECT cp.accountid
    FROM (
        SELECT 
            c2.accountid,
            SUM(p2.totalamount) AS cust_total
        FROM customer c2
        JOIN reservation r2 ON c2.accountid = r2.accountid
        JOIN payment p2 ON r2.resid = p2.resid
        GROUP BY c2.accountid
    ) cp
    WHERE cp.cust_total > (
        SELECT AVG(total)
        FROM (
            SELECT 
                SUM(p3.totalamount) AS total
            FROM customer c3
            JOIN reservation r3 ON c3.accountid = r3.accountid
            JOIN payment p3 ON r3.resid = p3.resid
            GROUP BY c3.accountid
        ) all_totals
    )
)

GROUP BY c.accountid, c.firstname, c.lastname;

SELECT * FROM Advanced_Customer_Analytics ORDER BY TotalSpent DESC LIMIT 10;

DROP VIEW Advanced_Customer_Analytics;



-- Q14: Additional Advanced Queries
/* Identify long-stay customers who stayed more than 3 days.
Show account ID, full customer name, and length of stay. Sort results by length of stay in descending order. */
SELECT c.accountid, 
               CONCAT(c.firstname, ' ', c.lastname) AS "CustomerName", 
               (r.checkout - r.checkin) AS "LengthOfStay" 
FROM customer c 

INNER JOIN reservation r 
ON c.accountid = r.accountid 

WHERE r.accountid IN 
               (SELECT re.accountid FROM reservation re WHERE (re.checkout - re.checkin) > 3) 

ORDER BY (r.checkout - r.checkin) DESC;
