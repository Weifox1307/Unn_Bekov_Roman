-- Товары
INSERT INTO products (p_name, p_price, p_unit, p_stock) VALUES 
('Смартфон', 45000.00, 'шт', 5),
('Наушники', 3000.00, 'шт', 10),
('Кабель USB', 500.00, 'шт', 20);

-- Клиент
INSERT INTO customers (c_last_name, c_first_name, c_email) 
VALUES ('Беков', 'Роман', 'bekovroman0@gmail.com');

-- Создание заказ
INSERT INTO orders (c_id, o_delivery_date) VALUES (1, '2025-06-10');

-- Добавление товаров в заказ (Смартфон + Наушники)
-- Если сумма заказа превысит 5000, клиент получит статус "постоянный клиент"
INSERT INTO order_items (o_id, p_id, quantity) VALUES (1, 1, 1);
INSERT INTO order_items (o_id, p_id, quantity) VALUES (1, 2, 1);
