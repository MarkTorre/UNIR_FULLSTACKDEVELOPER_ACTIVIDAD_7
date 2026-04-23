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
CREATE SCHEMA IF NOT EXISTS `db_restaurantes` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE `db_restaurantes` ;

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
-- Table `db_restaurantes`.`restaurantes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurantes`.`restaurantes` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT 'nombre del restaurante',
  `direccion` VARCHAR(100) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT 'dirección del restaurante',
  `telefono` VARCHAR(20) NOT NULL COMMENT 'telefono del restaurante',
  `abierto` TINYINT UNSIGNED NOT NULL COMMENT 'restaurante abierto o cerrado',
  `responsable` VARCHAR(50) CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci' NOT NULL COMMENT 'nombre del responsable del restaurante',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `telefono_UNIQUE` (`telefono` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table `db_restaurantes`.`favoritos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_restaurantes`.`favoritos` (
  `id` INT(10) UNSIGNED ZEROFILL NOT NULL AUTO_INCREMENT,
  `fk_restaurantes` INT(10) UNSIGNED ZEROFILL NOT NULL,
  `fk_clientes` INT(10) UNSIGNED ZEROFILL NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_favoritos_restaurantes_idx` (`fk_restaurantes` ASC) VISIBLE,
  INDEX `fk_favoritos_clientes_idx` (`fk_clientes` ASC) VISIBLE,
  CONSTRAINT `fk_favoritos_clientes`
    FOREIGN KEY (`fk_clientes`)
    REFERENCES `db_restaurantes`.`clientes` (`id`),
  CONSTRAINT `fk_favoritos_restaurantes`
    FOREIGN KEY (`fk_restaurantes`)
    REFERENCES `db_restaurantes`.`restaurantes` (`id`))
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
  INDEX `fk_mesas_restaurantes_idx` (`fk_restaurantes` ASC) VISIBLE,
  CONSTRAINT `fk_mesas_restaurantes`
    FOREIGN KEY (`fk_restaurantes`)
    REFERENCES `db_restaurantes`.`restaurantes` (`id`))
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
  INDEX `fk_reservas_mesas_idx` (`fk_mesas` ASC) VISIBLE,
  INDEX `fk_reservas_clientes_idx` (`fk_clientes` ASC) VISIBLE,
  UNIQUE INDEX `uq_fecha_reserva_fk_mesas` (`fecha_reserva` ASC, `fk_mesas` ASC) COMMENT 'No pueden haber la misma reserva de la mesa en la misma hora.' INVISIBLE,
  CONSTRAINT `fk_reservas_clientes`
    FOREIGN KEY (`fk_clientes`)
    REFERENCES `db_restaurantes`.`clientes` (`id`),
  CONSTRAINT `fk_reservas_mesas`
    FOREIGN KEY (`fk_mesas`)
    REFERENCES `db_restaurantes`.`mesas` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

# 1. SENTENCIAS DE INSERCCIÓN
# 1.1 INSERCCIÓN DE 10 RESTAURANTES
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (1,"Masnou","Passeig Mas Masnou, s/n, 17811 Santa Pau, Girona", "(+34)972454185", 0, "Josep ");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (2,"Los Montes de Galicia","C. de Azcona, 46, Salamanca, 28028 Madrid", "(+34)972454175",  0, "Alberto");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (3,"Boroa Jatetxea", "San Pedro de Boroa, 11, Astepe, 48340 Boroa, Bizkaia", "(+34)972454775", 1, "Eloy");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (4,"Taberna Casa Manteca", "C. Corralón de los Carros, 66, 11002 Cádiz", "(+34)972464175", 1, "Mireia");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (5,"Casa Claudio","P.º Extremadura, 21, 10190 Casar de Cáceres, Cáceres", "(+34)972444175", 0, "Carla");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (6,"El Rincón del Sabor","Calle Mayor, 15, 28013 Madrid", "(+34)915123456", 1, "Luis");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (7,"La Taberna Verde","Av. Diagonal, 320, 08013 Barcelona", "(+34)932987654", 1, "Marta");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (8,"Sabores del Sur","Calle Feria, 45, 41003 Sevilla", "(+34)954112233", 0, "Antonio");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (9,"Mar y Tierra","Paseo Marítimo, 12, 29016 Málaga", "(+34)952334455", 1, "Lucía");
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (10,"El Fogón Gallego","Rúa Real, 78, 15003 A Coruña", "(+34)981556677", 0, "Pedro");

# 1.2 INSERCCIÓN 2 MESAS POR CADA RESTAURANTE (20 MESAS EN TOTAL).
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (1, 1, 1, 2);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (2, 1, 2, 4);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (3, 2, 1, 4);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (4, 2, 2, 4);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (5, 3, 1, 4);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (6, 3, 2, 4);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (7, 4, 1, 2);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (8, 4, 2, 4);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (9, 5, 1, 8);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (10, 5, 2, 4);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (11, 6, 1, 4);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (12, 6, 2, 8);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (13, 7, 1, 4);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (14, 7, 2, 2);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (15, 8, 1, 2);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (16, 8, 2, 2);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (17, 9, 1, 6);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (18, 9, 2, 4);

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (19, 10, 1, 5);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (20, 10, 2, 4);


# 2. SENTENCIAS DE ADQUISICIÓN
