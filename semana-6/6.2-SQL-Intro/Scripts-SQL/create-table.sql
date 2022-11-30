-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema coches
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema coches
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `coches` DEFAULT CHARACTER SET utf8 ;
USE `coches` ;

-- -----------------------------------------------------
-- Table `coches`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`clientes` (
  `idclientes` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `provincia` VARCHAR(45) NULL,
  `telefono` INT NOT NULL,
  PRIMARY KEY (`idclientes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coches`.`fecha-compra`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`fecha-compra` (
  `idfecha-compra` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfecha-compra`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coches`.`vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`vendedor` (
  `idvendedor` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `sucursal` VARCHAR(45) NOT NULL,
  `fecha_incorporacion` DATE NOT NULL,
  PRIMARY KEY (`idvendedor`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coches`.`facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`facturas` (
  `idfacturas` INT NOT NULL,
  `precio` FLOAT NOT NULL,
  `clientes_idclientes` INT NOT NULL,
  `fecha-compra_idfecha-compra` INT NOT NULL,
  `vendedor_idvendedor` INT NOT NULL,
  PRIMARY KEY (`idfacturas`, `clientes_idclientes`, `fecha-compra_idfecha-compra`),
  INDEX `fk_facturas_clientes_idx` (`clientes_idclientes` ASC) VISIBLE,
  INDEX `fk_facturas_fecha-compra1_idx` (`fecha-compra_idfecha-compra` ASC) VISIBLE,
  INDEX `fk_facturas_vendedor1_idx` (`vendedor_idvendedor` ASC) VISIBLE,
  CONSTRAINT `fk_facturas_clientes`
    FOREIGN KEY (`clientes_idclientes`)
    REFERENCES `coches`.`clientes` (`idclientes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_fecha-compra1`
    FOREIGN KEY (`fecha-compra_idfecha-compra`)
    REFERENCES `coches`.`fecha-compra` (`idfecha-compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_facturas_vendedor1`
    FOREIGN KEY (`vendedor_idvendedor`)
    REFERENCES `coches`.`vendedor` (`idvendedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `coches`.`producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `coches`.`producto` (
  `idproducto` INT NOT NULL,
  `precio` FLOAT NOT NULL,
  `tipo-coche` VARCHAR(45) NOT NULL,
  `facturas_idfacturas` INT NOT NULL,
  `facturas_clientes_idclientes` INT NOT NULL,
  `facturas_fecha-compra_idfecha-compra` INT NOT NULL,
  PRIMARY KEY (`idproducto`),
  INDEX `fk_producto_facturas1_idx` (`facturas_idfacturas` ASC, `facturas_clientes_idclientes` ASC, `facturas_fecha-compra_idfecha-compra` ASC) VISIBLE,
  CONSTRAINT `fk_producto_facturas1`
    FOREIGN KEY (`facturas_idfacturas` , `facturas_clientes_idclientes` , `facturas_fecha-compra_idfecha-compra`)
    REFERENCES `coches`.`facturas` (`idfacturas` , `clientes_idclientes` , `fecha-compra_idfecha-compra`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
