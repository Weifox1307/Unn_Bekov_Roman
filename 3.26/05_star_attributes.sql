-- Таблица описаний атрибутов
CREATE TABLE attribute_definitions (
    attr_id SERIAL PRIMARY KEY,
    attr_name VARCHAR(50) NOT NULL UNIQUE
);

-- Таблица значений (связь с товаром)
CREATE TABLE product_attribute_values (
    product_id INT REFERENCES products(product_id),
    attr_id INT REFERENCES attribute_definitions(attr_id),
    attr_value TEXT,
    PRIMARY KEY (product_id, attr_id)
);

-- Функции добавления
CREATE OR REPLACE FUNCTION add_attribute_def(name TEXT) RETURNS VOID AS $$
BEGIN
    INSERT INTO attribute_definitions (attr_name) VALUES (name) ON CONFLICT DO NOTHING;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_product_attr_value(p_id INT, a_name TEXT, val TEXT) RETURNS VOID AS $$
DECLARE
    v_attr_id INT;
BEGIN
    SELECT attr_id INTO v_attr_id FROM attribute_definitions WHERE attr_name = a_name;
    INSERT INTO product_attribute_values (product_id, attr_id, attr_value) 
    VALUES (p_id, v_attr_id, val);
END;
$$ LANGUAGE plpgsql;
