-- Процедура с курсором: сделать лояльными тех, кто потратил > 5000
CREATE OR REPLACE PROCEDURE update_loyalty_status()
AS $$
DECLARE
    rec RECORD;
    cur_clients CURSOR FOR 
        SELECT c.client_id, SUM(oi.quantity * oi.price_at_sale) as total
        FROM clients c
        JOIN orders o ON c.client_id = o.client_id
        JOIN order_items oi ON o.order_id = oi.order_id
        GROUP BY c.client_id;
BEGIN
    OPEN cur_clients;
    LOOP
        FETCH cur_clients INTO rec;
        EXIT WHEN NOT FOUND;
        
        IF rec.total > 5000 THEN
            UPDATE clients SET is_loyal = TRUE WHERE client_id = rec.client_id;
        END IF;
    END LOOP;
    CLOSE cur_clients;
END;
$$ LANGUAGE plpgsql;

-- Удаление клиента и его заказов без CASCADE
CREATE OR REPLACE PROCEDURE delete_client_safely(p_client_id INT)
AS $$
BEGIN
    -- Удаляем позиции всех заказов клиента
    DELETE FROM order_items 
    WHERE order_id IN (SELECT order_id FROM orders WHERE client_id = p_client_id);
    
    -- Удаляем заказы
    DELETE FROM orders WHERE client_id = p_client_id;
    
    -- Удаляем клиента
    DELETE FROM clients WHERE client_id = p_client_id;
END;
$$ LANGUAGE plpgsql;
