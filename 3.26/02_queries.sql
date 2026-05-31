-- Соединение таблиц и агрегация (сумма покупок по каждому клиенту)
SELECT 
    c.last_name, 
    SUM(oi.quantity * oi.price_at_sale) as total_spent
FROM clients c
JOIN orders o ON c.client_id = o.client_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.last_name
HAVING SUM(oi.quantity * oi.price_at_sale) > 0;

-- Скалярные функции даты/времени (заказы за последние 30 дней)
SELECT order_id, order_date 
FROM orders 
WHERE order_date > CURRENT_DATE - INTERVAL '30 days';

-- Текстовый поиск (поиск клиентов с почтой на gmail)
SELECT * FROM clients 
WHERE email LIKE '%@gmail.com';

-- Поиск родительских записей, у которых нет дочерних (товары, которые ни разу не покупали)
SELECT p.name 
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
WHERE oi.item_id IS NULL;
