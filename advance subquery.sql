-- we are going to do the sql subquery 
-- aall the detail vedios afre in this tables 
select count(*) from employea;



--- code 1 

-- find the name of employee whos salary is greater than the average of all employees 
--select avg(salary) as average_sal from employea; -- this will provide us the average salary of the employee

select count(*) from employea where salary>44444.44 -- 5 employes whose salary is greater than average

-- main code 
-- find the detail of employee whose salary is greater than the average salary of all employees 
select * from employea where salary >(select avg(salary) from employea) order by salary desc;
-- code finish


--scalar subquery --> alternate method for the detail of the employeee 
-- this will filter the datas 
select * from employea e join (select avg(salary)as avg_sal from employea) as x 
on e.salary>x.avg_sal;  -- id , name, salary , avg _ sal'

-- fetch the detail of the employee of the maximum salary  using the subquery 
select * from employea e join(select max(salary) as maxsal from employea ) as x 
on e.salary=x.maxsal;

-- fethch the detaiol of the employee ofn the minimum salary 
select * from employea where salary=(select min(salary) from employea);

-- using the join condition
 select e.* from employea e join ( select min(salary) as min_sal from employea ) as x
 on e.salary=x.min_sal;
 -- e.* will provide the detail only of the alias  e 
 -- * will provide all the detaiol information of the both table
 
select * from employea e  join (select min(salary) as min_sal, max(salary) as maxsal from employea) as x
 on e.salary=x.maxsal;

-- fetch the detaiol of the employee whose salary is less than the average salary
-- method 1
select * from employea where salary<(select avg(salary) from employea) order by salary desc;

-- method 2 
select * from employea e join (select avg(salary) as avg_sal from employea)as x 
on e.salary<x.avg_sal;


-- finish of code 1 

/*
COPY department(id, emp_name, dept_name, salary)
FROM 'E:\xamppp databases\detail.csv'
DELIMITER ','
CSV HEADER;   */





-- starting of code 2 
-- working table department
select * from department;

--create table department(id int, emp_name varchar(40), dept_name varchar(30),salary int);

-- find the total no of employees work in each department
select dept_name, count(*) as no_of_emp from department group by dept_name order by no_of_emp desc;

-- for sure  
select COUNT(*) from department where dept_name='ENGINEERING';

-- find the detail of the employee who earns highest saalry in each department

-- this will provide us the department name and the max salary of the employee in each department
select dept_name, max(salary) as max_sal from department group by dept_name;

-- now the main query stARTS from here  ---> this is true statements 
 select * from department where (dept_name,salary )in (select dept_name, 
 max(salary) as max_sal from department group by dept_name) order by salary desc;
-- medical 90000, engineering 89000, csit 80000, bca 80000 , it 300000


-- fetch detail of the employee except the max salary from the department
 select * from department where (dept_name,salary ) not in (select dept_name, 
 max(salary) as max_sal from department group by dept_name) order by salary desc;



-- fetch the detail of the employee who has the minimum salary in each department
select * from department where (dept_name, salary) in(
select dept_name, min(salary) as min_sal from department group by dept_name 	
)



-- corelelated sub query  
-- A aubquery which is related to the outer query

-- find the employees in each department who earn more than the average salary in that department
 select  distinct dept_name from department;  -- find all the department name 
 
 select avg(salary) from department where dept_name='BCA'

--SElect * from department where dept_name='BCA'; -- this gives the average salary of bca department
-- syntax 
  
  /*
   select * from department where salary>
     (select avg(salary) from department where dept_name= 'specific department ' );  */
-- inner query is depend on the outer query 

select * from department d where salary >(select avg(salary) from department e
										 where d.dept_name=e.dept_name); 


-- find the department who do not have any employeee --> this require tablem so i will do later 



-- subquery inside the subquery
select * from devices;

select product_category, count(product_category)  from devices group by product_category;


-- find the stores whose sales where better than the avegrage saless across all  stores
  -- steps to follow 
    --  1  find the total sales for each store
	--  2 find avg for all the stores
	-- 3 compare 1 and 2 

--select * from devices where product_category='washing machine';

 select product_category, sum(price) as total_sum_of_product from devices group by product_category;

select avg(total_sum_of_product) as avg_price from (
	 select product_category, sum(price) as total_sum_of_product from devices group by product_category
) x

-- did product_category, brand, product_name, price 
select * from devices;

--this statements is true 
select * from(
  select product_category,sum(price) as total_price from devices group by product_category ) sales 
  
join
(select avg(total_price) as avgr from ( select product_category,sum(price) as total_price
							  from devices group by product_category)avgs) avg_ 
	on sales.total_price>avg_.avgr


--this will provide only the product category and the total price only 
select sales.* from(
  select product_category,sum(price) as total_price from devices group by product_category ) sales 
  
