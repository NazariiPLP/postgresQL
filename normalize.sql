-- 1 НФ: в кожній комірці зберігається атомарне значення (без списків ітп)
-- 2 НФ: 1 НФ + таблиця повинна мати ключ; ключ функціонально визначає всю строку
-- 3 НФ: 2 НФ + ми маємо прибрати транзитивні функціональні залежності атрибутів
-- 4 НФ: неключові транзитивні залежності не можуть бути в складі складеного ключа


/*

Необхідно спроектувати БД логістичної компанії.

В БД мають бути наступні таблиці.

Товари:
- код товару
- назва
- ціна


Замовлення на поставку:
- код замовлення
- найменування постачальника
- адреса постачальника
- телефон
- номер контракту
- дата заключення контракту
- найменування товару
- план поставки (кількість в шт.)


Фактичні відгрузки товару:
- код відгрузки
- код замовлення
- дата відгрузки
- відгружено товару (шт)


* Уточнення з приводу відгрузок.
Це логістична компанія.
Уявіть, що якийсь магазин, наприклад, замовив 100 одинииць товару.
Ви можете це замовлення поділити на декілька відгрузок.
Наприклад, у 1 відгрузці ви цьому магазину доставляєте 50 товарів.
У якійсь іншій відгрузці доставляєте інші 50 товарів.

При проектування БД необхідно врахувати.
1. Товар може мати декілька замовлень на постачання.
2. Замовлення відповідає ОДНОМУ товару.
3. Товару можуть відповідати декілька відгрузок.
4. У одній відггрузці може бути декілька товарів.
5. Товар не обов'язково має замволення. Кожне замовлення відповідає товару.
6. Товар не обов'язкоо відгружається замовнику, але кожна відгрузка обов'язково відповідає певному товару.


P.S. Повна творча свобода =)
Реалізуйте це завдання, як ви його бачите.

*/

CREATE TABLE products(
    id serial PRIMARY KEY,
    name varchar (300) CHECK(name != '') NOT NULL
);

CREATE TABLE manufacturers(
    id serial PRIMARY KEY,
    name varchar(400) CHECK(name != '') NOT NULL,
    address text CHECK(address != '') NOT NULL,
    tel_number varchar(15) CHECK(tel_number != '') NOT NULL
);

CREATE TABLE orders(
    id serial PRIMARY KEY,
    product_id int REFERENCES products(id),
    quantity_plan int CHECK (quantity_plan > 0) NOT NULL,
    product_price decimal(10, 2),
    contract_number varchar(30) NOT NULL,
    contract_address text CHECK (contract_address != '') NOT NULL,
    contract_date date NOT NULL,
    manufacturer_id int REFERENCES manufacturers(id),
);

CREATE TABLE shipments(
    id serial PRIMARY KEY,
    order_id int REFERENCES orders(id),
    shipment_date timestamp NOT NULL
);

CREATE TABLE products_to_shipments(
    product_id int REFERENCES products(id),
    shipment_id int REFERENCES shipments(id),
    product_quantity int NOT NULL 
);

