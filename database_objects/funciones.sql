USE TUFUT;

-- Creación FUNCIONES
-- FUNCIÓN DE GANANCIA POR CLIENTE: Arroja la ganancia total (sin discriminar por abono y equipos) según id cliente.
DELIMITER //

CREATE FUNCTION calcular_ganancia_cliente(id_cliente INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE ganancia_total INT;
    
    SELECT 
        SUM(v.precio_abono - v.costo_abono) + SUM(v.precio_equipo - v.costo_equipo)
    INTO ganancia_total
    FROM VENTAS v
    WHERE v.id_cliente = id_cliente;

    RETURN ganancia_total;
END //

DELIMITER ;

-- FUNCIÓN DE CANTIDAD EQUIPOS VENDIDOS: Arroja la cantidad total vendida por id equipo.
DELIMITER //

CREATE FUNCTION cantidad_vendida_por_equipo(id_equipo INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE cantidad_vendida INT;
    
    SELECT SUM(cantidad) INTO cantidad_vendida
    FROM VENTAS
    WHERE id_equipo = id_equipo;
    
    RETURN cantidad_vendida;
END //

DELIMITER ;