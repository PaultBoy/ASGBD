Delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `recorrer_nombres`()
BEGIN
	declare nombre_cli varchar(255) default '';
    declare cod_cli int default 0;
    declare encontrado boolean default 1;
    declare nom cursor for select nombre, codigo_cliente from clientes;
    declare continue handler for not found set encontrado = false;
    open nom;
    while encontrado = true do
		fetch nom into nombre_cli, cod_cli;
        if cod_cli >= 2 then
			update clientes
			set nombre = concat(nombre_cli,"-",cod_cli) where nombre = nombre_cli;
		end if;
	end while;
END
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `recorrer_nombre_sin_cursor`()
BEGIN
	declare numfilas int default (Select count(*) from clientes);
    declare cod int default 1;
    declare nombres varchar(255) default '';
    while cod <= numfilas do
		if cod >= 2 then
			set nombres = (select nombre from clientes where codigo_cliente = cod);
			update clientes
            set nombre = concat(nombres,"-",cod) where codigo_cliente = cod;
        end if;
        set cod = cod + 1;
    end while;
END
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor1`()
BEGIN
	declare id_noticia int;
    declare contador int default 1;
    declare Ctitulo varchar(255);
    declare Cfecha date;
    declare Cautor varchar(255);
    -- Cursor: conjunto de datos recogidos en forma de tabla de una consulta
	declare cursor1 cursor for select autores.login, noticias.id, noticias.titulo, noticias.fecha_pub from noticias join autores on noticias.autor_id = autores.id_autor where autores.login not like "%3";
    set id_noticia = 152;
    open cursor1;
    -- Fetch almacena la información de un registro del cursor por cada ejecución del comando
    while contador <= 10 do
		fetch cursor1 into Cautor,id_noticia, Ctitulo, Cfecha;
		select Cautor, id_noticia, Ctitulo, Cfecha;
        set contador = contador + 1;
	end while;
    close cursor1;
END
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor1_version2`()
BEGIN
	declare id_noticia int;
    declare contador int default 1;
    declare Ctitulo varchar(255);
    declare Cfecha date;
    declare Cautor int;
    declare nombre varchar(45);
    -- Cursor: conjunto de datos recogidos en forma de tabla de una consulta
	declare cursor1 cursor for select id, titulo, fecha_pub from noticias;
    set id_noticia = 152;
    open cursor1;
    -- Fetch almacena la información de un registro del cursor por cada ejecución del comando
    while contador <= 10 do
		fetch cursor1 into id_noticia,Cautor, Ctitulo, Cfecha;
        select login into nombre from autores where id_autor=Cautor;
		select id_noticia,nombre, Ctitulo, Cfecha;
        set contador = contador + 1;
	end while;
    close cursor1;
END
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `nombre`()
BEGIN
	declare nombre_cli varchar(255);
    declare fecha_cre date;
    declare dinero int;
    declare cuenta int;
    declare fin bool default false;
    declare cuentas cursor for select nombre, cod_cuenta, fecha_creacion, saldo from clientes join cuentas on clientes.codigo_cliente = cuentas.cod_cliente;
    declare continue handler for not found set fin = true;
    open cuentas;
	while fin = false do
		fetch cuentas into nombre_cli, cuenta, fecha_cre, dinero;
        select nombre_cli,cuenta,fecha_cre,dinero;
    end while;
    close cuentas;
