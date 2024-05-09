-- 1 НФ: в кожній комірці зберігається атомарне значення (без списків ітп)
-- 2 НФ: 1 НФ + таблиця повинна мати ключ; ключ функціонально визначає всю строку
-- 3 НФ: 2 НФ + ми маємо прибрати транзитивні функціональні залежності атрибутів



----------------------

DROP TABLE employees, positions, departments;

----------------------

CREATE TABLE employees(
    id serial PRIMARY KEY,
    name varchar(200),
    position varchar(200) REFERENCES positions(name)
);

CREATE TABLE positions(
    name varchar(300) PRIMARY KEY,
    department varchar(300) REFERENCES departments(name),
    car_aviability boolean
);

CREATE TABLE departments(
    name varchar(200) PRIMARY KEY,
    phone_number varchar(15)
);


----------------------

INSERT INTO departments VALUES
('Top management', '11-11-11'),
('Operational direction', '22-22-22'),
('Financial direction', '33-33-33'),
('Developers direction', '44-44-44');

----------------------

INSERT INTO positions VALUES
('CFO', 'Top management', true),
('CEO', 'Top management', true),
('SMM/PR division', 'Operational direction', false),
('Accountant', 'Financial direction', false),
('JS developer', 'Developers direction', false),
('Sales manager', 'Operational direction', false),
('Bodyguard for developers', 'Operational direction', true),
('Driver', 'Operational direction', true);


----------------------


INSERT INTO employees (name, position) VALUES
('John', 'JS developer'),
('Jane', 'Sales manager'),
('Jake', 'Bodyguard for developers'),
('Andrew', 'Driver'),
('Milena', 'CFO'),
('Sergey', 'CEO'),
('Matthew', 'SMM/PR division'),
('Timofey', 'Accountant');


---------------------- Дістаємо інфу про співробітника + доступне / не доступне авто


SELECT employees.id, employees.name, employees.position, positions.car_aviability FROM 
employees JOIN positions
ON employees.position = positions.name;

---------------------- Дістаємо інфу про співробітника + номер телефону відділу + доступне / не доступне авто

SELECT employees.id, employees.name, employees.position, positions.car_aviability, departments.phone_number AS "Department phone number" FROM 
employees JOIN positions
ON employees.position = positions.name
JOIN departments
ON positions.department = departments.name;
