USE TUFUT;

-- Trigger para comprobar la disponibilidad de una cancha antes de realizar una reserva.
DELIMITER //
CREATE TRIGGER before_insert_reservas
BEFORE INSERT ON RESERVAS
FOR EACH ROW
BEGIN
    DECLARE disponibilidad BOOLEAN;
    
    SET disponibilidad = DisponibilidadCancha(NEW.IdCancha, NEW.FechaReserva, NEW.IdHorario);
    
    IF disponibilidad = FALSE THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cancha no esta disponible en esa fecha y hora';
    END IF;
END //
DELIMITER ;

-- Trigger para registrar en la tabla de auditoria las inserciones de pagos.
DELIMITER //

CREATE TRIGGER after_insert_pagos
AFTER INSERT ON PAGOS
FOR EACH ROW
BEGIN
    INSERT INTO AuditoriaPagos (
        IdPago, 
        CantidadPagoNuevo, 
        FechaPagoNuevo, 
        IdCliente, 
        Accion, 
        FechaAccion
    )
    VALUES (
        NEW.IdPago, 
        NEW.CantidadPago, 
        NEW.FechaPago, 
        NEW.IdCliente, 
        'Inserción de Pago', 
        NOW()
    );
END //

-- Trigger para evitar eliminar reservas con un dia o menos de anticipacion.
 DELIMITER //

CREATE TRIGGER before_delete_reservas_evitar_proximas_24h
BEFORE DELETE ON RESERVAS
FOR EACH ROW
BEGIN
    IF OLD.FechaReserva <= NOW() + INTERVAL 1 DAY THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se pueden eliminar reservas que esten dentro de las proximas 24 horas';
    END IF;
END //

DELIMITER ;
