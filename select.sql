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

SELECT * FROM users
LIMIT 50
OFFSET 200; -- 50 * 4

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
WHERE _кількість_років_ = 30 OR salary > 80;

11. Вибрати всіх працівників у віці від 25 до 28 років

12. Вибрати всіх працівників, що народились у вересні

13. Видалити робітника з id = 4

14. Видалити Олега

15. Видалити всіх робітників старших за 30 років

*/