.mode column
.header on
.nullvalue Null

-- os clientes que foram à ultima sessão
create view if not exists int2V as
select IdCliente, Bilhete.HoraInicio as HoraInicio, Bilhete.HoraFim as HoraFim, Bilhete.Dia as Dia, NomeFilme
from Bilhete join Sessao
on Bilhete.HoraInicio = Sessao.HoraInicio and Bilhete.HoraFim = Sessao.HoraFim and Bilhete.Dia = Sessao.Dia
where NomeFilme = 'EndGame';

select Nome, max(Idade) as Idade, Telemovel, NomeFilme
from Cliente join int2V
on Cliente.IdCliente == int2V.IdCliente
where HoraInicio in (
    select max(HoraInicio)
    from int2V);


Drop view if exists int2V;