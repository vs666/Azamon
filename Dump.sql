-- MySQL dump 10.13  Distrib 8.0.21, for Linux (x86_64)
--
-- Host: localhost    Database: ECOM
-- ------------------------------------------------------
-- Server version	8.0.21-0ubuntu0.20.04.4
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */
;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */
;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */
;
/*!50503 SET NAMES utf8mb4 */
;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */
;
/*!40103 SET TIME_ZONE='+00:00' */
;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */
;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */
;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */
;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */
;
--
-- Table structure for table `AGENCY`
--
DROP DATABASE IF EXISTS `ECOM`;
CREATE SCHEMA `ECOM`;
USE `ECOM`;

DROP TABLE IF EXISTS `AGENCY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `AGENCY` (
  `EmailID` varchar(255) NOT NULL,
  `AgencyID` varchar(15) NOT NULL,
  PRIMARY KEY (`AgencyID`),
  KEY `EmailID` (`EmailID`),
  CONSTRAINT `AGENCY_ibfk_1` FOREIGN KEY (`EmailID`) REFERENCES `USER_TABLE` (`EmailID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `AGENCY`
--
LOCK TABLES `AGENCY` WRITE;
/*!40000 ALTER TABLE `AGENCY` DISABLE KEYS */
;
INSERT INTO `AGENCY`
VALUES ('aa', 'aa11'),
  ('rapido@delivery.in', 'RAPIDO007');
/*!40000 ALTER TABLE `AGENCY` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `BELONGS_TO`
--
DROP TABLE IF EXISTS `BELONGS_TO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `BELONGS_TO` (
  `ProductID` varchar(255) NOT NULL,
  `CategoryID` varchar(255) NOT NULL,
  PRIMARY KEY (`ProductID`, `CategoryID`),
  KEY `CategoryID` (`CategoryID`),
  CONSTRAINT `BELONGS_TO_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `PRODUCTS` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `BELONGS_TO_ibfk_2` FOREIGN KEY (`CategoryID`) REFERENCES `CATEGORY` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `BELONGS_TO`
--
LOCK TABLES `BELONGS_TO` WRITE;
/*!40000 ALTER TABLE `BELONGS_TO` DISABLE KEYS */
;
INSERT INTO `BELONGS_TO`
VALUES ('BayLE9', 'Clothing'),
  ('M19WEX', 'Clothing'),
  ('asd', 'Cricket'),
  ('Nimbus2000', 'Cricket'),
  ('MacAir', 'Electronics'),
  ('OneP_se', 'Electronics'),
  ('S434K', 'Electronics'),
  ('ADI2010', 'Football/Soccer'),
  ('Barca10', 'Football/Soccer'),
  ('ADI2010', 'Sports'),
  ('Barca10', 'Sports'),
  ('Nimbus2000', 'Sports'),
  ('PUMAF99', 'Sports'),
  ('PUMAF99', 'Tennis/Badminton');
/*!40000 ALTER TABLE `BELONGS_TO` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `BILL`
--
DROP TABLE IF EXISTS `BILL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `BILL` (
  `Bill_number` int NOT NULL AUTO_INCREMENT,
  `Purchase_time` time NOT NULL,
  `Purchase_date` date NOT NULL,
  PRIMARY KEY (`Bill_number`)
) ENGINE = InnoDB AUTO_INCREMENT = 26 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `BILL`
--
LOCK TABLES `BILL` WRITE;
/*!40000 ALTER TABLE `BILL` DISABLE KEYS */
;
INSERT INTO `BILL`
VALUES (1, '17:54:38', '2020-10-06'),
  (2, '18:09:18', '2020-10-06'),
  (3, '18:13:44', '2020-10-06'),
  (4, '18:18:16', '2020-10-06'),
  (5, '18:24:25', '2020-10-06'),
  (6, '18:26:43', '2020-10-06'),
  (7, '18:27:25', '2020-10-06'),
  (8, '18:27:32', '2020-10-06'),
  (9, '20:25:32', '2020-10-06'),
  (10, '20:25:55', '2020-10-06'),
  (11, '20:27:06', '2020-10-06'),
  (12, '20:31:49', '2020-10-06'),
  (13, '20:32:25', '2020-10-06'),
  (14, '20:56:55', '2020-10-06'),
  (15, '20:57:55', '2020-10-06'),
  (16, '20:59:04', '2020-10-06'),
  (17, '20:59:53', '2020-10-06'),
  (18, '21:00:41', '2020-10-06'),
  (19, '21:03:56', '2020-10-06'),
  (20, '21:04:57', '2020-10-06'),
  (21, '21:06:04', '2020-10-06'),
  (22, '21:07:29', '2020-10-06'),
  (23, '21:09:30', '2020-10-06'),
  (24, '21:10:23', '2020-10-06'),
  (25, '21:18:27', '2020-10-06');
