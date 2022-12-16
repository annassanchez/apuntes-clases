use coches;

select * FROM clientes;

UPDATE clientes
SET provincia_cliente = 'Asturias'
WHERE idclientes = 1;

SET SQL_SAFE_UPDATES = 0;

UPDATE clientes
SET provincia_cliente = 'Asturias';

DELETE FROM clientes 
WHERE nombre_cliente = 'Rodri';

DELETE FROM clientes ;

ALTER TABLE clientes
DROP COLUMN provincia_cliente;

ALTER TABLE clientes
ADD COLUMN provincia_cliente varchar(45);

ALTER TABLE clientes
RENAME COLUMN provincia_cliente TO ciudad;

ALTER TABLE clientes
MODIFY COLUMN ciudad float;