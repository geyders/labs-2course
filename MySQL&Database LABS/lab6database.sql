-- MySQL Workbench Synchronization
-- Generated: 2024-10-13 12:35
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: yulia

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `Product` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `Product`.`Product` (
  `ProductID` INT(11) NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `UnitOfMeasure` VARCHAR(45) NOT NULL,
  `UnitPrice` DECIMAL NOT NULL,
  `SupplierID` INT(11) NOT NULL,
  `Category_id` INT(11) NOT NULL,
  PRIMARY KEY (`ProductID`, `Category_id`, `SupplierID`),
  CONSTRAINT `product_id`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Product`.`Stock` (`id integer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Product`.`Invoice` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`ProductID`)
    REFERENCES `Product`.`Order` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`Stock` (
  `id integer` INT(11) NOT NULL,
  `Stock_id` INT(11) NOT NULL,
  `Product_id` INT(11) NOT NULL,
  `QuantityinStock` INT(11) NOT NULL,
  PRIMARY KEY (`id integer`),
  INDEX `stock_id_idx` (`Product_id` ASC) VISIBLE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Product`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`Sale` (
  `id integer` INT(11) NULL DEFAULT NULL,
  `Sale_id` INT(11) NULL DEFAULT NULL,
  `Saledate` DATE NOT NULL,
  `Product_id` INT(11) NOT NULL,
  `QuantitySold` INT(11) NOT NULL,
  `QuantityAfterSale` INT(11) NOT NULL,
  `Customer_id` INT(11) NOT NULL,
  `Employee_id` INT(11) NOT NULL,
  PRIMARY KEY (`id integer`, `Sale_id`),
  INDEX `product_id_idx` (`Product_id` ASC) VISIBLE,
  CONSTRAINT `sale_id`
    FOREIGN KEY (`id integer`)
    REFERENCES `Product`.`Invoice` (`invoice_id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `sale_id`
    FOREIGN KEY (`Sale_id`)
    REFERENCES `Product`.`Employee` (`id`)
    ON DELETE SET NULL
    ON UPDATE SET NULL,
  CONSTRAINT `product_id`
    FOREIGN KEY (`Product_id`)
    REFERENCES `Product`.`Product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`Supplier` (
  `id integer` INT(11) NOT NULL,
  `suppleir_id` INT(11) NOT NULL,
  `supplierName` VARCHAR(45) NOT NULL,
  `contactInfo` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id integer`, `suppleir_id`),
  INDEX `suplier_id_idx` (`suppleir_id` ASC) VISIBLE,
  CONSTRAINT `suplier_id`
    FOREIGN KEY (`suppleir_id`)
    REFERENCES `Product`.`Product` (`SupplierID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`Invoice` (
  `id` INT(11) NOT NULL,
  `invoice_id` INT(11) NOT NULL,
  `sale_id` INT(11) NOT NULL,
  `invoiceDate` DATE NOT NULL,
  `totalAmount` DECIMAL NOT NULL,
  PRIMARY KEY (`id`, `invoice_id`),
  INDEX `invoice_id_idx` (`invoice_id` ASC) VISIBLE,
  CONSTRAINT `invoice_id`
    FOREIGN KEY (`invoice_id`)
    REFERENCES `Product`.`Payment` (`payment_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`Customer` (
  `id` INT(11) NOT NULL,
  `customer_id` INT(11) NOT NULL,
  `customerName` VARCHAR(45) NOT NULL,
  `contactInfo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `customer_id`),
  CONSTRAINT `customer_id`
    FOREIGN KEY (`id`)
    REFERENCES `Product`.`Sale` (`Sale_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `custome_id`
    FOREIGN KEY (`id`)
    REFERENCES `Product`.`Order` (`order_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`ProductCategory` (
  `id` INT(11) NOT NULL,
  `category_id` INT(11) NOT NULL,
  `categoryName` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `category_id_idx` (`category_id` ASC) VISIBLE,
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `Product`.`Product` (`Category_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`Order` (
  `id` INT(11) NULL DEFAULT NULL,
  `order_id` INT(11) NOT NULL,
  `orderDate` DATE NOT NULL,
  `customer_id` INT(11) NOT NULL,
  `product_id` INT(11) NOT NULL,
  `quantityOrdered` INT(11) NOT NULL,
  `totalAmount` DECIMAL NOT NULL,
  PRIMARY KEY (`id`, `order_id`),
  INDEX `customer_id_idx` (`customer_id` ASC) VISIBLE,
  INDEX `product_id_idx` (`product_id` ASC) VISIBLE,
  CONSTRAINT `customer_id`
    FOREIGN KEY (`customer_id`)
    REFERENCES `Product`.`Customer` (`customer_id`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `Product`.`Product` (`ProductID`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`Employee` (
  `id` INT(11) NOT NULL,
  `employee_id` INT(11) NOT NULL,
  `employeeName` VARCHAR(45) NOT NULL,
  `position` VARCHAR(45) NOT NULL,
  `contactInfo` VARCHAR(45) NOT NULL,
  `hireDate` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `employee_id_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `employee_id`
    FOREIGN KEY (`employee_id`)
    REFERENCES `Product`.`Sale` (`Sale_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Product`.`Payment` (
  `id` INT(11) NOT NULL,
  `payment_id` INT(11) NOT NULL,
  `invoice_id` INT(11) NOT NULL,
  `payment_date` DATE NOT NULL,
  `paymentAmount` DECIMAL NOT NULL,
  `paymentMethod` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`, `payment_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
