-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `Role` VARCHAR(100) NOT NULL,
  `Address` VARCHAR(200) NOT NULL,
  `ContactNumber` VARCHAR(20) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `AnnualSalary` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`EmployeeID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(100) NOT NULL,
  `LastName` VARCHAR(100) NOT NULL,
  `Address` VARCHAR(200) NULL,
  `ContactNo` VARCHAR(20) NULL,
  `Email` VARCHAR(200) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `ItemId` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(100) NOT NULL,
  `Type` VARCHAR(100) NOT NULL,
  `Cuisine` VARCHAR(100) NOT NULL,
  `Price` DECIMAL(8,2) NOT NULL,
  PRIMARY KEY (`ItemId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `Time` TIMESTAMP NOT NULL,
  `TableNo` SMALLINT UNSIGNED NOT NULL,
  `CustomerID` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `fk_customer_id_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_customer_id`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` INT NOT NULL AUTO_INCREMENT,
  `BookingID` INT NOT NULL,
  `EmployeeID` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `fk_booking_id_idx` (`BookingID` ASC) VISIBLE,
  INDEX `fk_employee_id_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `fk_booking_id`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_id`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderItems` (
  `OrderItemID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `ItemID` SMALLINT UNSIGNED NOT NULL,
  `Quantity` TINYINT UNSIGNED NOT NULL,
  INDEX `fk_order_id_idx` (`OrderID` ASC) VISIBLE,
  INDEX `fk_item_id_idx` (`ItemID` ASC) VISIBLE,
  PRIMARY KEY (`OrderItemID`),
  CONSTRAINT `fk_order_id`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_id`
    FOREIGN KEY (`ItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`ItemId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderStatuses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderStatuses` (
  `OrderStatusID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` INT NOT NULL,
  `StatusChanged` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Status` ENUM('received', 'delivered', 'paid') NOT NULL,
  INDEX `fk_order_id_idx` (`OrderID` ASC) VISIBLE,
  PRIMARY KEY (`OrderStatusID`),
  CONSTRAINT `fk_order_id_2`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
