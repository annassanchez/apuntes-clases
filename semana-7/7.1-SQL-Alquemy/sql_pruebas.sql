SELECT authors.au_id AS author_ID, authors.au_lname AS last_name,  
authors.au_fname AS first_name, 
CASE
	WHEN sum(sales.qty) IS NULL THEN 0
	ELSE sum(sales.qty)
    END AS total
FROM authors
LEFT JOIN titleauthor
ON authors.au_id = titleauthor.au_id
LEFT JOIN titles
ON titles.title_id = titleauthor.title_id
LEFT JOIN sales
ON titles.title_id = sales.title_id
GROUP BY authors.au_id
ORDER BY max(sales.qty) DESC
;
-- libros más vendidos por tienda
-- cantidad de libros, nombre de la tienda, nombre del libro
SELECT title, stor_name, qty
FROM sales
INNER JOIN stores
ON stores.stor_id = sales.stor_id
INNER JOIN titles
ON titles.title_id = sales.title_id

SELECT title, stor_name, sum(qty) as total_sales
FROM sales
INNER JOIN stores
ON stores.stor_id = sales.stor_id
INNER JOIN titles
ON titles.title_id = sales.title_id
GROUP BY stor_name, titles.title_id
ORDER BY sum(qty) DESC, stor_name


SELECT title, stor_name, max(sum(qty)) as total_sales
FROM sales
INNER JOIN stores
ON stores.stor_id = sales.stor_id
INNER JOIN titles
ON titles.title_id = sales.title_id
GROUP BY stor_name, titles.title_id