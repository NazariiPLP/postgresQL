-- Ключ - ознака (найчастіше штучна) яка відрізняє один запис у таблиці від іншого
-- Первинний ключ (PRIMARY KEY) - використовується для того, щоб ключу дати обмеження унікальності (UNIQUE) і обмеження NOT NULL


/* ALTER */

CREATE TABLE products(
    id serial PRIMARY KEY,
    brand varchar(200) NOT NULL CHECK (brand != ''),
    model varchar(300) NOT NULL CHECK (model != ''),
    description text,
    category varchar(200) NOT NULL CHECK (category != ''),
    price numeric(10, 2) NOT NULL CHECK (price > 0),
    discounted_price numeric(10, 2) CHECK (discounted_price <= price)
);

DROP TABLE products;

INSERT INTO products (brand, model, category, price) VALUES
('Samsung', 'S10', 'smartphones', 200),
('Iphone', '15 Pro', 'smartphones', 1200),
('Sony', '456', 'TV', 300),
('Sony', '457', 'TV', 600);


ALTER TABLE products
ADD CONSTRAINT "unique_brand_model_pair" UNIQUE(brand, model);


INSERT INTO products (brand, model, category, price) VALUES
('Iphone', '15 Pro', 'smartphones', 500);


ALTER TABLE products
ADD COLUMN quantity int;


ALTER TABLE products
ADD CONSTRAINT "products_quantity_check" CHECK(quantity >= 0);


ALTER TABLE products
DROP CONSTRAINT "products_quantity_check";

ALTER TABLE products
DROP COLUMN quantity;