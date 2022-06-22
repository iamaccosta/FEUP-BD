PRAGMA FOREIGN_KEYS = ON;
.mode column
.header on
.nullvalue Null

drop view if exists NumeroSessoesFilme;

create view if not exists NumeroSessoesFilme as
select NomeFilme, Dia, count(NomeFilme) as NumeroSessoes
from Sessao
group by NomeFilme, Dia
order by NumeroSessoes desc;

create trigger if not exists ConfirmNumeroSessoes
before insert on Sessao
For each row
when exists (select * from NumeroSessoesFilme where NumeroSessoes = 3)
BEGIN
    select raise(abort,"Chegou ao número máximo de Sessões nesse dia");
End;
