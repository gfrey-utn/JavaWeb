-- TP 2: Triggers - Gastón Rey
use negocioWebRopa;

-- Borrado de Triggers Anteriores
drop trigger if exists TR_Clientes_Insert;
drop trigger if exists TR_Clientes_Update;
drop trigger if exists TR_Clientes_Delete;
drop trigger if exists TR_Articulos_Insert;
drop trigger if exists TR_Articulos_Update;
drop trigger if exists TR_Articulos_Delete;
drop trigger if exists TR_Facturas_Insert;
drop trigger if exists TR_Facturas_Update;
drop trigger if exists TR_Facturas_Delete;
drop trigger if exists TR_Detalles_Insert;
drop trigger if exists TR_Detalles_Update;
drop trigger if exists TR_Detalles_Delete;

-- Tabla Clientes

delimiter //
create trigger TR_Clientes_Insert
	after insert on clientes
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Clientes', 'INSERT', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Clientes_Update
	after update on clientes
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Clientes', 'UPDATE', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Clientes_Delete
	before delete on clientes
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Clientes', 'DELETE', curdate(), curtime(), current_user(), OLD.id);
    end;
// delimiter ;

-- Tabla Articulos

delimiter //
create trigger TR_Articulos_Insert
	after insert on articulos
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Articulos', 'INSERT', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Articulos_Update
	after update on articulos
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Articulos', 'UPDATE', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Articulos_Delete
	before delete on articulos
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Articulos', 'DELETE', curdate(), curtime(), current_user(), OLD.id);
    end;
// delimiter ;

-- Tabla Facturas

delimiter //
create trigger TR_Facturas_Insert
	after insert on facturas
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Facturas', 'INSERT', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Facturas_Update
	after update on facturas
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Facturas', 'UPDATE', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Facturas_Delete
	before delete on facturas
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Facturas', 'DELETE', curdate(), curtime(), current_user(), OLD.id);
    end;
// delimiter ;

-- Tabla Detalles

delimiter //
create trigger TR_Detalles_Insert
	after insert on detalles
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Detalles', 'INSERT', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Detalles_Update
	after update on detalles
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Detalles', 'UPDATE', curdate(), curtime(), current_user(), NEW.id);
    end;
// delimiter ;

delimiter //
create trigger TR_Detalles_Delete
	before delete on detalles
    for each row
    begin
		insert into control (tabla, accion, fecha, hora, usuario, idRegistro)
			values ('Detalles', 'DELETE', curdate(), curtime(), current_user(), OLD.id);
    end;
// delimiter ;

select * from control; -- Tabla de control

-- Testeo con sentencias DML (y procedures)
insert into clientes (nombre, apellido) values ('Lionel', 'Scaloni');
update clientes set apellido = "Messi" where id = 10;
delete from clientes where id = 20;

call SP_Articulos_Insert_Min("Camiseta");
call SP_Articulos_Update(13, 'Gorra', 'ROPA', 'Celeste', '', 50, 50, 200, 120, 250, 'INVIERNO');
call SP_Articulos_Delete(14);

call SP_Facturas_Insert('A', 16, curdate(), 'DEBITO', 17);
call SP_Facturas_Update(6, 'C', 2, curdate(), 'DEBITO', 8);
call SP_Facturas_Delete('B', 10);

call SP_Facturas_AgregarDetalle(6, 15, 250, 6);
update detalles set cantidad = 7 where id = 5;
call SP_Detalles_Delete(3, 3);
