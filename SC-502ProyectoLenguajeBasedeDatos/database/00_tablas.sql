-- Tablas del Sistema 

CREATE TABLE clientes (
    cliente_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    telefono VARCHAR2(15) NOT NULL,
    direccion VARCHAR2(100)
);

CREATE TABLE productos (
    producto_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL,
    descripcion VARCHAR2(100),
    precio NUMBER(10,2) NOT NULL,
    cantidad_stock NUMBER DEFAULT 0
);

CREATE TABLE pedidos (
    pedido_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente_id NUMBER NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT SYSTIMESTAMP,
    total NUMBER(10,2) DEFAULT 0,
    estado VARCHAR2(20) DEFAULT 'PENDIENTE',
    FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id)
);

CREATE TABLE detalle_pedidos (
    detalle_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id NUMBER NOT NULL,
    producto_id NUMBER NOT NULL,
    cantidad NUMBER NOT NULL,
    precio_unitario NUMBER(10,2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);


--Estructura para la ACTULIZACION DE LA BASE DE DATOS
-- Tabla ROLES
CREATE TABLE ROLES (
    rol_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(50) NOT NULL
);

-- Tabla USUARIOS
CREATE TABLE USUARIOS (
    usuario_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    correo VARCHAR2(100) UNIQUE NOT NULL,
    password VARCHAR2(100) NOT NULL,
    rol_id NUMBER NOT NULL,
    FOREIGN KEY (rol_id) REFERENCES ROLES(rol_id)
);

-- Tabla CLIENTES
CREATE TABLE CLIENTES (
    cliente_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    telefono VARCHAR2(15) NOT NULL,
    direccion VARCHAR2(200),
    correo VARCHAR2(100)
);

-- Tabla PROVEEDORES
CREATE TABLE PROVEEDORES (
    proveedor_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    telefono VARCHAR2(15) NOT NULL,
    direccion VARCHAR2(200) NOT NULL
);

-- Tabla PRODUCTOS
CREATE TABLE PRODUCTOS (
    producto_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR2(100) NOT NULL,
    descripcion VARCHAR2(200),
    precio_actual NUMBER(10,2) NOT NULL,
    proveedor_id NUMBER,
    FOREIGN KEY (proveedor_id) REFERENCES PROVEEDORES(proveedor_id)
);

-- Tabla PEDIDOS
CREATE TABLE PEDIDOS (
    pedido_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    estado VARCHAR2(20) DEFAULT 'PENDIENTE' NOT NULL,
    cliente_id NUMBER NOT NULL,
    usuario_id NUMBER NOT NULL,
    FOREIGN KEY (cliente_id) REFERENCES CLIENTES(cliente_id),
    FOREIGN KEY (usuario_id) REFERENCES USUARIOS(usuario_id)
);

-- Tabla DETALLE_PEDIDOS
CREATE TABLE DETALLE_PEDIDOS (
    detalle_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id NUMBER NOT NULL,
    producto_id NUMBER NOT NULL,
    cantidad NUMBER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMBER(10,2) NOT NULL,
    descuento_id NUMBER,
    FOREIGN KEY (pedido_id) REFERENCES PEDIDOS(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES PRODUCTOS(producto_id),
    FOREIGN KEY (descuento_id) REFERENCES DESCUENTOS(descuento_id)
);

-- Tabla FACTURAS
CREATE TABLE FACTURAS (
    factura_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id NUMBER UNIQUE NOT NULL,
    fecha DATE NOT NULL,
    subtotal NUMBER(10,2) NOT NULL,
    impuesto NUMBER(10,2) NOT NULL,
    total NUMBER(10,2) NOT NULL,
    medio_pago VARCHAR2(50) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES PEDIDOS(pedido_id)
);

-- Tabla INVENTARIO
CREATE TABLE INVENTARIO (
    inventario_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    producto_id NUMBER UNIQUE NOT NULL,
    cantidad_disponible NUMBER NOT NULL CHECK (cantidad_disponible >= 0),
    fecha_actualizacion TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES PRODUCTOS(producto_id)
);

-- Tabla HISTORICO_PRECIOS
CREATE TABLE HISTORICO_PRECIOS (
    historico_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    producto_id NUMBER NOT NULL,
    precio_anterior NUMBER(10,2) NOT NULL,
    precio_nuevo NUMBER(10,2) NOT NULL,
    fecha_cambio TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    FOREIGN KEY (producto_id) REFERENCES PRODUCTOS(producto_id)
);

-- Tabla DESCUENTOS
CREATE TABLE DESCUENTOS (
    descuento_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    descripcion VARCHAR2(200) NOT NULL,
    porcentaje NUMBER(5,2) NOT NULL CHECK (porcentaje >= 0 AND porcentaje <= 100),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

--insetar producto
INSERT INTO productos(nombre, precio) VALUES ('Pizza Hawaiana', 8500);
COMMIT;

CREATE OR REPLACE PROCEDURE sp_insertar_producto(
    p_nombre IN VARCHAR2,
    p_precio IN NUMBER,
    p_id OUT NUMBER
) AS
BEGIN
    INSERT INTO productos(nombre, precio)
    VALUES(p_nombre, p_precio)
    RETURNING producto_id INTO p_id;
    COMMIT;
END;
/
--PERMISO
GRANT EXECUTE ON sp_insertar_producto TO GTA;

SELECT * FROM productos;
SELECT * FROM productos;
