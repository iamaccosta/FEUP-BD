.mode column
.header on
.nullvalue Null

select Filme.NomeFilme, FilmeAtor.Nome
from Filme natural join FilmeAtor
order by Filme.NomeFilme;