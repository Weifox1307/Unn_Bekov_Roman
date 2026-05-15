-- Триггер: Проверка склада и фиксация цены
CREATE OR REPLACE FUNCTION fn_before_order_item() RETURNS TRIGGER AS $$
DECLARE
    available_stock INT;
BEGIN
    -- Проверяем наличие товара на складе
    SELECT p_stock INTO available_stock FROM products WHERE p_id = NEW.p_id;
    
    IF available_stock < NEW.quantity THEN
        RAISE EXCEPTION 'Товара недостаточно! На складе осталось: %', available_stock;
    END IF;

    -- Списываем со склада
    UPDATE products SET p_stock = p_stock - NEW.quantity WHERE p_id = NEW.p_id;
    
    -- Подтягиваем текущую цену из таблицы товаров в чек
    SELECT p_price INTO NEW.price_fact FROM products WHERE p_id = NEW.p_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_stock
BEFORE INSERT ON order_items FOR EACH ROW EXECUTE FUNCTION fn_before_order_item();


-- Триггер: Обновление суммы заказа и статуса клиента
CREATE OR REPLACE FUNCTION fn_after_order_item() RETURNS TRIGGER AS $$
DECLARE
    spent_total NUMERIC;
    cust_id INT;
BEGIN
    -- Считаем и обновляем общую сумму заказа
    UPDATE orders 
    SET o_total_sum = (SELECT SUM(quantity * price_fact) FROM order_items WHERE o_id = NEW.o_id)
    WHERE o_id = NEW.o_id;

    -- Проверяем условие для выдачи клиенту статуса "постоянный"
    SELECT c_id INTO cust_id FROM orders WHERE o_id = NEW.o_id;
    SELECT SUM(o_total_sum) INTO spent_total FROM orders WHERE c_id = cust_id;

    IF spent_total > 5000 THEN
        UPDATE customers SET c_is_permanent = TRUE WHERE c_id = cust_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_totals
AFTER INSERT ON order_items FOR EACH ROW EXECUTE FUNCTION fn_after_order_item();
