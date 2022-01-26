-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema optica
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `optica` DEFAULT CHARACTER SET utf8mb4 ;
USE `optica` ;

-- -----------------------------------------------------
-- Table `optica`.`proveedores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`proveedores` (
  `id_proveedores` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `calle` VARCHAR(45) NULL,
  `numero` VARCHAR(15) NULL,
  `piso` VARCHAR(15) NULL,
  `puerta` VARCHAR(15) NULL,
  `ciudad` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(15) NULL,
  `pais` VARCHAR(45) NULL,
  `telefono` VARCHAR(10) NULL,
  `fax` VARCHAR(10) NULL,
  `nif` VARCHAR(45) NULL,
  PRIMARY KEY (`id_proveedores`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`gafas` (
  `id_gafas` INT(11) NOT NULL AUTO_INCREMENT,
  `marca` VARCHAR(45) NULL,
  `graduacion` VARCHAR(5) NULL,
  `tipo_de_montura` ENUM('flotante', 'pasta', 'metalica') NULL,
  `color_de_montura` VARCHAR(15) NULL,
  `color_cristales` VARCHAR(15) NULL,
  `precio` DECIMAL(4,2) NULL,
  `proveedores_id` INT(11) NOT NULL,
  PRIMARY KEY (`id_gafas`),
  INDEX `fk_gafas_proveedores_idx` (`proveedores_id` ASC),
  CONSTRAINT `proveedores_id`
    FOREIGN KEY (`proveedores_id`)
    REFERENCES `optica`.`proveedores` (`id_proveedores`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`clientes` (
  `id_clientes` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido1` VARCHAR(45) NULL,
  `apellido2` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `ciudad` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(45) NULL,
  `correo_electronico` VARCHAR(45) NULL,
  `data_registro` DATE NULL,
  `clientes_id_clientes` INT(11) NULL,
  PRIMARY KEY (`id_clientes`),
  INDEX `fk_clientes_clientes1_idx` (`clientes_id_clientes` ASC),
  CONSTRAINT `fk_clientes_clientes1`
    FOREIGN KEY (`clientes_id_clientes`)
    REFERENCES `optica`.`clientes` (`id_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`empleados` (
  `id_empleados` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido1` VARCHAR(45) NULL,
  `apellido2` VARCHAR(45) NULL,
  PRIMARY KEY (`id_empleados`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`ventas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`ventas` (
  `id_ventas` INT(11) NOT NULL AUTO_INCREMENT,
  `empleados_id` INT(11) NOT NULL,
  `id_gafas` INT(11) NOT NULL,
  `data_de_venta` DATETIME NOT NULL,
  `clientes_id_clientes` INT(11) NOT NULL,
  INDEX `fk_ventas_empleados1_idx` (`empleados_id` ASC),
  INDEX `fk_ventas_gafas1_idx` (`id_gafas` ASC),
  PRIMARY KEY (`id_ventas`),
  INDEX `fk_ventas_clientes1_idx` (`clientes_id_clientes` ASC),
  CONSTRAINT `idempleados`
    FOREIGN KEY (`empleados_id`)
    REFERENCES `optica`.`empleados` (`id_empleados`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `idgafas`
    FOREIGN KEY (`id_gafas`)
    REFERENCES `optica`.`gafas` (`id_gafas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ventas_clientes1`
    FOREIGN KEY (`clientes_id_clientes`)
    REFERENCES `optica`.`clientes` (`id_clientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `optica`.`marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `optica`.`marcas` (
  `id_marca` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `proveedores_id_proveedores` INT(11) NOT NULL,
  INDEX `fk_table1_proveedores1_idx` (`proveedores_id_proveedores` ASC),
  PRIMARY KEY (`id_marca`),
  CONSTRAINT `fk_table1_proveedores1`
    FOREIGN KEY (`proveedores_id_proveedores`)
    REFERENCES `optica`.`proveedores` (`id_proveedores`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
