/* Project - DDL */

DROP SCHEMA IF EXISTS hotel_schema CASCADE;
CREATE SCHEMA hotel_schema;

SET search_path TO hotel_schema;

DROP TABLE IF EXISTS EMPLOYEE CASCADE;
DROP TABLE IF EXISTS DEPARTMENT CASCADE;
DROP TABLE IF EXISTS CUSTOMER CASCADE;
DROP TABLE IF EXISTS RESERVATION CASCADE;
DROP TABLE IF EXISTS ROOM CASCADE;
DROP TABLE IF EXISTS PAYMENT CASCADE;

-- ===================================
-- CREATE TABLES
-- ===================================

CREATE TABLE EMPLOYEE (
    EmployeeID CHAR(6) PRIMARY KEY,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    DepartmentID CHAR(3),
    Title VARCHAR(50) NOT NULL,
    EmploymentType VARCHAR(10) NOT NULL,
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE DEPARTMENT (
    DepartmentID CHAR(3) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL,
    DepartmentHead CHAR(6),
    Capacity INT NOT NULL,
    DepartmentEmail VARCHAR(100),
    PhoneExtension INT,
    FOREIGN KEY (DepartmentHead) REFERENCES EMPLOYEE(EmployeeID)
);



ALTER TABLE EMPLOYEE
ADD FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID);

CREATE TABLE CUSTOMER (
    AccountID CHAR(8) PRIMARY KEY,
    LastName VARCHAR(50) NOT NULL,
    FirstName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15)
);

CREATE TABLE RESERVATION (
    ResID CHAR(12) PRIMARY KEY,
    AccountID CHAR(8) NOT NULL,
    RoomQuantity INT NOT NULL,
    PartySize INT NOT NULL,
    CheckIn DATE NOT NULL,
    CheckOut DATE NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES CUSTOMER(AccountID)
);

CREATE TABLE ROOM (
    RoomID CHAR(3) PRIMARY KEY,
    ResID CHAR(12),
    RoomType VARCHAR(20) NOT NULL,
    RoomView VARCHAR(50),
    MaxOccupancy INT,
    Floor INT NOT NULL,
    FOREIGN KEY (ResID) REFERENCES RESERVATION(ResID)
);

CREATE TABLE PAYMENT (
    ReceiptID CHAR(10) PRIMARY KEY,
    ResID CHAR(12) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    DatePaid DATE NOT NULL,
    Notes TEXT,
    FOREIGN KEY (ResID) REFERENCES RESERVATION(ResID)
);

-- ===================================
-- SEQUENCES
-- ===================================

DROP SEQUENCE IF EXISTS res_id_seq CASCADE;
DROP SEQUENCE IF EXISTS receipt_id_seq CASCADE;
DROP SEQUENCE IF EXISTS department_id_seq CASCADE;

-- RESID: 12-digit padded string
CREATE SEQUENCE res_id_seq
  START WITH 100000000001
  INCREMENT BY 1;
 
 
-- RECEIPTID: 10-digit padded string
CREATE SEQUENCE receipt_id_seq
  START WITH 3000000001
  INCREMENT BY 1;


--DEPARTMENTID: 3-digit padded string
CREATE SEQUENCE department_id_seq
    START 100
    INCREMENT 50;

 
-- ===================================
-- TRIGGER FUNCTIONS
-- ===================================

-- RESERVATION
CREATE OR REPLACE FUNCTION assign_res_id()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.ResID IS NULL THEN
    NEW.ResID := LPAD(nextval('res_id_seq')::text, 12, '0');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
 

-- PAYMENT
CREATE OR REPLACE FUNCTION assign_receipt_id()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.ReceiptID IS NULL THEN
    NEW.ReceiptID := LPAD(nextval('receipt_id_seq')::text, 10, '0');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--DEPARTMENT
CREATE OR REPLACE FUNCTION assign_department_id()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.DepartmentID IS NULL THEN
    NEW.DepartmentID := LPAD(nextval('department_id_seq')::text, 3, '0');
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


--MaxOccupancy
CREATE OR REPLACE FUNCTION set_max_occupancy()
RETURNS TRIGGER AS $$
BEGIN
    IF LOWER(NEW.RoomType) = 'king' THEN
        NEW.MaxOccupancy := 2;
    ELSIF LOWER(NEW.RoomType) = 'double' THEN
        NEW.MaxOccupancy := 4;
    ELSIF LOWER(NEW.RoomType) = 'family' THEN
        NEW.MaxOccupancy := 6;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


-- ===================================
-- TRIGGERS
-- ===================================
 
-- RESERVATION
CREATE TRIGGER trg_assign_res_id
BEFORE INSERT ON RESERVATION
FOR EACH ROW
EXECUTE FUNCTION assign_res_id();

-- PAYMENT
CREATE TRIGGER trg_assign_receipt_id
BEFORE INSERT ON PAYMENT
FOR EACH ROW
EXECUTE FUNCTION assign_receipt_id();

--DEPARTMENT
CREATE TRIGGER trg_assign_department_id
BEFORE INSERT ON DEPARTMENT
FOR EACH ROW
EXECUTE FUNCTION assign_department_id();

--MaxOccupancy
CREATE TRIGGER insert_max_occupancy
BEFORE INSERT ON ROOM
FOR EACH ROW
EXECUTE FUNCTION set_max_occupancy();
