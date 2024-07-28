USE TUFUT;

-- Creación FUNCIONES
-- Funcion de disponibilidad de cancha: Realiza la comprobacion de que si una cancha esta disponible o no. Si devuelve 0 entonces la cancha esta disponible para esa fecha.
DELIMITER //
CREATE FUNCTION DisponibilidadCancha(IdCancha INT, Fecha DATE, IdHorario INT)
RETURNS BOOLEAN
READS SQL DATA
BEGIN
    DECLARE disponibilidad INTEGER;

    SELECT COUNT(*) INTO disponibilidad
    FROM RESERVAS
    WHERE IdCancha = IdCancha
    AND DATE(FechaReserva) = Fecha
    AND IdHorario = IdHorario;

    IF disponibilidad = 0 THEN
        RETURN TRUE; -- La cancha está disponible
    ELSE
        RETURN FALSE; -- La cancha no está disponible
    END IF;
END //
DELIMITER ;

-- Funcion de categorizacion de clientes: Segun las veces que un cliente realizó reservas se puede saber la clase de categoria que tiene.
DELIMITER //
CREATE FUNCTION CategoriaCliente(IdCliente INT)
RETURNS VARCHAR(20)
READS SQL DATA
BEGIN
    DECLARE CantidadReservas INT;
    DECLARE Categoria VARCHAR(20);

    -- Calcular cuantas reservas hizo el cliente y lo guarda en la variable CantidadReservas.
    SELECT COUNT(*) INTO CantidadReservas
    FROM RESERVAS
    WHERE IdCliente = IdCliente;

    -- Asignar una categoria segun la cantidad de reservas hechas.
    IF CantidadReservas >= 20 THEN
        SET Categoria = 'cliente VIP';
    ELSEIF CantidadReservas >= 10 THEN
        SET Categoria = 'cliente frecuente';
    ELSEIF CantidadReservas = 0 THEN
        SET Categoria = 'cliente inactivo';
    ELSE
        SET Categoria = 'cliente nuevo';
    END IF;

    RETURN Categoria;
END //

DELIMITER ;

DELIMITER //

CREATE FUNCTION DetallePago(IdPago INT)
RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
    DECLARE Detalles VARCHAR(200);

    -- Concatenar y obtener los detalles del pago.
    SELECT CONCAT('Cliente: ', c.NombreCliente, ' ', c.ApellidoCliente, ', Monto: $', p.CantidadPago, ', Fecha: ', p.FechaPago)
    INTO Detalles
    FROM PAGOS p
    JOIN CLIENTES c ON p.IdCliente = c.IdCliente
    WHERE p.IdPago = IdPago;

    RETURN Detalles;
END //

DELIMITER ;