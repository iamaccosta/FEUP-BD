PRAGMA FOREIGN_KEYS = ON;
.mode column
.header on
.nullvalue Null

select * from Bilhete order by HoraInicio;

insert into Bilhete (Preco, HoraInicio, HoraFim, Dia, Numero, IdLugar, IdCliente) values(5.00, '21:15', '23:34:59', 06, 01, 01, 2);

select * from Bilhete order by HoraInicio;