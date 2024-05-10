/*


CREATE FUNCTION function_name ([parameter1 data_type [, parameter2 data_type, ...]])
RETURNS return_data_type
AS
$$
BEGIN

    -- Тіло функції (операції)
    RETURN result;

END;
$$
LANGUAGE plpgsql; -- Мова програмування функції для Postgresql

*/

CREATE FUNCTION add_numbers(number1 integer, number2 integer)
RETURNS integer
AS
$$
BEGIN
    RETURN number1 + number2;
END;
$$
LANGUAGE plpgsql;

-- Виклик функції

SELECT add_numbers(5, 15);

-- Видалення функції

DROP FUNCTION add_numbers;
DROP FUNCTION add_numbers(integer, integer);