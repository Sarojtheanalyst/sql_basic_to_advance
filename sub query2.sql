--create table apple(id int not null primary key, store_name varchar(40),
--				   product_name varchar(30),quantity int, price int);

-- copy the data from excel to the tables 
 /*copy apple(id,store_name,product_name,quantity,price)
from 'E:\NEW DATABASES\apple.csv'
DELIMITER ','
CSV HEADER;  */

--select * from apple limit 10;

-- grouping the data with resapect with their store_name
  /*select store_name, sum(price) as total_sales , sum(quantity) as total_quantity from apple
group by store_name;

-- find the average of the total price from the grouping table
select avg(total_sales) as averageprice , avg(total_quantity)as average_quantity from(
 select  sum(price) as total_sales, sum(quantity) as total_quantity group by store_name) as x;  */
 
 
 /*select store,sum(quantity) as total_quantity , sum(price) as total_price from apple group by store;
select * from apple limit 10; */

--select * from apple;

--select * from apple;

--select store, sum(price) as total_price, sum(quantity) as total_quantity from apple group by store;
--select * from apple;
select * from (select store , sum(price) as total_price from apple  group by
			 store) as x
			 
join (
select avg(total_price) as avg_price from( select store , sum(price) as total_price from apple  group by
			 store) as x) as avgik 
			 on x.total_price>avgik.avg_price;

 -- modified versions
 

with sales as(select store , sum(price) as total_price from apple group by store)

select * from  sales sy
join(select avg(total_price) as avg_price from sales  ) avg_ on
sy.total_price>avg_.avg_price;
                                                    
     
-- bogus code

with hari as(select store , sum(price) as total_price from apple group by store)

select * from  hari sy
join (select avg(total_price) as avg_price from hari  ) avg_ on
sy.total_price>avg_.avg_price;
                                        


















