create table product(id int, product_name varchar(30), quantity_ramain int,
					price int , total_sold int);

-- insert some data in the product table
insert into product values(5,'headphone',20,1500,12);
truncate table product;

select * from product;-- iphone, redmi,laptop, airpod, headphone

-- create table sales 
create table sales(id serial, order_date date,order_time time,order_itme varchar(30),
				  total_price float , order_quantity int);
				 
select * from sales;  -- no elements are in the table sales 

-- ------******** creating procedure **********--------------
create or replace procedure buy(p_pname varchar, p_quantity int)
language plpgsql
as $hellow$
declare
 v_product_name varchar(20);
 v_price float;
 v_count int;

begin
select count(1) into v_count
from product where
product_name=p_pname and quantity_ramain>=p_quantity;

if v_count>0 then
  select product_name, price
  into v_product_name,v_price from product
  where product_name=p_pname;

-- insert the data into the sales;-- id, order_date, order_time, total_price , order
insert into sales(order_date,order_time,order_itme,total_price,order_quantity)
values (current_date,current_time, v_product_name,(v_price*p_quantity),p_quantity);

 -- product  id,product_name,quantity_ramain,	price , total_sold 

update product
 set quantity_ramain=(quantity_ramain-p_quantity),
 total_sold =(total_sold +p_quantity)
 where product_name=p_pname;
 raise notice 'product sold sucessfully ';
 

else
raise notice 'insufficient quantity';
end if;
end;
$hellow$

-- created procedure sucessfully ---- 
select * from product;-- (25,15),(30,25),(10,5),(50,25),(21,12)
--iphone , redmi, laptop , airpod,headphone
--80000,25000,80000,2500, 1500

select * from sales; -- no data are availbe in the sales 

call buy('iphone',5);  --we can purchase the iphone 5 quantity
-- this data will be in the sales table 

select * from sales;-- 1 2023-08-13  15:26;16  iphone 400000 5 

select * from product order by product_name ;  -- 1 iphone 20 , 80000 ,20

-- we can buy redmi
call buy('headphone',10);
select * from sales ;

-- save the both details of  sales and products table in the folder using the query save in the csv file
  copy sales to 'E:\sql generate\sales2.csv' with delimiter ',' csv header;

-- product details 
copy product to 'E:\sql generate\product2.csv' with delimiter ',' csv header

























