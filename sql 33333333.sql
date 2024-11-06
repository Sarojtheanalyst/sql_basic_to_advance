-- create table devices
create table devices(did int not null primary key, product_category varchar(60),
					brand varchar(30), product_name varchar(50),price int);
					
-- insert the data in the tables
copy devices(did,product_category,brand,product_name,price)
from 'E:\sample csv files\electric_appliance.csv'
delimiter ','
CSV HEADER;

-- check whether the data is copy or not in the tables
select * from devices order by product_category;

-- count the total produts present in the tables 
select count(product_category) from devices;

-- show all the unique product category from the table devices
select distinct product_category from devices order by product_category;

-- apply the wqindow function over all the tables


-- fetch the most expensive product from the tables 
select * , first_value(product_name) over( order by price desc) as 
    most_expensive_product from devices limit 5;

-- fetch the least expensive product from the tables 
select *,last_value(product_name) over(order by price desc 
					range between unbounded preceding and unbounded following)
	as least_expensive_product from devices;



-- here i am going to write the alternate way to write the sql by window function


select *, first_value(product_name) over w as most_expensive_product,
last_value(product_name) over w as least_expensive_value from devices
window w as (order by price desc range between  unbounded preceding and unbounded following );


select * from devices;

-- extract the first name and last name based on the alphabetic 

select *, first_value(product_name) over w as first_name,
last_value(product_name) over w as last_name from devices
window w as (order by product_name asc range between unbounded preceding
			  and unbounded following) ;
			  
			  
-- extract the first name and last name based on the products
/* this will first make the alphabet of product_category in asc and desc then
it will sort the data */

select *, first_value(product_name) over w as first_name,
last_value(product_name) over w as last_name from devices
window w as (order by product_category desc range between unbounded preceding
			  and unbounded following) ;
			  
--display the second most expensive product 
select * from devices order by price desc limit 10;

select *, nth_value(product_name,2) over w as second_expensive from devices
window w as(order by price desc range between unbounded preceding and unbounded following);


-- dispolay the third  most cvheap product from the table
select *, nth_value(product_name,3) over w as second_least_expensive from devices
window w as(order by price asc range between unbounded preceding and unbounded following);


-- poartition with tghe different values
select product_name, 
case when x.buckets=1 then 'expensive'
     when x.buckets=2 then ' mid'
	 when x.buckets=3 then 'cheaper'
	 else null
	 end phone_category
from(select * ,ntile(3) over (order by price desc) as buckets  )  from devices x;


-- grouping the mobile category based on their price
select product_name, 
case when x.buckets=1 then 'expensive'
     when x.buckets=2 then 'mid'
	 when x.buckets=3 then 'cheaper'
end phone_category

from(
	
	select *, ntile(3) over (order by price desc) as buckets from devices where
	product_category='mobile') as x;

-- product category based on the prodfuct category
select product_name, price,
ntile(3) over(order by price desc) as category from devices where product_category='mobile';



select product_name,price,brand,
 case when x.buckets=1 then 'expensive'
      when x.buckets=2 then 'mid'
	  when x.buckets=3 then 'cheap'
	  else null
	  end laptop_category

from(select *, ntile(3) over (order by price desc) as buckets
from devices where product_category='laptop') as x;

select product_name, price, 
 case when x.buckets=1 then ' very high'
      when x.buckets=2 then 'high '
      when x.buckets=3 then 'medium'
	  when x.buckets=4 then 'low'
	  when x.buckets=5 then 'very low'
	  else null
	  end products_range
	from(select * , ntile(5) over(order by price desc) as buckets from devices) as x;
 
			  
-- this n tile will divide the products
select product_name, price , ntile(10) over(order by product_name  asc) as 
  product_range from devices;


-- divide the products based on the earphone
select product_name, price,
 case when x.buckets=1 then 'expensive'
      when x.buckets=2 then 'midium'
	  when x.buckets=3 then 'low'
	  else null
	  end product_range
	 
from( select * , ntile(3) over (order by price desc) as buckets from devices
	where product_category='earphone') as x;


-- cumulative distribution based on thne price of the products
select * ,cume_dist() over (order by price desc) as cumulativr_distribution,
 round(cume_dist() over (order by price desc)::numeric*100,2) as cum_dist_per
 from devices ;

-- cumulative percentage based on the product_category
select * ,cume_dist() over (order by product_category asc) as cumulativr_distribution,
 round(cume_dist() over (order by product_category)::numeric*100,2) as cum_dist_per
 from devices order by product_category ;