END
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor1_version2`()
BEGIN
	declare id_noticia int;
    declare contador int default 1;
    declare Ctitulo varchar(255);
    declare Cfecha date;
    declare Cautor varchar(255);
    declare idAut int;
    -- Cursor: conjunto de datos recogidos en forma de tabla de una consulta
	declare cursor1 cursor for select autores.id_autor,autores.login, noticias.id, noticias.titulo, noticias.fecha_pub from noticias join autores on noticias.autor_id = autores.id_autor;
    set id_noticia = 152;
    open cursor1;
    -- Fetch almacena la información de un registro del cursor por cada ejecución del comando
    while contador <= 10 do
		fetch cursor1 into idAut,Cautor,id_noticia, Ctitulo, Cfecha;
        if Cautor not like "%3" then
			select idAut,Cautor, id_noticia, Ctitulo, Cfecha;
             set contador = contador + 1;
		end if;
	end while;
    close cursor1;
END
$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor1_version3`()
BEGIN
	declare id_noticia int;
    declare contador int default 1;
    declare Ctitulo varchar(255);
    declare Cfecha date;
    declare Cautor varchar(255);
    declare idAut int;
    declare semaforo bool default 0;
    -- Cursor: conjunto de datos recogidos en forma de tabla de una consulta
	declare cursor1 cursor for select autores.id_autor,autores.login, noticias.id, noticias.titulo, noticias.fecha_pub from noticias join autores on noticias.autor_id = autores.id_autor;
    declare continue handler for not found set semaforo = 1;
    set id_noticia = 152;
    open cursor1;
    -- Fetch almacena la información de un registro del cursor por cada ejecución del comando
    Loop1: while contador <= 10000 do
		fetch cursor1 into idAut,Cautor,id_noticia, Ctitulo, Cfecha;
        if semaforo=1 then
			leave Loop1;
		end if;
        if Cautor not like "%3" then
			select idAut,Cautor, id_noticia, Ctitulo, Cfecha;
             set contador = contador + 1;
		end if;
	end while;
    close cursor1;
END
$$
Delimiter $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cursor1_version3`()
BEGIN
	declare id_noticia int;
    declare contador int default 1;
    declare Ctitulo varchar(255);
    declare Cfecha date;
    declare Cautor varchar(255);
    declare idAut int;
    declare semaforo bool default 0;
    declare suma int default 0;
    -- Cursor: conjunto de datos recogidos en forma de tabla de una consulta
	declare cursor1 cursor for select autores.id_autor,autores.login, noticias.id, noticias.titulo, noticias.fecha_pub from noticias join autores on noticias.autor_id = autores.id_autor;
    declare continue handler for not found set semaforo = 1;
    set id_noticia = 152;
    open cursor1;
    -- Fetch almacena la información de un registro del cursor por cada ejecución del comando
    Loop1: loop
		fetch cursor1 into idAut,Cautor,id_noticia, Ctitulo, Cfecha;
        if semaforo=1 then
			leave Loop1;
		end if;
       if Cautor not like "%3" then
			-- select idAut,Cautor, id_noticia, Ctitulo, Cfecha;
			set contador = contador + 1;
		end if;
		if semaforo=1 then
			leave Loop1;
		end if;
	end loop Loop1;
    select contador;
    close cursor1;
END
$$
Create procedure cursor_demo5()
begin
	declare tmp varchar(200);
    declare lrf bool;
    declare cuenta int;
    declare cursor2 cursor for select titulo from noticias;
    declare continue handler for not found set lrf=1;
    set lrf=0;
    set cuenta = 0;
    Open cursor2;
    l_cursor: While(lrf=0) do
		fetch cursor2 into tmp;
		set cuenta = cuenta + 1;
        if lrf=1 then
			leave l_cursor;
		end if;
	end while l_cursor;
    close cursor2;
    select cuenta;
end;
$$
create procedure noticias_autor() 
BEGIN 
	declare vautor int;
	declare na_count int;
    declare fin bool;
    declare autor_cursor cursor for select id_autor from autores;
    declare noticia_cursor cursor for select autor_id from noticias where autor_id = vautor;
    declare continue handler for not found set fin = 1;
    set na_count=0;
    open autor_cursor;
    autor_loop: LOOP
		fetch autor_cursor into vautor;
        if fin=1 then
			leave autor_loop;
		end if;
        open noticia_cursor;
        set na_count=0;
        noticias_loop:LOOP
			fetch noticia_cursor into vautor;
            if fin=1 then
				leave autor_loop;
			end if;
            set na_count=na_count+1;
		end loop noticias_loop;
        close noticia_cursor;
        set fin = 0;
        select concat('El autor ',vautor,' tiene ',na_count,' noticias ');
	end loop autor_loop;
    close autor_cursor;
end;
$$