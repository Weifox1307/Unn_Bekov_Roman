-- ТОВАРЫ
CREATE TABLE products (
    p_id SERIAL PRIMARY KEY,
    p_name VARCHAR(255) NOT NULL,
    p_price NUMERIC(15, 2) NOT NULL,
    p_unit VARCHAR(20),             -- штуки, кг, литры
    p_stock INT DEFAULT 0           -- Остаток на складе
);

-- КЛИЕНТЫ
CREATE TABLE customers (
    c_id SERIAL PRIMARY KEY,
    c_last_name VARCHAR(100) NOT NULL,
    c_first_name VARCHAR(100) NOT NULL,
    c_middle_name VARCHAR(100),
    c_address TEXT,
    c_phone VARCHAR(20),
    c_email VARCHAR(100),
    c_is_permanent BOOLEAN DEFAULT FALSE -- Статус постоянного клиента
);

-- ЗАКАЗЫ
CREATE TABLE orders (
    o_id SERIAL PRIMARY KEY,
    c_id INT REFERENCES customers(c_id),
    o_date DATE DEFAULT CURRENT_DATE,
    o_delivery_date DATE,
    o_total_sum NUMERIC(15, 2) DEFAULT 0 -- Итоговая сумма заказа (без скидок)
);

-- СОСТАВ ЗАКАЗА
-- Покупка нескольких видов товара
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    o_id INT REFERENCES orders(o_id) ON DELETE CASCADE,
    p_id INT REFERENCES products(p_id),
    quantity INT NOT NULL,
    price_fact NUMERIC(15, 2) -- Цена на момент продажи
);