/*!40000 ALTER TABLE `BILL` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `CART`
--
DROP TABLE IF EXISTS `CART`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `CART` (
  `CustomerID` varchar(225) NOT NULL,
  `ProductID` varchar(15) NOT NULL,
  `Product_type` varchar(255) NOT NULL,
  PRIMARY KEY (`CustomerID`, `ProductID`),
  KEY `ProductID` (`ProductID`),
  CONSTRAINT `CART_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `CUSTOMER_DETAILS` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CART_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `PRODUCTS` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `CART`
--
LOCK TABLES `CART` WRITE;
/*!40000 ALTER TABLE `CART` DISABLE KEYS */
;
/*!40000 ALTER TABLE `CART` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `CATEGORY`
--
DROP TABLE IF EXISTS `CATEGORY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `CATEGORY` (
  `CategoryID` varchar(255) NOT NULL,
  PRIMARY KEY (`CategoryID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `CATEGORY`
--
LOCK TABLES `CATEGORY` WRITE;
/*!40000 ALTER TABLE `CATEGORY` DISABLE KEYS */
;
INSERT INTO `CATEGORY`
VALUES ('Casual_Wear'),
  ('Clothing'),
  ('Cricket'),
  ('Electronics'),
  ('Football/Soccer'),
  ('Laptops'),
  ('Mechanical'),
  ('Party_Wear'),
  ('Phones'),
  ('Sports'),
  ('Sports_Wear'),
  ('Television'),
  ('Tennis/Badminton');
/*!40000 ALTER TABLE `CATEGORY` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `CUSTOMER_DETAILS`
--
DROP TABLE IF EXISTS `CUSTOMER_DETAILS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `CUSTOMER_DETAILS` (
  `CustomerID` varchar(225) NOT NULL,
  `EmailID` varchar(225) NOT NULL,
  `Date_of_joining` date DEFAULT NULL,
  PRIMARY KEY (`CustomerID`),
  KEY `EmailID` (`EmailID`),
  CONSTRAINT `CUSTOMER_DETAILS_ibfk_1` FOREIGN KEY (`EmailID`) REFERENCES `USER_TABLE` (`EmailID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `CUSTOMER_DETAILS`
--
LOCK TABLES `CUSTOMER_DETAILS` WRITE;
/*!40000 ALTER TABLE `CUSTOMER_DETAILS` DISABLE KEYS */
;
INSERT INTO `CUSTOMER_DETAILS`
VALUES ('a@2019-02-02@1', 'a', '2019-02-02'),
  ('b@2020-11-11@2', 'b', '2020-11-11'),
  (
    'vs@research.ibm.w@2014-04-01@9374732112',
    'vs@research.ibm.w',
    '2014-04-01'
  );
/*!40000 ALTER TABLE `CUSTOMER_DETAILS` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `DELIVERY`
--
DROP TABLE IF EXISTS `DELIVERY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `DELIVERY` (
  `TrackID` varchar(15) NOT NULL,
  `Delivery_time` time NOT NULL,
  `AgencyID` varchar(15) NOT NULL,
  PRIMARY KEY (`TrackID`),
  KEY `AgencyID` (`AgencyID`),
  CONSTRAINT `DELIVERY_ibfk_1` FOREIGN KEY (`AgencyID`) REFERENCES `AGENCY` (`AgencyID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `DELIVERY`
--
LOCK TABLES `DELIVERY` WRITE;
/*!40000 ALTER TABLE `DELIVERY` DISABLE KEYS */
;
INSERT INTO `DELIVERY`
VALUES ('19aa11', '21:03:56', 'aa11'),
  ('21aa11', '21:06:04', 'aa11'),
  ('22aa11', '21:07:29', 'aa11'),
  ('23aa11', '21:09:30', 'aa11'),
  ('24aa11', '21:10:23', 'aa11'),
  ('25aa11', '21:18:27', 'aa11');
