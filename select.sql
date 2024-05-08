--- 1

CREATE TABLE emoloyees(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK(name !=''),
    salary int NOT NULL CHECK(salary >= 0),
    work_hours int NOT NULL CHECK(work_hours >= 0)  
);

--- 2

INSERT INTO emoloyees(name, salary, work_hours) VALUES
('Ivanov', 400, 80),
('Petrov', 750, 185),
('Sidorov', 0, 0);

--- 3

UPDATE emoloyees
SET salary = salary * 1.2
WHERE work_hours > 150;


----

INSERT INTO users (first_name, last_name, email, gender, birthday, is_subscribe) VALUES
('Test', 'Testovich', 'test@gmail.com', 'gender', '1800-12-12', false) RETURNING *;

DELETE FROM users
WHERE id = 5;


---------------------

-- Задача: вивести всіх користувачів з інфою про них + вік


SELECT id, first_name, last_name, birthday, extract("years" from age(birthday)) FROM users;


UPDATE users
SET birthday = '2005-01-01'
WHERE (gender = 'female' AND is_subscribe);


----------------------
-- make_interval(years, month, [days]) - функція, яка створжю власний інтервал

SELECT id, first_name, last_name, make_interval(40, 8) FROM users;


----------------------

-- Аліаси - псевдоніми
-- Якщо кирилиця - обов'язково лапки
-- Якщо латиниця - можна з лапками або без
SELECT first_name AS "Ім'я", last_name AS "Прізвище", id AS "особистий номер" FROM users;


SELECT id, first_name, last_name, birthday, extract("years" from age(birthday)) AS years FROM users
WHERE extract("years" from age(birthday)) BETWEEN 2 and 10;

SELECT id, first_name, last_name, birthday, extract("years" from age(birthday)) AS "years old" FROM users
WHERE extract("years" from age(birthday)) BETWEEN 2 and 10;


-----------------------

/*

Пагінація - спосіб розділити великий об'єм інформації на менші частини 

1) Нам потрібні сторінки
2) Нам потрібно знати, яка кількість результатів буде відображатись на кожній сторінці

*/

-- LIMIT - задача кількість результатів, яку потрібно отримати
--           (кількість результатів на сторінці)

 -- 50 * 4

-- Скільки потрібно відступати (формуоа для розрахуку OFFSET)
/*

У цій формулі, перша сторінка буде вважатимь нульовою

OFFSET = LIMIT * сторінка_яку_ми_запитуємо - 1
*/



--------------------


SELECT id first_name || ' ' || last_name AS "full name", gender, email FROM users;

SELECT id, concat(first_name, ' ', last_name) AS "full name", gender, email FROM users;

/*

Задача: знайти всіх користувачів, повне ім'я яких (ім'я + прізвище) > 5 символів

*/

-- варіант 1

SELECT id, concat(first_name, last_name) AS "full name", gender, email FROM users
WHERE char_length(concat(first_name, last_name)) < 10;


-- варіант 2
SELECT * FROM
(
    SELECT id, concat(first_name, last_name) AS "full name", gender, email FROM users
)  AS "FN"
WHERE char_length("FN"."full name") < 10; -- фільтрація відбувається у основному запиті

/*


Створити таблицю workers:
- id
- name
- salary
- birthday

*/

CREATE TABLE workers(
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK (name != ''),
    salary int NOT NULL CHECK (salary >= 0),
    birthday date NOT NULL CHECK (birthday < current_date)
);

INSERT INTO workers(name, salary, birthday) VALUES
('Oleg', 300, '1968-03-26');

INSERT INTO workers(name, salary, birthday) VALUES
('Yaroslawa', 500, '1958-09-12');

INSERT INTO workers(name, salary, birthday) VALUES
('Sasha', 1000, '1990-12-30'),
('Masha', 200, '1985-11-01');

UPDATE workers
SET salary = 500
WHERE id = 1;

UPDATE workers
SET salary = 400
WHERE salary > 500;

SELECT * FROM workers
WHERE salary >= 400;

SELECT * FROM workers
WHERE id = 4;

SELECT salary, extract("years" from age(birthday)) AS "years old" FROM workers
WHERE id = 1;

SELECT * FROM workers
WHERE name = 'Yaroslawa';

SELECT * FROM workers
WHERE extract('years' from age(birthday)) = 30 OR salary > 800;

SELECT *, extract(years from age(birthday)) AS "age" FROM workers
WHERE extract(years from age(birthday)) BETWEEN 25 and 28;

SELECT * FROM workers
WHERE extract('month' from birthday) = 9;

DELETE FROM workers
WHERE id = 4;

DELETE FROM workers
WHERE name = 'Oleg';

DELETE FROM workers
WHERE extract('years' from age(birthday)) > 30;

