-- Ключ - ознака (найчастіше штучна) яка відрізняє один запис у таблиці від іншого
-- Первинний ключ (PRIMARY KEY) - використовується для того, щоб ключу дати обмеження унікальності (UNIQUE) і обмеження NOT NULL
-- Група стовпців - стовпець (група стовпців) які могли статти первинним ключем, але ще не обрані як такі
-- Зовнішній ключ (foreing keys) - стовпець (група стовпців) які містять значення, які посилаються на ідентифікатори в інших таблицях 


/*

Задача: реалізуйте чат між юзерами.

В кожного чата є власник (owner).
В кожного юзера може бути багато чатів. В одному чаті - багато юзерів.
В кожному чаті - багато повідомлень. Одне повідомленнч - в одному чаті.


*/

CREATE TABLE chats (
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK(name != ''),
    owner_id int REFERENCES users(id),
    created_at timestamp DEFAULT current_timestamp
);

INSERT INTO chats(name, owner_id) VALUES -- створення чату
('superchat', 2);

CREATE TABLE chats_to_users(
    chat_id int REFERENCES chats(id),
    user_id int REFERENCES users(id),
    join_at timestamp DEFAULT current_timestamp,
    PRIMARY KEY (chat_id, user_id)
);

INSERT INTO chats_to_users(chat_id, user_id) VALUES -- додавання до чату учасників
(2, 2);

INSERT INTO chats_to_users(chat_id, user_id) VALUES -- додавання до чату учасників
(2, 3);

CREATE TABLE messages(
    id serial PRIMARY KEY, 
    body text NOT NULL CHECK(body != ''),
    created_at timestamp DEFAULT current_timestamp,
    is_read boolean NOT NULL DEFAULT false,
    -- author_id int REFERENCES chats_to_users(user_id),
    -- chat_id int REFERENCES chats_to_users(chat_id)
    author_id int,
    chat_id int,
    FOREIGN KEY (author_id, chat_id) REFERENCES chats_to_users(user_id, chat_id)
);

INSERT INTO messages (body, author_id, chat_id) VALUES -- додавання повідомлень до чату
('go for coffe?', 3, 2),
('go', 2, 2);