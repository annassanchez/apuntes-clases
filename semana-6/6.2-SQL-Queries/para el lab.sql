select type, case
	when royalty < 15 then "bajo"
    when royalty = 15 then "medio"
	else "alto"
    end as hola
from titles;

select type, case
	when royalty < 15 then "bajo"
    when royalty = 15 then "medio"
    when royalty IS NULL then royaltys
	else "alto"
    end as hola
from titles;