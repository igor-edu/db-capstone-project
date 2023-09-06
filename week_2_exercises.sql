
--======================= EXERCISE 1: CREATE A VIRTUAL TABLE TO SUMMARIZE DATA

-- TASK 1: Create a virtual table called OrdersView that focuses on OrderID, Quantity and Cost columns within the Orders table for all orders with a quantity greater than 2
CREATE OR REPLACE VIEW OrdersView AS 
SELECT Orders.OrderID, SUM(OrderItems.Quantity) AS Quantity, 
	SUM(OrderItems.Quantity * MenuItems.Price) AS Cost
FROM Orders
INNER JOIN OrderItems 
ON Orders.OrderID = OrderItems.OrderID 
INNER JOIN MenuItems 
ON OrderItems.ItemID = MenuItems.ItemID
GROUP BY Orders.OrderID
HAVING SUM(OrderItems.Quantity) > 2;

-- TASK 2: Show information from all orders on all customers with details on items, cost, quantity, cuisine
SELECT Customers.CustomerID, 
	CONCAT(Customers.FirstName, ' ', Customers.LastName) AS FullName,
    Orders.OrderID, MenuItems.Name AS MenuItem, OrderItems.Quantity,
    MenuItems.Price, OrderItems.Quantity * MenuItems.Price AS Cost,
    MenuItems.Cuisine
FROM Customers
INNER JOIN Bookings
ON Customers.CustomerID = Bookings.CustomerID
INNER JOIN Orders 
ON Bookings.BookingID = Orders.BookingID
INNER JOIN OrderItems 
ON Orders.OrderID = OrderItems.OrderID
INNER JOIN MenuItems 
ON OrderItems.ItemID = MenuItems.ItemID
ORDER BY Orders.OrderID;

-- TASK 3: Find all menu items that appeared in more than 2 orders
SELECT MenuItems.Name AS MenuItemName
FROM MenuItems
WHERE 2 < ANY (
	SELECT COUNT(DISTINCT OrderItems.OrderID) 
	FROM OrderItems
	WHERE OrderItems.ItemID = MenuItems.ItemID
);


--====================== EXERCISE 2: CREATE OPTIMIZED QUERIES TO MANAGE AND ANALYZE DATA
-- TASK 1: Create a procedure that displays the maximum ordered quantity in the OrderItems table
CREATE PROCEDURE GetMaxQuantity()
SELECT MAX(Quantity) AS 'Max Quantity in OrderItems'
FROM OrderItems;

-- TASK 2: Create a prepared statement called GetOrderDetail that returns details for specific order using order id
PREPARE GetOrderDetail FROM
"SELECT Orders.OrderID, SUM(OrderItems.Quantity) AS Quantity,
	SUM(OrderItems.Quantity * MenuItems.Price) AS Cost
FROM Customers
INNER JOIN Bookings 
ON Customers.CustomerID = Bookings.CustomerID
INNER JOIN Orders 
ON Bookings.BookingID = Orders.BookingID
INNER JOIN OrderItems 
ON Orders.OrderID = OrderItems.OrderID
INNER JOIN MenuItems 
ON OrderItems.ItemID = MenuItems.ItemID
WHERE Orders.OrderID = ?
GROUP BY Orders.OrderID";
SET @id = 1;
EXECUTE GetOrderDetail USING @id;

-- TASK 3: Delete an order record based on the user input of the order id
DELIMITER //
CREATE PROCEDURE CancelOrder(IN order_id INT)
BEGIN
	DELETE FROM Orders 
    WHERE Orders.OrderId = order_id;
    SELECT CONCAT('Order ', order_id, ' is cancelled') AS 'Confirmation';
END //
DELIMITER ;


--===================== EXERCISE 3: Create SQL queries to check available bookings based on user input
-- TASK 1: Populate the Bookings table with some records of data
INSERT INTO Bookings
	(Time, TableNo, CustomerID)
VALUES
	('2022-10-10 12:00:00', 5, 1),
    ('2022-10-11 12:00:00', 2, 2),
    ('2022-10-13 12:00:00', 2, 1),
    ('2022-11-12 12:00:00', 3, 3);

-- TASK 2: Create stored procedure called CheckBooking to check whether a table is already booked
DELIMITER //
CREATE PROCEDURE CheckBooking(IN time TIMESTAMP, IN table_no SMALLINT UNSIGNED)
BEGIN
	SELECT CASE WHEN EXISTS (
		SELECT *
		FROM Bookings 
		WHERE Bookings.Time = time AND Bookings.TableNo = table_no) 
	THEN CONCAT('Table ', table_no, ' is already booked')
	ELSE CONCAT('Table ', table_no, ' is free to book')
	END AS 'Booking Status';
END //
DELIMITER ;

-- TASK 3: Create stored procedure AddValidBooking to verify a booking, use transaction with rollback or commit
DELIMITER //
CREATE PROCEDURE AddValidBooking(
    IN time TIMESTAMP, IN table_no SMALLINT UNSIGNED, IN customer_id SMALLINT UNSIGNED)
BEGIN
	DECLARE already_booked TINYINT UNSIGNED DEFAULT 0;
	START TRANSACTION;
	SET already_booked = EXISTS (
		SELECT *
		FROM Bookings 
		WHERE Bookings.Time = time AND Bookings.TableNo = table_no);
	INSERT INTO Bookings (Time, TableNo, CustomerID)
	VALUES (time, table_no, customer_id);
	IF already_booked = 1 THEN
		BEGIN
			SELECT CONCAT('Table ', table_no, ' is already booked - booking cancelled!') AS 'Booking Status'; 
            ROLLBACK;
		END;
	ELSE 
		BEGIN
			SELECT CONCAT('Table ', table_no, ' is free to  book - booking successful.') AS 'Booking Status';
            COMMIT;
		END;
	END IF;
END //
DELIMITER ;


-- ===================== EXERCISE 4: CREATE SQL QUERIES TO ADD AND UPDATE BOOKINGS
-- TASK 1: Create a procedure to add a new record in Bookings table
DELIMITER //
CREATE PROCEDURE AddBooking(
    IN time TIMESTAMP, IN table_number SMALLINT UNSIGNED, IN customer_id SMALLINT UNSIGNED)
BEGIN
INSERT INTO Bookings (Time, TableNo, CustomerID)
VALUES (time, table_number, customer_id);
END //
DELIMITER ;

-- TASK 2: Create procedure to update existing booking
DELIMITER //
CREATE PROCEDURE UpdateBooking(IN booking_id INT, IN time TIMESTAMP)
BEGIN
	UPDATE Bookings 
	SET Bookings.Time = time 
	WHERE Bookings.BookingID = booking_id;
END //
DELIMITER ;

-- TASK 3: Create a procedure to delete a booking from a table
DELIMITER //
CREATE PROCEDURE CancelBooking(IN booking_id INT)
BEGIN
DELETE FROM Bookings
WHERE Bookings.BookingID = booking_id;
END //
DELIMITER ;