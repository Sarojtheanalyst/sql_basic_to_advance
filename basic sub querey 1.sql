select * from customer; -- id, pname, quantity, price  1 to 11 
select * from paymment; -- id payment_date  --1 2 3 4 

create table paymment (id int, payment_date date);
insert into paymment values(3,'20240604')
select * from paymment;  

-- this will update the values
update paymment set id=4 where payment_date='20240604'
--extract the payment date from the customer

select d.product_name , payment_date from paymment p  where exists (
select id,pname as product_name from customer
	where c.id=p.id) as d



