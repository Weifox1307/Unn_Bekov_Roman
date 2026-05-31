-- 1. Таблица товаров
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2) NOT NULL CHECK (price > 0),
    unit VARCHAR(50) NOT NULL,
    stock_quantity INT DEFAULT 0 CHECK (stock_quantity >= 0)
);

-- 2. Таблица клиентов
CREATE TABLE clients (
    client_id SERIAL PRIMARY KEY,
    last_name VARCHAR(100) NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    middle_name VARCHAR(100),
    address TEXT,
    phone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    is_loyal BOOLEAN DEFAULT FALSE
);

-- 3. Таблица заказов
CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    client_id INT REFERENCES clients(client_id),
    order_date DATE DEFAULT CURRENT_DATE,
    delivery_date DATE,
    CONSTRAINT check_dates CHECK (delivery_date >= order_date)
);

-- 4. Состав заказа
CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT NOT NULL CHECK (quantity > 0),
    price_at_sale NUMERIC(10, 2) NOT NULL
);

CREATE VIEW view_order_details AS
SELECT 
    o.order_id, 
    c.last_name || ' ' || c.first_name as client_name,
    p.name as product_name,
    oi.quantity,
    oi.price_at_sale,
    (oi.quantity * oi.price_at_sale) as total_item_price
FROM orders o
JOIN clients c ON o.client_id = c.client_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;
