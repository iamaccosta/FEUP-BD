PRAGMA FOREIGN_KEYS = ON;
.mode column
.header on
.nullvalue Null

Drop table if exists Cartaz;
create table Cartaz(
    IdCartaz INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    CapaUCI TEXT DEFAULT 'UCI'
);

Drop table if exists Filme;
create table Filme(
    NomeFilme TEXT NOT NULL,
    Ano DATE NOT NULL,
    IdadeMinima NUMBER DEFAULT 4,
    Duracao TIME NOT NULL,
    Descricao TEXT NOT NULL,
    IdCartaz INTEGER NOT NULL REFERENCES Cartaz ON UPDATE CASCADE ON DELETE CASCADE, 
    PRIMARY KEY(NomeFilme, Ano),
    CHECK(IdadeMinima >= 4),
    CHECK(Duracao > 0),
    UNIQUE(NomeFilme, Ano)
);

Drop table if exists Categoria;
create table Categoria(
    NomeCategoria TEXT PRIMARY KEY NOT NULL
);

Drop table if exists Sala;
create table Sala(
    Numero NUMBER PRIMARY KEY NOT NULL,
    CHECK(Numero >= 1 AND Numero <= 30)
);

Drop table if exists Sessao;
create table Sessao(
    HoraInicio TIME NOT NULL,
    HoraFim TIME NOT NULL,
    Dia NUMBER,
    Numero NUMBER NOT NULL REFERENCES Sala ON UPDATE CASCADE ON DELETE CASCADE,
    NomeFilme TEXT NOT NULL,
    Ano DATE NOT NULL,
    PRIMARY KEY(HoraInicio, HoraFim, Dia, Numero),
    FOREIGN KEY(NomeFilme, Ano) REFERENCES Filme ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK(HoraInicio < HoraFim),
    CHECK(HoraFim <= '23:59:59'),
    CHECK(Dia > 0 AND Dia <= 31)
);

Drop table if exists Lugar;
create table Lugar(
    IdLugar INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Linha NUMBER NOT NULL,
    Coluna NUMBER NOT NULL,
    Numero NUMBER NOT NULL REFERENCES Sala ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK(Linha > 0 AND Linha <= 20),
    CHECK(Coluna > 0 AND Coluna <= 20)
);

Drop table if exists Pessoa;
create table Pessoa(
    Nome TEXT NOT NULL,
    Idade NUMBER NOT NULL,
    Morada TEXT NOT NULL,
    Sexo CHAR(1) NOT NULL,
    PRIMARY KEY(Nome, Idade, Morada),
    CHECK(Idade > 0),
    CHECK(Sexo = 'M' OR Sexo = 'F')
);

Drop table if exists Ator;
create table Ator(
    Nome TEXT NOT NULL,
    Idade NUMBER NOT NULL,
    Morada TEXT NOT NULL,
    Papel TEXT DEFAULT 'Figurante',
    FOREIGN KEY(Nome, Idade, Morada) REFERENCES Pessoa ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(Nome, Idade, Morada),
    CHECK(Papel = 'Papel Principal' OR Papel = 'Papel Secundario' OR Papel = 'Figurante')
);

Drop table if exists Cliente;
create table Cliente(
    IdCliente INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Nome TEXT NOT NULL,
    Idade NUMBER NOT NULL,
    Morada TEXT NOT NULL,
    Telemovel CHAR(9) NOT NULL,
    FOREIGN KEY(Nome, Idade, Morada) REFERENCES Pessoa ON UPDATE CASCADE ON DELETE CASCADE,
    UNIQUE (Telemovel)
);

Drop table if exists Bilhete;
create table Bilhete(
    IdBilhete INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    Preco FLOAT DEFAULT 5.00,
    HoraInicio TIME NOT NULL,
    HoraFim TIME NOT NULL,
    Dia NUMBER,
    Numero NUMBER NOT NULL,
    IdLugar INTEGER NOT NULL REFERENCES Lugar ON UPDATE CASCADE ON DELETE CASCADE,
    IdCliente INTEGER NOT NULL REFERENCES Cliente ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(HoraInicio, HoraFim, Dia, Numero) REFERENCES Sessao ON UPDATE CASCADE ON DELETE CASCADE,
    CHECK(Preco = 5.00)
);

Drop table if exists Menu;
create table Menu(
    Tamanho TEXT PRIMARY KEY DEFAULT 'Pequeno',
    Preco FLOAT DEFAULT 3.00,
    CHECK(Tamanho = 'Pequeno' OR Tamanho = 'Medio' OR Tamanho = 'Grande'),
    CHECK((Preco = 3.00 AND Tamanho = 'Pequeno') OR (Preco = 5.00 AND Tamanho = 'Medio') OR (Preco = 7.00 AND Tamanho = 'Grande'))
);

Drop table if exists FilmeCategoria;
create table FilmeCategoria(
    NomeFilme TEXT NOT NULL,
    Ano DATE NOT NULL,
    NomeCategoria TEXT NOT NULL REFERENCES Categoria ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(NomeFilme, Ano) REFERENCES Filme ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(NomeFilme, Ano, NomeCategoria)
);

Drop table if exists FilmeAtor;
create table FilmeAtor(
    NomeFilme TEXT NOT NULL,
    Ano DATE NOT NULL,
    Nome TEXT NOT NULL,
    Idade NUMBER NOT NULL,
    Morada TEXT NOT NULL,
    FOREIGN KEY(NomeFilme, Ano) REFERENCES Filme ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(Nome, Idade, Morada) REFERENCES Ator ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(NomeFilme, Ano, Nome, Idade, Morada)
);

Drop table if exists FilmeCliente;
create table FilmeCliente(
    NomeFilme TEXT,
    Ano DATE,
    IdCliente INTEGER NOT NULL REFERENCES Cliente ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY(NomeFilme, Ano) REFERENCES Filme ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(NomeFilme, Ano, IdCliente)
);

Drop table if exists ClienteMenu;
create table ClienteMenu(
    IdCliente INTEGER NOT NULL REFERENCES Cliente ON UPDATE CASCADE ON DELETE CASCADE,
    Tamanho TEXT DEFAULT 'Pequeno' REFERENCES Menu ON UPDATE CASCADE ON DELETE CASCADE,
    PRIMARY KEY(IdCliente, Tamanho)
);