/*

1. Додайте робітника з ім'ям Олег, з/п 300

2. Додайте робітницю Ярославу, з/п 500

3. Додайте двох новиз працівників одним запитом
Сашу, з/п 1000
Машу, з/п 200

4. Встановити Олегу з/п 500

5. Всім, у кого з/п більше 500, врізати з/п до 400

6. Вибрати (SELECT) всіх працівників, чия з/п більше 400

7. Вибрати робітника з id = 4

8. Дізнатися (SELECT) з/п та вік Жені

9. Спробувати знайти робітника з ім'ям "Petya"

10. Вибрати працівників у віці 30 років АБО з з/п > 800
WHERE _кількість_років_ = 30 OR salary > 800;

11. Вибрати всіх працівників у віці від 25 до 28 років

12. Вибрати всіх працівників, що народились у вересні

13. Видалити робітника з id = 4

14. Видалити Олега

15. Видалити всіх робітників старших за 30 років

*/



--- Агрегатні функції - функції, які виконують якусь операцію над групою рядків в межах стовпця і повертають одне значення
--- COUNT, SUM, AVG, MIN, MAX

SELECT max(weight) FROM users;

SELECT min(weight) FROM users;

SELECT sum(weight) FROM users;

SELECT avg(weight) FROM users;

-- Підрахувати кількість записів в таблиці

SELECT count(id) FROM users;

-- Знайти середню вагу чоловік і жінок (окремо)

SELECT gender, avg(weight) FROM users
GROUP BY gender;

-- Знайти середню вагу чоловіків

SELECT avg(weight) FROM users
WHERE gender = 'male';

-- Знайти середню вагу всіх користувачів, старших за 10 років

SELECT avg(weight) FROM users
WHERE extract('years' from age(birthday)) > 10;

SELECT brand, avg(price) FROM products
GROUP BY brand;


-- Сортування - впорядкування даних за певними ознаками

-- ASC - за збільшенням (default)
-- DESC - за зменшенням

SELECT * FROM users
ORDER BY birthday ASC,
            first_name ASC;

UPDATE users
SET birthday = '2002-09-14'
WHERE id BETWEEN 2 and 4;

-- Вивести 3 телефони, яких залишилось найменше

SELECT * FROM products
ORDER BY quantity ASC
LIMIT 3;

SELECT * FROM products
ORDER BY price ASC;

SELECT * FROM products
ORDER BY price DESC
LIMIT 5;



-- Фільтрація груп

/*

Знайти кількість користувачів у кожній віковій групі

*/

SELECT count(*) AS "кількість" extract('years' from age(birthday)) AS "вікова група"
FROM users
GROUP BY "вікова група"
ORDER BY "вікова група";

/*

Модифікувати запит таким чином, щоб залишились вікові групі, де < 500 користувачів

*/

SELECT count(*), extract('years' from age(birthday)) AS "вікова група"
FROM users
GROUP BY "вікова група"
HAVING count(*) < 500;



--- РЕЛЯЦІЙНІ ОПЕРАЦІЇ

CREATE TABLE A (
    v char(3),
    t int 
);

CREATE TABLE B (
    v char (3)
);

INSERT INTO A VALUES
('XXX', 1),
('XXY', 1),
('XXZ', 1),
('XYX', 2),
('XYY', 2),
('XYZ', 2),
('YXX', 3),
('YXY', 3);
('XYZ', 3);

INSERT INTO B VALUES
('ZXX'),
('XXX'), -- A
('ZXZ'),
('YXZ'), -- A
('YXY'); -- A

SELECT * FROM A, B;

-- UNION - об'єднання
-- (все, те, що в A + все те, що в B. Спільне - в одному екземплярі)

-- INTERSEC - перетин множин
-- (все те, що є і в A, і в B в єдиному екземплярі)

-- Різниця:
---- А мінус В - все з А мінус спільні елементи для А і В
---- В мінус А - все з А мінус спільні елементи для В і А

SELECT v FROM A
UNION 
SELECT * FROM B; -- ОТРИМАЄМО ВСІ УНІКАЛЬНІ ЗАПИСИ З ДЖВОХ ТАБЛИЦЬ БЕЗ ДУБЛЮВАНЬ

SELECT v FROM A
INTERSECT
SELECT * FROM B; -- ОТРИМАЄ 3 ЕЛЕМЕНТИ, ЯКІ ПОВТОРЮЮТЬСЯ В ДВОХ ТАБЛИЦЯХ

SELECT v FROM A
EXCEPT
SELECT * FROM B; -- ОТРИМАЄМО ВСІ ЕЛЕМЕНТИ З ТАБЛИЦЯ А, МІНУС ЕЛЕМЕНТИ З ТАБЛИЦІ В

SELECT * FROM B
EXCEPT
SELECT v FROM A; -- ОТРИМАЄМО ВСІ ЕЛЕМЕНТИ З ТАБЛИЦЯ B, МІНУС ЕЛЕМЕНТИ З ТАБЛИЦІ A

---------------

SELECT count(*)
FROM products;

SELECT avg(price)
FROM products;

SELECT brand, avg(price)
FROM products
GROUP BY brand;

