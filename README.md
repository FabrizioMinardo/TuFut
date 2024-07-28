## Realizacion de una base de datos para un club que alquila canchas.

### Introducción:
El club "5 de diamantes" solicitó mis servicios como DBA para el desarrollo de una base de datos para gestionar de manera eficiente las reservas de sus canchas y tener un control de los pagos de las mismas.

### Problemas frencuentes antes de la BD:
Tras entrevistas con el jefe y su personal, además de la revisión de registros pasados, los principales problemas se radican en qué:
-   Las reservas no se registran correctamente.
-   Se producen duplicidad de reservas a la misma hora por diferentes clientes.
-  Los pagos no quedan registrados debido a descuidos de los empleados o perdida de los datos en forma fisica.
Todo esto provoca la insatisfacción por parte de los clientes además de perdida significativa de dinero.

### Objetivos de la BD:
-   Con un diseño y creacion de una base de datos normalizada estos problemas se solucionaran pudiendo almacenar correctamente las reservas, qué cliente la realizó y sabiendo el monto del pago de dicha reserva.
-   Además el proceso de reserva se agilizará reduciendo mucho el margen de error y evitando conflictos con el cliente.

### Herramientas que voy a utilizar:
-   **Una base de datos relacional como MySQL** me parece la mejor opción para solucionar este problema debido a su escabilidad y su compatibilidad con aplicaciones web.
-   **Como lenguaje backend elegí PHP** por su facil integracion con MySQL y su flexibidad.
-   **El servidor en la nube elegido es AWS** porque garantiza una accesibilidad confiable y de alta disponiblidad. Además de mejorar la experiencia de usuario, el costo está dentro del presupuesto del cliente y cumple con creces los requisitos.
-   **Como control de versiones voy a utilizar GIT** para tener un seguimiento seguro de las implementaciones realizadas.
- **Docker**: Para asegurar un entorno de desarrollo y producción estandarizado, facilitando la gestión de la base de datos y sus dependencias.

## Tablas:
1.  **Canchas:**
-   En esta tabla se guarda el id de cada cancha y la descripcion, que en este caso es su ubicacion dentro del club.
-   Atributos: IdCancha, DescripcionCancha, CostoHora.
2.  **Clientes:** 
-   Esta tabla almacena los datos de los clientes que han reservado alguna vez una cancha.
-   Atributos: IdCliente, NombreCliente, ApellidoCliente, TelefonoCliente.
3.  **Empleados;**
-   Esta tabla guarda los datos de los empleados.
-   Atributos: IdEmpleado, NombreEmpleado, RolEmpleado.
4.  **Pagos:**
-   Esta tabla guarda los pagos y su cantidad.
-   Atributos: IdPago, FechaPago, CantidadPago, IdCliente.
5.  **Reservas:**
-   Esta tabla guarda las reservas de las canchas indicando qué cancha, qué cliente, la hora de la reserva y el empleado que gestionó la reserva.
-   Atributos: IdReserva, FechaReserva, IdCliente, IdCancha, IdHorario, IdEmpleado.
-   Contenedores: Implementaré Docker para asegurar un entorno de desarrollo y producción estandarizado, facilitando la gestión de la base de datos y sus dependencias.
6.  **Horarios:**
-   Esta tabla guarda los intervalos de tiempo disponibles para las reservas de las canchas.
-   Atributos: IdHorario, HoraInicio, HoraFin.
7.  **Insumos:**
-   Esta tabla guarda los insumos que pueden ser utilizados durante las reservas, como pelotas, redes, etc.
-   Atributos: IdInsumo, DescripcionInsumo, Cantidad.
8.  **Categorias:**
-   Esta tabla guarda los tipos de clientes según su frecuencia de reservas.
-   Atributos: IdCategoria, DescripcionCategoria.
9.  **Detalle_Pagos:**
-   En esta tabla se guardan los detalles de los pagos, asociando cada pago con las reservas correspondientes.
-   Atributos: IdDetallePago, IdPago, Descripcion, Monto.
10. **Reservas_Insumos:**
-   Esta tabla guarda la relación entre las reservas y los insumos utilizados en cada reserva.
-   Atributos: IdReserva, IdInsumo.
# Resultados:
-   Las reservas serán registradas de manera correcta y precisa, reduciendo significativamente los errores de duplicación o falta de registro.
-   El proceso de reserva será más ágil y eficiente, gracias a la automatización y optimización de los flujos de trabajo.
-   La gestión centralizada y transparente de las reservas minimizará los conflictos y malentendidos con los clientes.
-   Los pagos asociados a las reservas serán registrados y gestionados de manera correcta, asegurando un control adecuado y reduciendo la pérdida de ingresos.
-   Tanto el personal administrativo como los clientes podrán acceder fácilmente a la información actualizada sobre reservas y pagos, mejorando la comunicación.

