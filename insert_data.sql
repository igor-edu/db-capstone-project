INSERT INTO Employees 
    (FirstName, LastName, Role, Address, ContactNo, Email, AnnualSalary)
VALUES
    ('Meadow', 'Gilmore', 'Receptionist', '5331 Rexford Court, Montgomery AL 36116', '(206)342-8631', 'meadow@gmail.com', 28000),
    ('Vihaan', 'Sherman', 'Receptionist', '8642 Yule Street, Arvada CO 80007', '(717)550-1675', 'vihaan@yahoo.com', 28000), 
    ('Addilyn', 'Leach', 'Head Waiter', '1693 Alice Court, Annapolis MD 21401', '(248)762-0356', 'addilyn@outlook.com', 45000),
    ('Westin', 'Singh', 'Waiter', '915 Heath Drive, Montgomery AL 36108', '(253)644-2182', 'westin@icloud.com', 36000),
    ('Vivienne', 'Roach', 'Waiter', '19141 Pine Ridge Circle, Anchorage AK 99516', '(212)658-3916', 'vivienne@gmail.com', 36000), 
    ('Caspian', 'Blankenship', 'Waiter', '4001 Anderson Road, Nashville TN 37217', '(209)300-2557', 'caspian@inbox.com', 36000),
    ('Rosalee', 'Henderson', 'Waiter', '6095 Terry Lane, Golden CO 80403', '(262)162-1585', 'rosale@gmail.com', 36000),
    ('Beau', 'McCarty', 'Waiter', '4016 Doane Street, Fremont CA 94538', '(252)258-3799', 'beau@outlook.com', 36000),
    ('Halo', 'Lambert', 'Head Chef', '2325 Eastridge Circle, Moore OK 73160', '(234)109-6666', 'halo@yahoo.com', 49000),
    ('Mario', 'Olson', 'Assistant Chef', '2436 Naples Avenue, Panama City FL 32405', '(201)874-8593', 'mario@gmail.com', 42000),
    ('Isabel', 'Olsen', 'Manager', '14285 Wycliff Way, Magalia CA 95954', '(581)200-6541', 'isabel@yahoo.com', 53000);


INSERT INTO Customers 
    (FirstName, LastName, Address, ContactNo, Email)
VALUES 
    ('Skyler', 'Ward', '5821 Taft Street, Arvada CO 80004', '(773)589-6209', 'skyler@yahoo.com'),
    ('Ariana', 'Moon', '631 West 32nd Avenue, Anchorage AK 99503', '(442)000-1332', 'ariana@gmail.com'),
    ('Nova', 'Durham', '683 North Wilson Avenue, Fayetteville AR 72701', '(559)436-0470', 'nova@inbox.com'),
    ('Tiffany', 'Bartlett', '7502 Kingman Street, Panama City Beach FL 32408', '(904)969-0742', 'tiffany@gmail.com'),
    ('Kace', 'Floyd', '3138 Banneker Drive Northeast, Washington AR 20018', '(670)799-5997', 'kace@outlook.com'),
    ('Desmond', 'Holmes', '6101 North 60th Avenue, Glendale AZ 85301', '(603)225-7188', 'desmond@gmail.com'),
    ('Bailey', 'Montgomery', '2707 Eden Street, Nashville TN 37208', '(403)132-3834', 'bailey@gmail.com'),
    ('Rosa', 'Cantrell', '1810 Orchard Place, Anchorage AK 99502', '(613)958-7711', 'rosa@yahoo.com'),
    ('Harris', 'Bowen', '5688 Johnson Court, Arvada CO 80002', '(323)527-1605', 'harris@outlook.com'),
    ('Dream', 'Morton', '2617 Truffula Circle, Norman OK 73069', '(414)901-7677', 'dream@yahoo.com');


INSERT INTO MenuItems
    (Name, Type, Cuisine, Price)
VALUES 
    ('Olives', 'Starter', 'Greek', 1.50),
    ('Flatbread', 'Starter', 'Italian', 1.20),
    ('Minestrone', 'Starter', 'Italian', 1.60),
    ('Tomato Bread', 'Starter', 'Italian', 1.50),
    ('Falafel', 'Starter', 'Turkish', 1.90),
    ('Humus', 'Starter', 'Greek', 1.00),
    ('Greek Salad', 'Main Course', 'Greek', 4.60),
    ('Bean Soup', 'Main Course', 'American', 3.90),
    ('Pizza', 'Main Course', 'Italian', 5.60),
    ('Kabasa', 'Main Course', 'Turkish', 4.80),
    ('Athens White Wine', 'Drinks', 'Greek', 8.50),
    ('Corfu Red Wine', 'Drinks', 'French', 9.80),
    ('Turkish Coffee', 'Drinks', 'Turkish', 2.90),
    ('Greek Yoghurt', 'Desserts', 'Greek', 3.60),
    ('Ice Cream', 'Desserts', 'American', 3.90),
    ('Cheesecake', 'Desserts', 'American', 4.50);


