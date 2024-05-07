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
('YXY');

SELECT * FROM A, B;

-- UNION - об'єднання
-- (все, те, що в A + все те, що в B. Спільне - в одному екземплярі)

-- INTERSEC - перетин множин
-- (все те, що є і в A, і в B в єдиному екземплярі)

-- Різниця:
---- А мінус В - все з А мінус спільні елементи для А і В
---- В мінус А - все з А мінус спільні елементи для В і А

SELECT * FROM A
UNION 
SELECT * FROM B; -- ОТРИМАЄМО ВСІ УНІКАЛЬНІ ЗАПИСИ З ДЖВОХ ТАБЛИЦЬ БЕЗ ДУБЛЮВАНЬ

SELECT * FROM A
INTERSECT
SELECT * FROM B; -- ОТРИМАЄ 3 ЕЛЕМЕНТИ, ЯКІ ПОВТОРЮЮТЬСЯ В ДВОХ ТАБЛИЦЯХ

SELECT * FROM A
EXCEPT
SELECT * FROM B; -- ОТРИМАЄМО ВСІ ЕЛЕМЕНТИ З ТАБЛИЦЯ А, МІНУС ЕЛЕМЕНТИ З ТАБЛИЦІ В
