.mode column
.header on
.nullvalue Null

create view if not exists int9V as
select Numero, max(NumeroLugaresOcupados)
from (select *, count(Numero) as NumeroLugaresOcupados
    from Bilhete
    where Dia = 14
    group by Numero);

select distinct IdLugar, Linha, Coluna, Lugar.Numero as NumeroSala
from (Lugar natural join Sessao) natural join int9V;

Drop view if exists int9V;