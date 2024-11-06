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














--select distinct product_category from devices;




