-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Hospital
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Hospital
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Hospital` ;
USE `Hospital` ;

-- -----------------------------------------------------
-- Table `Hospital`.`Medica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Medica` (
  `overtime_rate` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`overtime_rate`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`specialist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`specialist` (
  `field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`field_area`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`doctor` (
  `name` VARCHAR(45) NOT NULL,
  `Date_of_birth` DATE NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `phone_number` VARCHAR(45) NOT NULL,
  `salary` DECIMAL(10,2) NOT NULL,
  `Medica_overtime_rate` DECIMAL(10,2) NOT NULL,
  `specialist_field_area` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`name`, `Date_of_birth`),
  INDEX `fk_doctor_Medica_idx` (`Medica_overtime_rate` ASC) VISIBLE,
  INDEX `fk_doctor_specialist1_idx` (`specialist_field_area` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_Medica`
    FOREIGN KEY (`Medica_overtime_rate`)
    REFERENCES `Hospital`.`Medica` (`overtime_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_doctor_specialist1`
    FOREIGN KEY (`specialist_field_area`)
    REFERENCES `Hospital`.`specialist` (`field_area`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`table3`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`table3` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`patient` (
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `phone_number` VARCHAR(45) NULL,
  `Date_of_birth` DATE NOT NULL,
  PRIMARY KEY (`name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`Bill`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`Bill` (
  `total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`total`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`payment` (
  `details` VARCHAR(45) NOT NULL,
  `method` ENUM('cash', 'card') NULL,
  `Bill_total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`details`),
  INDEX `fk_payment_Bill1_idx` (`Bill_total` ASC) VISIBLE,
  CONSTRAINT `fk_payment_Bill1`
    FOREIGN KEY (`Bill_total`)
    REFERENCES `Hospital`.`Bill` (`total`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Hospital`.`appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Hospital`.`appointment` (
  `date` DATE NOT NULL,
  `time` TIME NOT NULL,
  `patient_name` VARCHAR(45) NOT NULL,
  `doctor_name` VARCHAR(45) NOT NULL,
  `doctor_Date_of_birth` DATE NOT NULL,
  `payment_details` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`date`),
  INDEX `fk_appointment_patient1_idx` (`patient_name` ASC) VISIBLE,
  INDEX `fk_appointment_doctor1_idx` (`doctor_name` ASC, `doctor_Date_of_birth` ASC) VISIBLE,
  INDEX `fk_appointment_payment1_idx` (`payment_details` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_patient1`
    FOREIGN KEY (`patient_name`)
    REFERENCES `Hospital`.`patient` (`name`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_doctor1`
    FOREIGN KEY (`doctor_name` , `doctor_Date_of_birth`)
    REFERENCES `Hospital`.`doctor` (`name` , `Date_of_birth`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_appointment_payment1`
    FOREIGN KEY (`payment_details`)
    REFERENCES `Hospital`.`payment` (`details`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