## DER:
```
+--------------------+        +-----------------------+        +------------------+
|      CLIENTES      |        |        RESERVAS       |        |      CANCHAS     |
+--------------------+        +-----------------------+        +------------------+
| IdCliente (PK)     |<>-----o| IdReserva (PK)        |o-------| IdCancha (PK)    |
| NombreCliente      |        | FechaReserva          |        | DescripcionCancha|
| ApellidoCliente    |        | IdCliente (FK)        |        | CostoHora        |
| TelefonoCliente    |        | IdCancha (FK)         |        +------------------+
| IdCategoria (FK)   |        | IdHorario (FK)        |
+--------------------+        | IdEmpleado (FK)       |
         ^                    +-----------------------+
         |                              ^
         |                              |
         |                              |
+------------------+                    |
|    CATEGORIAS    |                    |
+------------------+                    |
| IdCategoria (PK) |                    |
| DescripcionCat.  |                    |
+------------------+                    |
                                        |
+------------------+                    |
|    EMPLEADOS     |                    |
+------------------+                    |
| IdEmpleado (PK)  |<>------------------+
| NombreEmpleado   |                    |
| RolEmpleado      |                    |
+------------------+                    |
                                        |
+------------------+        +-----------------------+
|     HORARIOS     |        |    RESERVAS_INSUMOS   |
+------------------+        +-----------------------+
| IdHorario (PK)   |<>------| IdReserva (PK,FK)     |
| HoraInicio       |        | IdInsumo (PK,FK)      |
| HoraFin          |        +-----------------------+
+------------------+                    ^
                                        |
+------------------+                    |
|      PAGOS       |             +------------------+
+------------------+             |      INSUMOS     |
| IdPago (PK)      |             +------------------+
| FechaPago        |             | IdInsumo (PK)    |
| CantidadPago     |             | DescripcionInsumo|
| IdCliente (FK)   |             | Cantidad         |
+------------------+             +------------------+
         ^
         |
         |
+------------------+
|  DETALLE_PAGOS   |
+------------------+
| IdDetallePago(PK)|
| IdPago (FK)      |
| Descripcion      |
| Monto            |
+------------------+
```
## Funciones:
Se elaboraron 3 funciones para la base de datos.
1.  *DisponibilidadCancha*
-   Descripción:
Realiza la comprobación de que si una cancha está disponible o no en una fecha y hora determinada.
-   Objetivo:
Consultar si una cancha está disponible.
-   Valor que retorna:
BOOLEAN - Retorna TRUE si la cancha está disponible, y FALSE en caso contrario.
-   Utilidad:
Permite verificar la disponibilidad de una cancha antes de registrar una nueva reserva, optimizando la gestión de las canchas y evitando conflictos de horarios.
2.  *CategoriaCliente*
-   Descripción:
Clasifica a los clientes en diferentes categorías según la cantidad de reservas que han realizado.
-   Objetivo:
Asignar una categoría a cada cliente basado en su historial de reservas.
-   Valor que retorna:
VARCHAR(20) - Retorna una cadena con la categoría del cliente, que puede ser 'cliente VIP', 'cliente frecuente', 'cliente nuevo' o 'cliente inactivo'.
-   Utilidad:
Facilita la identificación de los clientes según su nivel de actividad, permitiendo implementar estrategias de fidelización y promociones específicas para cada categoría.
3.  *DetallePago*
-   Descripción:
Obtiene los detalles de un pago específico, incluyendo el cliente que realizó el pago, el monto y la fecha del mismo.
-   Objetivo:
Proporciona información detallada sobre un pago realizado por un cliente.
-   Valor que retorna:
VARCHAR(200) - Retorna una cadena concatenada con los detalles del pago.
-   Utilidad:
Permite obtener rápidamente información sobre los pagos realizados, útil para consultas, reportes financieros y para el seguimiento de transacciones.

## Procedimientos almacenados:
*SP_RegistrarReserva*

-   Descripción:
Inserta una nueva reserva en la base de datos.
-   Objetivo:
Registrar una nueva reserva para un cliente en una cancha específica, en una fecha y horario determinados, gestionada por un empleado.
-   Parámetros de entrada:
-   -   Id_Cliente INT: Identificador del cliente que realiza la reserva.
-   -   Id_Cancha INT: Identificador de la cancha reservada.
-   -   fecha DATE: Fecha de la reserva.
-   -   Id_Horario INT: Identificador del horario de la reserva.
-   -   Id_Empleado INT: Identificador del empleado que gestiona la reserva.
-   Acciones:
Inserta un nuevo registro en la tabla RESERVAS con los detalles proporcionados.
-   Utilidad:
Facilita la creación de nuevas reservas de manera controlada y sistemática, asegurando que toda la información relevante sea registrada adecuadamente.

