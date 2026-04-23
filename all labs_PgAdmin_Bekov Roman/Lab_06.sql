-- Bekov Roman_3824Б1ПР4

-- Лабораторная работа №6
SELECT 
    a.name AS "Агент",
    SUM(q.amount) AS "Личный оборот",
    ROUND(SUM(q.amount) * 100.0 / SUM(SUM(q.amount)) OVER(), 2) AS "Вклад %"
FROM agents a
JOIN quotations q ON a.id = q.agent_id
GROUP BY a.name;
