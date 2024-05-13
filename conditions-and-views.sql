CREATE SCHEMA new_schema;

CREATE TABLE new_schema.users(
    first_name varchar(20) NOT NULL CHECK(first_name != ''),
    last_name varchar(20) NOT NULL CHECK(last_name != ''),
    email varchar(20) NOT NULL CHECK(email != '')
);
