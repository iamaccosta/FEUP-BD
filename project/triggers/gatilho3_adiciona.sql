PRAGMA FOREIGN_KEYS = ON;
.mode column
.header on
.nullvalue Null

create trigger if not exists ConfirmLugarBilhete
after insert on Bilhete
For each row
when exists (select * from Bilhete where Dia=new.Dia And HoraInicio=new.HoraInicio And HoraFim=new.HoraFim And Numero=new.Numero And IdLugar=new.IdLugar)
Begin
    select raise(rollback,"Lugar Ocupado.");
End;
