DROP DATABASE IF EXISTS films;
CREATE DATABASE IF NOT EXISTS films;
USE films;
SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE countries(
    country_id smallint primary key,
    country varchar(50),
    last_update date
);

CREATE TABLE cities(
    city_id int primary key,
    city varchar(50),
    last_update date,
    country_id smallint,
    constraint foreign key (country_id) references countries(country_id)
);

CREATE TABLE address(
    address_id int primary key,
    address varchar(255),
    address2 varchar(255),
    district varchar(255),
    postal_code char(5),
    phone char(9),
    last_update date,
    city_id int,
    constraint foreign key (city_id) references cities(city_id)
);

CREATE TABLE language(
    language_id int primary key,
    name varchar(255),
    last_update date
);

CREATE TABLE films(
    film_id int primary key,
    title varchar(255),
    description varchar(255),
    release_year year,
    rental_duration smallint,
    rental_rate double,
    length int,
    replacement_cost double,
    rating char(2),
    special_features varchar(255),
    last_update date,
    language_id int,
    original_language_id int,
    constraint foreign key (language_id) references language(language_id),
    constraint foreign key (original_language_id) references language(language_id)
);

CREATE TABLE actor(
    actor_id int primary key,
    first_name varchar(255),
    last_name varchar(255),
    last_update date
);

CREATE TABLE category(
    category_id int primary key,
    name varchar(255),
    last_update date
);

CREATE TABLE inventory(
    inventory_id int primary key,
    last_update date,
    store_id int,
    film_id int,
    constraint foreign key (store_id) references store(store_id),
    constraint foreign key (film_id) references films(film_id)
);

CREATE TABLE store(
    store_id int primary key,
    manager_staff_id int,
    last_update date,
    address_id int,
    constraint foreign key (manager_staff_id) references staff(staff_id),
    constraint foreign key (address_id) references address(address_id)
);

CREATE TABLE customer(
    customer_id int primary key,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(50),
    active bool,
    create_date date,
    last_update date,
    address_id int,
    store_id int,
    constraint foreign key (address_id) references address(address_id),
    constraint foreign key (store_id) references store(store_id)
);

CREATE TABLE rental(
    rental_id int primary key,
    rental varchar(50),
    rental_date date,
    return_date date,
    last_update date,
    customer_id int,
    staff_id int,
    inventory_id int,
    constraint foreign key (customer_id) references customer(customer_id),
    constraint foreign key (staff_id) references staff(staff_id),
    constraint foreign key (inventory_id) references inventory(inventory_id)
);

CREATE TABLE staff(
    staff_id int primary key,
    first_name varchar(255),
    last_name varchar(255),
    picture varchar(255),
    email varchar(50),
    active bool,
    username varchar(255),
    password varchar(255),
    last_update date,
    address_id int,
    store_id int,
    constraint foreign key (address_id) references address(address_id),
    constraint foreign key (store_id) references store(store_id)
);


CREATE TABLE payment (
    payment_id int primary key,
    customer_id int,
    rental_id int,
    staff_id int,
    amount double,
    payment_date date,
    last_update date,
    constraint foreign key (customer_id) references customer(customer_id),
    constraint foreign key (rental_id) references rental(rental_id),
    constraint foreign key (staff_id) references staff(staff_id)
);

CREATE TABLE film_actor (
    film_id int,
    actor_id int,
    last_update date,
    primary key (film_id, actor_id),
    constraint foreign key (film_id) references films(film_id),
    constraint foreign key (actor_id) references actor(actor_id)
);

CREATE TABLE film_category (
    film_id int,
    category_id int,
    last_update date,
    primary key (film_id, category_id),
    constraint foreign key (film_id) references films(film_id),
    constraint foreign key (category_id) references category(category_id)
);

SET FOREIGN_KEY_CHECKS = 1;
