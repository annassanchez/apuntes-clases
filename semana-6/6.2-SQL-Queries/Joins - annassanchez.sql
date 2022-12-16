select *
from publishers
inner join employee
on publishers.pub_id = employee.pub_id
;

select concat(fname, " ", lname) as nombre_completo, pub_name 
from publishers
inner join employee
on publishers.pub_id = employee.pub_id
;

select concat(fname, " ", lname) as nombre_completo, pub_name, employee.pub_id
from publishers
inner join employee
on publishers.pub_id = employee.pub_id
;

-- es como un inner join suponiendo que las columnas para matchear se llaman igual
select *
from publishers
natural join employee
;

select *
from publishers
left join employee
on publishers.pub_id = employee.pub_id
;

select *
from publishers
right join employee
on publishers.pub_id = employee.pub_id
;

select *
from titles
natural join sales
natural join stores
;

select stor_name, title
from titles
inner join sales
on titles.title_id = sales.title_id
inner join stores
on stores.stor_id = stores.stor_id
;

select stor_name, title
from authors
natural join titleauthor
natural join titles
natural join sales
natural join stores
natural join discounts
;

