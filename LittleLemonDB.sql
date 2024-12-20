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
-- Table `LittleLemonDB`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customer` (
  `customerID` INT NOT NULL,
  `name` VARCHAR(225) NOT NULL,
  `contact` INT NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `bookingID` INT NOT NULL,
  `bDate` DATETIME NOT NULL,
  `bNO` INT NOT NULL,
  `customerID` INT NOT NULL,
  PRIMARY KEY (`bookingID`),
  INDEX `customer_id_fk_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `bookings_customer_id_fk`
    FOREIGN KEY (`customerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `menuitemID` INT NOT NULL,
  `starters` VARCHAR(45) NOT NULL,
  `courses` VARCHAR(45) NOT NULL,
  `drinks` VARCHAR(45) NOT NULL,
  `desserts` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`menuitemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `menuID` INT NOT NULL,
  `cuisines` VARCHAR(45) NOT NULL,
  `orderID` INT NOT NULL,
  `menuitemID` INT NOT NULL,
  PRIMARY KEY (`menuID`),
  INDEX `order_id_fk_idx` (`orderID` ASC) VISIBLE,
  INDEX `menu_menuitems_id_fk_idx` (`menuitemID` ASC) VISIBLE,
  CONSTRAINT `menu_order_id_fk2`
    FOREIGN KEY (`orderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`orderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `menu_menuitems_id_fk`
    FOREIGN KEY (`menuitemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`menuitemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `orderID` INT NOT NULL,
  `oDate` DATETIME NOT NULL,
  `quantity` INT NOT NULL,
  `cost` DECIMAL(5,2) NOT NULL,
  `bookingID` INT NOT NULL,
  `menuID` INT NOT NULL,
  `customerID` INT NOT NULL,
  PRIMARY KEY (`orderID`),
  INDEX `booking_id_fk_idx` (`bookingID` ASC) VISIBLE,
  INDEX `orders_menu_id_fk_idx` (`menuID` ASC) VISIBLE,
  INDEX `orders_customer_id_fk_idx` (`customerID` ASC) VISIBLE,
  CONSTRAINT `orders_booking_id_fk2`
    FOREIGN KEY (`bookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`bookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_menu_id_fk`
    FOREIGN KEY (`menuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`menuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `orders_customer_id_fk`
    FOREIGN KEY (`customerID`)
    REFERENCES `LittleLemonDB`.`Customer` (`customerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Staff`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Staff` (
  `staffID` INT NOT NULL,
  `role` VARCHAR(225) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `bookingID` INT NOT NULL,
  `orderID` INT NOT NULL,
  PRIMARY KEY (`staffID`),
  INDEX `booking_id_fk_idx` (`bookingID` ASC) VISIBLE,
  INDEX `order_id_fk_idx` (`orderID` ASC) VISIBLE,
  CONSTRAINT `staff_booking_id_fk`
    FOREIGN KEY (`bookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`bookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `staff_order_id_fk`
    FOREIGN KEY (`orderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`orderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Status`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Status` (
  `statusID` INT NOT NULL,
  `deliveryDate` DATETIME NOT NULL,
  `status` VARCHAR(255) NOT NULL,
  `orderID` INT NOT NULL,
  PRIMARY KEY (`statusID`),
  INDEX `order_id_fk_idx` (`orderID` ASC) VISIBLE,
  CONSTRAINT `status_order_id_fk`
    FOREIGN KEY (`orderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`orderID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
