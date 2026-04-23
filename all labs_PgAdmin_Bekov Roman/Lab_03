-- Bekov Roman_3824Б1ПР4

-- Лабораторная работа №3

-- Функция проверки
CREATE OR REPLACE FUNCTION check_qitem_price() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.offer_price < NEW.vendor_price OR NEW.offer_price > NEW.list_price THEN
        RAISE EXCEPTION 'Цена предложения должна быть в интервале между ценой вендора и прайсом!';
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;


-- Триггер
CREATE TRIGGER trg_check_price 
BEFORE INSERT ON qitem 
FOR EACH ROW EXECUTE FUNCTION check_qitem_price();

-- ПРОВЕРКА
-- INSERT INTO qitem (offer_price, vendor_price, list_price) VALUES (500, 100, 200);
