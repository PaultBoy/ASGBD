create database pablo;
use pablo;
create table vinyas(
id int primary key,
Nombre varchar(255)
);
-- Esta sintaxis es especialmene útil para poder cambiar el nombre de la tabla
alter table vinyas
rename to users;
