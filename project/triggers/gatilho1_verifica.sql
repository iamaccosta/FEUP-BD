PRAGMA FOREIGN_KEYS = ON;
.mode column
.header on
.nullvalue Null

select NomeFilme, Ano, IdCartaz from Filme order by Ano desc;

update Filme set IdCartaz = 3 where NomeFilme = 'IT';
update Filme set IdCartaz = 3 where NomeFilme = 'Pitch Perfect';

select NomeFilme, Ano, IdCartaz from Filme order by Ano desc;