.mode column
.header on
.nullvalue Null

select Nome, Idade, Tamanho
from Cliente, ClienteMenu
where Cliente.IdCliente = ClienteMenu.IdCliente and Nome like 'Ma%' and Tamanho = 'Medio';