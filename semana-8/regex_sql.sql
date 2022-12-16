SELECT * FROM publications.jobs;

-- quiero seleccionar a los managers
SELECT * FROM publications.jobs
WHERE job_desc LIKE "%Man%"
;
-- no es case sensitive
SELECT * FROM publications.jobs
WHERE job_desc LIKE "%man%"
;

-- ciudades que empiezan por B
SELECT * FROM publishers
WHERE city LIKE 'B%'
;

-- ciudades que NO empiezan por B
SELECT * FROM publishers
WHERE city NOT LIKE 'B%'
;

-- seleccionar las ciudades que empiezan por b --> con regex
SELECT * FROM publishers
WHERE city REGEXP '^B'
;

-- seleccionar las ciudades que empiezan por b --> con regex
SELECT * FROM stores
WHERE stor_address REGEXP '\\d{3}'
;

-- seleccionar las ciudades que empiezan por b --> con regex
SELECT * FROM stores
WHERE stor_address REGEXP '\\d{2}\\s'
;

-- intentar resolverlo pero en vez que con regex + likes
SELECT * FROM stores
WHERE stor_address LIKE '[0-9]%'
;

-- seleccionar años, meses...
select year(pubdate)
from titles;

-- seleccionar años, meses...
select month(pubdate)
from titles;

-- puedes ver hasta que día de la semana son las fechas introducidas...
select dayname(pubdate)
from titles;

-- precio medio titles, fecha de publicación y el pub_id
-- ingresos por editorial por año
SELECT pub_id, sum(price), year(pubdate)
FROM titles
GROUP BY pub_id, year(pubdate)
HAVING sum(price) IS NOT NULL
;

-- cuantos libros se venden por día de la semana

SELECT dayname(ord_date), sum(qty)
FROM sales
GROUP BY dayname(ord_date)
;

SELECT dayname(ord_date), sum(qty), sum(price)
FROM sales
INNER JOIN titles
ON sales.title_id = titles.title_id
GROUP BY dayname(ord_date)
ORDER BY sum(price) DESC
;

-- nombre y apellido de escritores, royalty mayor que el precio
select concat(au_fname, ' ', au_lname) as author_name, sum(royalty), sum(price)
from titles
INNER JOIN titleauthor
ON titles.title_id = titleauthor.title_id
INNER JOIN authors
ON titleauthor.au_id = authors.au_id
where royalty > price
group by author_name
;

select * from titles;

SELECT concat(au_fname, ' ', au_lname) as author_name
from authors
where au_id in 
(
	select au_id from titleauthor
	where title_id in (
		select title_id from titles
		where royalty > price
	)
);


select concat(au_fname, ' ', au_lname) as author_name
from titles
INNER JOIN titleauthor
ON titles.title_id = titleauthor.title_id
INNER JOIN authors
ON titleauthor.au_id = authors.au_id
where 'b' = (
	CASE
    WHEN price - royalty > 0 then 'perfecto, el rey es mi padre'
    ELSE 'b'
    END
)
;

-- beneficios por autor
SELECT * FROM titles;

SELECT concat(au_fname, ' ', au_lname) as author_name, sum((advance + (price*royalty /100)*ytd_sales)) as ganancias
from titles
INNER JOIN titleauthor
ON titles.title_id = titleauthor.title_id
INNER JOIN authors
ON titleauthor.au_id = authors.au_id 
group by author_name
order by ganancias desc
;

SELECT concat(au_fname, ' ', au_lname) as author_name, sum((advance + (price*royalty /100)*qty)) as ganancias
from titles
INNER JOIN titleauthor
ON titles.title_id = titleauthor.title_id
INNER JOIN authors
ON titleauthor.au_id = authors.au_id 
INNER JOIN sales
ON titles.title_id = sales.title_id 
group by author_name
order by ganancias desc
;

SELECT CONCAT(au_lname, "", au_fname) AS AUTORES, sum(advance+((royalty*price)/100)*qty) AS BENEFICIOS FROM titles
NATURAL JOIN titleauthor
NATURAL JOIN authors
NATURAL JOIN sales
GROUP BY AUTORES
order by BENEFICIOS desc

-- tienda en la que se vende, id factura, cantidad de libros vendidos
SELECT stor_name, sum(qty), ord_num
FROM sales
INNER JOIN stores
ON stores.stor_id = sales.stor_id
GROUP BY ord_num
;

-- titulo de los titulos en las facturas
SELECT stor_name, sum(qty), ord_num, group_concat(title)
FROM sales
INNER JOIN stores
ON stores.stor_id = sales.stor_id
INNER JOIN titles
ON sales.title_id = titles.title_id
GROUP BY ord_num
order by sum(qty) desc
;
