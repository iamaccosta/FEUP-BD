PRAGMA FOREIGN_KEYS = ON;
.mode column
.header on
.nullvalue Null

create trigger if not exists ChangeIdCartaz
before update of IdCartaz on Filme
when (old.Ano > '2016:12:31' and new.IdCartaz = 3)
begin
    select raise(abort, "O Filme ainda é recente.");
end;