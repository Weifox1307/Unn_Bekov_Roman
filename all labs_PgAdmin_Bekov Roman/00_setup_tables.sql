-- Bekov Roman_3824Б1ПР4

-- Таблица для Лабораторных работ 1, 2, 4 и 6
CREATE TABLE IF NOT EXISTS quotations (
    id SERIAL PRIMARY KEY,
    q_date DATE NOT NULL,
    amount NUMERIC(15, 2) NOT NULL,
    agent_id INT
);

-- Таблица для Лабораторной работы №3
CREATE TABLE IF NOT EXISTS qitem (
    id SERIAL PRIMARY KEY,
    offer_price NUMERIC(15, 2),
    vendor_price NUMERIC(15, 2),
    list_price NUMERIC(15, 2)
);

-- Таблица для Лабораторной работы №4
CREATE TABLE IF NOT EXISTS admin_log (
    log_id SERIAL PRIMARY KEY,
    table_name TEXT,
    operation TEXT,
    record_id INT,
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Таблицы для Лабораторной работы №5 (Star-scheme / Разреженные данные)
CREATE TABLE IF NOT EXISTS agents (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS agent_attributes (
    agent_id INT REFERENCES agents(id),
    attr_name TEXT,
    attr_value TEXT
);

-- ТЕСТОВЫЕ ДАННЫЕ
INSERT INTO agents (name) VALUES ('Иван Иванов'), ('Петр Петров');

INSERT INTO quotations (q_date, amount, agent_id) VALUES 
('2025-01-10', 100000.00, 1),
('2025-01-20', 130000.00, 1),
('2025-02-05', 70000.00, 2),
('2025-02-15', 80000.00, 2);
