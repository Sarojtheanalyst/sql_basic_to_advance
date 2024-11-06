-- table employe(id int primary key, pname varchar(30),amount numeric);
--insert into employe values(12,'led light',300);
--select * from employe;

-- adding the subquery in the field 
/*select * from employe
where amount>(select avg(amount) from employe);   */

--select avg(amount) from employe; 


--create table paymet(id int primary key, amount int, mode varchar(20));
--insert into paymet values(6,20,'cash')
--select * from paymet;
 -- update paymet  set id=20 where id=1
--create table customera(id int, name varchar(20), address varchar(20)); --1,2,3,4,5,6
--insert into customera values(10,'pusparaj','dolakha');
--select * from customera;
--select * from paymet where id in( select id from customera)

 -- exists operator in tjhe sql 
 select name,address from customera c where exists(select id,amount from paymet p  where p.id=c.id and amount<100);



