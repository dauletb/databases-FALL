--a)
SELECT * from dealer,client;
--b)
SELECT * from dealer  join client c on dealer.id = c.dealer_id;
--c)
SELECT * from dealer join client on dealer.id=client.dealer_id and dealer.location=client.city;
--d)
SELECT s.id,amount,c.name,city
from client c join sell s on c.id=s.client_id and amount<500 and amount>100;
--e)
SELECT *
from dealer d left outer join client c on d.id=c.dealer_id;
--f)
SELECT c.name,city,d.name,charge from
dealer d join client c on d.id=c.dealer_id;
--g)
SELECT c.name,city,d.name,charge from
dealer d join client c on d.id = c.dealer_id and charge>0.12;
--h)
SELECT c.name,c.city,s.id,s.date,s.amount,d.name,d.charge
from dealer d join client c on d.id = c.dealer_id
left outer join sell s on c.id = s.client_id;
--i)
SELECT c.name,c.priority,s.id,s.amount,s.name
from dealer d join client c on d.id = c.dealer_id
join sell s on c.id = s.client_id;
--2)
--a)
CReate view a as
SELECT count(id) as unique_clients,avg(amount) as average, sum(amount) as sum,date
from client join sell s on client.id = s.client_id
group by date;
--b)
create view b as
SELECT sum(amount) as sum,date
from client join sell s on client.id = s.client_id
group by date
ORDER BY sum desc;
--c)
create view c1 as
SELECT count(id) as nu_of_sales,avg(amount) as avg,sum(amount) as sum, s.dealer_id
from dealer d join sell s on d.id = s.client_id
group by s.dealer_id;
--d)
create view d1 as
SELECT sum(amount)*d.charge as tot_with_charge,d.charge
from dealer d join sell s on d.id = s.dealer_id
group by d.id;
--e)
create view e as
SELECT count(id) as nu_of_sales,avg(amount) as avg,sum(amount) as sum,location
from dealer d join sell s on d.id = s.dealer_id
group by d.location;

--f)
create view f as
SELECT count(s.id) as nu_of_sales,avg(amount) as avg,sum(amount) as sum,city
from client c join sell s on s.client_id= c.id
group by c.city;
--g)


