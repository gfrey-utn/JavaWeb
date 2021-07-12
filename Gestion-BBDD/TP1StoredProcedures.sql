-- TP 1: Stored Procedures - Gastón Rey
use negocioWebRopa;
set sql_safe_updates = 0;

-- Borrado de Procedimientos Anteriores
drop procedure if exists SP_Articulos_Insert_Min;
drop procedure if exists SP_Articulos_Insert_Full;
drop procedure if exists SP_Articulos_Delete;
drop procedure if exists SP_Articulos_Update;
drop procedure if exists SP_Articulos_All;
drop procedure if exists SP_Articulos_Reponer;

drop procedure if exists SP_Facturas_Insert;
drop procedure if exists SP_Facturas_Delete;
drop procedure if exists SP_Facturas_Update;
drop procedure if exists SP_Facturas_All;
drop procedure if exists SP_Facturas_AgregarDetalle;

drop procedure if exists SP_Detalles_Delete;
drop procedure if exists SP_Detalles_All;

-- Tabla Artículos

delimiter //
	create procedure SP_Articulos_Insert_Min(Pdescripcion varchar(25))
    begin
		insert into articulos (descripcion) values (Pdescripcion); 
    end
// delimiter ;

delimiter //
	create procedure SP_Articulos_Insert_Full(Pdescripcion varchar(25), Ptipo enum('CALZADO','ROPA'),
		Pcolor varchar(20), Ptalle_num varchar(20), Pstock int, PstockMin int, PstockMax int,
        Pcosto double, Pprecio double, Ptemporada enum('VERANO','OTOÑO','INVIERNO'))
    begin
		insert into articulos (descripcion, tipo, color, talle_num, stock, stockMin, stockMax,
			costo, precio, temporada) values (Pdescripcion, Ptipo, Pcolor, Ptalle_num, Pstock,
            PstockMin, PstockMax, Pcosto, Pprecio, Ptemporada);
    end
// delimiter ;

delimiter //
	create procedure SP_Articulos_Delete(Pid int)
    begin
		delete from articulos where id = Pid;
    end
// delimiter ;

delimiter //
	create procedure SP_Articulos_Update(Pid int, Pdescripcion varchar(25), Ptipo enum('CALZADO','ROPA'),
		Pcolor varchar(20), Ptalle_num varchar(20), Pstock int, PstockMin int, PstockMax int,
        Pcosto double, Pprecio double, Ptemporada enum('VERANO','OTOÑO','INVIERNO'))
    begin
		update articulos set descripcion = Pdescripcion, tipo = Ptipo, color = Pcolor,
			talle_num = Ptalle_num, stock = Pstock, stockMin = PstockMin, stockMax = pStockMax,
            costo = Pcosto, precio = Pprecio, temporada = Ptemporada where id = Pid;
    end
// delimiter ;

delimiter //
	create procedure SP_Articulos_All()
    begin
		select * from articulos;
    end
// delimiter ;

delimiter //
	create procedure SP_Articulos_Reponer(Pid int)
    begin
		update articulos set stock = stockMax where id = Pid;
    end
// delimiter ;

-- Tabla Facturas

delimiter //
	create procedure SP_Facturas_Insert(Pletra enum('A','B','C'), Pnumero int, Pfecha date,
			PmedioDePago enum('EFECTIVO','DEBITO','TARJETA'), PidCliente int)
    begin
		insert into facturas (letra, numero, fecha, medioDePago, idCliente) values
        (Pletra, Pnumero, Pfecha, PmedioDePago, PidCliente);
    end
// delimiter ;

delimiter //
	create procedure SP_Facturas_Delete(Pletra enum('A','B','C'), Pnumero int)
    begin
		delete from facturas where letra = Pletra and numero = Pnumero;
    end
// delimiter ;

delimiter //
	create procedure SP_Facturas_Update(Pid int, Pletra enum('A','B','C'), Pnumero int,
		Pfecha date, PmedioDePago enum('EFECTIVO','DEBITO','TARJETA'), PidCliente int)
    begin
		update facturas set letra = Pletra, numero = Pnumero, fecha = Pfecha,
			medioDePago = PmedioDePago, idCliente = PidCliente where id = Pid;
    end
// delimiter ;

delimiter //
	create procedure SP_Facturas_All()
    begin
		select * from facturas;
    end
// delimiter ;

delimiter //
	create procedure SP_Facturas_AgregarDetalle(PidFactura int, PidArticulo int, Pprecio float, Pcantidad int)
    begin
		insert into detalles (idArticulo, idFactura, precio, cantidad) values (PidArticulo, PidFactura,
        Pprecio, Pcantidad);
    end
// delimiter ;

-- Tabla Detalles

delimiter //
	create procedure SP_Detalles_Delete(PidArticulo int, PidFactura int)
    begin
		delete from detalles where idArticulo = PidArticulo and idFactura = PidFactura;
    end
// delimiter ;

delimiter //
	create procedure SP_Detalles_All()
    begin
		select * from detalles;
    end
// delimiter ;

-- Testeo de Calls
call SP_Articulos_Insert_Min('Barbijo');
call SP_Articulos_Insert_Full('Barbijo', 'ROPA', 'Blanco', '', 80, 50, 200, 100, 120, 'INVIERNO');
call SP_Articulos_Delete(4);
call SP_Articulos_Update(8, 'Botas', 'CALZADO', 'Rojo', '38', 20, 10, 30, 500, 650, 'INVIERNO');
call SP_Articulos_All();
call SP_Articulos_Reponer(8);

call SP_Facturas_Insert('A', 12, curdate(), 'EFECTIVO', 1);
call SP_Facturas_Delete('A', 8);
call SP_Facturas_Update(5, 'C', 3, curdate(), 'TARJETA', 10);
call SP_Facturas_All();
call SP_Facturas_AgregarDetalle(7, 10, 200, 4);

call SP_Detalles_Delete(2, 3);
call SP_Detalles_All();
