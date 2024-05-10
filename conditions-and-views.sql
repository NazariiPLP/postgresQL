SELECT * FROM users
WHERE gender is NULL;

ALTER TABLE orders
ADD COLUMN status boolean;




UPDATE orders
SET status = true
WHERE id % 2 = 0;

UPDATE orders
SET status = false
WHERE id % 2 = 1;


SELECT id, created_at, customer_id, status AS order_status FROM orders;


--- 1 syntax CASE

/*
CASE 
    WHEN condition1 = true
    THEN result1
    WHEN condition2 = true
    THEN result2
    ...
    ELSE result3
END;    
*/

-- вивести всі замовлення, там де статус true - написати "виконано", де статус false - написати "нове"

SELECT id, created_at, customer_id (
    CASE
    WHEN status = TRUE
    THEN 'виконано' 
    WHEN status = FALSE
    THEN 'нове'
    ELSE 'інший статус'
    END
) AS order_status
FROM orders
ORDER BY id;


-- 2 syntax CASE

/*
    CASE condition WHEN value1 THEN result1
                    WHEN value2 THEN result2
                    ...
        ELSE default_result
    END;
*/

-- Витягти місяць народження юзера і на його основі вивести, народився восени, навесні, влітку чи взимку

SELECT *, (
    CASE extract('month' from birthday)
        WHEN 1 THEN 'winter'
        WHEN 2 THEN 'winter'
        WHEN 3 THEN 'spring'
        WHEN 4 THEN 'spring'
        WHEN 5 THEN 'spring'
        WHEN 6 THEN 'summer'
        WHEN 7 THEN 'summer'
        WHEN 8 THEN 'summer'
        WHEN 9 THEN 'fall'
        WHEN 10 THEN 'fall'
        WHEN 11 THEN 'fall'
        WHEN 12 THEN 'winter'
        ELSE 'unknown'
    END
) AS "пора року" FROM users;



/*

Задача 1

Вивести юзерів, в яких в стовпці "стать_прописом" буде українською прописано "чоловік", "жінка", "інший варіант"

Задача 2

Вивести всі товари з  таблиці products
Якщо ціна більше 6 тис - флагман
Якщо ціна від до 2 до 6 тисяч - середній клас
Якщо ціна менше 2 тис - бюджетний

*/


SELECT id, name (
    CASE gender
        WHEN "male" THEN "чоловік"
        WHEN "female" THEN "жінка"
        ELSE "інший варіант"
END
) AS "стать прописом" FROM users;


SELECT *, (
    CASE price
        WHEN price > 6000 THEN "флагман"
        WHEN price BETWEEN 2000 AND 6000 THEN "середній клас"
        WHEM price < 2000 THEN "бюджетний"
        ELSE 'Інша невідома цінова категорія'
    END
) AS product_rate
FROM products
ORDER BY price;
