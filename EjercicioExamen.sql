Delimiter $$

create procedure EliminarEscritor (D varchar(10))
begin
	declare Id, L int;
    declare semaforo int default 0;
    declare C cursor for select IdLibro from Libros, Escrito where Libros.IdLibro = Escrito.IdLibro and Escrito.IdEscritor = id;
    set semaforo = 0;
    select IdEscritor into Id from Escritor where DNI = D;
    open C;
    mientras:while semaforo = 0 do
		fetch C into L;
		if semaforo = 1 then
			leave mientras;
        end if;
        call EliminarLibro(L);
        call EliminarRelacion(L);
    end while;
    close c;
end
$$
create function mayorDeTres(a int, b int, c int)
returns int
begin
	declare numMayor int default 0;
    if (a >= numMayor) then
		set numMayor = a;
	end if;
	if (b >= numMayor) then
		set numMayor = b;
	end if;
	if (c >= numMayor) then
		set numMayor = c;
	end if;
    return numMayor;
end$$

create procedure AnadirLibro (T varchar(10), Np int,D varchar)
begin
	select IdEscritor into Id from Escritor where DNI=D;
    insert into Libros(TiTulo,Npaginas) values (T,Np);
    select IdLibro into IdL from Libros where Titulo=T;
    call crearrelacion(Id, IdL);
    insert into Escrito(IdEscritor,IdLibro) values (Id, Id1);
end