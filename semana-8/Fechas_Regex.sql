USE publications;

-- -- -- -- -- -- -- -- -- -- -- -- 
-- OTROS MÉTODOS EXPLORATORIOS --
-- -- -- -- -- -- -- -- -- -- -- -- 


-- si queremos obtener la información básica de una tabla 
DESCRIBE jobs ;


-- LENGTH Si queremos sacar la longitud de algun elemento de una columna 
SELECT au_id, LENGTH (au_id) as longitud FROM authors a;



-- CONCAT junta varios string en una misma columna
SELECT CONCAT(au_lname, " ",  au_fname) as nombre_completo, address , state  from authors; 


-- CONCAT_WS junta varios strings con el separador que le indiquemos
SELECT CONCAT_WS(", ", address, city, state) as full_direcction from authors; 



-- GROUP_CONCAT devuelve una cadena con un valor concatenado no NULL de un grupo.
SELECT  state, GROUP_CONCAT(au_fname)  from authors a 
	GROUP BY state;


-- -- -- -- -- -- -- -- -- 
-- TRABAJANDO CON NULOS --
-- -- -- -- -- -- -- -- -- 


SELECT count(ISNULL(price)) as nulos_precio, -- contamos el número de nulos para la columna precio
	   count(ISNULL(type)) as nulos_tipo -- lo mismo para la columna tipo
FROM titles; -- sacar el número de nulos que tenemos para dos columnas

-- filtramos los datos para los que no sean nulos
select * from titles
where price IS NOT NULL and type IS NOT NULL;

-- -- -- -- -- -- -- 
-- REGEX EN SQL --
-- -- -- -- -- -- --
SELECT * FROM jobs;

-- queremos sacar todos los empleados que sean Managers
SELECT * FROM jobs -- devuelveme todo de la tabla jobs todas las columnas
WHERE job_desc  LIKE "%man%"; -- donde en la columna de descripción contengan "man"


SELECT * from jobs j 
where job_desc  REGEXP  '.*Man.*'; -- usamos la sentencia regexp. Es exactamente lo mismo que lo anterior

SELECT * FROM publishers;

-- seleccionamos todas aquellas editoriales que su ciudad empiece por B
SELECT * FROM publishers
WHERE city LIKE "B%";

-- y las que no empiezan por B
SELECT * FROM publishers
WHERE city NOT LIKE "B%";


-- Como haríamos la consulta anterior con regex
SELECT * from publishers
where city  REGEXP  '^B'; 

-- Como haríamos la consulta anterior con regex, para las ciudades que no empiezan con B
SELECT * from publishers
where city  REGEXP  '[^B]'; 



-- -- -- -- -- -- -- -- -- --
-- TRABAJANDO CON FECHAS --
-- -- -- -- -- -- -- -- -- --

SELECT * FROM titles ;
SELECT * FROM sales ;

-- sacamos el precio total vendido por cada editorial. Redondead el precio a dos decimales.
SELECT pub_id, ROUND(SUM(price), 2)  as precio_total from titles
	group by pub_id ; 
	
-- extraed el precio medio por editorial y años
SELECT pub_id, YEAR(pubdate) as año, ROUND(AVG(price),2) as precio_promedio
	FROM titles
    GROUP BY pub_id, año
	HAVING precio_promedio IS NOT NULL; 
	
-- mejoramos la query anterior pero en vez de por año, lo hacemos por año y mes
SELECT pub_id, YEAR(pubdate) as año, MONTH(pubdate) as mes, ROUND(AVG(price),2) as precio_promedio
	FROM titles
    GROUP BY pub_id,año, mes
	HAVING precio_promedio IS NOT NULL; 

-- ¿cuántos libros se han vendido por cada día de la semana?
SELECT DAYNAME(pubdate) as dia_semana, sum(qty) as cantidad
FROM titles as t
INNER JOIN sales as s ON t.title_id = s.title_id
GROUP BY DAYNAME(pubdate);

-- mejoramos la query anterior y sacamos también el total del precio de los libros venidos. Guardad los resultados en una tabla temporal
CREATE TEMPORARY TABLE dias_semana
SELECT DAYNAME(pubdate) as dia_semana ,  sum(qty) as cantidad, ROUND(sum(price),2) as precio from titles t 
	INNER JOIN sales as s ON t.title_id = s.title_id
	GROUP BY DAYNAME(pubdate);   
    
select * from dias_semana;


-- basandonos en la tabla creada en el paso anterior. ¿Cuál es el total de ingresos por día de la semana?
select dia_semana, cantidad * precio as total from dias_semana;
