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
