/*

order -> status:
- true = виконано
- false = не виконано
- ('new', 'processing', 'shiped', 'done', 'cancelled')

*/

INSERT INTO orders(customer_id, status) VALUES
(6003, 'new');

CREATE TYPE order_status AS ENUM('new', 'processing', 'shiped', 'done', 'cancelled');


ALTER TABLE orders
ALTER COLUMN status 
TYPE order_status
USING (
    CASE status
        WHEN false THEN 'processing'
        WHEN true THEN 'done'
        ELSE 'new'
    END
)::order_status;



SELECT * FROM orders
ORDER BY created_at DESC;


UPDATE orders
SET status = 'processing'
WHERE id = 3;