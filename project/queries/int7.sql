.mode column
.header on
.nullvalue Null

create view if not exists int7V as
select IdCliente, count(IdCliente) as IdasAoCinema, Preco*count(IdCliente) as PrecoBilhetes
from Bilhete
group by IdCliente;

select IdCliente, IdasAoCinema, Preco*IdasAoCinema + PrecoBilhetes as 'PrecoTotalGasto ($)'
from (ClienteMenu natural join Menu) natural join int7V;

Drop view if exists int7V;