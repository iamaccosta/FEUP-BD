.mode column
.header on
.nullvalue Null

select NomeFilme, Ano
from Filme F1
where not exists (select * 
                from Filme F2 
                where F2.Ano > F1.Ano)
union
select NomeFilme, Ano
from Filme F1
where not exists (select * 
                from Filme F2 
                where F2.Ano < F1.Ano)
order by Ano desc;