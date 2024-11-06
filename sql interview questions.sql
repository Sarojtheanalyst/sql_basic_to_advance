-- fetch all the detail information off the employee from table 
select * from employeb;

-- count how many employees are present inb the table
select count(teacher_name) from employeb;

-- find min , max , avg, total of salary of employee from the table
select max(salary) as max_salary,min(salary) as min_salary,
round(avg(salary)::numeric,2) as average_salary,
sum(salary) as total_salary from employeb;


-- find the detail information of the employye who have max and min salary from the table
--> max salary 
select * from employeb
where  salary in (select max(salary) from employeb);

--> min salary
select * from employeb
where salary in(select min(salary) from employeb);

-- fetch the detail of the employee whose salarty is greater than average salary
  --> method 1 
select * from employeb b where salary>
(select avg(salary) as average_sal from employeb);

--> method 2  from the join condition
select * from employeb join(select round(avg(salary)::numeric,2) as avg_sal from employeb) s
on employeb.salary>s.avg_sal

-- fetch the max , min , average sal, count no of employee,total salary
-- from the eachy department include the department name order by department anme

select dept_name,  round(avg(salary)::numeric,2) as average_sal,
min(salary) as min_sal,
max(salary) as max_sal,
sum(salary) as total_sal,
count(*) as no_of_employe
from employeb group by dept_name order by dept_name;

-- find the average salary of the department facebook
select round(avg(salary)::numeric,2) as average_salary from employeb where dept_name='facebook'


-- find the detail of the employee of  maximum and minimum salary
--in each department
--> maximum detail
select * from employeb where (dept_name,salary) in
 (select dept_name,max(salary) as maximum from employeb
  group by dept_name);

-->list of employee of minimum salary in each department
select * from employeb where (dept_name,salary)
in(select dept_name, min(salary) from employeb group by dept_name)

-- find the detail of the employee where emp  salary is greater than avg salary of that department
select * from employeb e1 where salary>
  (select avg(salary) as avge from employeb e2 
  where e1.dept_name=e2.dept_name) order by dept_name

select avg(salary) as average from employeb group by dept_name order by dept_name;
-- ,65600,81250, 4500, 75000

-- find the detail information of the department  whose avaerage  is 
-- greater than the total salary of each department

select * from (select dept_name,sum(salary) as total_salary from employeb b1  group by dept_name) y
			   join(select avg(total_sal) as avg_total from(
	select sum(salary) as total_sal from employeb )x  
) average_salary on average_salary.avg_total> y.total_salary












