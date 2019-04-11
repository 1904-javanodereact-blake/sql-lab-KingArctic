-- SQL Lab

-- 1.0	Setting up Oracle Chinook
-- In this section you will begin the process of working with the Oracle Chinook database
-- Task – Open the Chinook_Oracle.sql file and execute the scripts within.


-- 2.0 SQL Queries
-- In this section you will be performing various queries against the Oracle Chinook database.


-- 2.1 SELECT
-- Task – Select all records from the Employee table.
-- Task – Select all records from the Employee table where last name is King.
-- Task – Select all records from the Employee table where first name is Andrew and REPORTSTO is NULL.

SELECT * FROM employee;
SELECT * FROM employee WHERE lastname = 'King';
SELECT * FROM employee where firstname = 'Andrew' AND reportsto ISNULL;

-- 2.2 ORDER BY
-- Task – Select all albums in Album table and sort result set in descending order by title.
-- Task – Select first name from Customer and sort result set in ascending order by city

SELECT * FROM album ORDER BY title DESC;
SELECT firstname FROM customer ORDER BY city ASC;

-- 2.3 INSERT INTO
-- Task – Insert two new records into Genre table
-- Task – Insert two new records into Employee table
-- Task – Insert two new records into Customer table

INSERT INTO genre (genreid, name) VALUES (26, 'Trap'), (27, 'Dubstep');

INSERT INTO employee (employeeid,lastname,firstname,title,reportsto,birthdate,hiredate,address,city,state,country,postalcode,phone,fax,email)
		VALUES (9,'Lyons','Charles','Game Developer',1,'1996-06-18 00:00:00','2023-03-21 00:00:00','1839 Perry Lane Road','Brunswick','GA','United States','31525','+1 (912) 399-1415','+1 (912) 399-1415','austinlyns@gmail.com'),
				(10,'Pendragon','Diane','Software Developer',1,'1997-09-28 00:00:00','2023-05-12 00:00:00','191 Ironsword Way','Brunswick','GA','United States','31520','+1 (912) 399-1415','+1 (912) 399-1415','dianepenny@gmail.com');

INSERT INTO customer (customerid,firstname,lastname,company,address,city,state,country,postalcode,phone,email,supportrepid)
		VALUES (60,'Charles','Lyons','Lyonex Industries','1839 Perry Lane Road','Brunswick','GA',
				'United States','31525','+1 (912) 399-1415','austinlyns@gmail.com',6),
				(61,'Diane','Pendragon',NULL,'191 Ironsword Way','Brunswick','GA',
				'United States','31520','+1 (912) 399-1415','dianepenny@gmail.com',6);

-- 2.4 UPDATE
-- Task – Update Aaron Mitchell in Customer table to Robert Walter
-- Task – Update name of artist in the Artist table “Creedence Clearwater Revival” to “CCR”

UPDATE customer
SET	firstname = 'Robert',
	lastname = 'Walter'
WHERE firstname = 'Aaron' AND lastname = 'Mitchell';

UPDATE artist
SET name = 'CCR'
WHERE name = 'Creedence Clearwater Revival'

-- 2.5 LIKE
-- Task – Select all invoices with a billing address like “T%”

SELECT * FROM invoice WHERE billingaddress LIKE 'T%';

-- 2.6 BETWEEN
-- Task – Select all invoices that have a total between 15 and 50
-- Task – Select all employees hired between 1st of June 2003 and 1st of March 2004

SELECT * FROM invoice WHERE total BETWEEN 15 AND 50;
SELECT * FROM employee WHERE hiredate BETWEEN '2003-06-01 00:00:00' AND '2004-03-01 00:00:00';

-- 2.7 DELETE
-- Task – Delete a record in Customer table where the name is Robert Walter (There may be constraints that rely on this, find out how to resolve them).

DELETE FROM invoiceline where invoiceid IN ( SELECT invoiceid FROM invoice WHERE customerid IN (SELECT customerid FROM customer WHERE firstname = 'Robert' AND lastname = 'Walter'));
 
DELETE FROM invoice WHERE customerid IN (SELECT customerid FROM customer WHERE firstname = 'Robert' AND lastname = 'Walter')

DELETE FROM customer WHERE firstname = 'Robert' AND lastname = 'Walter';

-- 3.0	SQL Functions
-- In this section you will be using the Oracle system functions, as well as your own functions, to perform various actions against the database


-- 3.1 System Defined Functions
-- Task – Use a function that returns the current time.
-- Task – Use a function that returns the length of a mediatype from the mediatype table

SELECT CURRENT_TIME;

SELECT LENGTH(name) FROM mediatype;

-- 3.2 System Defined Aggregate Functions
-- Task – Use a function that returns the average total of all invoices
-- Task – Use a function that returns the most expensive track

SELECT AVG(total) FROM invoice;

SELECT * FROM track WHERE unitprice in (SELECT MAX(unitprice) FROM track);

-- 7.0 JOINS
-- In this section you will be working with combing various tables through the use of joins. You will work with outer, inner, right, left, cross, and self joins.


-- 7.1 INNER
-- Task – Create an inner join that joins customers and orders and specifies the name of the customer and the invoiceId.

SELECT customer.firstname, customer.lastname, invoice.invoiceid
FROM customer 
INNER JOIN invoice
ON customer.customerid = invoice.customerid
ORDER BY customer.customerid;

-- 7.2 OUTER
-- Task – Create an outer join that joins the customer and invoice table, specifying the CustomerId, firstname, lastname, invoiceId, and total.

SELECT customer.customerid, customer.firstname, customer.lastname, invoice.invoiceid, invoice.total
FROM customer
FULL OUTER JOIN invoice
ON customer.customerid = invoice.customerid
ORDER BY customer.customerid ASC;

-- 7.3 RIGHT
-- Task – Create a right join that joins album and artist specifying artist name and title.

SELECT artist.name, album.title
FROM album
RIGHT JOIN artist
ON album.artistid = artist.artistid;

-- 7.4 CROSS
-- Task – Create a cross join that joins album and artist and sorts by artist name in ascending order.

SELECT * FROM artist
CROSS JOIN album
ORDER BY name ASC;

-- 7.5 SELF
-- Task – Perform a self-join on the employee table, joining on the reportsto column.

SELECT E.employeeid, E.firstname, E.lastname, M.firstname AS reportsto
FROM employee E, employee M
WHERE E.reportsto = M.employeeid;