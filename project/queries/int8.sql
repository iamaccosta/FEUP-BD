.mode column
.header on
.nullvalue Null

select FC1.NomeFilme, FC2.NomeFilme, FC1.NomeCategoria
from FilmeCategoria FC1, FilmeCategoria FC2
where FC1.NomeFilme > FC2.NomeFilme and FC1.NomeCategoria = FC2.NomeCategoria
order by FC1.NomeCategoria;