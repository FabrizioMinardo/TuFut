DROP DATABASE IF EXISTS TUFUT;

CREATE DATABASE TUFUT; 

USE TUFUT;

-- Tabla de horarios
DROP TABLE IF EXISTS `HORARIOS`;
CREATE TABLE `HORARIOS` (
  `IdHorario` int NOT NULL AUTO_INCREMENT,
  `HoraInicio` time NOT NULL,
  `HoraFin` time NOT NULL,
  PRIMARY KEY (`IdHorario`)
) COMMENT='Esta tabla guarda los horarios disponibles para las reservas';

-- Tabla de empleados
DROP TABLE IF EXISTS `EMPLEADOS`;
CREATE TABLE `EMPLEADOS` (
  `IdEmpleado` int NOT NULL AUTO_INCREMENT,
  `NombreEmpleado` varchar(60) DEFAULT NULL,
  `RolEmpleado` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`IdEmpleado`)
) COMMENT='Esta tabla guarda los empleados';

-- Tabla de canchas
DROP TABLE IF EXISTS `CANCHAS`;
CREATE TABLE `CANCHAS` (
  `IdCancha` int NOT NULL AUTO_INCREMENT,
  `DescripcionCancha` varchar(60) DEFAULT NULL,
  `CostoHora` int,
  PRIMARY KEY (`IdCancha`)
) COMMENT='En esta tabla se guarda el id de cada cancha y la descripcion, que en este caso es su ubicacion dentro del club';

-- Tabla de categorias
DROP TABLE IF EXISTS `CATEGORIAS`;
CREATE TABLE `CATEGORIAS` (
  `IdCategoria` int NOT NULL AUTO_INCREMENT,
  `DescripcionCategoria` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`IdCategoria`)
) COMMENT='Esta tabla guarda las categorías de los clientes';

-- Tabla de clientes
DROP TABLE IF EXISTS `CLIENTES`;
CREATE TABLE `CLIENTES` (
  `IdCliente` int NOT NULL AUTO_INCREMENT,
  `NombreCliente` varchar(60) DEFAULT NULL,
  `ApellidoCliente` varchar(60) DEFAULT NULL,
  `TelefonoCliente` varchar(80) NOT NULL,
  `IdCategoria` int,
  PRIMARY KEY (`IdCliente`),
  KEY `fk_clientes_categorias` (`IdCategoria`),
  CONSTRAINT `fk_clientes_categorias` FOREIGN KEY (`IdCategoria`) REFERENCES `CATEGORIAS` (`IdCategoria`)
) COMMENT='Esta tabla almacena los datos de los clientes que han reservado alguna cancha';

-- Tabla de pagos
DROP TABLE IF EXISTS `PAGOS`;
CREATE TABLE `PAGOS` (
  `IdPago` int NOT NULL AUTO_INCREMENT,
  `FechaPago` datetime DEFAULT CURRENT_TIMESTAMP,
  `CantidadPago` int DEFAULT NULL,
  `IdCliente` int,
  PRIMARY KEY (`IdPago`),
  KEY `fk_pagos_clientes` (`IdCliente`),
  CONSTRAINT `fk_pagos_clientes` FOREIGN KEY (`IdCliente`) REFERENCES `CLIENTES` (`IdCliente`)
) COMMENT='Esta tabla guarda los pagos y su cantidad';

-- Tabla de reservas
DROP TABLE IF EXISTS `RESERVAS`;
CREATE TABLE `RESERVAS` (
  `IdReserva` int NOT NULL AUTO_INCREMENT,
  `FechaReserva` datetime DEFAULT CURRENT_TIMESTAMP,
  `IdCliente` int NOT NULL,
  `IdCancha` int NOT NULL,
  `IdHorario` int NOT NULL,
  `IdEmpleado` int,
  PRIMARY KEY (`IdReserva`),
  KEY `fk_reservas_clientes` (`IdCliente`),
  KEY `fk_reservas_canchas` (`IdCancha`),
  KEY `fk_reservas_horarios` (`IdHorario`),
  KEY `fk_reservas_empleados` (`IdEmpleado`),
  CONSTRAINT `fk_reservas_clientes` FOREIGN KEY (`IdCliente`) REFERENCES `CLIENTES` (`IdCliente`),
  CONSTRAINT `fk_reservas_canchas` FOREIGN KEY (`IdCancha`) REFERENCES `CANCHAS` (`IdCancha`),
  CONSTRAINT `fk_reservas_horarios` FOREIGN KEY (`IdHorario`) REFERENCES `HORARIOS` (`IdHorario`),
  CONSTRAINT `fk_reservas_empleados` FOREIGN KEY (`IdEmpleado`) REFERENCES `EMPLEADOS` (`IdEmpleado`)
) COMMENT='Esta tabla guarda las reservas de las canchas por los clientes';

-- Tabla de detalles de pagos
DROP TABLE IF EXISTS `DETALLE_PAGOS`;
CREATE TABLE `DETALLE_PAGOS` (
  `IdDetallePago` int NOT NULL AUTO_INCREMENT,
  `IdPago` int NOT NULL,
  `Descripcion` varchar(255) DEFAULT NULL,
  `Monto` int DEFAULT NULL,
  PRIMARY KEY (`IdDetallePago`),
  KEY `fk_detalle_pagos_pagos` (`IdPago`),
  CONSTRAINT `fk_detalle_pagos_pagos` FOREIGN KEY (`IdPago`) REFERENCES `PAGOS` (`IdPago`)
) COMMENT='Esta tabla guarda los detalles de los pagos';

-- Tabla de insumos
DROP TABLE IF EXISTS `INSUMOS`;
CREATE TABLE `INSUMOS` (
  `IdInsumo` int NOT NULL AUTO_INCREMENT,
  `DescripcionInsumo` varchar(60) DEFAULT NULL,
  `Cantidad` int DEFAULT NULL,
  PRIMARY KEY (`IdInsumo`)
) COMMENT='Esta tabla guarda los insumos del club para saber la cantidad disponible de cada insumo';

-- Tabla intermedia entre reservas e insumos
DROP TABLE IF EXISTS `RESERVAS_INSUMOS`;
CREATE TABLE `RESERVAS_INSUMOS` (
  `IdReserva` int NOT NULL,
  `IdInsumo` int NOT NULL,
  PRIMARY KEY (`IdReserva`, `IdInsumo`),
  KEY `fk_reservas_insumos_reservas` (`IdReserva`),
  KEY `fk_reservas_insumos_insumos` (`IdInsumo`),
  CONSTRAINT `fk_reservas_insumos_reservas` FOREIGN KEY (`IdReserva`) REFERENCES `RESERVAS` (`IdReserva`),
  CONSTRAINT `fk_reservas_insumos_insumos` FOREIGN KEY (`IdInsumo`) REFERENCES `INSUMOS` (`IdInsumo`)
) COMMENT='Esta tabla guarda la relación entre reservas y los insumos utilizados';
