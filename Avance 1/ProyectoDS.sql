CREATE DATABASE proyectoDS;

	USE proyectoDS;

	CREATE TABLE TipoUsuario(
		idTipo int NOT NULL AUTO_INCREMENT,
        Nombre nvarchar(50) NOT NULL UNIQUE,
        PRIMARY KEY (idTipo)
	);
    
	CREATE TABLE Usuarios(
		idUsuario int AUTO_INCREMENT NOT NULL, 
        Contraseña nvarchar(25) NOT NULL,
        idTipo int NOT NULL,
        Nombres nvarchar(30) DEFAULT NULL,
        Apellidos nvarchar(30) DEFAULT NULL,
        Cedula nvarchar(10) UNIQUE NOT NULL,
        FechaNacimiento date DEFAULT NULL,
        Profesion nvarchar(30) DEFAULT NULL,
        Correo nvarchar(35) DEFAULT NULL,
        PRIMARY KEY (idUsuario),
        FOREIGN KEY (idTipo)  REFERENCES TipoUsuario(idTipo)
	);
    
    CREATE TABLE Marcas(
		idMarca int NOT NULL AUTO_INCREMENT,
        Nombre nvarchar(35) NOT NULL UNIQUE,
        PRIMARY KEY (idMarca)
	);
    
    CREATE TABLE TipoArticulo(
		idTipoArt int NOT NULL AUTO_INCREMENT,
        Nombre nvarchar(50) NOT NULL UNIQUE,
        PRIMARY KEY (idTipoArt)
	);
    
    CREATE TABLE Articulos(
		idArticulo int NOT NULL AUTO_INCREMENT,
        NombreModelo nvarchar(45) NOT NULL,
        idTipoArticulo int NOT NULL,
        idMarca int NOT NULL,
        Precio float NOT NULL,
        PRIMARY KEY (idArticulo),
        FOREIGN KEY (idTipoArticulo) REFERENCES TipoArticulo(idTipoArt),
        FOREIGN KEY (idMarca) REFERENCES Marcas(idMarca)
	);
    
    CREATE TABLE Clientes(
		idCliente int NOT NULL AUTO_INCREMENT,
        Nombre nvarchar(60) DEFAULT NULL,
        Direccion nvarchar(50) DEFAULT NULL,
        Correo nvarchar(35) DEFAULT NULL,
        Telefono nvarchar(20) DEFAULT NULL,
        PRIMARY KEY (idCliente)
	);
	
    CREATE TABLE CLientePersona(
		idClientePersona nvarchar(10) NOT NULL UNIQUE, #cédula de identidad de la persona
        idCliente int NOT NULL,
        PRIMARY KEY (idClientePersona),
        FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
	);
    
    CREATE TABLE ClienteEmpresa(
		idClienteEmpresa nvarchar(13) NOT NULL UNIQUE, #RUC de la empresa
        idCliente int NOT NULL,
        PRIMARY KEY (idClienteEmpresa),
        FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
	);
    
    CREATE TABLE Proveedores(
		idProveedor int NOT NULL AUTO_INCREMENT,
        Nombre nvarchar(50) NOT NULL,
        PRIMARY KEY (idProveedor)
	);
    
    CREATE TABLE TipoPago(
		idTipo int NOT NULL AUTO_INCREMENT,
        Tipo nvarchar(30) NOT NULL,
        PRIMARY KEY (idTipo)
	);
    
    CREATE TABLE Cotizacion(
		idCotizacion int NOT NULL AUTO_INCREMENT,
        Descripcion text DEFAULT NULL,
        idCliente int NOT NULL,
        idUsuario int NOT NULL,
        Fecha date NOT NULL,
        PRIMARY KEY (idCotizacion),
        FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
        FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
	);
    
    CREATE TABLE DescripcionCotizacion(
		idDescripcion int NOT NULL AUTO_INCREMENT,
        idCotizacion int NOT NULL,
        idArticulo int NOT NULL,
        Cantidad int NOT NULL,
        Total float NOT NULL,
        PRIMARY KEY (idDescripcion),
        FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo),
        FOREIGN KEY (idCotizacion) REFERENCES Cotizacion(idCotizacion)
	);
    
    CREATE TABLE Ventas(
		idVenta int NOT NULL AUTO_INCREMENT,
        Descripcion text DEFAULT NULL,
        idCliente int NOT NULL,
        idUsuario int NOT NULL,
        idTipoPago int NOT NULL,
        Fecha date NOT NULL,
        PRIMARY KEY (idVenta),
        FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente),
        FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
        FOREIGN KEY (idTipoPago) REFERENCES TipoPago(idTipo)
	);
    
    CREATE TABLE DescripcionVenta(
		idDescripcion int NOT NULL AUTO_INCREMENT,
        idVenta int NOT NULL,
        idArticulo int NOT NULL,
        Cantidad int NOT NULL,
        Total float NOT NULL,
        PRIMARY KEY (idDescripcion),
        FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo),
        FOREIGN KEY (idVenta) REFERENCES Ventas(idVenta)
	);
    
    CREATE TABLE Pagos(
		idPago int NOT NULL AUTO_INCREMENT,
        Descripcion text DEFAULT NULL,
        idProveedor int NOT NULL,
        idUsuario int NOT NULL,
        idTipoPago int NOT NULL,
        Fecha date NOT NULL,
        PRIMARY KEY (idPago),
        FOREIGN KEY (idProveedor) REFERENCES Proveedores(idProveedor),
        FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario),
        FOREIGN KEY (idTipoPago) REFERENCES TipoPago(idTipo)
	);
    
    CREATE TABLE DescripcionPago(
		idDescripcion int NOT NULL AUTO_INCREMENT,
        idPago int NOT NULL,
        idArticulo int NOT NULL,
        Cantidad int NOT NULL,
        Total float NOT NULL,
        PRIMARY KEY (idDescripcion),
        FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo),
        FOREIGN KEY (idPago) REFERENCES Pagos(idPago)
	);
    
    CREATE TABLE LogVenta(
		idLog int NOT NULL AUTO_INCREMENT,
        idVenta int NOT NULL,
        Fecha date,
        Hora time,
        PRIMARY KEY (idLog),
        FOREIGN KEY (idVenta) REFERENCES Ventas(idVenta)
	);
    
    CREATE TABLE LogCotizacion(
		idLog int NOT NULL AUTO_INCREMENT,
        idCotizacion int NOT NULL,
        Fecha date,
        Hora time,
        PRIMARY KEY (idLog),
        FOREIGN KEY (idCotizacion) REFERENCES Cotizacion(idCotizacion)
	);
    
    CREATE TABLE LogCliente(
		idLog int NOT NULL AUTO_INCREMENT,
        idCliente int NOT NULL,
        Fecha date,
        Hora time,
        PRIMARY KEY (idLog),
        FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
	);
    
    CREATE TABLE LogPago(
		idLog int NOT NULL AUTO_INCREMENT,
        idPago int NOT NULL,
        Fecha date,
        Hora time,
        PRIMARY KEY (idLog),
        FOREIGN KEY (idPago) REFERENCES Pagos(idPago)
	);
    
    CREATE TABLE TipoEstablecimiento(
		idTipo int NOT NULL AUTO_INCREMENT,
        Nombre nvarchar(25),
        PRIMARY KEY (idTipo)
	);
    
    CREATE TABLE Establecimientos(
		idEstablecimiento int NOT NULL AUTO_INCREMENT,
        idTipo int NOT NULL,
        Nombre nvarchar(25) DEFAULT NULL,
        Direccion nvarchar(50) DEFAULT NULL,
        Encargado int NOT NULL,
        PRIMARY KEY (idEstablecimiento),
        FOREIGN KEY (idTipo) REFERENCES TipoEstablecimiento(idTipo),
        FOREIGN KEY (Encargado) REFERENCES Usuarios(idUsuario)
	);
    
    CREATE TABLE Inventario(
		idInventario int NOT NULL AUTO_INCREMENT,
        idArticulo int NOT NULL,
        Cantidad int NOT NULL,
        idLocal int NOT NULL,
        PRIMARY KEY (idInventario),
        FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo),
        FOREIGN KEY (idLocal) REFERENCES Establecimientos(idEstablecimiento)
	);
    
    CREATE TABLE ReporteVendedor(
		idReporteVendedor int NOT NULL AUTO_INCREMENT,
        idVendedor int NOT NULL,
        CantidadVentas int NOT NULL,
        MontoTotal float NOT NULL,
        PRIMARY KEY (idReporteVendedor),
        FOREIGN KEY (idVendedor) REFERENCES Usuarios(idUsuario)
	);
    
    CREATE TABLE ReporteArticulo(
		idReporteArticulo int NOT NULL AUTO_INCREMENT,
        idArticulo int NOT NULL,
        Cantidad int NOT NULL,
        MontoTotal float NOT NULL,
        PRIMARY KEY (idReporteArticulo),
        FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo)
	);
    
    CREATE TABLE  ReporteClienteMasIngresos(
		idReporteCliente int NOT NULL AUTO_INCREMENT,
        idCliente int NOT NULL,
        MontoPromedio float NOT NULL,
        PRIMARY KEY (idReporteCliente),
        FOREIGN KEY (idCliente) REFERENCES Clientes(idCliente)
	);
    
    CREATE TABLE Peticiones(
		idPeticion int NOT NULL AUTO_INCREMENT,
        idArticulo int NOT NULL,
        LocalOrigen int NOT NULL,
        LocalDestino int NOT NULL,
        idUsuario int NOT NULL,
        PRIMARY KEY (idPeticion),
        FOREIGN KEY (idArticulo) REFERENCES Articulos(idArticulo),
        FOREIGN KEY (LocalOrigen) REFERENCES Establecimientos(idEstablecimiento),
        FOREIGN KEY (LocalDestino) REFERENCES Establecimientos(idEstablecimiento),
        FOREIGN KEY (idUsuario) REFERENCES Usuarios(idUsuario)
	);
    
    DELIMITER //
    
    CREATE PROCEDURE InsertarCliente(IN Cliente int)
    Begin
		INSERT INTO LogCliente(idCliente, Fecha, Hora) 
		VALUES (Cliente,CURDATE(),CURTIME());
	END //
    
    CREATE PROCEDURE InsertarVenta(IN Venta int)
    Begin
		INSERT INTO LogVenta(idVenta, Fecha, Hora) 
		VALUES (Venta,CURDATE(),CURTIME());
	END //
    
    CREATE PROCEDURE InsertarCotizacion(IN Cotizacion int)
    Begin
		INSERT INTO LogCotizacion(idCotizacion, Fecha, Hora) 
		VALUES (Cotizacion,CURDATE(),CURTIME());
	END //
    
    CREATE PROCEDURE InsertarPago(IN Pago int)
    Begin
		INSERT INTO LogPago(idPago, Fecha, Hora) 
		VALUES (Pago,CURDATE(),CURTIME());
	END //
    
    DELIMITER ;
    
        