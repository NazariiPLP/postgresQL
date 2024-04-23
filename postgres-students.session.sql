-- Ключ - ознака (найчастіше штучна) яка відрізняє один запис у таблиці від іншого
-- Первинний ключ (PRIMARY KEY) - використовується для того, щоб ключу дати обмеження унікальності (UNIQUE) і обмеження NOT NULL
-- Група стовпців - стовпець (група стовпців) які могли статти первинним ключем, але ще не обрані як такі.
-- Зовнішній ключ (foreing keys) - стовпець (група стовпців) які містять значення, які посилаються на ідентифікатори в інших таблицях 

CREATE TABLE orders(
    id serial PRIMARY KEY,
    created_at timestamp NOT NULL DEFAULT current_timestamp,
    customer_id int REFERENCES users(id)
);

DROP TABLE orders;

ALTER TABLE users
ADD COLUMN id serial PRIMARY KEY;

CREATE TABLE orders_to_products(
    product_id int REFERENCES products(id),
    order_id int REFERENCES orders(id),
    quantity int, 
    PRIMARY KEY(order_id, product_id)
); 

-- таблиця1_to_таблиця2



-- ОФОРМЛЕННЯ ЗАМОВЛЕННЯ ДЛЯ ЮЗЕРА


-- 1. Створили замовлення
INSERT INTO orders (customer_id) VALUES
(4);

-- 2. Наповнити замовлення
INSERT INTO orders_to_products (product_id, order_id,quantity) VALUES 
(2, 1, 1),
(3, 1, 2),
(4, 1, 1);