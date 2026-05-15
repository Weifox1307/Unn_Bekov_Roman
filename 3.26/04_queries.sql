-- Представление для расчета финальной стоимости со всеми скидками
CREATE OR REPLACE VIEW v_final_billing AS
SELECT 
    o.o_id AS "Заказ №",
    c.c_last_name AS "Фамилия",
    o.o_total_sum AS "Сумма без скидок",
    -- Скидка: 2% (статус) + 3% (если заказ > 15000)
    CASE 
        WHEN c.c_is_permanent = TRUE AND o.o_total_sum > 15000 THEN 5
        WHEN c.c_is_permanent = TRUE OR o.o_total_sum > 15000 THEN 2
        ELSE 0 
    END AS "Скидка %",
    -- Итого к оплате
    o.o_total_sum * (1 - (CASE 
        WHEN c.c_is_permanent = TRUE AND o.o_total_sum > 15000 THEN 0.05
        WHEN c.c_is_permanent = TRUE OR o.o_total_sum > 15000 THEN 0.02
        ELSE 0 
    END)) AS "К оплате"
FROM orders o
JOIN customers c ON o.c_id = c.c_id;

-- 1. Посмотреть итоговый чек
SELECT * FROM v_final_billing;

-- 2. Проверить остатки на складе (где мало товара)
SELECT p_name, p_stock FROM products WHERE p_stock < 3;