--cumulative percentage based on the product_name
select * ,cume_dist() over (order by product_name asc) as cumulativr_distribution,
 round(cume_dist() over (order by product_name)::numeric*100,2) as cum_dist_per
 from devices order by product_name ;
 
-- cumulative percentage based on the brand
select * ,cume_dist() over (order by brand asc) as cumulativr_distribution,
 round(cume_dist() over (order by brand)::numeric*100,2) as cum_dist_per
 from devices order by brand ;
 

select count(distinct(brand)) from devices;

-- cumulative percentage based on the did 
select * ,cume_dist() over (order by did asc) as cumulativr_distribution,
 round(cume_dist() over (order by did)::numeric*100,2) as cum_dist_per
 from devices order by did ;
 
-- there are 41 rows in the table 1 box equivalence to 2.44
-- 2.44*41=100
-- 1 box equivalence=100/total no of rows 
-- current_row no / total no of rows 

-- fetch the first 30% of the data based on the price

select product_category, product_name, price,
 concat(cume_dist_per,' %')as cume_dist_percentage 
from (
       select *, round(cume_dist() over(order by price desc)::numeric*100,2) as cume_dist_per
	from devices ) as x where x.cume_dist_per<90;


-- frtch the 30 % data based on the product_category in ascending oreder

select product_category, product_name, price,
 concat(cume_dist_per,' %')as cume_dist_percentage 
from (
       select *, round(cume_dist() over(order by product_category asc)::numeric*100,2) as cume_dist_per
	from devices ) as x where x.cume_dist_per<15;

-- nfetch the first lowest price 40 % of the products
select product_category,price,
 concat(cume_dist_per,' %')as cume_dist_percentage 
 from(
	 select *, round(cume_dist() over (order by price asc )::numeric*100,2) as
	 cume_dist_per from devices ) as x where x.cume_dist_per<30;

-- fetch the first 50 % based on thje product_name 
select product_category,product_name,
 concat(cume_dist_per,' %')as cume_dist_percentage from
 (  select *, round(cume_dist() over(order by product_name)::numeric*100,2) as cume_dist_per
  from devices
 ) as x where x.cume_dist_per<50



