-- Bekov Roman_3824Б1ПР4

-- Лабораторная работа №4

-- Запись в лог
CREATE OR REPLACE FUNCTION log_quotations_insert() RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO admin_log (table_name, operation, record_id)
    VALUES ('quotations', 'INSERT', NEW.id);
    RETURN NEW;
END; $$ LANGUAGE plpgsql;

-- Триггер AFTER
CREATE TRIGGER trg_log_after_ins
AFTER INSERT ON quotations 
FOR EACH ROW EXECUTE FUNCTION log_quotations_insert();
