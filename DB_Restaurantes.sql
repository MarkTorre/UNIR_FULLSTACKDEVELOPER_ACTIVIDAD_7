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
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `fk_restaurantes` INT UNSIGNED NOT NULL,
  `fk_clientes` INT UNSIGNED NOT NULL,
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
INSERT IGNORE INTO restaurantes(id, nombre, direccion, telefono, abierto, responsable) VALUES (1,"Masnou","Passeig Mas Masnou, s/n, 17811 Santa Pau, Girona", "(+34)972454185", 1, "Josep ");
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

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (9, 4, 3, 8);
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

INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (21, 10, 3, 2);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (22, 10, 4, 4);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (23, 10, 5, 6);
INSERT IGNORE mesas(id, fk_restaurantes, numero, comensales) VALUES (24, 10, 6, 4);

# 1.3 INSERCCIÓN 10 CLIENTES.
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (1, "juan.perez@gmail.com", "Juan Pérez", "600111222");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (2, "maria.lopez@gmail.com", "María López", "600111223");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (3, "carlos.sanchez@gmail.com", "Carlos Sánchez", "600111224");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (4, "laura.garcia@gmail.com", "Laura García", "600111225");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (5, "pedro.martin@gmail.com", "Pedro Martín", "600111226");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (6, "ana.ruiz@gmail.com", "Ana Ruiz", "600111227");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (7, "david.fernandez@gmail.com", "David Fernández", "600111228");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (8, "lucia.gomez@gmail.com", "Lucía Gómez", "600111229");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (9, "jorge.diaz@gmail.com", "Jorge Díaz", "600111230");
INSERT IGNORE INTO clientes(id, email, nombre, telefono) VALUES (10, "sofia.alonso@gmail.com", "Sofía Alonso", "600111231");

# 1.4 INSERCCIÓN 20 RESTAURANTES FAVORITOS REPARTIDOS ENTRE TODOS LOS RESTAURANTES Y CLIENTES
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (1, 1, 1);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (2, 1, 2);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (3, 2, 2);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (4, 2, 3);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (5, 3, 3);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (6, 3, 4);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (7, 4, 4);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (8, 4, 5);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (9, 5, 5);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (10, 5, 6);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (11, 6, 6);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (12, 6, 7);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (13, 7, 7);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (14, 7, 8);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (15, 8, 8);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (16, 8, 9);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (17, 9, 9);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (18, 9, 10);

INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (19, 10, 10);
INSERT IGNORE INTO favoritos(id, fk_restaurantes, fk_clientes) VALUES (20, 10, 1);

