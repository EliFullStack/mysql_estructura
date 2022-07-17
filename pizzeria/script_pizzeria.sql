-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema modelo_pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema modelo_pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `modelo_pizzeria` DEFAULT CHARACTER SET utf8mb4 ;
USE `modelo_pizzeria` ;

-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`provincias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`provincias` (
  `id_provincia` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_provincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`localidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`localidades` (
  `id_localidad` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_provincia` INT(11) NOT NULL,
  PRIMARY KEY (`id_localidad`),
  INDEX `fk_localidades_provincias_idx` (`id_provincia` ASC),
  CONSTRAINT `fk_localidades_provincias`
    FOREIGN KEY (`id_provincia`)
    REFERENCES `modelo_pizzeria`.`provincias` (`id_provincia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`clientes` (
  `id_clientes` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido1` VARCHAR(45) NULL,
  `apellido2` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `codigo_postal` VARCHAR(5) NULL,
  `telefono` VARCHAR(45) NULL,
  `id_localidad` INT(11) NOT NULL,
  PRIMARY KEY (`id_clientes`),
  INDEX `fk_clientes_localidades1_idx` (`id_localidad` ASC),
  CONSTRAINT `fk_clientes_localidades1`
    FOREIGN KEY (`id_localidad`)
    REFERENCES `modelo_pizzeria`.`localidades` (`id_localidad`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`locales`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`locales` (
  `id_locales` INT(11) NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(45) NOT NULL,
  `codigo_postal` VARCHAR(45) NOT NULL,
  `id_localidad` INT(11) NOT NULL,
  PRIMARY KEY (`id_locales`),
  INDEX `fk_locales_localidades1_idx` (`id_localidad` ASC),
  CONSTRAINT `fk_locales_localidades1`
    FOREIGN KEY (`id_localidad`)
    REFERENCES `modelo_pizzeria`.`localidades` (`id_localidad`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`comandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`comandas` (
  `id_comanda` INT(11) NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NOT NULL,
  `a_domicilio` BIT(1) NOT NULL,
  `nro_pedido_bebidas` INT NULL,
  `nro_pedido_hamburguesas` INT NULL,
  `nro_pedido_pizzas` INT NULL,
  `precio_total_comanda` FLOAT NULL,
  `id_locales` INT(11) NOT NULL,
  `id_clientes` INT(11) NOT NULL,
  PRIMARY KEY (`id_comanda`),
  INDEX `fk_comandas_locales1_idx` (`id_locales` ASC),
  INDEX `fk_comandas_clientes1_idx` (`id_clientes` ASC),
  CONSTRAINT `fk_comandas_locales1`
    FOREIGN KEY (`id_locales`)
    REFERENCES `modelo_pizzeria`.`locales` (`id_locales`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_clientes1`
    FOREIGN KEY (`id_clientes`)
    REFERENCES `modelo_pizzeria`.`clientes` (`id_clientes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`categoria_pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`categoria_pizzas` (
  `id_categoria_pizzas` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_categoria_pizzas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`pizzas` (
  `id_pizzas` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(256) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio_unitario` FLOAT NOT NULL,
  `id_categoria_pizzas` INT(11) NOT NULL,
  PRIMARY KEY (`id_pizzas`),
  INDEX `fk_pizzas_categoria_pizzas1_idx` (`id_categoria_pizzas` ASC),
  CONSTRAINT `fk_pizzas_categoria_pizzas1`
    FOREIGN KEY (`id_categoria_pizzas`)
    REFERENCES `modelo_pizzeria`.`categoria_pizzas` (`id_categoria_pizzas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`comandas_has_productos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`comandas_has_productos` (
  `comandas_id_comanda` INT NOT NULL,
  `productos_id_productos` INT NOT NULL,
  PRIMARY KEY (`comandas_id_comanda`, `productos_id_productos`),
  INDEX `fk_comandas_has_productos_productos1_idx` (`productos_id_productos` ASC),
  INDEX `fk_comandas_has_productos_comandas1_idx` (`comandas_id_comanda` ASC),
  CONSTRAINT `fk_comandas_has_productos_comandas1`
    FOREIGN KEY (`comandas_id_comanda`)
    REFERENCES `modelo_pizzeria`.`comandas` (`id_comanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_has_productos_productos1`
    FOREIGN KEY (`productos_id_productos`)
    REFERENCES `modelo_pizzeria`.`pizzas` (`id_pizzas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`productos_has_comandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`productos_has_comandas` (
  `productos_id_productos` INT NOT NULL,
  `comandas_id_comanda` INT NOT NULL,
  PRIMARY KEY (`productos_id_productos`, `comandas_id_comanda`),
  INDEX `fk_productos_has_comandas_comandas1_idx` (`comandas_id_comanda` ASC),
  INDEX `fk_productos_has_comandas_productos1_idx` (`productos_id_productos` ASC),
  CONSTRAINT `fk_productos_has_comandas_productos1`
    FOREIGN KEY (`productos_id_productos`)
    REFERENCES `modelo_pizzeria`.`pizzas` (`id_pizzas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productos_has_comandas_comandas1`
    FOREIGN KEY (`comandas_id_comanda`)
    REFERENCES `modelo_pizzeria`.`comandas` (`id_comanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`empleados` (
  `id_empleados` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `apellido1` VARCHAR(45) NULL,
  `apellido2` VARCHAR(45) NULL,
  `nif` VARCHAR(10) NOT NULL,
  `telefono` VARCHAR(45) NULL,
  `puesto` ENUM('cocinero', 'repartidor') NOT NULL,
  `id_locales` INT(11) NOT NULL,
  PRIMARY KEY (`id_empleados`),
  INDEX `fk_empleados_locales1_idx` (`id_locales` ASC),
  CONSTRAINT `fk_empleados_locales1`
    FOREIGN KEY (`id_locales`)
    REFERENCES `modelo_pizzeria`.`locales` (`id_locales`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`comandas_a_domicilio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`comandas_a_domicilio` (
  `id_comandas_a_domicilio` INT(11) NOT NULL AUTO_INCREMENT,
  `data_hora` DATETIME NOT NULL,
  `id_comanda` INT(11) NOT NULL,
  `id_empleados` INT(11) NOT NULL,
  INDEX `fk_comandas_a_domicilio_comandas1_idx` (`id_comanda` ASC),
  INDEX `fk_comandas_a_domicilio_empleados1_idx` (`id_empleados` ASC),
  PRIMARY KEY (`id_comandas_a_domicilio`),
  CONSTRAINT `fk_comandas_a_domicilio_comandas1`
    FOREIGN KEY (`id_comanda`)
    REFERENCES `modelo_pizzeria`.`comandas` (`id_comanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_a_domicilio_empleados1`
    FOREIGN KEY (`id_empleados`)
    REFERENCES `modelo_pizzeria`.`empleados` (`id_empleados`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`hamburguesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`hamburguesas` (
  `id_hamburguesas` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(256) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio_unitario` FLOAT NULL,
  PRIMARY KEY (`id_hamburguesas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`bebidas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`bebidas` (
  `id_bebidas` INT(11) NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  `descripcion` VARCHAR(256) NULL,
  `imagen` VARCHAR(45) NULL,
  `precio_unitario` FLOAT NULL,
  PRIMARY KEY (`id_bebidas`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`comandas_pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`comandas_pizzas` (
  `id_comanda` INT(11) NOT NULL,
  `id_pizzas` INT(11) NOT NULL,
  `cant_pizzas` INT NULL,
  `precio_total` FLOAT NULL,
  PRIMARY KEY (`id_comanda`, `id_pizzas`),
  INDEX `fk_pizzas_has_comandas_comandas1_idx` (`id_comanda` ASC),
  INDEX `fk_pizzas_has_comandas_pizzas1_idx` (`id_pizzas` ASC),
  CONSTRAINT `fk_pizzas_has_comandas_pizzas1`
    FOREIGN KEY (`id_pizzas`)
    REFERENCES `modelo_pizzeria`.`pizzas` (`id_pizzas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pizzas_has_comandas_comandas1`
    FOREIGN KEY (`id_comanda`)
    REFERENCES `modelo_pizzeria`.`comandas` (`id_comanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`comandas_hamburguesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`comandas_hamburguesas` (
  `id_comanda` INT(11) NOT NULL,
  `id_hamburguesas` INT(11) NOT NULL,
  `cant_hamburguesas` INT NULL,
  `precio_total` FLOAT NULL,
  PRIMARY KEY (`id_comanda`, `id_hamburguesas`),
  INDEX `fk_comandas_has_hamburguesas_hamburguesas1_idx` (`id_hamburguesas` ASC),
  INDEX `fk_comandas_has_hamburguesas_comandas1_idx` (`id_comanda` ASC),
  CONSTRAINT `fk_comandas_has_hamburguesas_comandas1`
    FOREIGN KEY (`id_comanda`)
    REFERENCES `modelo_pizzeria`.`comandas` (`id_comanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_has_hamburguesas_hamburguesas1`
    FOREIGN KEY (`id_hamburguesas`)
    REFERENCES `modelo_pizzeria`.`hamburguesas` (`id_hamburguesas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `modelo_pizzeria`.`bebidas_comandas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `modelo_pizzeria`.`bebidas_comandas` (
  `id_comanda` INT(11) NOT NULL,
  `id_bebidas` INT(11) NOT NULL,
  `cant_bebidas` INT NULL,
  `precio_total` FLOAT NULL,
  PRIMARY KEY (`id_comanda`, `id_bebidas`),
  INDEX `fk_comandas_has_bebidas_bebidas1_idx` (`id_bebidas` ASC),
  INDEX `fk_comandas_has_bebidas_comandas1_idx` (`id_comanda` ASC),
  CONSTRAINT `fk_comandas_has_bebidas_comandas1`
    FOREIGN KEY (`id_comanda`)
    REFERENCES `modelo_pizzeria`.`comandas` (`id_comanda`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comandas_has_bebidas_bebidas1`
    FOREIGN KEY (`id_bebidas`)
    REFERENCES `modelo_pizzeria`.`bebidas` (`id_bebidas`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
