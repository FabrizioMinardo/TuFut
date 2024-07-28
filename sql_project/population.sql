USE TUFUT;

-- IMPORTANTE PARA QUE ENTIENDA QUE DEBE HACER LA IMPORTACION
SET GLOBAL local_infile = true;

INSERT INTO `CATEGORIAS`(`DescripcionCategoria`)
VALUES ('Cliente nuevo'),('Cliente frecuente'),('Cliente inactivos'),('Cliente VIP'),('Cliente Empresa');

LOAD    DATA LOCAL INFILE 'sql_project/data_csv/CLIENTES.csv'
        INTO TABLE  CLIENTES
            FIELDS TERMINATED   BY ','  ENCLOSED BY '"'
            LINES TERMINATED    BY '\n'		 
            IGNORE 1 LINES
		(NombreCliente, ApellidoCliente, TelefonoCliente, IdCategoria);

INSERT INTO `HORARIOS` (`HoraInicio`, `HoraFin`)
VALUES ('08:00:00', '09:00:00')
, ('09:00:00', '10:00:00')
, ('10:00:00', '11:00:00')
, ('11:00:00', '12:00:00')
, ('12:00:00', '13:00:00')
, ('13:00:00', '14:00:00')
, ('14:00:00', '15:00:00')
, ('15:00:00', '16:00:00')
, ('16:00:00', '17:00:00')
, ('17:00:00', '18:00:00')
, ('18:00:00', '19:00:00')
, ('19:00:00', '20:00:00')
, ('20:00:00', '21:00:00')
, ('21:00:00', '22:00:00');

INSERT INTO `CANCHAS`
VALUES (1,'Primera Cancha de 5',50)
, (2,'Segunda Cancha de 5',55)
, (3,'Primera Cancha de 7',70)
, (4,'Segunda Cancha de 7',75)
, (5,'Cancha de 11',100);

INSERT INTO `EMPLEADOS`
VALUES (1,'Juan Perez','Jefe')
, (2,'Ana Gomez','Empleado')
, (3,'Carlos Ruiz','Empleado')
, (4,'Mara Lopez','Empleado')
, (5,'Luis Sanchez','Empleado');

LOAD    DATA LOCAL INFILE 'sql_project/data_csv/PAGOS.csv'
        INTO TABLE  PAGOS
            FIELDS TERMINATED   BY ','  ENCLOSED BY '"'
            LINES TERMINATED    BY '\n'		 
            IGNORE 1 LINES
		(FechaPago, CantidadPago, IdCliente);

LOAD    DATA LOCAL INFILE 'sql_project/data_csv/RESERVAS.csv'
        INTO TABLE  RESERVAS 
            FIELDS TERMINATED   BY ','  ENCLOSED BY '"'
            LINES TERMINATED    BY '\n'		 
            IGNORE 1 LINES
		(FechaReserva, IdCliente, IdCancha, IdHorario, IdEmpleado);

INSERT INTO `INSUMOS` (`DescripcionInsumo`, `Cantidad`)
VALUES ('Pelotas de ftbol', 20)
, ('Conos de entrenamiento', 50)
, ('Redes para arcos', 10)
, ('Marcadores', 15)
, ('Botellas de agua', 100);

LOAD    DATA LOCAL INFILE 'sql_project/data_csv/DETALLE_PAGOS.csv'
        INTO TABLE  DETALLE_PAGOS
            FIELDS TERMINATED   BY ','  ENCLOSED BY '"'
            LINES TERMINATED    BY '\n'		 
            IGNORE 1 LINES
		(IdPago, Descripcion, Monto);

LOAD    DATA LOCAL INFILE 'sql_project/data_csv/RESERVAS_INSUMOS.csv'
        INTO TABLE  RESERVAS_INSUMOS
            FIELDS TERMINATED   BY ','  ENCLOSED BY '"'
            LINES TERMINATED    BY '\n'		 
            IGNORE 1 LINES
		(IdReserva, IdInsumo);