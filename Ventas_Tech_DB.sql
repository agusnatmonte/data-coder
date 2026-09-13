CREATE DATABASE Ventas_Tech_DB;
USE Ventas_Tech_DB;
-- =====================================================================
-- 1) DROP TABLES
-- Orden inverso a las dependencias: primero la tabla de hechos (ventas),
-- que tiene FK hacia clientes y productos; después productos, que tiene
-- FK hacia categorias; al final las tablas sin dependencias.
-- Esto evita el error del "huevo y la gallina" al reejecutar el script.
-- =====================================================================
DROP TABLE IF EXISTS Ventas;
DROP TABLE IF EXISTS Productos;
DROP TABLE IF EXISTS Clientes;
DROP TABLE IF EXISTS Categorias;
 
-- =====================================================================
-- 2) CREATE TABLES
-- =====================================================================

CREATE TABLE Categorias (
id_Categoria INT PRIMARY KEY,
nombre_Categoria VARCHAR (50) NOT NULL ,
descripcion VARCHAR(200)
);
CREATE TABLE Clientes (
id_Cliente INT PRIMARY KEY,
nombre_Cliente VARCHAR(50) NOT NULL,
email  VARCHAR(100) UNIQUE,
ciudad VARCHAR(50),
fecha_registro DATE NOT NULL
);

CREATE TABLE Productos (
id_Productos INT PRIMARY KEY,
nombre_Producto VARCHAR(50) NOT NULL,
id_Categoria INT,
precio_producto DECIMAL(10,2) NOT NULL,
stock INT DEFAULT 0,
activo TINYINT DEFAULT 1,
FOREIGN KEY (id_Categoria) REFERENCES Categorias(id_Categoria)
);

CREATE TABLE Ventas (
    id_Venta   INT PRIMARY KEY,
    id_Cliente  INT,
    id_Producto INT,
    cantidad  INT NOT NULL,
    precio_Unitario  DECIMAL(10,2) NOT NULL,
    fecha_Venta  DATE NOT NULL,
    FOREIGN KEY (id_Cliente) REFERENCES Clientes(id_Cliente),
    FOREIGN KEY (id_Producto) REFERENCES Productos(id_Productos)
);

-- =====================================================================
-- 3) INSERT DATA
-- Primero las tablas sin dependencias (categorias, clientes),
-- después productos (depende de categorias), al final ventas
-- (depende de clientes y productos).
-- =====================================================================
 
 --Categorías

INSERT INTO Categorias VALUES (1, 'Computación', 'Laptops, PCs y monitores');
INSERT INTO Categorias VALUES (2, 'Accesorios', 'Periféricos y complementos');
INSERT INTO Categorias VALUES (3, 'Audio', 'Auriculares y parlantes');
INSERT INTO Categorias VALUES (4, 'Almacenamiento', 'Discos y memorias');

--Clientes
INSERT INTO Clientes VALUES (1, 'María López',   'maria@mail.com',   'Buenos Aires', '2024-01-05');
INSERT INTO Clientes VALUES (2, 'Carlos Ruiz',   'carlos@mail.com',  'Córdoba',      '2024-01-10');
INSERT INTO Clientes VALUES (3, 'Ana Gómez',     'ana@mail.com',     'Rosario',      '2024-02-01');
INSERT INTO Clientes VALUES (4, 'Pedro Sanz',    'pedro@mail.com',   'Mendoza',      '2024-02-15');
INSERT INTO Clientes VALUES (5, 'Laura Torres',  'laura@mail.com',   'Tucumán',      '2024-03-01');
INSERT INTO Clientes VALUES (6, 'Pablo Treyer',  'pablo@mail.com',   'Formosa',      '2024-03-02');
--Productos
INSERT INTO Productos VALUES (1, 'Laptop Pro 15',       1, 1200.00, 15, 1);
INSERT INTO Productos VALUES (2, 'Mouse Inalámbrico',   2,   28.00, 80, 1);
INSERT INTO Productos VALUES (3, 'Monitor 4K 27"',      1,  450.00, 12, 1);
INSERT INTO Productos VALUES (4, 'Auriculares BT Pro',  3,  120.00, 35, 1);
INSERT INTO Productos VALUES (5, 'SSD Externo 1TB',     4,  130.00, 18, 1);
INSERT INTO Productos VALUES (6, 'Teclado Mecánico',    2,   95.00, 40, 1);
INSERT INTO Productos VALUES (7, 'Laptop Pro 14',       1, 1000.00, 30, 1);
--Ventas

INSERT INTO Ventas VALUES (1,  1, 1, 2, 1200.00, '2024-03-05');
INSERT INTO Ventas VALUES (2,  2, 2, 5,   28.00, '2024-03-06');
INSERT INTO Ventas VALUES (3,  3, 3, 1,  450.00, '2024-03-07');
INSERT INTO Ventas VALUES (4,  1, 4, 2,  120.00, '2024-03-08');
INSERT INTO Ventas VALUES (5,  4, 5, 3,  130.00, '2024-03-10');
INSERT INTO Ventas VALUES (6,  2, 6, 4,   95.00, '2024-03-11');
INSERT INTO Ventas VALUES (7,  5, 1, 1, 1200.00, '2024-03-12');
INSERT INTO Ventas VALUES (8,  3, 2, 8,   28.00, '2024-03-13');
INSERT INTO Ventas VALUES (9,  4, 4, 1,  120.00, '2024-03-14');
INSERT INTO Ventas VALUES (10, 5, 3, 2,  450.00, '2024-03-15');

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;

