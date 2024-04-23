-- Ключ - ознака (найчастіше штучна) яка відрізняє один запис у таблиці від іншого
-- Первинний ключ (PRIMARY KEY) - використовується для того, щоб ключу дати обмеження унікальності (UNIQUE) і обмеження NOT NULL

/*

Створити таблицю books

В книги є:
1. Порядковий номер
2. Автор книги
3. Назва книги
4. Рік випуску
5. Видавництво
6. Категорія
7. Синопсиси 
8. Кількість примірників
9. Статус -- книга видана / не видана 

ALTER: 

1. Додати Lо таблиці обмеження, що кількість примірників (пункт 8) не може бути менше 0

* 2. Додати до таблиці обмеження, що автор + назва книги не може бути пустим рядкои і має бути унікальним

*/

CREATE TABLE books(
    id serial PRIMARY KEY,
    author varchar(256),
    name varchar(300),
    year varchar(4),
    publisher varchar(256),
    category varchar(256),
    synopsys text,
    quantity int,
    status boolean
);

ALTER TABLE books
ADD CONSTRAINT "quaintity_more_zero" CHECK (quantity >= 0);

ALTER TABLE books
ADD CONSTRAINT "author_name_unique" UNIQUE(author, name);

INSERT INTO books(author, name, quantity) VALUES
('Оноре де Бальзак', 'Гобсек', 200);

INSERT INTO books(author, name, quantity) VALUES
('Оскар Уальд', 'Портрет Доріана Грея', 0);

INSERT INTO books(author, name, quantity) VALUES
('Оноре де Бальза', 'Шагренева Шкіра', 1500);
