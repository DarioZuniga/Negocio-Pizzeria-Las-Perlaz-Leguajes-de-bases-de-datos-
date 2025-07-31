-- Procedimientos para gestión de clientes
CREATE OR REPLACE PROCEDURE sp_registrar_cliente(
    p_nombre IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_direccion IN VARCHAR2,
    p_cliente_id OUT NUMBER
) AS
BEGIN
    INSERT INTO clientes(nombre, telefono, direccion)
    VALUES(p_nombre, p_telefono, p_direccion)
    RETURNING cliente_id INTO p_cliente_id;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE sp_actualizar_cliente(
    p_cliente_id IN NUMBER,
    p_nombre IN VARCHAR2,
    p_telefono IN VARCHAR2,
    p_direccion IN VARCHAR2
) AS
BEGIN
    UPDATE clientes
    SET nombre = p_nombre,
        telefono = p_telefono,
        direccion = p_direccion
    WHERE cliente_id = p_cliente_id;
    COMMIT;
END;
/