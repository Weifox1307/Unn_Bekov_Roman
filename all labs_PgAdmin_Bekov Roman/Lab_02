-- Bekov Roman_3824Б1ПР4

-- Лабораторная работа №2
CREATE OR REPLACE PROCEDURE create_monthly_view(start_d DATE, end_d DATE)
LANGUAGE plpgsql AS $$
BEGIN
    EXECUTE format('
        CREATE OR REPLACE VIEW v_monthly_report AS
        SELECT TO_CHAR(q_date, ''MM.YYYY''), SUM(amount)
        FROM quotations
        WHERE q_date BETWEEN %L AND %L
        GROUP BY 1', start_d, end_d);
END; $$;

CALL create_monthly_view('2025-01-01', '2025-03-31');

SELECT * FROM v_monthly_report;
