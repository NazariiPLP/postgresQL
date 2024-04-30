SELECT * FROM users;


--------


SELECT id, first_name, last_name, email FROM users;



--------


SELECT id, first_name, last_name, email FROM users
WHERE id > 2;



SELECT id, first_name, last_name, email FROM users
WHERE gender = 'male';


SELECT email FROM users
WHERE is_subscribe;

SELECT email FROM users
WHERE is_subscribe = 'false';


--------



/*

Задача: знайти всіх користувачів, у яких висота (height) не NULL

*/

SELECT * FROM users
WHERE height IS NOT NULL;


/*

Задача: знайти всіх користувачів, які не підписались на розсилку

*/

SELECT first_name, last_name, email, is_subscribe FROM users
WHERE is_subscribe is false;



---------------------------

SELECT first_name, last_name, email FROM users
WHERE first_name = 'Peter';

/*

У нас є діапазон імен ('William', 'John', 'Jason')
Задача: знайти всіх юзерів, які входять у діапазон

*/

SELECT first_name, last_name, email FROM users
WHERE first_name IN ('Peter', 'Susan');

SELECT first_name, last_name, email FROM users
WHERE first_name NOT IN ('DRACO', 'Susan');

-----------------------------

/*

Задача: знайти всіх юзерів, у яких id між 1 і 4

*/

-- варіант 1
SELECT first_name, last_name, id FROM users
WHERE id > 1 AND id < 4;


-- варіант 2
SELECT first_name, last_name, id FROM users
WHERE id BETWEEN 2 and 3;

-----------------------------


/*

Задача: Знайти всіх юзерів, ім'я яких починається на буквук 'P'

% - будь-яку кількість будь-яких символів
_ - 1 будь-який символ

*/

SELECT first_name, last_name FROM users
WHERE first_name LIKE 'P%';

/*

Задача: Знайти всіх юзерів, у яких рівно 5 символів у імені

*/

SELECT first_name, last_name FROM users 
WHERE first_name LIKE '_____';

/*

Задача: знайти всіх юзерів, у яких ім'я складається з 5 символів і починається на S

*/

SELECT first_name, last_name FROM users
WHERE first_name LIKE 'S____';

/*

Задача: Знайти всіх юзерів, у яких ім'я закінчується на 'a' 

*/

SELECT first_name, last_name FROM users
WHERE first_name LIKE '%n';





---------------------------


ALTER TABLE users
ADD COLUMN weight int CHECK(weight != 0 AND weight >0); 

----------------------------

UPDATE users
SET weight = 60;

----------------------------

UPDATE users
SET weight = 100
WHERE id BETWEEN 2 and 4;

----------------------------

UPDATE users
SET weight = 95
WHERE id = 4;

