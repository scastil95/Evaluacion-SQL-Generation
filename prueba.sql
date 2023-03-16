# Crear un esquema para la base de datos de Don José
CREATE SCHEMA  AlmacenDonJose;

# Utilizar el esquema
USE AlmacenDonJose;

# Creo tabla para almacenar los datos de las compras que realizan
# y agrego las fk a las que creo que son necesarias
CREATE TABLE comprasCliente (
    comprasCliente_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fechaCompra DATE,
    numProductos INT,
    formaPago VARCHAR(15),
    totalCompra DOUBLE
);

#  Tabla para almacenar los datos de las compras realizadas al proveedor
CREATE TABLE comprasAlmacen (
    comprasAlmacen_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    fechaCompra DATE,
    totalCompra DOUBLE,
    formaPago VARCHAR(15),
    CantProductos INT,
    proveedor_id INTEGER NOT NULL,
    FOREIGN KEY (proveedor_id) REFERENCES proveedor (proveedor_id)
);

#  Tabla para almacenar los detalles de las compras
CREATE TABLE detalleCompra (
    detalleCompra_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cantProductos INT,
    precioXunidad DOUBLE,
    comprasAlmacen_id INTEGER NOT NULL,
    productos_id INTEGER NOT NULL,
    FOREIGN KEY (comprasAlmacen_id) REFERENCES comprasAlmacen (comprasAlmacen_id)
);

#  Tabla para almacenar los datos de los productos con el precio de venta (el precio al que lo vende) y de compra (el precio de compra que lo adquirió el almacenero)
# Almacenar la información sobre los productos que se venden incluyendo la cantidad en stock
CREATE TABLE productos (
    productos_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombreProducto VARCHAR (20),
    precioVenta DOUBLE,
    precioCompra DOUBLE,
    stock INT,
    flujoCaja_id INTEGER NOT NULL,
    detalleCompra_id INTEGER NOT NULL,
    FOREIGN KEY (flujoCaja_id) REFERENCES flujoCaja (flujoCaja_id),
    FOREIGN KEY (detalleCompra_id) REFERENCES detalleCompra (detalleCompra_id)
);

#  Tabla para guardar a los distintos proveedores del almacén con sus respectivos datos
CREATE TABLE proveedor (
    proveedor_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR (20),
    direccion VARCHAR (50),
    telefono INT,
    email VARCHAR (30)
);

#  Tabla para que almacene los datos de las cajas
CREATE TABLE flujoCaja (
    flujoCaja_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    cantidad INT,
    precioUnitario DOUBLE,
    comprasCliente_id INTEGER NOT NULL,
    productos_id INTEGER NOT NULL,
    FOREIGN KEY (comprasCliente_id) REFERENCES comprasCliente (comprasCliente_id)
);

#--------------------------------------------------------------------------
	
# Inseto los datos de prueba
INSERT INTO comprasCliente (fechaCompra, numProductos, formaPago, totalCompra)
VALUES  ('2023-03-15', 2, 'Efectivo', 3000),
		('2023-03-16', 1, 'Debito', 1000),
        ('2023-03-17', 3, 'Efectivo', 2000),
        ('2023-03-18', 1, 'Efectivo', 1500),
        ('2023-03-19', 3, 'Debito', 3000);
        
INSERT INTO proveedor (nombre, direccion, telefono, email)
VALUES (" Fruna", 'Av. la Paz 123', 12334567, 'Fruna@gmail.cl'),
		("Supercerdo", 'Av. Chancho 447', 22434568, 'cerdo@super.cl'),
        ("FredyVega", 'Av. Lavega 1421', 3231321, 'Fvega@gmail.cl'),
		("soprole", 'Av. leche 12321', 25124123, 'soprole@gmail.cl'),
        ("abarrotes.cl", 'Av.dondevendan', 52323553, 'abaahorra@gmail.cl');
        
        
INSERT INTO comprasAlmacen (fechaCompra, totalCompra, formaPago, CantProductos, proveedor_id)
VALUES ('2023-03-14', 4500, 'Debito', 5, 1),
		('2023-03-14', 10000, 'Debito', 3, 2),
        ('2023-03-13', 20000, 'Efectivo', 10, 3),
          ('2023-03-04', 19999, 'Debito', 20, 4),
          ('2023-03-10', 50000, 'Cheque', 50, 5);


INSERT INTO productos (nombreProducto, precioVenta, precioCompra, stock, flujoCaja_id, detalleCompra_id)
VALUES ("Galleta Triton", 900, 600, 20, 1, 1),
		("chuleta centro", 3600, 2500, 10, 1, 2),
        ("lechuga", 5000, 3200, 5, 2, 3),
        ("Galleta bachata", 200, 50,10, 1, 1),
        ("yogurth frutilla", 200, 120,10, 2, 5);
        
INSERT INTO detalleCompra (cantProductos, precioXunidad, comprasAlmacen_id, productos_id)
VALUES (3, 900, 1, 1),
		(3, 3600, 2, 2),
        (3, 200, 3, 3),
        (3, 300, 1, 4),
        (3, 1000, 5, 5);
        
INSERT INTO flujoCaja (cantidad, precioUnitario, comprasCliente_id, productos_id)
VALUES (3, 900, 1, 1),
		(3, 3600, 2, 2),
        (3, 200, 3, 3),
        (3, 300, 1, 4),
        (3, 1000, 5, 5);
        
#--------------------------------------------------------------------------
	
    #Pruebas simples
    
SELECT nombre, direccion, email FROM proveedor;

SELECT *
FROM productos
WHERE precioVenta > 100; #solo logre que me trajiera la galleta triton :C

#--------------------------------------------------------------------------
	
 #Pruebas con JOIN
 
SELECT proveedor.nombre, comprasAlmacen.fechaCompra, comprasAlmacen.totalCompra 
FROM comprasAlmacen 
JOIN proveedor ON comprasAlmacen.proveedor_id = proveedor.proveedor_id;

SELECT *
FROM proveedor
INNER JOIN comprasAlmacen ON proveedor.proveedor_id = comprasAlmacen.proveedor_id;


