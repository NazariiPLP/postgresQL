-- 1 НФ: в кожній комірці зберігається атомарне значення (без списків ітп)
-- 2 НФ: 1 НФ + таблиця повинна мати ключ; ключ функціонально визначає всю строку
-- 3 НФ: 2 НФ + ми маємо прибрати транзитивні функціональні залежності атрибутів
-- 4 НФ: неключові транзитивні залежності не можуть бути в складі складеного ключа


/*

-- teachers

-- students

-- subjects

Обмеження:
1 викладач може вести тільки 1 предмет


-- teachers 1:m subjects

- students m:n subjects

-- students m:n teachers

*/

------------------------------------

CREATE TABLE students (
    id serial PRIMARY KEY,
    name varchar(30)
);

INSERT INTO students (name) VALUES 
('Ivanov'),
('Petrov'),
('Sidorov');

------------------------------------

CREATE TABLE teachers (
    id serial PRIMARY KEY,
    name varchar(30),
    subject varchar(50) REFERENCES subjects(name)
);

CREATE TABLE subjects(
    name varchar(50) PRIMARY KEY
);

INSERT INTO subjects VALUES
('Системи штучного інтелекту'),
('Хмарний компьютинг');

INSERT INTO teachers(name, subject) VALUES 
('Smirnov', 'Системи штучного інтелекту'),
('Petrenko', 'Хмарний компьютинг');

--------------------------------------------

CREATE TABLE students_to_teachers(
    teacher_id int REFERENCES teachers(id),
    student_id int REFERENCES students(id),
    PRIMARY KEY (teacher_id, student_id)
);


/*
Обмеження:
1 викладач може вести тільки 1 предмет
*/
INSERT INTO students_to_teachers VALUES
(1, 1),
(1, 2),
(2, 1);



--------------------------------------------

/*
                                +               +                   +
Задача: реалізуваьт витяг, який студент, який предмет вивчає і хто викладає предмет


students -> students_to_teachers -> teachers

*/

SELECT students.id, students.name, teachers.name, teachers.subject FROM 
students JOIN students_to_teachers
ON students.id = students_to_teachers.student_id
JOIN teachers
ON students_to_teachers.teacher_id = teachers.id;