# 1.5 INSERCCIÓN 20 RESERVAS REPARTIDAS ENTRE TODOS LOS RESTAURANTES Y CLIENTES
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (1, 1, 1, "2026-06-01 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (2, 1, 2, "2026-06-01 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (3, 2, 2, "2026-06-02 11:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (4, 2, 4, "2026-06-02 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (5, 3, 5, "2026-06-03 11:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (6, 3, 6, "2026-06-03 11:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (7, 4, 7, "2026-06-01 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (8, 4, 8, "2026-06-01 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (9, 5, 9, "2026-06-01 12:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (10, 5, 10, "2026-06-01 12:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (11, 6, 11, "2026-06-01 13:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (12, 6, 12, "2026-06-01 13:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (13, 7, 13, "2026-06-01 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (14, 7, 14, "2026-06-01 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (15, 8, 15, "2026-06-01 14:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (16, 8, 16, "2026-06-01 14:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (17, 9, 17, "2026-06-01 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (18, 9, 18, "2026-06-01 10:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (19, 10, 19, "2026-06-01 21:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (20, 10, 20, "2026-06-01 21:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (21, 2, 9, "2026-06-01 13:00:00");
INSERT IGNORE INTO reservas(id, fk_clientes, fk_mesas, fecha_reserva) VALUES (22, 4, 9, "2026-06-01 17:00:00");

# 2. SENTENCIAS DE ADQUISICIÓN CLIENTES
#2.1 OBTENCIÓN TODAS LAS RESERVAS QUE TIENEN UN RESTAURANTE PARA UN DÍA CONCRETO (DATOS CLIENTE Y MESA RESERVADA).
SET @RESTAURANTE_1 = 1;
SET @FECHA_RESERVA_1 = "2026-06-01 10:00:00";

SELECT c.nombre, c.email, c.telefono, m.numero, m.comensales FROM clientes as c
INNER JOIN reservas as r
	ON c.id = r.fk_clientes
INNER JOIN mesas as m
	ON m.id = r.fk_clientes
WHERE m.fk_restaurantes = @RESTAURANTE_1
	AND r.fecha_reserva = @FECHA_RESERVA_1;
    
#2.2 OBTENCIÓN TODAS LOS NOMBRES DE LOS RESTAURANTES FAVORITOS Y QUE ESTÉN ABIERTOS, PARA UN CLIENTE CONCRETO.
SET @RESTAURANTE_ABIERTO = 1;
SET @CLIENTE_ID = 1;

SELECT r.nombre as 'restaurantes_abiertos_favoritos', c.nombre as 'nombre_cliente'  FROM  restaurantes as r
INNER JOIN favoritos as f
	ON r.id = f.fk_restaurantes
INNER JOIN clientes as c
	ON c.id = f.fk_clientes
WHERE r.abierto = @RESTAURANTE_ABIERTO 
	AND c.id = @CLIENTE_ID;
    
#2.3 ACTUALIZACIÓN FECHA Y HORA DE UNA RESERVA
SET @FECHA_ACTUALIZADA = "2026-06-02 12:00:00";
SET @CLIENTE_ID_2 = 2;
SET @MESA_ID_3 = 3;

UPDATE reservas as r
SET fecha_reserva = @FECHA_ACTUALIZADA 
WHERE r.fk_clientes = @CLIENTE_ID_2
	AND r.fk_mesas = @MESA_ID_3;

#2.4 ELIMINAR TODOS LOS RESTAURANTES FAVORITOS QUE NO SE ENCUENTRAN ABIERTOS PARA UN CLIENTE CONCRETO
SET @RESTAURANTE_CERRADO = 0;
SET @CLIENTE_ID_3 = 3;

DELETE f FROM favoritos as f
INNER JOIN restaurantes as r
	ON r.id = f.fk_restaurantes
WHERE r.abierto = @RESTAURANTE_CERRADO 
	AND f.fk_clientes = @CLIENTE_ID_3;

#2.5 SELECCIÓN NOMBRE RESTAURANTES CON MÁS DE TRES RESERVAS DE CUATRO O MÁS COMENSALES PARA UN DÍA ESPECÍFICO
SET @DIA_RESERVA = "2026-06-01";
SET @MIN_COMENSALES = 4;
SET @NUMERO_RESERVAS = 3;

SELECT r.nombre, COUNT(re.id) AS 'numero_reservas' FROM restaurantes AS r
INNER JOIN mesas as m
	ON m.fk_restaurantes = r.id
INNER JOIN reservas as re
	ON re.fk_mesas = m.id
WHERE m.comensales >= @MIN_COMENSALES 
	AND DATE(re.fecha_reserva) = @DIA_RESERVA
GROUP BY r.id
HAVING numero_reservas > @NUMERO_RESERVAS;

#2.6 SELECCIÓN AFORO MÁXIMO PARA UN RESTAURANTE CONCRETO.
SET @RESTAURANTE_ID_4 = 4;

SELECT r.nombre, SUM(m.comensales) as 'aforo' FROM mesas as m
INNER JOIN restaurantes as r
	ON r.id = m.fk_restaurantes
WHERE m.fk_restaurantes = @RESTAURANTE_ID_4
GROUP BY r.id;

#2.7 SELECCIÓN MESAS QUE DISPONGAN DE ESPACIO PARA DOS COMENSALES Y QUE SE ENCUENTREN DISPONIBLES EN UN RESTAURANTE ESPECÍFICO PARA UNA FECHA Y HORA CONCRETOS
SET @FECHA_RESERVA = "2026-06-01 10:00:00";
SET @MAX_COMENSALES = 2;
SET @RESTAURANTE_ID = 2;

SELECT m.* FROM mesas as m
LEFT JOIN reservas as r
	ON m.id = r.fk_mesas
WHERE m.comensales >= @MAX_COMENSALES
	AND m.fk_restaurantes = @RESTAURANTE_ID
	AND (r.fecha_reserva IS NULL OR r.fecha_reserva != @FECHA_RESERVA);

#2.8 SELECCIÓN NOMBRE DEL CLIENTE QUE HA REALIZADO MÁS RESERVAS EN UN RESTAURANTE ESPECÍFICO DENTRO DE UN RANGO DE FECHAS DADO.
#SELECT c.nombre FROM clientes AS c
SET @RESTAURANTE_ID = 1;

SELECT c.nombre FROM restaurantes AS r
INNER JOIN mesas AS m
	ON m.fk_restaurantes = r.id
INNER JOIN reservas AS re
	ON re.fk_mesas = m.id
INNER JOIN clientes AS c
	ON c.id = re.fk_clientes
WHERE r.id = @RESTAURANTE_ID
GROUP BY c.id
ORDER BY COUNT(c.id) DESC
LIMIT 1;


    




