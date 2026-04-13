CREATE TABLE IF NOT EXISTS agents (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS agent_attributes (
    agent_id INT REFERENCES agents(id),
    attr_name TEXT,  -- Название (например, 'дети')
    attr_value TEXT  -- Значение (например, '2')
);

-- ТЕСТ:
INSERT INTO agents (name) VALUES ('Иван Смирнов'), ('Анна Петрова');
INSERT INTO agent_attributes (agent_id, attr_name, attr_value) 
VALUES (1, 'количество детей', '2');

-- Показать данные "звездой":
SELECT a.name, aa.attr_name, aa.attr_value
FROM agents a
LEFT JOIN agent_attributes aa ON a.id = aa.agent_id;
