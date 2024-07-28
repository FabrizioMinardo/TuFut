USE TUFUT;

-- Procedimiento almacenado para registrar una reserva.
DELIMITER //

CREATE PROCEDURE SP_RegistrarReserva (
    IN Id_Cliente INT,
    IN Id_Cancha INT,
    IN fecha DATE,
    IN Id_Horario INT,
    IN Id_Empleado INT
)
BEGIN
    INSERT INTO RESERVAS (IdCliente, IdCancha, FechaReserva, IdHorario, IdEmpleado)
    VALUES (Id_Cliente, Id_Cancha, fecha, Id_Horario, Id_Empleado);
END //

DELIMITER ;

-- Procedimiento almacenado para actualizar la cantidad de un pago.
DELIMITER //
CREATE PROCEDURE SP_ActualizarPago(
    IN Id_Pago INT,
    IN NuevaCantidad INT
)
BEGIN
    UPDATE PAGOS
    SET CantidadPago = NuevaCantidad
    WHERE IdPago = Id_Pago;
END //
DELIMITER ;

DELIMITER //

-- Procedimiento almacenado para borrar las reservas y sus pagos verificando primero la categoria del cliente y si la reserva existe
DELIMITER //

CREATE PROCEDURE SP_EliminarReserva (
    IN Id_Reserva INT
)
BEGIN
    DECLARE Id_Cliente INT;
    DECLARE Categoria_Cliente VARCHAR(20);

    -- Verificar si la reserva existe
    SELECT IdCliente INTO Id_Cliente
    FROM RESERVAS
    WHERE IdReserva = Id_Reserva
    LIMIT 1;

    -- Si no se encuentra la reserva, lanzar un error
    IF Id_Cliente IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La reserva no existe.';
    ELSE
        -- Obtener la categoría del cliente
        SET Categoria_Cliente = CategoriaCliente(Id_Cliente);

        -- Validar la categoría del cliente
        IF Categoria_Cliente = 'cliente nuevo' THEN
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Los clientes nuevos no pueden eliminar reservas.';
        ELSE
            -- Eliminar los detalles del pago correspondientes
            DELETE FROM DETALLE_PAGOS
            WHERE IdPago IN (SELECT IdPago FROM PAGOS WHERE IdCliente = Id_Cliente);

            -- Eliminar la reserva
            DELETE FROM RESERVAS
            WHERE IdReserva = Id_Reserva;

            -- Eliminar los pagos correspondientes
            DELETE FROM PAGOS
            WHERE IdCliente = Id_Cliente;
        END IF;
    END IF;
END //

DELIMITER ;

