DROP DATABASE IF EXISTS ECOM;
CREATE DATABASE ECOM;
USE ECOM;
-- ZSh
CREATE TABLE USER_TABLE(
    EmailID VARCHAR(225) NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Address_line1 VARCHAR(225),
    Street VARCHAR(225),
    Pincode INT,
    Date_of_birth DATE,
    Phone_number VARCHAR(12) UNIQUE,
    PRIMARY KEY (EmailID)
);
CREATE TABLE AGENCY(
    EmailID VARCHAR(255) NOT NULL,
    AgencyID VARCHAR(15) NOT NULL,
    PRIMARY KEY (AgencyID),
    FOREIGN KEY (EmailID) REFERENCES USER_TABLE(EmailID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE CUSTOMER_DETAILS(
    CustomerID VARCHAR(225) NOT NULL,
    EmailID VARCHAR(225) NOT NULL,
    Date_of_joining DATE,
    PRIMARY KEY (CustomerID),
    FOREIGN KEY(EmailID) REFERENCES USER_TABLE(EmailID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE SUPPLIER(
    SupplierID VARCHAR(225) NOT NULL,
    EmailID VARCHAR(225) NOT NULL,
    PRIMARY KEY (SupplierID),
    FOREIGN KEY(EmailID) REFERENCES USER_TABLE(EmailID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- BARUl
CREATE TABLE BILL (
    Bill_number INT NOT NULL AUTO_INCREMENT,
    Purchase_time TIME NOT NULL,
    Purchase_date DATE NOT NULL,
    PRIMARY KEY (Bill_number)
);

CREATE TABLE PRODUCTS (
    ProductID VARCHAR(255) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    Product_name VARCHAR(255) NOT NULL,
    Brand VARCHAR(255),
    PRIMARY KEY (ProductID)
);
CREATE TABLE CATEGORY (
    CategoryID VARCHAR(255) NOT NULL,
    PRIMARY KEY (CategoryID)
);
CREATE TABLE BELONGS_TO (
    ProductID VARCHAR(255) NOT NULL,
    CategoryID VARCHAR(255) NOT NULL,
    PRIMARY KEY (ProductID, CategoryID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES CATEGORY(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE FALLS_UNDER (
    SuperCategoryID VARCHAR(255) NOT NULL,
    SubCategoryID VARCHAR(255) NOT NULL,
    PRIMARY KEY (SuperCategoryID, SubCategoryID),
    FOREIGN KEY (SubCategoryID) REFERENCES CATEGORY(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (SuperCategoryID) REFERENCES CATEGORY(CategoryID) ON DELETE CASCADE ON UPDATE CASCADE
);
-- Ashwin
CREATE TABLE DELIVERY(
    TrackID VARCHAR(15) NOT NULL,
    Delivery_time TIME NOT NULL,
    AgencyID VARCHAR(15) NOT NULL,
    PRIMARY KEY(TrackID),
    FOREIGN KEY (AgencyID) REFERENCES AGENCY(AgencyID) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE ORDERS(
    TrackID VARCHAR(225) NOT NULL,
    Bill_number INT NOT NULL,
    CustomerID VARCHAR(225) NOT NULL,
    PRIMARY KEY (TrackID, Bill_number, CustomerID),
    FOREIGN KEY(TrackID) REFERENCES DELIVERY(TrackID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(Bill_number) REFERENCES BILL(Bill_number) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(CustomerID) REFERENCES CUSTOMER_DETAILS(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE PAYMENT_MODE(
    Company VARCHAR(30) NOT NULL,
    Mode VARCHAR(15) NOT NULL,
    PRIMARY KEY (Company, Mode)
);
CREATE TABLE PURCHASE(
    ProductID VARCHAR(15) NOT NULL,
    Bill_no INT NOT NULL,
    Mode_of_payment VARCHAR(15) NOT NULL,
    Payment_company VARCHAR(30) NOT NULL,
    Purchase_no INT NOT NULL AUTO_INCREMENT,
    PRIMARY KEY (Purchase_no),
    FOREIGN KEY(Payment_company, Mode_of_payment) REFERENCES PAYMENT_MODE(Company, Mode) ON DELETE CASCADE ON UPDATE CASCADE
    -- FOREIGN KEY (Bill_no) REFERENCES BILL(Bill_number),
    -- CHECK (Purchase_no >= 0)
);

CREATE TABLE SELLS(
    ProductID VARCHAR(225) NOT NULL,
    SupplierID VARCHAR(225) NOT NULL,
    PRIMARY KEY (ProductID, SupplierID),
    FOREIGN KEY(ProductID) REFERENCES PRODUCTS(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY(SupplierID) REFERENCES SUPPLIER(SupplierID) ON DELETE CASCADE ON UPDATE CASCADE
);
CREATE TABLE WARRANTY(
    Bill_num INT NOT NULL,
    ProductId VARCHAR(15) NOT NULL,
    Purchase_num INT NOT NULL,
    Applicable Boolean NOT NULL,
    Warranty_period INT DEFAULT 0,
    PRIMARY KEY(Bill_num, ProductId, Purchase_num),
    FOREIGN KEY (Bill_num) REFERENCES BILL(Bill_number) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES PRODUCTS(ProductID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Purchase_num) REFERENCES PURCHASE(Purchase_no) ON DELETE CASCADE ON UPDATE CASCADE
);


CREATE TABLE CART(
    CustomerID VARCHAR(225) NOT NULL,
    ProductID VARCHAR(15) NOT NULL,
    Product_type VARCHAR(255) NOT NULL,
    PRIMARY KEY (CustomerID,ProductID),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER_DETAILS(CustomerID) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductID) ON DELETE CASCADE ON UPDATE CASCADE
);