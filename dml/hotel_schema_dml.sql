set search_path to hotel_schema;

/* Project - DML */

-- Insert into CUSTOMER table
INSERT INTO CUSTOMER (AccountID, LastName, FirstName, Email, PhoneNumber) 
VALUES
('AUEE9347', 'Anderson', 'Sam', 'samoldsame@gmail.com', '489-123-4567'),
('F904WFHS', 'Nguyen', 'Lilia', 'lilnguyen031@yahoo.com', '289-987-6543'),
('SRG9WKND', 'Williams', 'Erik', 'eriknotme@icloud.com', '378-246-8012'),
('SVN93W02', 'Brown', 'Lucas', 'lucas.brownie@gmail.com', '912-135-7910'),
('JROWG903', 'Davis', 'Patricia', 'patdavis98@hotmail.com', '426-864-2098'),
('NAEGP923', 'Miller', 'Sabrina', 'sabrinaqueen@yahoo.com', '917-753-1986'),
('VR84320F', 'Rodriguez', 'Linda', 'lindarod445@icloud.com', '714-420-8521'),
('PVB843SK', 'Garcia', 'Jenna', 'jenna.garcia117@gmail.com', '512-319-7410'),
('SP294ASP', 'Monroe', 'Maria', 'yummymm96@gmail.com', '853-648-3109'),
('AQF39HSQ', 'Martinez', 'Christopher', 'chri.smart@icloud.com', '786-537-0897'),
('PQ2WSG81', 'Toups', 'Angela', 'angela.lotus00@gmail.com', '479-026-9785'),
('EOD024WS', 'Patel', 'Kevin', 'kevinpatel219@yahoo.com', '389-915-6374');


-- Insert into RESERVATION table
INSERT INTO RESERVATION (AccountID, RoomQuantity, PartySize, CheckIn, CheckOut) 
VALUES
('AUEE9347', 1, 3, '2025-06-15', '2025-06-20'),
('F904WFHS', 1, 2, '2025-07-05', '2025-07-08'),
('SRG9WKND', 2, 4, '2025-10-01', '2025-10-03'),
('SVN93W02', 1, 2, '2025-06-05', '2025-06-07'),
('NAEGP923', 2, 4, '2025-08-20', '2025-08-25'),
('VR84320F', 1, 2, '2025-06-12', '2025-06-18'),
('SP294ASP', 2, 6, '2025-07-01', '2025-07-07'),
('AQF39HSQ', 1, 4, '2025-08-18', '2025-08-22'),
('PQ2WSG81', 1, 3, '2025-09-02', '2025-09-05'),
('EOD024WS', 1, 2, '2025-10-10', '2025-10-14');


-- Insert into ROOM table
INSERT INTO ROOM (RoomID,ResID, RoomType, RoomView, Floor) 
VALUES
('101', NULL , 'Family', 'Ocean View', 1),
('102', '100000000001','Double', 'City View', 1),
('103', '100000000004','King', 'Ocean View', 1),
('104', NULL,'Double', 'Pool View', 1),
('105', '100000000002','King', 'City View', 1),
('201', NULL,'Family', 'Ocean View', 2),
('202', '100000000009','Double', 'City View', 2),
('203', '100000000003','King', 'Ocean View', 2),
('204', '100000000003','Double', 'Pool View', 2),
('205', NULL, 'King', 'City View', 2),
('301', NULL, 'Family', 'Ocean View', 3),
('302', '100000000005','Double', 'City View', 3),
('303', '100000000005','King', 'Ocean View', 3),
('304', '100000000006','Double', 'Pool View', 3),
('305', NULL, 'King', 'City View', 3),
('401', '100000000007','Family', 'Ocean View', 4),
('402', '100000000007','Double', 'City View', 4),
('403', NULL, 'King', 'Ocean View', 4),
('404', '100000000008','Double', 'Pool View', 4),
('405', '100000000010','King', 'City View', 4);


-- Insert into PAYMENT table
INSERT INTO PAYMENT (ResID, PaymentMethod, TotalAmount, DatePaid, Notes)
VALUES
('100000000001', 'Credit Card', 250.00, '2025-04-01', 'Paid in full'),
('100000000002','Credit Card', 150.00, '2025-04-02', 'Paid in cash at counter'),
('100000000003','Credit Card', 300.00, '2025-04-03', NULL),
('100000000004','Debit Card', 220.00, '2025-04-04', 'Paid via debit'),
('100000000005','Credit Card', 275.00, '2025-04-05', 'Online transfer'),
('100000000006','Credit Card', 190.00, '2025-04-06', NULL),
('100000000007','Debit Card', 310.00, '2025-04-07', 'Discount applied'),
('100000000008','Debit Card', 450.00, '2025-04-08', NULL),
('100000000009','Debit Card', 400.00, '2025-04-09', 'Late fee included'),
('100000000010','Credit Card', 180.00, '2025-04-10', 'Paid same day');


