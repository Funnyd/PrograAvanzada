CREATE DATABASE PROYECTO_VENTAS;

USE PROYECTO_VENTAS;

CREATE TABLE Categoria (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Producto (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    CategoriaId INT NOT NULL,
    Precio FLOAT NOT NULL,
    ImpuestoPorc FLOAT NOT NULL,
    Stock INT NOT NULL DEFAULT 0,
    ImagenUrl VARCHAR(255),
    Activo BIT NOT NULL DEFAULT 1,
    CONSTRAINT FK_Producto_Categoria FOREIGN KEY (CategoriaId) REFERENCES Categoria(Id)
);
GO

CREATE TABLE Cliente (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Cedula VARCHAR(20) NOT NULL UNIQUE,
    Correo VARCHAR(100) NOT NULL,
    Telefono VARCHAR(20),
    Direccion VARCHAR(200)
);
GO

CREATE TABLE Usuario (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NombreUsuario VARCHAR(50) NOT NULL UNIQUE,
    ContrasenaHash VARCHAR(255) NOT NULL,
    Rol VARCHAR(50) NOT NULL DEFAULT 'Empleado',
    Activo BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Pedido (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ClienteId INT NOT NULL,
    UsuarioId INT NOT NULL,
    Fecha DATETIME NOT NULL DEFAULT GETDATE(),
    Subtotal DECIMAL(10,2) NOT NULL,
    Impuestos DECIMAL(10,2) NOT NULL,
    Total DECIMAL(10,2) NOT NULL,
    Estado VARCHAR(50) NOT NULL DEFAULT 'Pendiente',
    CONSTRAINT FK_Pedido_Cliente FOREIGN KEY (ClienteId) REFERENCES Cliente(Id),
    CONSTRAINT FK_Pedido_Usuario FOREIGN KEY (UsuarioId) REFERENCES Usuario(Id)
);
GO

CREATE TABLE PedidoDetalle (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    PedidoId INT NOT NULL,
    ProductoId INT NOT NULL,
    Cantidad INT NOT NULL,
    PrecioUnit DECIMAL(10,2) NOT NULL,
    Descuento DECIMAL(10,2) DEFAULT 0,
    ImpuestoPorc DECIMAL(5,2) NOT NULL,
    TotalLinea DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_PedidoDetalle_Pedido FOREIGN KEY (PedidoId) REFERENCES Pedido(Id),
    CONSTRAINT FK_PedidoDetalle_Producto FOREIGN KEY (ProductoId) REFERENCES Producto(Id)
);
GO

INSERT INTO Usuario
VALUES
('Usuario1', 'Contrasena', 'Empleado',1);

INSERT INTO Categoria
VALUES
('Cuerda'),
('Viento'),
('Percusion'),
('Teclado'),
('Electrico');

INSERT INTO Producto
VALUES
('Guitarra', 1, 93500, 13, 20, 'Guitarra.jpg', 1),
('Guitarra Electrica', 5, 650000, 13, 10, 'Stratocaster.jpg', 1),
('Bajo Electrico', 5, 195000, 13, 15, 'Ibanez.jpg', 1),
('Teclado Yamaha', 4, 321200, 13, 8, 'Teclado.jpg', 1),
('Violin 4/4', 1, 288500, 13, 7, 'Violin.jpg', 1),
('Saxofon', 2, 295000, 13, 12, 'Saxofon.jpg', 1),
('Bateria', 3, 519000, 10, 6, 'Bateria.jpg', 1),
('Trompeta', 2, 12500, 10, 5, 'Trompeta.jpg', 1),
('Ukelele', 1, 25800, 10, 16, 'Ukelele.jpg', 1),
('Piano Electrico', 4, 344650, 10, 4, 'Piano.jpg', 1);

INSERT INTO Cliente
VALUES
('Daniel Quesada', '119110011', 'correo1@gmail.com', '70142020', 'San Rafael Arriba'),
('Alejandro Obregon', '120560011', 'correo2@gmail.com', '84295502', 'Desamparados'),
('Ariel Ñuñez', '320720333', 'correo3@gmail.com', '10294445', 'Heredia Centro'),
('Marcelo Baldi', '267890010', 'correo4@gmail.com', '70015667', 'San Jose Central'),
('Armando Montiel', '335980789', 'correo5@gmail.com', '20104500', 'Desamparados'),
('Daniel Mora', '178900320', 'correo6@gmail.com', '45608090', 'Santa Ana');
/*Justificacion de la normalizacion. 
La base de datos del proyecto PROYECTO_VENTAS 
está normalizada hasta la Tercera Forma Normal (3FN).
Esto se hizo para evitar datos repetidos y mantener una buena organización entre las tablas. 
Cada tabla tiene su función: los productos se relacionan con categorías, 
los pedidos con los clientes y usuarios, y los detalles de pedido con los productos.

En la 3FN, cada dato depende solo de su clave principal, no de otros campos. 
Por ejemplo, el nombre de la categoría no se repite en los productos,
sino que se guarda en la tabla Categoria, y se relaciona por su Id.

Además, los totales (subtotal, impuestos y total) se guardan en las tablas Pedido
y PedidoDetalle aunque se puedan recalcular. Esto es importante para tener un registro 
exacto de cada venta en el momento en que ocurrió, lo cual sirve para auditorías o consultas futuras.*/ 
