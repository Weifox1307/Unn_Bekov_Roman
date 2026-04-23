-- Bekov Roman_3824Б1ПР4

-- Лабораторная работа №5

-- Добавление атрибута агенту №1 (Ивану)
INSERT INTO agent_attributes (agent_id, attr_name, attr_value) 
VALUES (1, 'количество детей', '2');

-- Звездная схема
SELECT a.name, aa.attr_name, aa.attr_value
FROM agents a
LEFT JOIN agent_attributes aa ON a.id = aa.agent_id;