/*!40000 ALTER TABLE `DELIVERY` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `FALLS_UNDER`
--
DROP TABLE IF EXISTS `FALLS_UNDER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `FALLS_UNDER` (
  `SuperCategoryID` varchar(255) NOT NULL,
  `SubCategoryID` varchar(255) NOT NULL,
  PRIMARY KEY (`SuperCategoryID`, `SubCategoryID`),
  KEY `SubCategoryID` (`SubCategoryID`),
  CONSTRAINT `FALLS_UNDER_ibfk_1` FOREIGN KEY (`SubCategoryID`) REFERENCES `CATEGORY` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FALLS_UNDER_ibfk_2` FOREIGN KEY (`SuperCategoryID`) REFERENCES `CATEGORY` (`CategoryID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `FALLS_UNDER`
--
LOCK TABLES `FALLS_UNDER` WRITE;
/*!40000 ALTER TABLE `FALLS_UNDER` DISABLE KEYS */
;
INSERT INTO `FALLS_UNDER`
VALUES ('Clothing', 'Casual_Wear'),
  ('Sports', 'Cricket'),
  ('Sports', 'Football/Soccer'),
  ('Electronics', 'Laptops'),
  ('Clothing', 'Party_Wear'),
  ('Electronics', 'Phones'),
  ('Clothing', 'Sports_Wear'),
  ('Electronics', 'Television'),
  ('Sports', 'Tennis/Badminton');
/*!40000 ALTER TABLE `FALLS_UNDER` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `ORDERS`
--
DROP TABLE IF EXISTS `ORDERS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `ORDERS` (
  `TrackID` varchar(225) NOT NULL,
  `Bill_number` int NOT NULL,
  `CustomerID` varchar(225) NOT NULL,
  PRIMARY KEY (`TrackID`, `Bill_number`, `CustomerID`),
  KEY `Bill_number` (`Bill_number`),
  KEY `CustomerID` (`CustomerID`),
  CONSTRAINT `ORDERS_ibfk_1` FOREIGN KEY (`TrackID`) REFERENCES `DELIVERY` (`TrackID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ORDERS_ibfk_2` FOREIGN KEY (`Bill_number`) REFERENCES `BILL` (`Bill_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ORDERS_ibfk_3` FOREIGN KEY (`CustomerID`) REFERENCES `CUSTOMER_DETAILS` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `ORDERS`
--
LOCK TABLES `ORDERS` WRITE;
/*!40000 ALTER TABLE `ORDERS` DISABLE KEYS */
;
INSERT INTO `ORDERS`
VALUES ('19aa11', 19, 'a@2019-02-02@1'),
  ('21aa11', 21, 'a@2019-02-02@1'),
  ('22aa11', 22, 'a@2019-02-02@1'),
  ('23aa11', 23, 'a@2019-02-02@1'),
  ('24aa11', 24, 'a@2019-02-02@1'),
  ('25aa11', 25, 'a@2019-02-02@1');
/*!40000 ALTER TABLE `ORDERS` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `PAYMENT_MODE`
--
DROP TABLE IF EXISTS `PAYMENT_MODE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `PAYMENT_MODE` (
  `Company` varchar(30) NOT NULL,
  `Mode` varchar(15) NOT NULL,
  PRIMARY KEY (`Company`, `Mode`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `PAYMENT_MODE`
--
LOCK TABLES `PAYMENT_MODE` WRITE;
/*!40000 ALTER TABLE `PAYMENT_MODE` DISABLE KEYS */
;
INSERT INTO `PAYMENT_MODE`
VALUES ('abiboss', 'card'),
  ('adiboss', 'cash'),
  ('Amazon Pay', 'OnlineBanking'),
  ('NoCompany', 'CashOnDelivery'),
  ('PayTM', 'OnlineBanking'),
  ('StateBankofIndia', 'Debit Card'),
  ('StateBankofIndia', 'OnlineBanking');