join
(select avg(total_price) as avgr from ( select product_category,sum(price) as total_price
							  from devices group by product_category)avgs) avg_ 
	on sales.total_price>avg_.avgr
	



-- find the total sum of the price of the product category=wasing machine  
select product_category, sum(price) as total_price from devices group by product_category
having product_category=
'washing machine';

-- find the average sum of the price of the product category=wasing machine  
select product_category, avg(price) as total_price from devices group by product_category
having product_category=
'washing machine';


-- find the maximum  price of the product category=wasing machine  
select product_category, max(price) as total_price from devices group by product_category
having product_category=
'washing machine';


-- find the minimum  price of the product category=wasing machine  
select product_category, min(price) as total_price from devices group by product_category
having product_category=
'washing machine';


-- find the how many product are avilable in the product  category=wasing machine  
select product_category, count(*) as total_price from devices group by product_category
having product_category=
'washing machine';



select * from devices;

-- detail information of alll types of product category with all the aggegrate functions 

select x.*,y.max_price,z.min_price,aa.no_of_quantity,b.average_price from (
select product_category, sum(price) as total_price from devices group by product_category) x 
join (select product_category,max (price) as max_price from devices group by product_category) y
on x.product_category=y.product_category
join (select product_category,min (price) as min_price from devices group by product_category) z
on y.product_category=z.product_category
join (select product_category,count (price) as no_of_quantity from devices group by product_category) aa
on z.product_category=aa.product_category
join  (select product_category,avg(price) as average_price from devices group by product_category) b
on b.product_category=aa.product_category
order by product_category asc;

-- to chech the value is true or not from the above query
select * from devices where product_category='earphone';


 

-- fetch all the peoducts detail and add remarks having the higher than average and lower price 
-- this method is heavy we have to calculate the average for every devices the completion time is 109
select *,(case when price > (select avg(price) from devices)
    then 'higher than average '
	else 'loweer than average'
		end) as remarks from devices;  
		  
-- better complexity - this will add the new column avg_price in the table 
select * from devices cross join (select avg(price) as avg_price  from devices) x

-- now the actual query  -- the cost is lower 
select *, (case when price> x.avg_price then 'greater than average'
			    else 'lower than average' end) as remarks 
from devices
cross join (select avg(price) as avg_price from devices) as x  



-- fetch the details of the qyantity  which is greater than the average price  
select * from ( 
	select *, (case when price> x.avg_price then 'greater than average'
			    else 'lower than average' end) as remarks 
from devices
cross join (select avg(price) as avg_price from devices) as x ) as s 

    where s.remarks='greater than average'


-- fetch only some records -- did, product_category, price , remarks 
select s.did,s.product_category,s.price,s.remarks from ( 
	select *, (case when price> x.avg_price then 'greater than average'
			    else 'lower than average' end) as remarks 
from devices
cross join (select avg(price) as avg_price from devices) as x ) as s 

    where s.remarks='greater than average'


-- find the stores who have sold more units than the average units sold by all stores 
  -- find the total units sold by all the stores
  -- finc the average units sold from the sum table 
  -- comapre 1 and 2 
 
select * from apple;


select * from (
	( select store, sum(quantity) as total_q from apple group by store) totals
	join 	
 (select  avg(total_qs) as avgss from(
 select store, sum(quantity) as total_qs from apple group by store) x ) avgs  
 on totals.total_q>avgs.avgss)
 

select * from apple;

select avg(total_q) from (
select store,sum(quantity) as total_q from apple group by store) x 

select * from(
 (select store, sum(quantity) as total_quantity from apple group by store ) totals
 join
( select avg(total_q) as avgs  from (
select store,sum(quantity) as total_q from apple group by store) x) sales
on totals.total_quantity>sales.avgs)

 
--quantity pricde   --

select avg(total_q) from(
select store, sum(quantity) as total_q from apple group by store) s


-- this is also true 
select * from (
(select  avg(total_q) avgsss from(
select store, sum(quantity) as total_q from apple group by store) s) total_sales
	join
	(select store,sum(quantity) as totals from apple group  by store) avgs
	
 on avgs.totals>total_sales.avgsss)


--next only some part can be accessed 
select avgs.* from (
(select  avg(total_q) avgsss from(
select store, sum(quantity) as total_q from apple group by store) s) total_sales
	join
	(select store,sum(quantity) as totals from apple group  by store) avgs
 on avgs.totals>total_sales.avgsss)


-- apple 3 155, apple 4 140 , apple 1 101

-- find the stores who have sold more units than the average units sold bvyy all stores using having
select store, sum(quantity) as total from apple
group by store having sum(quantity) >( select avg(quantity) from apple ) order by total desc;


select * from apple
select store, count(*) from apple group by store;