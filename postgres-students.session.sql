-- Ключ - ознака (найчастіше штучна) яка відрізняє один запис у таблиці від іншого
-- Первинний ключ (PRIMARY KEY) - використовується для того, щоб ключу дати обмеження унікальності (UNIQUE) і обмеження NOT NULL
-- Група стовпців - стовпець (група стовпців) які могли статти первинним ключем, але ще не обрані як такі
-- Зовнішній ключ (foreing keys) - стовпець (група стовпців) які містять значення, які посилаються на ідентифікатори в інших таблицях 


/*

Задача: МІНІ-ЮТУБ

Таблиця контенту:
- назва
- опис
- автоп (юзер, який створив контент)
- дата створення 


Реакції
- is_liked:
    - null - користувач не ставив оцінку взагалі
    - true - контекнт лайкнули
    - false - контент дізлайкнули

У контента може бути багато реакцій від користувачів
Реакції - зв'язок між користувачем і контентом    


*/

CREATE TABLE contents(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK(name != ''),
    description text,
    author_id int REFERENCES users(id),
    created_at timestamp DEFAULT current_timestamp
);

CREATE TABLE reactions(
    content_id int REFERENCES contents(id),
    user_id int REFERENCES users(id),
    is_liked boolean
);

INSERT INTO contents(name, author_id) VALUES
('Funny dogs', 3);

INSERT INTO reactions VALUES -- додати реакцію
(1, 1, true);