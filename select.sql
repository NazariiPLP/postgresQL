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

