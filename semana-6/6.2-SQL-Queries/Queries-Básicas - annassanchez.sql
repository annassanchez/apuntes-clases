use publications;

select * from authors;

select au_lname, au_fname, state from authors;

SELECT CONCAT(au_lname, ' ', au_fname) as nombre_completo, state FROM authors;

-- ojo, puedes seleccionar más movidas con asterisco y campos calculados, no al revés
SELECT *, CONCAT(au_lname, ' ', au_fname) as nombre_completo FROM authors;

-- sacar valores únicos de la columa state
SELECT DISTINCT(state) FROM authors;
-- Y PUEDO SABER CUANTOS VALORES ÚNICOS
SELECT count(DISTINCT(state)) AS recuento_state FROM authors;

-- distinct coge todos los campos --> no se puede cruzar
SELECT DISTINCT state, contract 
FROM authors
ORDER BY state;

-- order by --> ordena de menor a mayor
-- con desc el orden se puede alterar
SELECT DISTINCT state, contract 
FROM authors
ORDER BY state, contract DESC;

SELECT DISTINCT state, contract 
FROM authors
ORDER BY state DESC, contract DESC;

SELECT COUNT(au_id) as numero_autores, state
FROM authors
GROUP BY state
ORDER BY numero_autores DESC;

-- esta sentencia va a dar error --> primero se hace el from luego el groupby, luego el select y por último el order by
SELECT COUNT(au_id) as numero_autores, state
FROM authors
GROUP BY numero_autores
ORDER BY numero_autores DESC;

-- EL LIBRO MÁS CARO
select title, MAX(price)
FROM titles
GROUP BY title
ORDER BY MAX(price) DESC
LIMIT 1;

-- offset --> desde donde tiene que buscar
select title, MAX(price)
FROM titles
GROUP BY title
ORDER BY MAX(price) DESC
-- OFFSET 3
LIMIT 1;

-- min lo mismo
SELECT min(price)
FROM titles;

-- min lo mismo
SELECT max(price) - min(price) as diferencia_precios
FROM titles;

-- promedio
SELECT avg(price)
FROM titles;

SELECT avg(price)
FROM titles;

-- filtros
SELECT * FROM titles
WHERE price > 15.000;

SELECT * FROM titles
WHERE price = 19.990;

SELECT * FROM titles
WHERE type = 'Business';

SELECT * FROM titles
WHERE type != 'Business';

SELECT * FROM titles
WHERE price > 15.000 and type = 'business';

SELECT * FROM titles
WHERE price > 15.000 or type = 'business';

-- in / not in
SELECT * FROM titles
WHERE type in ('business', 'mod_cook');

SELECT * FROM titles
WHERE type not in ('business', 'mod_cook');

SELECT title FROM titles
WHERE `type` not in ('business', 'mod_cook') and price > 15.000;

select * 
from titles;

select type, count(title_id)
from titles
group by type;

-- ojo, para filtrar datos con condición se usa HAVING en vez de WHERE
select type, count(title_id) as numero_libros
from titles
group by type
having count(title_id) >3;

-- between es como un > que y < que
select *
from titles
where price > 10.00 and price < 20.000;

select *
from titles
where price between 10.000 and 20.000;

-- between tb funciona con texto
select *
from titles
where type between 'business' and 'popular_comp';

select *
from titles
where (price between 11.9500 and 20.000) and (type in ('business', 'mod_cook'));

select count(title_id)
from titles
where (price between 11.9500 and 20.000) and (type in ('business', 'mod_cook'))
group by type
having count(title_id) > 3;

select count(title_id), type from titles
where (price between 11.9500 and 20.000) and (type in ('business', 'mod_cook'))
group by type
having count(title_id)>1;


