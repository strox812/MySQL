drop table if exists catalogs;
create table catalogs (
id INT unsigned,
name varchar(255) comment 'Название раздела'
) comment = 'Разделы интернет-магазина';

drop table if exists users;
create table users (
id INT unsigned,
name varchar(255) comment 'Имя покупателя'
) comment = 'Покупатели';

drop table if exists products;
create table products (
id INT unsigned,
name varchar(255) comment 'Название',
desription TEXT comment 'Описание',
price DECIMAL (11,2) comment 'Цена',
catalog_id INT unsigned
) comment = 'Товарные позиции';

drop table if exists orders;
create table orders (
id INT unsigned,
user_id INT unsigned
) comment = 'Заказы';

drop table if exists orders_products;
create table orders_products (
id INT unsigned,
order_id INT unsigned,
product_id INT unsigned,
total INT unsigned default 1 comment 'Количество заказанных товарных позиций'
) comment = 'Состав заказа';

drop table if exists discounts;
create table discounts (
id INT unsigned,
user_id INT unsigned,
product_id INT unsigned,
discount FLOAT unsigned comment 'Величина скидки от 0.0 до 1.0'
) comment = 'Скидки';

drop table if exists storehouses;
create table storehouses (
id INT unsigned,
name VARCHAR(255) comment 'Название'
) comment = 'Склады';

drop table if exists storehouses_products;
create table storehouses_products (
id INT unsigned,
storehouse_id INT unsigned,
product_id INT unsigned,
value INT unsigned comment 'Запас товарной позиции на складе'
) comment = 'Запасы на складе';
