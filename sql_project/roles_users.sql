-- Crear rol para el jefe
DROP ROLE IF EXISTS 'Jefe';
CREATE ROLE 'Jefe';

-- Crear rol para el area de administracion del club
DROP ROLE IF EXISTS 'Administracion';
CREATE ROLE 'Administracion';

-- Crear rol para el area de contabilidad
DROP ROLE IF EXISTS 'Contabilidad';
CREATE ROLE 'Contabilidad';

-- Otorgo todos los permisos de todas las tablas al rol de jefe
GRANT ALL PRIVILEGES ON *.* TO 'Jefe' WITH GRANT OPTION;

-- Otorgo permisos de lectura, insercion, modificacion y eliminacion en las tablas de reservas, clientes y horarios al rol de administracion
GRANT SELECT, INSERT, UPDATE, DELETE ON TUFUT.RESERVAS TO 'Administracion';
GRANT SELECT, INSERT, UPDATE, DELETE ON TUFUT.CLIENTES TO 'Administracion';
GRANT SELECT, INSERT, UPDATE ON TUFUT.HORARIOS TO 'Administracion';


-- Otorgo permisos de lectura, insercion, modificacion y eliminacion en las tablas sobre los pagos y solo de lectura de la tabla de auditoria al rol de contabilidad
GRANT SELECT, INSERT, UPDATE, DELETE ON TUFUT.PAGOS TO 'Contabilidad';
GRANT SELECT, INSERT, UPDATE, DELETE ON TUFUT.DETALLE_PAGOS TO 'Contabilidad';
GRANT SELECT ON TUFUT.AuditoriaPagos TO 'Contabilidad';

-- Otorgo el permiso de que administracion pueda ejecutar los procedimientos de actualizacion de pagos, eliminar una reserva y registrar una reserva
GRANT EXECUTE ON PROCEDURE TUFUT.SP_ActualizarPago TO 'Administracion';
GRANT EXECUTE ON PROCEDURE TUFUT.SP_EliminarReserva TO 'Administracion';
GRANT EXECUTE ON PROCEDURE TUFUT.SP_RegistrarReserva TO 'Administracion';

-- Otorgo el permiso de que administracion pueda usar las funciones de CategoriaCliente y DetallePago
GRANT EXECUTE ON FUNCTION TUFUT.CategoriaCliente TO 'Administracion';
GRANT EXECUTE ON FUNCTION TUFUT.DetallePago TO 'Administracion';

-- Otorgo permiso a las vistas al rol de administracion
GRANT SELECT ON TUFUT.VW_ClientesFrecuentes_Pagos TO 'Administracion';
GRANT SELECT ON TUFUT.VW_PagosDetallados TO 'Administracion';

-- Otorgo permiso a las vistas al rol de contabilidad
GRANT SELECT ON TUFUT.VW_ClientesFrecuentes_Pagos TO 'Contabilidad';
GRANT SELECT ON TUFUT.VW_PagosDetallados TO 'Contabilidad';

-- Creo los usuarios
CREATE USER 'juan'@'localhost' IDENTIFIED BY 'juan123';
CREATE USER 'ana'@'localhost' IDENTIFIED BY 'ana123';
CREATE USER 'luis'@'localhost' IDENTIFIED BY 'luis123';
CREATE USER 'mara'@'localhost' IDENTIFIED BY 'mara123';
CREATE USER 'carlos'@'localhost' IDENTIFIED BY 'carlos';

-- Asigno los roles a los usuarios
GRANT 'Jefe' TO 'juan'@'localhost';
GRANT 'Administracion' TO 'ana'@'localhost';
GRANT 'Administracion' TO 'luis'@'localhost';
GRANT 'Contabilidad' TO 'mara'@'localhost';
GRANT 'Contabilidad' TO 'carlos'@'localhost';

-- Habilito los roles por defecto a los usuarios
SET DEFAULT ROLE 'Jefe' TO 'juan'@'localhost';
SET DEFAULT ROLE 'Administracion' TO 'ana'@'localhost';
SET DEFAULT ROLE 'Administracion' TO 'luis'@'localhost';
SET DEFAULT ROLE 'Contabilidad' TO 'mara'@'localhost';
SET DEFAULT ROLE 'Contabilidad' TO 'carlos'@'localhost';
