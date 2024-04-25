-- Ключ - ознака (найчастіше штучна) яка відрізняє один запис у таблиці від іншого
-- Первинний ключ (PRIMARY KEY) - використовується для того, щоб ключу дати обмеження унікальності (UNIQUE) і обмеження NOT NULL
-- Потенційний ключ - стовпець (група стовпців) які могли стати первинним ключем, але ще не обрані як такі.
-- Зовнішній ключ (foreign key) - стовпець (група стовпців) які містять значення, які посилаються на ідентифікатори в інших таблицях


-- 1:1


CREATE TABLE coaches(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK(name != '')
);

CREATE TABLE teams(
    id serial PRIMARY KEY,
    name varchar(256),
    coach_id int REFERENCES coaches(id)
);

-- + 1. Спочатку створюємо тренерів без зовнішнього ключа
-- + 2. Створюємо таблицю команд (з зовнішнім ключем)
-- + 3. За допомогою ALTER додати зовнішній ключ до таблиці coaches

ALTER TABLE coaches
ADD COLUMN team_id int REFERENCES teams(id);

-------

INSERT INTO coaches(name, team_id) VALUES
('Ivanov', NULL);

INSERT INTO teams(name, coach_id) VALUES
('Monreal', 1);

-- Оновлення інформації в таблиці коучів
-- коуч має відображати, яку команду він тренує (стовпець team_id)