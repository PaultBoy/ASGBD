select * from clientes join movimientos 
on clientes.dni=movimientos.dni;
insert into ebanca.kk values(1,'pepe');
update kk set nombre='juan' where nombre='pepe';
delete from ebanca.kk where id=1;
select * from ebanca.clientes;