
------------------ EXERCISE 1: CREATE A VIRTUAL TABLE TO SUMMARIZE DATA

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


------------------------ EXERCISE 2: CREATE OPTIMIZED QUERIES TO MANAGE AND ANALYZE DATA
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