/*!40000 ALTER TABLE `PAYMENT_MODE` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `PRODUCTS`
--
DROP TABLE IF EXISTS `PRODUCTS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `PRODUCTS` (
  `ProductID` varchar(255) NOT NULL,
  `Price` decimal(10, 2) NOT NULL,
  `Product_name` varchar(255) NOT NULL,
  `Brand` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ProductID`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `PRODUCTS`
--
LOCK TABLES `PRODUCTS` WRITE;
/*!40000 ALTER TABLE `PRODUCTS` DISABLE KEYS */
;
INSERT INTO `PRODUCTS`
VALUES (
    'ADI2010',
    100.00,
    'Adiboss Sports Shoes',
    'Adiboss'
  ),
  ('asd', 3333.00, 'asd', 'asd'),
  (
    'Barca10',
    1111.00,
    'Barca edition Football',
    'Adidas'
  ),
  (
    'BayLE9',
    1100.00,
    'Lewandoski edition Bayern Jersey',
    'Nike'
  ),
  (
    'M19WEX',
    29000.00,
    'Wedding Shervani',
    'Manyavar'
  ),
  ('MacAir', 83000.00, 'Mac Book Air', 'Apple'),
  (
    'Nimbus2000',
    21000.00,
    'Nimbus 2000 MagickBroom',
    'Borgin&Burkes'
  ),
  (
    'OneP_se',
    45500.00,
    'OnePlus Special Edition',
    'OnePlus'
  ),
  (
    'PUMAF99',
    1000.00,
    'Puma Frazer 99 Shoes',
    'PUMA'
  ),
  (
    'S434K',
    93000.00,
    'Sony 43 4K plasma TV',
    'Sony'
  );
/*!40000 ALTER TABLE `PRODUCTS` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `PURCHASE`
--
DROP TABLE IF EXISTS `PURCHASE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `PURCHASE` (
  `ProductID` varchar(15) NOT NULL,
  `Bill_no` int NOT NULL,
  `Mode_of_payment` varchar(15) NOT NULL,
  `Payment_company` varchar(30) NOT NULL,
  `Purchase_no` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`Purchase_no`),
  KEY `Payment_company` (`Payment_company`, `Mode_of_payment`),
  CONSTRAINT `PURCHASE_ibfk_1` FOREIGN KEY (`Payment_company`, `Mode_of_payment`) REFERENCES `PAYMENT_MODE` (`Company`, `Mode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `PURCHASE`
--
LOCK TABLES `PURCHASE` WRITE;
/*!40000 ALTER TABLE `PURCHASE` DISABLE KEYS */
;
INSERT INTO `PURCHASE`
VALUES ('ADI2010', 14, 'card', 'abiboss', 4),
  ('ADI2010', 15, 'card', 'abiboss', 5),
  ('ADI2010', 16, 'card', 'abiboss', 6);