INSERT INTO Bookings
    (Time, TableNo, CustomerID)
VALUES 
    ('2023-08-30 16:00:00', 5, 1),
    ('2023-08-30 18:00:00', 1, 2),
    ('2023-08-31 12:00:00', 9, 5),
    ('2023-08-31 16:00:00', 10, 3),
    ('2023-09-01 16:00:00', 2, 9),
    ('2023-09-01 20:00:00', 1, 2),
    ('2023-09-02 12:00:00', 10, 10),
    ('2023-09-02 16:00:00', 7, 6),
    ('2023-09-02 18:00:00', 4, 4),
    ('2023-09-02 20:00:00', 6, 1),
    ('2023-09-03 16:00:00', 1, 7),
    ('2023-09-03 18:00:00', 2, 8);


INSERT INTO Orders 
    (BookingID, EmployeeID)
VALUES 
    (1, 3),
    (2, 5),
    (3, 8),
    (4, 4),
    (5, 3),
    (6, 8),
    (7, 7),
    (8, 6),
    (9, 5),
    (10, 4);  


INSERT INTO OrderItems
    (OrderID, ItemID, Quantity)
VALUES 
    (1, 1, 2),
    (1, 6, 1),
    (1, 11, 2),
    (1, 14, 1),
    (2, 6, 2),
    (2, 8, 1),
    (2, 9, 1),
    (2, 12, 2),
    (2, 15, 1),
    (2, 16, 1),
    (3, 2, 1),
    (3, 10, 1),
    (3, 11, 1),
    (3, 14, 1),
    (4, 4, 2),
    (4, 9, 2),
    (4, 11, 2),
    (4, 16, 2),
    (5, 2, 3),
    (5, 8, 3),
    (5, 11, 1),
    (5, 12, 2),
    (5, 14, 4),
    (6, 5, 2),
    (6, 9, 2),
    (6, 12, 2),
    (6, 14, 2),
    (7, 1, 1),
    (7, 10, 1),
    (7, 13, 2),
    (8, 1, 4),
    (8, 8, 2),
    (8, 11, 2), 
    (8, 15, 2),
    (9, 1, 1),
    (9, 2, 1),
    (9, 7, 1),
    (9, 8, 1),
    (9, 11, 1),
    (9, 12, 1),
    (9, 15, 2),
    (10, 2, 2), 
    (10, 10, 2),
    (10, 11, 1),
    (10, 14, 1),
    (10, 16, 2);


INSERT INTO OrderStatuses 
    (OrderID, StatusChanged, Status)
VALUES 
    (1, '2023-08-30 16:30:00', 'received'),    
    (1, '2023-08-30 17:30:00', 'delivered'),    
    (1, '2023-08-30 18:30:00', 'paid'),
    (2, '2023-08-30 18:30:00', 'received'),
    (2, '2023-08-30 19:30:00', 'delivered'),
    (2, '2023-08-30 20:00:00', 'paid'),
    (3, '2023-08-31 12:30:00', 'received'),
    (3, '2023-08-31 13:00:00', 'delivered'),
    (3, '2023-08-31 13:30:00', 'paid'),
    (4, '2023-08-31 16:30:00', 'received'),
    (4, '2023-08-31 17:00:00', 'delivered'),
    (4, '2023-08-31 18:00:00', 'paid'),
    (5, '2023-09-01 16:30:00', 'received'),
    (5, '2023-09-01 17:00:00', 'delivered'),
    (5, '2023-09-01 17:30:00', 'paid'),
    (6, '2023-09-01 21:00:00', 'received'),
    (6, '2023-09-01 22:00:00', 'delivered'),
    (6, '2023-09-01 23:00:00', 'paid'),
    (7, '2023-09-02 12:00:00', 'received'),
    (7, '2023-09-02 12:30:00', 'delivered'),
    (7, '2023-09-02 14:00:00', 'paid'),
    (8, '2023-09-02 16:30:00', 'received'),
    (8, '2023-09-02 17:00:00', 'delivered'),
    (8, '2023-09-02 18:30:00', 'paid'),
    (9, '2023-09-02 18:30:00', 'received'),
    (9, '2023-09-02 19:30:00', 'delivered'),
    (9, '2023-09-02 21:30:00', 'paid'),
    (10, '2023-09-02 20:30:00', 'received'),
    (10, '2023-09-02 21:30:00', 'delivered'),
    (10, '2023-09-02 22:30:00', 'paid');


