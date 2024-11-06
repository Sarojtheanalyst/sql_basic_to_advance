select * from devices;

-- today we are going to use the window functions
-- window function is also known as analytic function
 
 
-- select the maximum price of a product and corresponding to each products
select *, max(price) over() as maximum_price from devices;

--select max(price) from devices;

-- select the minimum price, maximum, no of products , average of a produt and corresponding to each products
select *, max(price) over() as maximum_price,
min(price) over() as minimum_price,
avg(price) over() as average_price,
count(price) over() as no_of_products
from devices;


-- find the maximum , minimum , average , no of products based on product category
select product_category, max(price) as max_salary,
min(price) as min_salary,
sum(price) as total_price, 
avg(price) as average_price,
count(price) as no_of_products
from devices group by product_category order by product_category;


-- find the max, min, average, count, total based on product category corresponding to each products
select *, max(price) over(partition by product_category order by price desc
						 ) as max_price,
min(price) over (partition by product_category 
				range between unbounded preceding and current row) as min_price,
avg(price) over(partition by product_category) as average_price,
count(price) over (partition by product_category) as no_of_products,
sum(price) over (partition by product_category) as total_price
from devices;



-- find the maximum price product name, min price product name and 5th expensive product name 
--,  corresponding to each products
select *,
first_value(product_name)  over (order by price desc)as max_price_product,
last_value(product_name)  over ()as min_price_product,
nth_value(product_name,8) over() as fith_expensive_products
from devices;

-- find the 5th least expensive product
select product_category, product_name, price,
nth_value(product_name,5) over(order by price asc
			range between unbounded preceding and unbounded following) as fifth_least_expensive_product
from devices;


-- display the first most expensive, last expensive and 2nd most expensive from each category
select * ,
first_value(product_name) over w as max_product,
last_value(product_name) over w as min_product,
nth_value(product_name,2) over w as second_most_expensive
from devices
window w as (partition by product_category order by price desc
		range between unbounded preceding and unbounded following	)


-- nth tile functiond
-- write a query to seegregate all the expensive , mid range and the cheaper phones 
select *,
ntile(3) over(partition by product_category order by price desc) as buckets
from devices 
where product_category='mobile';


-- write a query to seegregate all the expensive , mid range and the cheaper phones 
select product_name,price,
case when x.buckets=1 then 'most expensive phones'
     when x.buckets=2 then 'mid expensive phones'
	 when x.buckets=3 then 'less expensive phones'
	 else null
	 end phones_category
from( select *,
ntile(3) over(partition by product_category order by price desc) as buckets
from devices 
where product_category='mobile'
) x ;

-- cumulative distributions -- 
--value varies between 0 to 1
-- formula to calculate = current row(rows with values same as current row)/total no of rows

-- fetch the first 30 % most expensive of the records based on the price
select *,
cume_dist() over(order by price desc) as cume_distribution,
round(cume_dist() over(order by price desc)::numeric*100,2) as cume_dist_percentage
from devices;

---- fetch the first 30 % most expensive of the records based on the price
select product_category,product_name,price,x.cume_dist_percentage from(
select *,
cume_dist() over(order by price desc) as cume_distribution,
round(cume_dist() over(order by price desc)::numeric*100,2) as cume_dist_percentage
from devices
)x
where cume_dist_percentage<30

--percent rank 
-relative rank of the current row/percent ranking
-- formula = current row no -1/total no ofrows-1

-- query to identify how much percentage more expensive is "iphone 14" compared to all the products
select * ,
percent_rank() over(order by price ) as percent_rank,
round(percent_rank() over(order by price )::numeric*100,2) as per_rank
from devices;

--query to identify how much percentage more expensive is "iphone 14" compared to all the products
select product_category,product_name,x.per_rank
 from( 
	 select * ,
percent_rank() over(order by price ) as percent_rank,
round(percent_rank() over(order by price )::numeric*100,2) as per_rank
from devices) x 
where x.product_name='iphone 14';


select * from devices order by price desc;