/*!40000 ALTER TABLE `PURCHASE` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `SELLS`
--
DROP TABLE IF EXISTS `SELLS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `SELLS` (
  `ProductID` varchar(225) NOT NULL,
  `SupplierID` varchar(225) NOT NULL,
  PRIMARY KEY (`ProductID`, `SupplierID`),
  KEY `SupplierID` (`SupplierID`),
  CONSTRAINT `SELLS_ibfk_1` FOREIGN KEY (`ProductID`) REFERENCES `PRODUCTS` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `SELLS_ibfk_2` FOREIGN KEY (`SupplierID`) REFERENCES `SUPPLIER` (`SupplierID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `SELLS`
--
LOCK TABLES `SELLS` WRITE;
/*!40000 ALTER TABLE `SELLS` DISABLE KEYS */
;
INSERT INTO `SELLS`
VALUES ('asd', 'z10');
/*!40000 ALTER TABLE `SELLS` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `SUPPLIER`
--
DROP TABLE IF EXISTS `SUPPLIER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `SUPPLIER` (
  `SupplierID` varchar(225) NOT NULL,
  `EmailID` varchar(225) NOT NULL,
  PRIMARY KEY (`SupplierID`),
  KEY `EmailID` (`EmailID`),
  CONSTRAINT `SUPPLIER_ibfk_1` FOREIGN KEY (`EmailID`) REFERENCES `USER_TABLE` (`EmailID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `SUPPLIER`
--
LOCK TABLES `SUPPLIER` WRITE;
/*!40000 ALTER TABLE `SUPPLIER` DISABLE KEYS */
;
INSERT INTO `SUPPLIER`
VALUES ('z10', 'z');
/*!40000 ALTER TABLE `SUPPLIER` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `USER_TABLE`
--
DROP TABLE IF EXISTS `USER_TABLE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `USER_TABLE` (
  `EmailID` varchar(225) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Address_line1` varchar(225) DEFAULT NULL,
  `Street` varchar(225) DEFAULT NULL,
  `Pincode` int DEFAULT NULL,
  `Date_of_birth` date DEFAULT NULL,
  `Phone_number` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`EmailID`),
  UNIQUE KEY `Phone_number` (`Phone_number`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `USER_TABLE`
--
LOCK TABLES `USER_TABLE` WRITE;
/*!40000 ALTER TABLE `USER_TABLE` DISABLE KEYS */
;
INSERT INTO `USER_TABLE`
VALUES ('a', 'a', 'a', 'a', 1, '2019-02-02', '1'),
  ('aa', 'aa', 'aa', 'aa', 11, '2020-02-02', '11'),
  ('b', 'b', 'b', 'b', 2, '2020-11-11', '2'),
  (
    'rapido@delivery.in',
    'Rapido Delivery',
    'C-322 Industrial Warehouse',
    'G.T. Road',
    211001,
    '2011-02-22',
    '9385777743'
  ),
  (
    'vs@research.ibm.w',
    'Varul Srivastava',
    'A-21 High Court Colony, Chauphatka',
    'G. T. Road',
    211001,
    '2001-02-24',
    '9374732112'
  ),
  ('z', 'z', 'z', 'z', 10, '2020-10-10', '10');
/*!40000 ALTER TABLE `USER_TABLE` ENABLE KEYS */
;
UNLOCK TABLES;
--
-- Table structure for table `WARRANTY`
--
DROP TABLE IF EXISTS `WARRANTY`;
/*!40101 SET @saved_cs_client     = @@character_set_client */
;
/*!50503 SET character_set_client = utf8mb4 */
;
CREATE TABLE `WARRANTY` (
  `Bill_num` int NOT NULL,
  `ProductId` varchar(15) NOT NULL,
  `Purchase_num` int NOT NULL,
  `Applicable` tinyint(1) NOT NULL,
  `Warranty_period` int DEFAULT '0',
  PRIMARY KEY (`Bill_num`, `ProductId`, `Purchase_num`),
  KEY `ProductId` (`ProductId`),
  KEY `Purchase_num` (`Purchase_num`),
  CONSTRAINT `WARRANTY_ibfk_1` FOREIGN KEY (`Bill_num`) REFERENCES `BILL` (`Bill_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `WARRANTY_ibfk_2` FOREIGN KEY (`ProductId`) REFERENCES `PRODUCTS` (`ProductID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `WARRANTY_ibfk_3` FOREIGN KEY (`Purchase_num`) REFERENCES `PURCHASE` (`Purchase_no`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */
;
--
-- Dumping data for table `WARRANTY`
--
LOCK TABLES `WARRANTY` WRITE;
/*!40000 ALTER TABLE `WARRANTY` DISABLE KEYS */
;
INSERT INTO `WARRANTY`
VALUES (16, 'ADI2010', 6, 1, 1);
/*!40000 ALTER TABLE `WARRANTY` ENABLE KEYS */
;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */
;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */
;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */
;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */
;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */
;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */
;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */
;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */
;
-- Dump completed on 2020-10-06 21:33:02