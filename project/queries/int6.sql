.mode column
.header on
.nullvalue Null

select IdCliente, Nome
from Cliente C1
where C1.IdCliente in (
    select IdCliente
    from FilmeCliente
    where NomeFilme = "EndGame"
    intersect
    select IdCliente
    from FilmeCliente
    where NomeFilme = "Spider-Man: NO WAY HOME");

