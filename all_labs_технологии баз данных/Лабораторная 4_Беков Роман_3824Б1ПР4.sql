CREATE TABLE IF NOT EXISTS admin_log (
    log_id SERIAL PRIMARY KEY,
    table_name TEXT,            -- имя таблицы, где было изменение
    op_type TEXT,               -- тип операции (INSERT)
    new_id INT,                 -- ID новой записи
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- время записи
);

CREATE OR REPLACE FUNCTION log_insert_action()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO admin_log (table_name, op_type, new_id)
    VALUES (TG_TABLE_NAME, 'INSERT', NEW.id);
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_after_insert_log
AFTER INSERT ON quotation_data
FOR EACH ROW
EXECUTE FUNCTION log_insert_action();
