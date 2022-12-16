USE coches;

INSERT INTO clientes
VALUES (1, 'Antonio', 'García', 'Calle Abrevadero 25', 1233456789, 'Madrid');

SELECT * FROM coches.clientes;
SELECT nombre_cliente, apellidos_cliente FROM coches.clientes;

INSERT INTO clientes
VALUES 
(2, 'Laura', 'López', 'Vía de la Paz', 1233456789, 'Jáen'),
(3, 'Rodri', 'Pérez', 'Calle Mayor 14', 1233456789, 'Ciudad Real');

INSERT INTO fecha
VALUES
(1, "2009-07-21 23:37:23"),
(2, "2009-05-21 23:37:23"),
(3, "2009-11-27 23:37:23");

SELECT * FROM coches.fecha;

INSERT INTO vendedor
VALUES
(1, 'Pablo', 'Toro', '2000-05-12');

SELECT * FROM coches.clientes;

INSERT INTO producto
VALUES
(1, 'Monovolumen', 12000.99);

select * from producto;

INSERT INTO
facturas
VALUES
(1, 2, 1, 1, 1);

select * from facturas;