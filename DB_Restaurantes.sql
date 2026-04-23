-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_restaurantes
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_restaurantes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_restaurantes` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `db_restaurantes` ;

-- -----------------------------------------------------
-- Table `db_restaurantes`.`restaurantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurantes`.`restaurantes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT 'nombre del restaurante',
  `direccion` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT 'dirección del restaurante',
  `telefono` VARCHAR(20) NOT NULL COMMENT 'telefono del restaurante',
  `abierto` TINYINT UNSIGNED NOT NULL COMMENT 'restaurante abierto o cerrado',
  `responsable` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT 'nombre del responsable del restaurante',
  PRIMARY KEY (`id`, `abierto`),
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `db_restaurantes`.`mesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurantes`.`mesas` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_restaurantes` INT UNSIGNED NOT NULL,
  `numero` SMALLINT UNSIGNED NOT NULL COMMENT 'número de la mesa',
  `comensales` TINYINT UNSIGNED NOT NULL COMMENT 'número máximo de comensales',
  PRIMARY KEY (`id`),
  INDEX `fk_mesas_restaurantes1_idx` (`fk_restaurantes` ASC) VISIBLE,
  CONSTRAINT `fk_mesas_restaurantes1`
    FOREIGN KEY (`fk_restaurantes`)
    REFERENCES `db_restaurantes`.`restaurantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `db_restaurantes`.`clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurantes`.`clientes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT 'correo electrónico del cliente',
  `nombre` VARCHAR(50) NOT NULL COMMENT 'nombre del cliente',
  `telefono` VARCHAR(20) NOT NULL COMMENT 'teléfono del cliente',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `db_restaurantes`.`reservas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurantes`.`reservas` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_clientes` INT UNSIGNED NOT NULL,
  `fk_mesas` INT UNSIGNED NOT NULL,
  `fecha_reserva` DATETIME NOT NULL COMMENT 'feha de la reserva del cliente',
  PRIMARY KEY (`id`),
  INDEX `fk_clientes_has_mesas_mesas1_idx` (`fk_mesas` ASC) VISIBLE,
  INDEX `fk_clientes_has_mesas_clientes_idx` (`fk_clientes` ASC) VISIBLE,
  UNIQUE INDEX `fecha_reserva_UNIQUE` (`fecha_reserva` ASC) VISIBLE,
  CONSTRAINT `fk_clientes_has_mesas_clientes`
    FOREIGN KEY (`fk_clientes`)
    REFERENCES `db_restaurantes`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_mesas_mesas1`
    FOREIGN KEY (`fk_mesas`)
    REFERENCES `db_restaurantes`.`mesas` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `db_restaurantes`.`favoritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurantes`.`favoritos` (
  `id` INT ZEROFILL NOT NULL AUTO_INCREMENT,
  `fk_restaurantes` INT ZEROFILL NOT NULL,
  `fk_clientes` INT ZEROFILL NOT NULL,
  INDEX `fk_clientes_has_restaurantes_restaurantes1_idx` (`fk_restaurantes` ASC) VISIBLE,
  INDEX `fk_clientes_has_restaurantes_clientes1_idx` (`fk_clientes` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_clientes_has_restaurantes_clientes1`
    FOREIGN KEY (`fk_clientes`)
    REFERENCES `db_restaurantes`.`clientes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_clientes_has_restaurantes_restaurantes1`
    FOREIGN KEY (`fk_restaurantes`)
    REFERENCES `db_restaurantes`.`restaurantes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
