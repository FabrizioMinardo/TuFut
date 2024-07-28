USE TUFUT;

CREATE OR REPLACE VIEW VW_ReservasClientes_Findes AS
SELECT 
    R.IdReserva,
    R.FechaReserva AS Fecha,
    C.NombreCliente AS Nombre,
    C.ApellidoCliente AS Apellido,
    R.IdCancha,
    R.IdHorario AS Hora
FROM 
    RESERVAS R
JOIN 
    CLIENTES C ON R.IdCliente = C.IdCliente
WHERE 
    DAYOFWEEK(R.FechaReserva) IN (1, 7);

CREATE OR REPLACE VIEW VW_PagosDetallados AS
SELECT 
    P.IdPago,
    P.FechaPago,
    P.CantidadPago,
    C.NombreCliente,
    C.ApellidoCliente,
    R.FechaReserva
FROM 
    PAGOS P
JOIN 
    CLIENTES C ON P.IdCliente = C.IdCliente
JOIN 
    RESERVAS R ON C.IdCliente = R.IdCliente
ORDER BY 
    P.FechaPago DESC;


    CREATE OR REPLACE VIEW VW_ClientesFrecuentes_Pagos AS
SELECT 
    C.NombreCliente AS Nombre,
    C.ApellidoCliente AS Apellido,
    TotalPagos.Total
FROM 
    CLIENTES C
JOIN (
    SELECT 
        P.IdCliente,
        SUM(P.CantidadPago) AS Total
    FROM 
        PAGOS P
    GROUP BY 
        P.IdCliente
    HAVING 
        SUM(P.CantidadPago) > 10000
) AS TotalPagos ON C.IdCliente = TotalPagos.IdCliente
WHERE 
    C.IdCategoria = (SELECT IdCategoria FROM CATEGORIAS WHERE DescripcionCategoria = 'Cliente frecuente');


CREATE OR REPLACE VIEW VW_ReservasHoy AS
SELECT
    R.FechaReserva AS Fecha,
    H.HoraInicio AS Cominezo,
    H.HoraFin AS Fin,
    C.NombreCliente AS Nombre,
    C.ApellidoCliente AS Apellido,
    CA.DescripcionCancha AS NombreCancha
FROM
    RESERVAS R
JOIN
    CLIENTES C ON R.IdCliente = C.IdCliente
JOIN
    HORARIOS H ON R.IdHorario = H.IdHorario
JOIN
    CANCHAS CA ON R.IdCancha = CA.IdCancha
WHERE
    DATE(R.FechaReserva) = CURDATE()
ORDER BY
    H.HoraInicio;