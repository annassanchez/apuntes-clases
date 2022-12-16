-- cuanto es la factura por producto
SELECT order_id, SUM(unit_price * quantity * (1 - discount)) AS precio_factura
FROM order_details
GROUP BY order_id
order by SUM(unit_price * quantity * (1 - discount)) desc
;

select * from order_details;

-- extraer la información de productos beverage
-- id_producto, nombre del producto y su id categoría [products, category]
SELECT category_id 
FROM categories
WHERE category_name = 'Beverages';

SELECT product_id, product_name, category_id
FROM products
WHERE category_id = (
		SELECT category_id 
		FROM categories
		WHERE category_name = 'Beverages'
    )
    
SELECT product_id, product_name, category_id
FROM products
WHERE category_id IN (SELECT category_id
						FROM categories
						WHERE category_name = "Beverages");
    
-- customers, supplies
-- 2. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país.

SELECT country 
FROM CUSTOMERS
WHERE country not in (SELECT country
	FROM suppliers)
GROUP BY country
;

-- lo correcto es usar distinct

SELECT DISTINCT country
FROM customers
WHERE country NOT IN (SELECT country
						FROM suppliers);

-- 3.  Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread". Extraed el OrderId y el nombre del cliente

SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM order_details;

SELECT order_id, contact_name
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id 
WHERE order_id in (SELECT order_id FROM order_details
	WHERE product_id = (
		SELECT product_id
		FROM products
		WHERE product_name = "Grandma's Boysenberry Spread") 
	AND quantity > 20
    )
    -- todo subqueries
SELECT contact_name, customer_id
FROM customers
WHERE customer_id in
	(SELECT customer_id
	FROM orders
	WHERE order_id in (SELECT order_id FROM order_details
		WHERE product_id = (
			SELECT product_id
			FROM products
			WHERE product_name = "Grandma's Boysenberry Spread") 
		AND quantity > 20
    )
)
    
    
SELECT order_id, company_name
FROM customers
NATURAL JOIN orders WHERE order_id IN( SELECT order_id
										FROM order_details WHERE product_id= 6 AND quantity>20);

-- extraer los 10 productos más caros
SELECT * 
FROM (
	SELECT *
    FROM products
    ORDER BY unit_price DESC
    LIMIT 10
) as tabuchi;

-- la buena práctica
SELECT * 
FROM (
	SELECT product_name, unit_price
    FROM products
) as tabluchi
ORDER BY unit_price DESC
LIMIT 10
;

-- nombre del empleado y su jefe
-- INNER JOIN EN LA MISMA TABLA 

SELECT * FROM employees AS A
INNER JOIN employees AS B
ON B.reports_to = A.employee_id;

-- es el único caso en el que se puede usar dos tablas en el join

SELECT *
FROM employees AS A, employees AS B
WHERE A.reports_to = B.employee_id;

SELECT concat(A.last_name, " ", A.first_name) AS nombre_empleado, concat(B.last_name, " ", B.first_name) as nombre_jefe
FROM employees AS A, employees AS B
WHERE A.reports_to = B.employee_id;
-- un inner join tiene la misma sintaxis


-- 5. Selecciona aquellos productos que su precio unitario sea mayor que la media de todos los precios
SELECT * 
FROM products
WHERE unit_price >= (
	SELECT avg(unit_price)
    FROM products
)
ORDER BY unit_price ;

-- cosa muy interesante
-- pedidos que tengan el order day más reciente para cada empleado

SELECT last_name, first_name, order_date
FROM orders AS O
inner join employees AS E
ON O.employee_id = E.employee_id
WHERE O.order_date in (
	SELECT MAX(order_date)
	FROM orders
	GROUP BY employee_id
);
-- no nos salen valores únicos --> se hace un rank

SELECT * FROM 
(
	SELECT last_name, first_name, DATE(order_date), -- solo la fecha, sin horas
	RANK() OVER(
		PARTITION BY last_name 
		ORDER BY order_date DESC -- ordeno primero para que me dé la ficha más alta
	) AS rango
	FROM orders AS O
	inner join employees AS E
	ON O.employee_id = E.employee_id
	WHERE O.order_date in (
		SELECT MAX(order_date)
		FROM orders
		GROUP BY employee_id
) 
ORDER BY last_name, rango) AS A 
WHERE rango = 1
;

CREATE TEMPORARY TABLE mejores(
	SELECT last_name, first_name, order_date,
    rank() over(
		PARTITION BY last_name ORDER BY order_date desc
    ) AS rango
    FROM orders as O
		INNER JOIN employees AS E
        ON O.employee_id = E.employee_id
	WHERE order_date in (
		SELECT MAX(order_date)
        FROM orders
        GROUP BY employee_id
    )
ORDER BY last_name, first_name
);

select * from mejores;

-- seleccionad el nombre, apellidos, posición de empleado, edad
SELECT last_name, first_name, DATEDIFF(current_date, birth_date) as edad -- en días
FROM employees

SELECT last_name, first_name, date_format(from_days(DATEDIFF(current_date, birth_date)), "%y años") as edad -- from_days para convertir de días a años y luego cambia el formato
FROM employees