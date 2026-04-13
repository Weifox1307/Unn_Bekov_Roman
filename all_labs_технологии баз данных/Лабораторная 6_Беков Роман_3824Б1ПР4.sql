ALTER TABLE quotation_data ADD COLUMN IF NOT EXISTS agent_id INT;
UPDATE quotation_data SET agent_id = 1 WHERE id % 2 = 0;
UPDATE quotation_data SET agent_id = 2 WHERE id % 2 <> 0;

SELECT 
    a.name AS "Агент",
    SUM(q.amount) AS "Личный оборот",
    ROUND(
        SUM(q.amount) * 100.0 / SUM(SUM(q.amount)) OVER(), 
        2
    ) AS "Доля в общем обороте %"
FROM agents a
JOIN quotation_data q ON a.id = q.agent_id
GROUP BY a.name;
