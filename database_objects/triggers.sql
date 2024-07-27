USE Wifly;



-- Creación TRIGGERS
-- VALIDACIÓN DE CANTIDAD DE EQUIPOS: verifica que la cantidad de equipos esten disponibles cuando se realiza una venta.

DELIMITER //

CREATE TRIGGER verificar_cantidad_equipo
BEFORE INSERT ON VENTAS
FOR EACH ROW
BEGIN
    DECLARE cantidad_disponible INT;

    -- Obtener la cantidad disponible del equipo que se va a vender
    SELECT cantidad INTO cantidad_disponible
    FROM EQUIPOS
    WHERE id_equipo = NEW.id_equipo;

    -- Verificar si hay suficiente cantidad
    IF cantidad_disponible < NEW.cantidad THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente cantidad en stock para el equipo seleccionado.';
    END IF;
END //

DELIMITER ;

-- VALIDACIÓN DE EMPLEADO-OPERACIÓN: permite verificar que el empleado y la operación existe antes de asignarla.
DELIMITER //

CREATE TRIGGER before_insert_assignment
BEFORE INSERT ON ASIGNACIONES
FOR EACH ROW
BEGIN
    DECLARE employee_exists INT;
    DECLARE operation_exists INT;
    
    SELECT COUNT(*) INTO employee_exists
    FROM EMPLEADOS
    WHERE id_empleado = NEW.id_empleado;
    
    SELECT COUNT(*) INTO operation_exists
    FROM OPERACIONES
    WHERE id_operacion = NEW.id_operacion;
    
    IF employee_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Empleado no existe';
    END IF;
    
    IF operation_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Operación no existe';
    END IF;
END ; //

DELIMITER ;