SELECT 
    TO_CHAR(q_date, 'MM.YYYY') AS "Месяц Год", 
    SUM(amount) AS "Сумма"
FROM quotation_data
WHERE q_date >= '2025-01-01' AND q_date <= '2025-02-28' 
GROUP BY 1 ORDER BY 1;
