CREATE OR REPLACE PROCEDURE create_monthly_report(start_d DATE, end_d DATE)
LANGUAGE plpgsql AS $$
BEGIN
    EXECUTE format('
        CREATE OR REPLACE VIEW v_monthly_quotation AS
        SELECT TO_CHAR(q_date, ''MM.YYYY''), SUM(amount)
        FROM quotation_data WHERE q_date BETWEEN %L AND %L
        GROUP BY 1', start_d, end_d);
END; $$;

-- Пример вызова: CALL create_monthly_report('2025-01-01', '2025-03-31');
-- Проверка: SELECT * FROM v_monthly_quotation;
