CREATE OR REPLACE FUNCTION check_price_logic()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.offer_price < NEW.vendor_price OR NEW.offer_price > NEW.list_price THEN
        RAISE EXCEPTION 'Цена вне диапазона!';
    END IF;
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_check_qitem_price
BEFORE INSERT ON qitem FOR EACH ROW EXECUTE FUNCTION check_price_logic();
