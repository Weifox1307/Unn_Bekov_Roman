-- Создаем денормализованный набор
CREATE VIEW analytics_sales_performance AS
SELECT 
    p.name as product_name,
    SUM(oi.quantity) as total_qty,
    RANK() OVER (ORDER BY SUM(oi.quantity) DESC) as sales_rank,
    LEAD(SUM(oi.quantity)) OVER (ORDER BY SUM(oi.quantity) DESC) - SUM(oi.quantity) as diff_with_next
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.name;
