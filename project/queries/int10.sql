.mode column
.header on
.nullvalue Null

select NomeFilme, count(NomeFilme) as NumeroCategorias
from FilmeCategoria
group by NomeFilme
union
select NomeFilme, 0
from Filme
where NomeFilme not in (select NomeFilme from FilmeCategoria)
order by NumeroCategorias desc;