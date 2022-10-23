-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema libman
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema libman
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `libman` DEFAULT CHARACTER SET utf8 ;
USE `libman` ;

-- -----------------------------------------------------
-- Table `libman`.`isbn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`isbn` (
  `isbn_id` INT NOT NULL AUTO_INCREMENT,
  `author` VARCHAR(45) NULL DEFAULT NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`isbn_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`book`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`book` (
  `idbook` INT NOT NULL AUTO_INCREMENT,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `title` VARCHAR(25) NULL DEFAULT NULL,
  `ISBN_isbn_id` INT NOT NULL,
  PRIMARY KEY (`idbook`),
  INDEX `fk_book_ISBN1_idx` (`ISBN_isbn_id` ASC) VISIBLE,
  CONSTRAINT `fk_book_ISBN1`
    FOREIGN KEY (`ISBN_isbn_id`)
    REFERENCES `libman`.`isbn` (`isbn_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`borrower`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`borrower` (
  `idborrower` INT NOT NULL,
  `DOR` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  PRIMARY KEY (`idborrower`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`city` (
  `city_id` INT NOT NULL AUTO_INCREMENT,
  `city_name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`city_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`main`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`main` (
  `idmain` INT NOT NULL AUTO_INCREMENT,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `city_city_id` INT NOT NULL,
  PRIMARY KEY (`idmain`),
  INDEX `fk_main_city1_idx` (`city_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_main_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `libman`.`city` (`city_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`branch` (
  `idbranch` INT NOT NULL AUTO_INCREMENT,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `city_city_id` INT NOT NULL,
  `main_idmain` INT NOT NULL,
  PRIMARY KEY (`idbranch`),
  INDEX `fk_branch_city_idx` (`city_city_id` ASC) VISIBLE,
  INDEX `fk_branch_main1_idx` (`main_idmain` ASC) VISIBLE,
  CONSTRAINT `fk_branch_city`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `libman`.`city` (`city_id`),
  CONSTRAINT `fk_branch_main1`
    FOREIGN KEY (`main_idmain`)
    REFERENCES `libman`.`main` (`idmain`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`copy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`copy` (
  `idcopy` INT NOT NULL AUTO_INCREMENT,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `price` VARCHAR(25) NULL DEFAULT NULL,
  `book_idbook` INT NOT NULL,
  PRIMARY KEY (`idcopy`),
  INDEX `fk_copy_book1_idx` (`book_idbook` ASC) VISIBLE,
  CONSTRAINT `fk_copy_book1`
    FOREIGN KEY (`book_idbook`)
    REFERENCES `libman`.`book` (`idbook`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`loan` (
  `idloan` INT NOT NULL AUTO_INCREMENT,
  `issue_date` VARCHAR(45) NULL DEFAULT NULL,
  `borrower_idborrower` INT NOT NULL,
  PRIMARY KEY (`idloan`),
  INDEX `fk_loan_borrower1_idx` (`borrower_idborrower` ASC) VISIBLE,
  CONSTRAINT `fk_loan_borrower1`
    FOREIGN KEY (`borrower_idborrower`)
    REFERENCES `libman`.`borrower` (`idborrower`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`copy_has_loan`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`copy_has_loan` (
  `copy_idcopy` INT NOT NULL,
  `loan_idloan` INT NOT NULL,
  PRIMARY KEY (`copy_idcopy`, `loan_idloan`),
  INDEX `fk_copy_has_loan_loan1_idx` (`loan_idloan` ASC) VISIBLE,
  INDEX `fk_copy_has_loan_copy1_idx` (`copy_idcopy` ASC) VISIBLE,
  CONSTRAINT `fk_copy_has_loan_copy1`
    FOREIGN KEY (`copy_idcopy`)
    REFERENCES `libman`.`copy` (`idcopy`),
  CONSTRAINT `fk_copy_has_loan_loan1`
    FOREIGN KEY (`loan_idloan`)
    REFERENCES `libman`.`loan` (`idloan`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`library` (
  `idlibrary` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `copy_idcopy` INT NOT NULL,
  PRIMARY KEY (`idlibrary`),
  INDEX `fk_library_copy1_idx` (`copy_idcopy` ASC) VISIBLE,
  CONSTRAINT `fk_library_copy1`
    FOREIGN KEY (`copy_idcopy`)
    REFERENCES `libman`.`copy` (`idcopy`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`library_has_branch`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`library_has_branch` (
  `library_idlibrary` INT NOT NULL,
  `branch_idbranch` INT NOT NULL,
  PRIMARY KEY (`library_idlibrary`, `branch_idbranch`),
  INDEX `fk_library_has_branch_branch1_idx` (`branch_idbranch` ASC) VISIBLE,
  INDEX `fk_library_has_branch_library1_idx` (`library_idlibrary` ASC) VISIBLE,
  CONSTRAINT `fk_library_has_branch_branch1`
    FOREIGN KEY (`branch_idbranch`)
    REFERENCES `libman`.`branch` (`idbranch`),
  CONSTRAINT `fk_library_has_branch_library1`
    FOREIGN KEY (`library_idlibrary`)
    REFERENCES `libman`.`library` (`idlibrary`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`main_has_library`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`main_has_library` (
  `main_idmain` INT NOT NULL,
  `library_idlibrary` INT NOT NULL,
  PRIMARY KEY (`main_idmain`, `library_idlibrary`),
  INDEX `fk_main_has_library_library1_idx` (`library_idlibrary` ASC) VISIBLE,
  INDEX `fk_main_has_library_main1_idx` (`main_idmain` ASC) VISIBLE,
  CONSTRAINT `fk_main_has_library_library1`
    FOREIGN KEY (`library_idlibrary`)
    REFERENCES `libman`.`library` (`idlibrary`),
  CONSTRAINT `fk_main_has_library_main1`
    FOREIGN KEY (`main_idmain`)
    REFERENCES `libman`.`main` (`idmain`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `libman`.`Barrower_contact`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`Barrower_contact` (
  `contact_id` INT NOT NULL AUTO_INCREMENT,
  `lan_no` VARCHAR(25) NULL,
  `mobi_no` VARCHAR(25) NULL,
  `last_update` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP(),
  `borrower_idborrower` INT NOT NULL,
  PRIMARY KEY (`contact_id`),
  INDEX `fk_Barrower_contact_borrower1_idx` (`borrower_idborrower` ASC) VISIBLE,
  CONSTRAINT `fk_Barrower_contact_borrower1`
    FOREIGN KEY (`borrower_idborrower`)
    REFERENCES `libman`.`borrower` (`idborrower`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libman`.`barrower_address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`barrower_address` (
  `address_id` INT NOT NULL AUTO_INCREMENT,
  `postal_code` VARCHAR(15) NULL,
  `street_name` VARCHAR(25) NULL,
  `zipcode` VARCHAR(25) NULL,
  `borrower_idborrower` INT NOT NULL,
  `city_city_id` INT NOT NULL,
  PRIMARY KEY (`address_id`),
  INDEX `fk_barrower_address_borrower1_idx` (`borrower_idborrower` ASC) VISIBLE,
  INDEX `fk_barrower_address_city1_idx` (`city_city_id` ASC) VISIBLE,
  CONSTRAINT `fk_barrower_address_borrower1`
    FOREIGN KEY (`borrower_idborrower`)
    REFERENCES `libman`.`borrower` (`idborrower`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_barrower_address_city1`
    FOREIGN KEY (`city_city_id`)
    REFERENCES `libman`.`city` (`city_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `libman`.`barrower_name`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `libman`.`barrower_name` (
  `name_id` INT NOT NULL AUTO_INCREMENT,
  `f_name` VARCHAR(45) NULL,
  `l_name` VARCHAR(45) NULL,
  `borrower_idborrower` INT NOT NULL,
  PRIMARY KEY (`name_id`),
  INDEX `fk_barrower_name_borrower1_idx` (`borrower_idborrower` ASC) VISIBLE,
  CONSTRAINT `fk_barrower_name_borrower1`
    FOREIGN KEY (`borrower_idborrower`)
    REFERENCES `libman`.`borrower` (`idborrower`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
