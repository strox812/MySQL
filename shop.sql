drop table if exists catalogs;
create table catalogs (
id SERIAL primary key,
name VARCHAR(255) comment 'Название раздела',
UNIQUE unique_name(name(10))
) comment = 'Разделы интернет-магазина';

-- ------------------------------------------------------------

-- INSERT INTO catalogs VALUES (NULL, 'Процессоры');
-- INSERT INTO catalogs (id, name) VALUES (NULL, 'Мат.платы');
-- INSERT INTO catalogs VALUES (DEFAULT, 'Видеокарты');

INSERT IGNORE INTO catalogs VALUES
(DEFAULT, 'Процессоры'),
(DEFAULT, 'Мат.платы'),
(DEFAULT, 'Видеокарты');

/*UPDATE
catalogs
SET
name = 'Процессоры (Intel)';
WHERE
name = 'Процессоры';*/

DROP TABLE IF EXISTS cat;
CREATE TABLE cat (
id SERIAL PRIMARY KEY,
name VARCHAR(255) comment 'Название раздела',
UNIQUE unique_name(name(10))
) comment = 'Разделы интернет-магазина';

/*INSERT INTO
cat
SELECT
*
FROM
catalogs;


SELECT * FROM cat; */

drop table if exists users;
create table users (
id SERIAL primary key,
name VARCHAR(255) comment 'Имя покупателя',
birthday_at DATE comment 'Дата рождения',
created_at DATETIME default CURRENT_TIMESTAMP,
updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
) comment = 'Покупатели';

drop table if exists products;
create table products (
id SERIAL primary key,
name VARCHAR (255) comment 'Название',
desription TEXT comment 'Описание',
price DECIMAL (11,2) comment 'Цена',
catalog_id INT unsigned,
created_at DATETIME default CURRENT_TIMESTAMP,
updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
key index_of_catalog_id (catalog_id)
) comment = 'Товарные позиции';

drop table if exists orders;
create table orders (
id serial primary key,
user_id INT unsigned,
created_at DATETIME default CURRENT_TIMESTAMP,
updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
key index_of_user_id (user_id)
) comment = 'Заказы';

drop table if exists orders_products;
create table orders_products (
id serial primary key,
order_id INT unsigned,
product_id INT unsigned,
total INT unsigned default 1 comment 'Количество заказанных товарных позиций',
created_at DATETIME default CURRENT_TIMESTAMP,
updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
) comment = 'Состав заказа';

drop table if exists discounts;
create table discounts (
id serial primary key,
user_id INT unsigned,
product_id INT unsigned,
discount FLOAT unsigned comment 'Величина скидки от 0.0 до 1.0',
started_at DATETIME,
finished_at DATETIME,
created_at DATETIME default CURRENT_TIMESTAMP,
updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
key index_of_user_id(user_id),
key index_of_product_id(product_id)
) comment = 'Скидки';

drop table if exists storehouses;
create table storehouses (
id serial primary key,
name VARCHAR(255) comment 'Название',
created_at DATETIME default CURRENT_TIMESTAMP,
updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
) comment = 'Склады';

drop table if exists storehouses_products;
create table storehouses_products (
id serial primary key,
storehouse_id INT unsigned,
product_id INT unsigned,
value INT unsigned comment 'Запас товарной позиции на складе',
created_at DATETIME default CURRENT_TIMESTAMP,
updated_at DATETIME default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP
) comment = 'Запасы на складе';
