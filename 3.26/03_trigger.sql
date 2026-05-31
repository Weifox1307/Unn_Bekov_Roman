CREATE OR REPLACE FUNCTION check_stock_before_insert()
RETURNS TRIGGER AS $$
BEGIN
    IF (SELECT stock_quantity FROM products WHERE product_id = NEW.product_id) < NEW.quantity THEN
        RAISE EXCEPTION 'Недостаточно товара на складе для товара ID %', NEW.product_id;
    END IF;
    
    UPDATE products 
    SET stock_quantity = stock_quantity - NEW.quantity 
    WHERE product_id = NEW.product_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_stock
BEFORE INSERT ON order_items
FOR EACH ROW
EXECUTE FUNCTION check_stock_before_insert();