#### Ejemplo

``` sql 
CALL SP_RegistrarReserva(1, 2, '2024-07-28', 3, 1);
```

*SP_ActualizarPago*
-   Descripción:
Actualiza la cantidad de un pago existente.
-   Objetivo:
Modificar la cantidad asociada a un pago específico.
-   Parámetros de entrada:
-   -   Id_Pago INT: Identificador del pago que se desea actualizar.
-   -   NuevaCantidad INT: Nueva cantidad para el pago.
-   Acciones:
Actualiza el campo CantidadPago en la tabla PAGOS para el registro con IdPago igual al parametro Id_Pago.
-   Utilidad:
Permite corregir o actualizar la información de pagos ya registrados, asegurando la exactitud de los registros.

#### Ejemplo

```sql
CALL SP_ActualizarPago(5, 150);
```


*SP_EliminarReserva*
-   Descripción:
Elimina una reserva y sus pagos asociados, verificando primero la categoría del cliente y si la reserva existe.
-   Objetivo:
Eliminar una reserva y todos los pagos relacionados, con una validación de la categoría del cliente para asegurarse de que los clientes nuevos no puedan eliminar reservas.
-   Parámetros de entrada:
-   -   Id_Reserva INT: Identificador de la reserva que se desea eliminar.
-   Acciones:
Verifica si la reserva existe y obtiene el IdCliente correspondiente.
Si la reserva no existe, lanza un error.
Obtiene la categoría del cliente usando la función CategoriaCliente.
Si la categoría del cliente es "cliente nuevo", lanza un error.
Si la categoría del cliente no es "cliente nuevo", elimina los detalles del pago, la reserva y los pagos asociados al cliente.
-   Utilidad:
Permite la eliminación controlada de reservas y sus pagos asociados, asegurando que solo ciertos tipos de clientes puedan realizar esta acción y manteniendo la integridad referencial de la base de datos.

#### Ejemplo

```sql
CALL SP_EliminarReserva(19);
```
## Vistas:
En el proyecto del sistema de reservas y pagos del club, se han diseñado varias vistas para diferentes áreas y con distintos objetivos. A continuación, se detallan estas vistas:
1.  VW_ReservasClientes_Findes
-   Descripción: Esta vista permite visualizar las reservas de los clientes realizadas los fines de semana.
-   Objetivo: Sirve para identificar y gestionar las reservas realizadas durante el fin de semana, lo cual puede ayudar en la planificación de recursos y personal necesario para esos días.
-   Tablas que la componen: RESERVAS, CLIENTES.
## Ejemplo
```sql
SELECT * FROM VW_ReservasClientes_Findes;
-- Detalles de reservas del CLiente Sile Padula
SELECT * FROM VW_ReservasClientes_Findes WHERE Nombre = 'Sile' AND Apellido = 'Padula';
```
2.  VW_PagosDetallados
-   Descripción: Esta vista proporciona una visión detallada de los pagos realizados por los clientes, incluyendo la fecha de pago, la cantidad pagada, y la fecha de la reserva correspondiente.
-   Objetivo: Permite llevar un control detallado de los pagos, facilitando la auditoría.
-   Tablas que la componen: PAGOS, CLIENTES, RESERVAS.
## Ejemplo
```sql
SELECT * FROM VW_PagosDetallados;
-- Pagos detallados del 25 de julio del 2024
SELECT * FROM VW_PagosDetallados
WHERE DATE(FechaPago) = '2024-07-25';
```
3.  VW_ClientesFrecuentes_Pagos
-   Descripción: Esta vista muestra a los clientes frecuentes que han realizado pagos por un monto total superior a 10,000.
-   Objetivo: Identificar a los clientes más valiosos que contribuyen significativamente al ingreso del club, facilitando la creación de estrategias de fidelización.
-   Tablas que la componen: CLIENTES, PAGOS, CATEGORIAS.
## Ejemplo
```sql
SELECT * FROM VW_ClientesFrecuentes_Pagos;
-- Clientes que pagaron mas de 20000
SELECT * FROM VW_ClientesFrecuentes_Pagos
WHERE Total > 20000;
```
4.  VW_ReservasHoy
-   Descripción: Esta vista muestra todas las reservas realizadas para el día de la fecha, la hora de inicio, fin, el nombre del cliente y la descripción de la cancha.
-   Objetivo: Facilita la gestión y el seguimiento de las reservas del día, permitiendo una organización eficiente de los recursos y personal.
-   Tablas que la componen: RESERVAS, CLIENTES, HORARIOS, CANCHAS.
## Ejemplo
```sql
SELECT * FROM VW_ReservasHoy;
```