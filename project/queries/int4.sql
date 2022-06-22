.mode column
.header on
.nullvalue Null

select Dia, max(NumeroClientes) as NumeroClientesMax
from (select Dia, Numero, count(Numero) as NumeroClientes
    from Bilhete
    group by Numero, Dia) G;