SELECT avg(price)
FROM products
WHERE brand = 'Samsung';

SELECT *
FROM products
ORDER BY price DESC
LIMIT 5;

INSERT INTO users (first_name, last_name, email, gender, is_subscribe, birthday)
VALUES
('User 1', 'Test 1', 'email1@gmail.com', 'male', true, '1990-09-10'),
('User 2', 'Test 2', 'email2@gmail.com', 'female', true, '1990-09-10'),
('User 3', 'Test 3', 'email3@gmail.com', 'male', false, '1990-09-10');

-- Задача: знайти id юзерів, які робили замовлення

SELECT id FROM users
INTERSECT
SELECT customer_id FROM orders;

-- Задача: знайти id юзерів, які не робили замовлень

SELECT id FROM users
EXCEPT
SELECT customer_id FROM orders;



------ Поєднання множин
/*

Поєднання множин - операція, яка об'єднує дві чи більше множин в одну множину.

*/

SELECT A.v AS "id", A.t AS "price", B.v AS "phone.id"
FROM a, b
WHERE A.v = B.v;


----


SELECT A.v AS "id", A.t AS "price", B.v AS "phone.id"
FROM A JOIN B
On A.v = B.v;

-- Задача: знайти всі замовлення бзера, у якого id = 4

SELECT *
FROM users JOIN orders
ON orders.customer_id = user.id
WHERE users.id = 5;

------

SELECT u, *, o.id AS "order_id"
FROM users AS u JOIN orders AS o
ON o.customer_id = u.id
WHERE u.id = 4;

------

SELECT *
FROM A JOIN B ON A.v = B.v
JOIN products ON A.t = products.id;

--- Знайти id всіх замовлень, де були замовлені телефони Samsung
SELECT *
FROM products AS p JOIN orders_to_products AS otp
ON p.id = otp.products_id
WHERE p.brand = 'Samsung';

-- Модифікуйте попередній запит. Порахуйте, скільки замовлень бренду Самсунг

SELECT count(*)
FROM products AS p JOIN orders_to_products AS otp
ON p.id = otp.products_id
WHERE p.brand = 'Samsung';

-- Зробити топ продажів. Який бренд найчастіше купували?

SELECT count(*)
FROM products AS p JOIN orders_to_products AS otp
ON p.id = otp.products_id
GROUP BY p.brand
ORDER BY "quantity" DESC;

--- Задача: знайти юзерів, які нічого не замовляли

-- варіант 1

SELECT * FROM 
users AS u LEFT JOIN orders AS o
ON u.id = o.customer_id
WHERE o.customer_id IS NULL;


-- варіант 2

SELECT * FROM users
WHERE id IN (
    SELECT id FROM users
    EXCEPT
    SELECT customer_id FROM orders;
);

--- Задача: знайти всіх юзерів і сумарну кількість їх замовлень

SELECT u.*, count(*) FROM
users AS u JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id;

INSERT INTO products (brand, model, category, price, quantity)
VALUES ('Microsoft', '12345', 'phones', 200, 2);


/*

1. Порахувати середній чек по всьому магазину

2. Витягти всі замовлення вище середнього чека

3. Витягти всіх коористувачів, в яких кількість замовлень вище середнього

4. Витягти кількість користувачів та кількість товарів, які вони замовляли (кількість замовлень * quantity)

*/

-- 1

SELECT avg(owc.cost) FROM (
    -- запит знаходить суму кожного замовлення
    SELECT otp.order_id, sum(p.price * otp.quantity) AS cost FROM 
    orders_to_products AS otp JOIN products AS p
    ON otp.products_id = p.id
    GROUP BY otp.order_id
) AS owc;

-- 2

SELECT owc.* FROM ( -- orders with cost
    -- запит знаходить суму кожного замовлення
    SELECT otp.order_id, sum(p.price * otp.quantity) AS cost FROM 
    orders_to_products AS otp JOIN products AS p
    ON otp.products_id = p.id
    GROUP BY otp.order_id;
) AS owc
WHERE owc.cost > (
    SELECT avg(own.cost) FROM (
    -- запит знаходить суму кожного замовлення
    SELECT otp.order_id, sum(p.price * otp.quantity) AS cost FROM 
    orders_to_products AS otp JOIN products AS p
    ON otp.products_id = p.id
    GROUP BY otp.order_id
    ) AS owc
);

-- 3

WITH orders_with_counts AS (
    -- Кількість замовлень кожного користувача
    SELECT customer_id, count(*) AS orders_count FROM orders
    GROUP BY customer_id
)

SELECT * FROM 
orders_with_counts JOIN users
ON user.id = orders_with_counts.customer_id
WHERE orders_with_counts.orders_count > (
    SELECT avg(orders_with_counts.orders_count) FROM orders_with_counts
);

-- 4

SELECT u.id, i.first_name, u.last_name, sum(otp.quantity) AS "products quantity" FROM
users AS u JOIN orders AS o
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
GROUP BY u.id;