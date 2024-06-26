/*

Транзакція - послідовність одного або декількох SQL запитів, які об'єбднуються в одну логічну операцію

*/

/* Синтаксис транзакцій:

BEGIN; --Початок транзакції

-- Ваші SQL запити тут (наприклад, вставка, оновлення, видалення даних)

COMMIT; -- Збергіаємо (фіксуємо) зміни


-- Якщо сталася помилка або щось пішло не так
ROLLBACK; -- Скасовуємо транзакцію та відміняємо зміни


-- Кінець транзакції


*/


BEGIN;

-- 1: створити замовлення
INSERT INTO orders(customer_id, status) VALUES
(6004, 'new')
RETURNING id;

-- 2: наповнити замовлення
INSERT INTO orders_to_products(order_id, product_id, quantity) VALUES
(LASTVAL(), 1, 1),
(LASTVAL(), 2, 3),
(LASTVAL(), 3, 1); 

COMMIT;


ROLLBACK;