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