-- percent rank()
-- identify how mucvh percentage more expensive is the phone  when compared to mother phone p[roducts
select product_category,product_name,price,
percent_rank() over(order by price) as percentage_rank,
round(percent_rank() over (order by price )::numeric*100,2) as percent_rank_per
from devices where product_category='mobile';

-- calcualte the percentage rank based on the product name 
select product_category,product_name,price,
percent_rank() over(order by product_name ) as percentage_rank,
round(percent_rank() over (order by product_name )::numeric*100,2) as percent_rank_per
from devices ;


-- querry to identify how much percentage more expensuve is acer aspire 5
-- more expensive when comapre to all the products
select product_name, per_rank
from( select *, round(percent_rank() over(order by price) 
	 ::numeric*100,2) as per_rank 
	 from devices )as x where x.product_name='acer aspire 5';

--select distinct product_category from devices;

-- window function based on the partition
--- select first two products name  from each  product category
select  x.product_category, x.product_name, x.price, x.rn from(
select e.*, row_number() over(partition by product_category order by product_name )
	as rn from devices e) as x
	where x.rn<3;


-- fetch first 3 product name from each prouct category with the maximum price
select x.product_category,x.product_name, x.price from(
	select e.*, rank() over(partition by product_category order by price desc) as rnk
	from devices e) as x
	where x.rnk<3 order by product_category asc;


-- fetch the 4 cheap product from the table with their minimum price
select x.product_category, x.product_name,x.price, x.rnk from(
  select e.*, rank() over (partition by product_category order by price asc ) as rnk
	from devices as e ) as x where x.rnk<4;
	
/*select product_category, price from devices where product_category='earphone'
order by price asc;  */

-- difference between rank , row number and dense rank
select e.product_category,e.price,
rank() over(partition by product_category ORDER BY price desc) as rank_number,
dense_rank() over(partition by product_category order by price desc) as dense_rank_no,
row_number() over (partition by product_category order by price desc) as row_number_y 
from devices e;

-- select first highest price  4 products 
select * from(
    select d.*,dense_rank() over(partition by product_category order by price desc) as dense_rank_no
	from devices d ) as x where x.dense_rank_no<5 and x.product_category='earphone';
	
-- lead and lag
select e.*, lead(price,2,0) over(partition by product_category order by price desc) as lead_,
lag(price,1,0) over(partition by product_category order  by price desc) as lag_
from devices e  where product_category='laptop';

-- mlead and lag  based on the product_name 
-- only theb ingeter value is used in te lead or lag function
select e.*, lead(price,2,0) over(partition by product_category order by price desc) as lead_,
lag(price,1,0) over(partition by product_category order  by price desc) as lag_
from devices e  where product_category='laptop';


-- fertch a querey baeed on the all products doisplay if the salary of the employee is highrt
-- loiwer  or equal to yhe previous salary 

select e.product_category,e.price,
lag(price) over(order by  product_name) as prev_product_price,
case when e.price>lag(price) over(order by product_name) then 'higher than prebvious employe'
     when e.price<lag(price) over(order by product_name) then 'lower than prebvious employe'
	when  e.price=lag(price) over(order by product_name) then 'equal to the previous '

else null
end price_range
from devices e;

-- first value 
-- fertch the  most expensive product from the table
select product_category, product_name ,price,
first_value(product_name) over(order by price desc) as most_exp_product
from devices order by product_name;


-- fetch the most lowest price product from the table from the first value
select product_category, product_name, price,
first_value(product_name) over (order by price asc) as least_expensive
from devices order by product_name;


-- fetch the first product name from the alphabet
select product_category, product_name, price,
first_value(product_name) over (order by product_name asc) as first_product
from devices order by price desc;

--fetch the last product name from the tables
select product_category, product_name, price,
first_value(product_name) over (order by product_name desc) as last_product
from devices order by price desc;


-- find the cheap product from the table using the lasdt value
select product_category,product_name,price,
last_value(product_name) over(order by price desc range
							 between unbounded preceding and unbounded following)
							 as least_exp from devices;



-- find the expensive  product from the table using the last value
select product_category,product_name,price,
last_value(product_name) over(order by price asc range
							 between unbounded preceding and unbounded following)
							 as least_exp from devices;

-- first most expensive product_ name and last less expensive product price  in each product_category
select product_category,product_name,price,
first_value(product_name) over (partition by product_category order by price desc) as most_exp_product,
last_value(product_name) over (partition by product_category order by price desc
							 range between unbounded preceding and unbounded following )
							 as least_expensive
	from devices;




-- alterbnate way to weite the wundow function
-- find the first most expensive product name
-- find the least expensive product name
-- find the 2nd highest expensive product name
-- find the 2nd lowest expensive product name

select product_category, product_name, price,
nth_value(product_name,2) over w as second_most_exp_peoduct,
nth_value(product_name,2) over(partition by product_category order by
	price asc range between unbounded preceding and unbounded following ) as second_cheap_product,
first_value(product_name) over w as most_exp_product,
last_value(product_name) over w as least_exp_product

from devices 

window w as(partition by product_category order by price desc 
			range between unbounded preceding and unbounded following) order by product_category 


-- this is a bogus code this is note true 
select e.product_category,e.product_name,e.price,e.most_exp_product,e.least_exp_product,
e.second_most_exp_peoduct,e.second_cheap_product from(
 select *, 
     first_value(product_name) over w as most_exp_product,
     last_value(product_name) over w as least_exp_product,
     nth_value(product_name,2) over w as second_most_exp_peoduct,
     nth_value(product_name,2) over(partition by product_category order by
	price asc range between unbounded preceding and unbounded following ) as second_cheap_product
from devices  d 

window w as(partition by product_category order by price desc 
			range between unbounded preceding and unbounded following) order by product_category 
			

) as e order by e.price;


-- this is correct code

select product_category, product_name, price,
last_value(product_name) over w as least_exp_product,
nth_value(product_name,2) over w as second_most_exp_peoduct,
nth_value(product_name,2) over(partition by product_category order by
	price asc range between unbounded preceding and unbounded following ) as second_cheap_product,
	first_value(product_name) over w as most_exp_product
	

from devices 

window w as(partition by product_category order by price desc 
			range between unbounded preceding and unbounded following) order by product_category;
			
			
--select second expensive and second cheap item -- this is in ascendiing order 
select product_category,product_name, price,

nth_value(product_name,2) over(partition by product_category order by 
	price desc range between unbounded preceding and unbounded following ) as second_cheap_product,
nth_value(product_name,2) over(partition by product_category order by price asc
	range between unbounded preceding and unbounded following) as second_most_exp_peoduct

	from devices

-- this is a valid syantax
--select (count(product_name)-1) from devices where product_category='earphone';

-- n tile in every categorized
-- thisnwill order with respect tomproduct categorixed
select product_category,product_name,price,
case when x.buckets=1 then 'expensive'
     when x.buckets=2 then 'mid'
	 when x.buckets=3 then 'low'
	 else null
	 end price_range

from(select *,
	 ntile(3) over(partition by product_category order by price desc) as buckets
	 from devices
	) as x order by x.product_category;

-- n tile with using the alphabet names
-- this can be divided in terms of the alphabet also
select product_category,product_name,price,
case when x.buckets=1 then 'starting products '
     when x.buckets=2 then 'mid proiducts '
	 when x.buckets=3 then 'end products '
	 else null
	 end price_range

from(select *,
	 ntile(3) over( order by product_name   asc) as buckets
	 from devices
	) as x order by x.product_name;



-- divide with respect with their price
select product_category,product_name,price,
case when x.buckets=1 then 'expensive products '
     when x.buckets=2 then 'mid price products  '
	 when x.buckets=3 then 'less price products  '
	 else null
	 end price_range

from(select *,
	 ntile(3) over( order by price desc) as buckets
	 from devices
	) as x order by x.price desc;



select * from devices limit 5;

select product_category,product_name , price,
-- this will treat as a cumulative 
sum(price) over (partition  by product_category order by price ) as total_sum,
avg(price) over (partition  by product_category order by price ) as average,

-- this will not treat as a cumulative distributation
sum(price)over( partition by product_category) as total,
avg(price) over(partition by product_category) as average
from devices;

-- calculate based on the product name
select product_category,product_name , price,
-- this will treat as a cumulative  based on the product name 
sum(price) over (partition  by product_category order by product_name ) as total_sum,
avg(price) over (partition  by product_category order by product_name ) as average,

-- this will not treat as a cumulative distributation
sum(price)over( partition by product_category) as total,
avg(price) over(partition by product_category) as average
from devices;


select product_category,product_name , price,
-- this will treat as a cumulative  based on the product name 
sum(price) over (partition  by product_category order by did ) as total_sum,
avg(price) over (partition  by product_category order by did ) as average,

-- this will not treat as a cumulative distributation
sum(price)over( partition by product_category) as total,
avg(price) over(partition by product_category) as average
from devices;



-- this will treate same as the , all the bwlowq products givees the sam,e result
select product_category,product_name , price,
 
sum(price) over (partition  by product_category order by product_category asc ) as total_sum,
avg(price) over (partition  by product_category order by product_category asc ) as average,

-- this will not treat as a cumulative distributation
sum(price)over( partition by product_category) as total,
avg(price) over(partition by product_category) as average
from devices;



select product_category,product_name , price,
 
sum(price) over (partition  by product_category order by price desc ) as total_sum,
avg(price) over (partition  by product_category order by price desc ) as average,

-- this will not treat as a cumulative distributation
sum(price)over( partition by product_category) as total,
avg(price) over(partition by product_category) as average
from devices;


select product_category,product_name , price,
 
sum(price) over (partition  by product_category order by price asc ) as total_sum,
avg(price) over (partition  by product_category order by price asc ) as average,

-- this will not treat as a cumulative distributation
sum(price)over( partition by product_category) as total,
avg(price) over(partition by product_category) as average
from  devices order by price asc;





select product_category,product_name , price,
 
sum(price) over (partition  by product_category order by price asc ) as total_sum,
avg(price) over (partition  by product_category order by price asc ) as average,

-- this will not treat as a cumulative distributation
sum(price)over( partition by product_category) as total,
avg(price) over(partition by product_category) as average
from  devices order by price asc;


-- product category ko inside ko product name anusar calculate hunxa 
select product_category,product_name , price,
 
 -- this will giovbe us the cumulative 
sum(price) over (partition  by product_category order by product_name  ) as total_sum,
avg(price) over (partition  by product_category order by product_name ) as average,

-- this will not treat as a cumulative distributation
sum(price)over( partition by product_category) as total,
avg(price) over(partition by product_category) as average,
lead(price) over(partition by product_category order by product_name),
lag(price) over (partition by product_category order by product_name )
from  devices ;
































