-- Insert into DEPARTMENT table
INSERT INTO DEPARTMENT (DepartmentName, DepartmentHead, Capacity, DepartmentEmail, PhoneExtension)
VALUES
('Front Desk', NULL, 10, 'frontdesk@hotel.com', 1),
('Housekeeping', NULL, 25, 'housekeeping@hotel.com', 2),
('Food and Beverage', NULL, 15, 'fnb@hotel.com', 3),
('Maintenance', NULL, 8, 'maintenance@hotel.com', 4),
('Security', NULL, 6, 'security@hotel.com', 5),
('Accounting', NULL, 5, 'accounting@hotel.com', 6),
('Human Resources', NULL, 4, 'hr@hotel.com', 7),
('Sales and Marketing', NULL, 6, 'sales@hotel.com', 8),
('IT Support', NULL, 3, 'it@hotel.com', 9),
('Events and Banquets', NULL, 5, 'events@hotel.com', 10);


-- Insert into EMPLOYEE table
INSERT INTO EMPLOYEE (EmployeeID, LastName, FirstName, DepartmentID, Title, EmploymentType, PhoneNumber, Email) 
VALUES
('SJ2743', 'Smith', 'John', 450, 'Sales Manager', 'Full-Time', '123-456-7890', 'john.smith@email.com'), 
('DJ1987', 'Doe', 'Jane', 400, 'HR Specialist', 'Full-Time', '987-654-3210', 'jane.doe@email.com'), 
('WA5629', 'Williams', 'Alex', 500, 'IT Technician', 'Part-Time', '456-789-0123', 'alex.williams@email.com'),
('GM4832', 'Garcia', 'Maria', 150, 'Housekeeping Supervisor', 'Full-Time', '789-654-3210', 'maria.garcia@email.com'),
('JM1305', 'Johnson', 'Michael', 100, 'Front Desk Receptionist', 'Full-Time', '321-987-6540', 'michael.johnson@email.com'),
('LS7461', 'Lee', 'Sophia', 200, 'Chef', 'Full-Time', '654-321-7890', 'sophia.lee@email.com'),
('BD9114', 'Brown', 'David', 300, 'Security Officer', 'Part-Time', '987-321-4560', 'david.brown@email.com'), 
('KE8046', 'Kim', 'Emily', 250, 'Maintenance Technician', 'Full-Time', '321-654-9870', 'emily.kim@email.com'),
('AC3372', 'Anderson', 'Chris', 550, 'Marketing Coordinator', 'Full-Time', '789-123-6540', 'chris.anderson@email.com'),
('MI6790', 'Martinez', 'Isabella', 350, 'Finance Analyst', 'Full-Time', '654-987-3210', 'isabella.martinez@email.com');


-- Assign employees as DepartmentHeads
UPDATE DEPARTMENT SET DepartmentHead = 'JM1305' WHERE DepartmentName = 'Front Desk';
UPDATE DEPARTMENT SET DepartmentHead = 'GM4832' WHERE DepartmentName = 'Housekeeping';
UPDATE DEPARTMENT SET DepartmentHead = 'LS7461' WHERE DepartmentName = 'Food and Beverage';
UPDATE DEPARTMENT SET DepartmentHead = 'KE8046' WHERE DepartmentName = 'Maintenance';
UPDATE DEPARTMENT SET DepartmentHead = 'BD9114' WHERE DepartmentName = 'Security';
UPDATE DEPARTMENT SET DepartmentHead = 'MI6790' WHERE DepartmentName = 'Accounting';
UPDATE DEPARTMENT SET DepartmentHead = 'DJ1987' WHERE DepartmentName = 'Human Resources';
UPDATE DEPARTMENT SET DepartmentHead = 'SJ2743' WHERE DepartmentName = 'Sales and Marketing';
UPDATE DEPARTMENT SET DepartmentHead = 'WA5629' WHERE DepartmentName = 'IT Support';
UPDATE DEPARTMENT SET DepartmentHead = 'AC3372' WHERE DepartmentName = 'Events and Banquets';
