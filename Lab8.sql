CREATE FUNCTION incr(input integer)
returns int
language plpgsql
as
$$
declare
arb integer ;
begin
arb=1;
return input+arb;
end;
$$;

CREATE FUNCTION sum(inp1 integer,inp2 integer)
returns int
language plpgsql
as
    $$
    declare arb integer;
        BEGIN
        arb=inp1+inp2;
        return arb;
    end;
$$;

CREATE FUNCTION check_if(inp1 integer)
returns bool
language plpgsql
as
    $$
    BEGIN
        if inp1%2=0 then
            return true;
    end if;
        end;
$$;

CREATE FUNCTION check_passw(passw varchar)
returns bool
language plpgsql
as
    $$BEGIN
    if passw not like '%a' then
        return false;
    end if;
end;
$$;



--2)
--a)
CREATE OR REPLACE FUNCTION times()
RETURNS TRIGGER AS
$ex$
    BEGIN
        SELECT now();
    end;
    $ex$;

CREATE TRIGGER ex1 AFTER INSERT or UPDATE or DELETE on transactions
    FOR EACH ROW EXECUTE PROCEDURE times();

--b)
CREATE OR replace FUNCTION pr2()
returns TRIGGER
language plpgsql
as $$
    BEGIN
        return now()-students_personal_information.age;
    end;
    $$;
CREATE TRIGGER ex2 AFTER INSERT on students_personal_information
    referencing new row as nrow
    for each row
    execute procedure pr2(nrow.birth_date);

--c)
CREATE Procedure pr3(inp varchar)
language plpgsql
as $$
    begin
        UPDATE orders
        SET price=price*3 WHERE bar_code=inp;
    end;
    $$;

CREATE TRIGGER ex3 AFTER INSERT on orders
    referencing new row as nrow
    for each row
    execute procedure pr3(nrow.bar_code);

-- d)

create function not_delete()
    returns trigger
    language plpgsql
    as
$$
    begin
    raise exception;
    end;
$$;

create trigger undo_delete before delete on products
    for each row execute procedure not_delete();

delete
from products
where id=1;

-- e

-- Task 4
create table employee(
    id serial primary key,
    name varchar(30),
    date_of_birth date,
    age integer,
    salary integer,
    work_experience integer,
    discount integer
);

insert into employee(name, salary, work_experience, discount)
values ('Bob', 2500, 3, 0);

select *
from employee;
-- a
create procedure salary_inc()
    language plpgsql
    as
$$
    begin
        update employee set salary = salary + (salary*0.1) where work_experience / 2 > 0;
        update employee set discount = discount + salary*0.1 where work_experience / 2 > 0;
        update employee set discount = discount + salary*0.01 where work_experience  > 5;
    end;
$$;

-- b
create procedure b()
    language plpgsql
    as
$$
    begin
        update employee set salary = salary + (salary*0.15) where age > 40;
        update employee set salary = salary + (salary*0.15) where work_experience > 8;
        update employee set discount = discount + (discount*0.20) where work_experience > 8;
    end;
$$;

call salary_inc();
call b();

-- Task 5

create table members (
    memid integer primary key NOT NULL,
    surname character varying(200) NOT NULL,
    firstname character varying(200) NOT NULL,
    address character varying(300) NOT NULL,
    zipcode integer NOT NULL,
    telephone character varying(20) NOT NULL,
    recommendedby integer references members(memid),
    joindate date NOT NULL
);


INSERT INTO members (memid, surname, firstname, address, zipcode, telephone, recommendedby, joindate)
VALUES
(1, 'M1', 'SM1', 'A1', 0, '123', NULL, '2016-02-02'),
(2, 'M2', 'SM2', 'A2', 4321, '133', NULL, '2016-03-01'),
(3, 'M3', 'SM3', 'A3', 4321, '132', 6, '2012-07-02'),
(4, 'M4', 'SM4', 'A4', 23423, '122', 3, '2012-07-03'),
(5, 'M5', 'SM5', 'A5', 234, '142', 1, '2012-07-01'),
(6, 'M6', 'SM6', 'A6', 56754, '145', 1, '2012-07-09'),
(7, 'M7', 'SM7', 'A7', 45678, '143', NULL, '2012-07-15'),
(8, 'M8', 'SM8', 'A8', 45678, '149', NULL, '2012-01-25'),
       (9, 'M9', 'SM9', 'A9', 45678, '148', NULL, '2012-11-03'),
       (10, 'M10', 'SM10', 'A10', 45678, '153', NULL, '2012-05-21'),
       (11, 'M11', 'SM11', 'A11', 45678, '143', NULL, '2012-07-15'),
       (12, 'M12', 'SM12', 'A12', 45678, '156', 4, '2012-09-02'),
       (13, 'M13', 'SM13', 'A13', 45678, '134', NULL, '2012-02-01'),
       (14, 'M14', 'SM14', 'A14', 45678, '131', NULL, '2012-10-06'),
       (15, 'M15', 'SM15', 'A15', 45678, '128', NULL, '2012-07-19'),
       (16, 'M16', 'SM16', 'A16', 45678, '147', NULL, '2012-03-22'),
       (22, 'M22', 'SM22', 'A22', 45678, '139', 4, '2012-04-28');




with recursive recommenders(recommender, member) as (
  select recommendedby, memid
    from members
  union all
  select mems.recommendedby, recs.member
    from recommenders recs
    inner join members mems
      on mems.memid = recs.recommender
)
select recs.member member, recs.recommender, mems.firstname, mems.surname
  from recommenders recs
  inner join members mems
    on recs.recommender = mems.memid
  where recs.member = 22 or recs.member = 12
order by recs.member asc, recs.recommender desc;




