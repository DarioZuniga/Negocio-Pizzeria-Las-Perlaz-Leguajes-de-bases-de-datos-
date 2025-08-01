-- Procedimiento CRUD para productos (ejemplo mínimo)
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

-- Añade al menos 9 procedimientos más similares