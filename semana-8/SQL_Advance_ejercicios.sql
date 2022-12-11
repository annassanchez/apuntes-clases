-- Cuáles son los libros más vendidos por tienda?
create temporary table mejores_ventas
SELECT 
row_number() over(partition by stor_name order by sum(qty) DESC) as orden,
stor_name ,  t.title, sum(qty) AS ventas FROM stores s
INNER JOIN sales s2 ON s.stor_id = s2.stor_id 
INNER JOIN titles t ON s2.title_id  = t.title_id 
GROUP BY stor_name, t.title_id 
ORDER BY stor_name , ventas DESC;

select * from mejores_ventas
where orden = 1;


-- Selecciona el nombre y apellido de aquellos escritores que reciben un royalty mayor que el precio del libro

-- Una forma de solucionarlo
select CONCAT(au_fname, " ", au_fname ) as autor from titles as t
INNER JOIN titleauthor t2 ON t.title_id = t2.title_id 
INNER JOIN authors a ON t2.au_id = a.au_id 
WHERE 'algo_pasa' =  
    (CASE
        WHEN price - royalty > 0 THEN "BIEN"
        ELSE "algo_pasa"
    END);

-- Otra forma de solucionarlo
select CONCAT(au_fname, " ", au_fname ) as autor from titles as t
INNER JOIN titleauthor t2 ON t.title_id = t2.title_id 
INNER JOIN authors a ON t2.au_id = a.au_id 
WHERE  price - royalty < 0;


-- Calculad el promedio de titulos vendidos por factura y tienda y el promedio de la cantidad de libros vendidos por factura

SELECT stor_name , round(titulos/facturas, 0)  as media_libros_factura, cantidad/facturas as avgqty FROM 
(SELECT stor_name, sum(qty) as cantidad, count(distinct ord_num) as facturas , count(t.title_id)  as titulos
FROM sales s 
INNER JOIN titles t ON s.title_id = t.title_id 
INNER JOIN stores st ON s.stor_id = st.stor_id 
GROUP BY stor_name) as average;

-- Cuanto ha vendido cada editorial por año?

SELECT YEAR(pubdate) as años,  pub_name , AVG(price) as precio_medio_libros from titles as t
	INNER JOIN publishers as p ON t.pub_id = p.pub_id 
	WHERE price IS NOT NULL 
	GROUP BY YEAR(pubdate), pub_name
	ORDER BY pub_name ; 


-- seleccionamos aquello libros que hayan sido vendidos por editoriales que tengan empleados que hayan sido contratados entre 1990 y 1992

select * from titles t 
where pub_id IN 
	(select DISTINCT pub_id from employee e 
	where year(hire_date) BETWEEN 1990 AND 1992);
    
-- selecciona aquellos libros donde de aquellas editoriales que tengan diseñadores 
select * from titles t 
WHERE pub_id IN(
	select DISTINCT e.pub_id  -- seleccionamos las editoriales que tienen diseñadores
	FROM jobs j 
	INNER JOIN employee e ON j.job_id = e.job_id 
	WHERE job_desc LIKE "%Des%")
