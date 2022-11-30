-- definimos que queremos usar la BBDD de "coches"
use coches;

-- INSERTAMOS DATOS EN LA TABLA CLIENTES
INSERT INTO clientes (idclientes, nombre, direccion, provincia, telefono)
VALUES (1, "Antonio", "Calle Abrevadero 23","Madrid", 123456789);

-- Podemos incluir múltiples valores a la vez
INSERT INTO clientes (idclientes, nombre, direccion, provincia, telefono)
VALUES
	(2, "Laura", "Calle Portugal 12","Sevilla", 345267814),
    (3, "Maria", "Avenida Madrid 45","Valencia", 984562356),
    (4, "Lucas", "Calle Leo, 1","Madrid", 234562345),
    (5, "Manuel", "Calle Jazmin","Cuenca", 125639394),
    (6, "Daniel", "Calle del Libro 23","Barcelona", 842567301);
    
-- chequeemos si se han introducido los datos: 
select * from clientes; -- con el * indicamos que queremos seleccionar todas las columnas. 


-- INSERTAMOS DATOS EN LA TABLA FECHA-COMPRA. 
-- ⚠️ Si vamos a introducir todos los datos de las columnas podemos obviar el nombre de las columnas. 
INSERT INTO `fecha-compra` 
VALUES
    (2, '2008-7-05', '21:22:00'), 
    (3, '2008-7-06', '21:22:00'), 
    (4, '2008-7-07', '21:22:00'),
    (5, '2008-7-08', '21:22:00'), 
    (6, '2008-7-09', '21:22:00'), 
    (7, '2008-7-10', '21:22:00');
    
-- chequeamos si se han insertado los valores
select * from `fecha-compra`;

-- INSERTAMOS DATOS EN LA TABLA VENDEDOR.
INSERT INTO vendedor 
VALUES
	(1, "Pablo", "Madrid-Alcorcón", "2000-1-01"),
    (2, "Laura", "Madrid-San Sebastian", "2005-9-10");
    
-- chequeamos si se han metido correctamente    
select * from vendedor;

-- INSERTAMOS DATOS EN LA TABLA FACTURAS.
INSERT INTO facturas 
VALUES
	(1, 23.500, 1, 3, 2 ),
    (2, 34.000, 2, 2, 1 );
    
-- chequeamos si se han metido correctamente    
select * from facturas;

-- INSERTAMOS DATOS EN LA TABLA PRODUCTO.
INSERT INTO producto 
VALUES
	(10, 12000.00, "Monovolumen",1, 1,3 ),
    (20, 17000.99, "Todoterreno",1, 1, 3);
    
