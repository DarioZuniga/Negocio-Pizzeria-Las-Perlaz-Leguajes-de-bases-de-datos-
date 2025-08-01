-- Procedimientos para gestión de pedidos
CREATE OR REPLACE PROCEDURE sp_crear_pedido(
    p_cliente_id IN NUMBER,
    p_usuario_id IN NUMBER,
    p_pedido_id OUT NUMBER
) AS
BEGIN
    INSERT INTO pedidos(cliente_id, usuario_id, estado)
    VALUES(p_cliente_id, p_usuario_id, 'PENDIENTE')
    RETURNING pedido_id INTO p_pedido_id;
    COMMIT;
END;
/

CREATE OR REPLACE PROCEDURE sp_agregar_producto_pedido(
    p_pedido_id IN NUMBER,
    p_producto_id IN NUMBER,
    p_cantidad IN NUMBER
) AS
    v_precio NUMBER;
BEGIN
    -- Obtener precio actual
    SELECT precio INTO v_precio FROM productos 
    WHERE producto_id = p_producto_id;
    
    -- Agregar a detalle
    INSERT INTO detalle_pedidos(pedido_id, producto_id, cantidad, precio_unitario)
    VALUES(p_pedido_id, p_producto_id, p_cantidad, v_precio);
    
    -- Actualizar stock
    UPDATE productos SET stock = stock - p_cantidad
    WHERE producto_id = p_producto_id;
    
    COMMIT;
END;
/