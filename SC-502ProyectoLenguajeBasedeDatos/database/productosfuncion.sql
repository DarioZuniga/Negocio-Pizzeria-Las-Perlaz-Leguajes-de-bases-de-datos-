
CREATE OR REPLACE PROCEDURE sp_registrar_producto(
    p_nombre IN VARCHAR2,
    p_descripcion IN VARCHAR2,
    p_precio IN NUMBER,
    p_stock IN NUMBER,
    p_proveedor_id IN NUMBER,
    p_producto_id OUT NUMBER
) AS
BEGIN
    INSERT INTO productos(nombre, descripcion, precio, stock, proveedor_id)
    VALUES(p_nombre, p_descripcion, p_precio, p_stock, p_proveedor_id)
    RETURNING producto_id INTO p_producto_id;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE sp_actualizar_precio(
    p_producto_id IN NUMBER,
    p_nuevo_precio IN NUMBER
) AS
BEGIN
    --  histórico automático
    UPDATE productos
    SET precio = p_nuevo_precio
    WHERE producto_id = p_producto_id;
    COMMIT;
END;
/