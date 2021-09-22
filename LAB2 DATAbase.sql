CREATE TABLE customers(
    id integer NOT NULL ,
    full_name varchar(50) NOT NULL ,
    timestamp timestamp NOT NULL ,
    delivery_adress text NOT NULL ,
    primary key (id)
);
CREATE TABLE products(
    id varchar NOT NULL ,
    name varchar NOT NULL UNIQUE ,
    description text,
    price double precision NOT NULL CHECK ( price>0 ) ,
    primary key (id)
);
CREATE TABLE orders(
    code integer NOT NULL ,
    customer_id integer,
    total_sum double precision NOT NULL CHECK ( total_sum>0 ),
    is_paid boolean NOT NULL ,
    primary key (code),
    foreign key (customer_id) references customers
);
CREATE TABLE order_items(
    order_code integer NOT NULL ,
    product_id varchar NOT NULL ,
    quantity integer NOT NULL CHECK ( quantity>0 ),
    primary key (order_code,product_id),
    foreign key (order_code) references orders,
    foreign key (product_id) references products
);
CREATE TABLE students_personal_information(
    full_name varchar(50) NOT NULL ,
    age integer NOT NULL ,
    birth_date varchar(20) NOT NULL ,
    gender char NOT NULL ,
    average_grade numeric(4,1) NOT NULL ,
    information_about_yourself text,
    dormitary varchar(3) NOT NULL ,
    additional_info text
);
CREATE TABLE instructors(
    full_name varchar(20) NOT NULL ,
    age integer NOT NULL CHECK ( age>0 ) ,
    speaking_languages text NOT NULL ,
    work_experience text ,
    remote_lessons varchar(3) NOT NULL
);
CREATE TABLE lessons(
    lesson_title varchar(40) NOT NULL ,
    room_number integer NOT NULL,
    instructor varchar(40) NOT NULL ,
    primary key (lesson_title)
);
CREATE TABLE lesson_participants(
    students varchar(20) NOT NULL ,
    lesson_title varchar(40) NOT NULL ,
    foreign key (lesson_title) references lessons
);
ALTER table students_personal_information
drop age;

ALTER table students_personal_information
add nationality;

UPDATE students_personal_information
SET additional_info='mature'
WHERE age>17;

DELETE from orders
WHERE is_paid=NO;

-- The differences between DDL and DML commands:
--1) DDL is used to define the database structure while DML allows to deal with data in databse;
--2)DDL commands usually affects whole database while DML commands affects some number of rows;

--Examples of DDL commands;
CREATE TABLE employees(
    name text,
    age integer
);
ALTER table employees
DROP age;

ALTER table employees
add birth_date;

--examples of DML commands;
SELECT *
from employees;

INSERT into employees(name,age) values(
                                       'Daulet',19);
UPDATE employees
SET age=20
WHERE name='Daulet';

DELETE from employees
WHERE name='Daulet';

