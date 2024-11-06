--create table teacher(id int primary key, subject varchar(20), name varchar(30),salary int,
--			date_of_join DATE, address varchar(20));	

/*  -- copy the data in te table through the excel 
copy teacher(id,subject,name,salary,date_of_join,address)
from 'E:\sample csv files\teacher_detail1.csv'
DELIMITER ','
CSV HEADER;
*/

-- display all the names based on their date 
--select * from teacher order by date_of_join asc;

-- using the window functions
--there is no any data group by so this is calculated individual
 /*select id,subject,salary, 
sum(salary) over(order by id) as " total_salary",
AVG(salary) over (order by id) as "average_salary",
min(salary) over(order by id) as "min_salary",
max(salary) over(order by id) as "max_salary"
from teacher; 
*/

 n /*-- lead and lag functio
select id, subject, salary ,
first_value(salary) over (order by salary) as " first_value",
last_value(salary) over (order by salary ) as " last_value",
lead(salary,2,0) over(order by salary) as "lead_value",
lag(salary) over(order by salary) as "lag_value",
lead(id) over(order by id) as "id_lead",
lag(id) over(order by id) as "id_lag"
from teacher;
*/

--ranking function in the window function

select id,subject,salary,
ROW_NUMBER() over(order by subject) as " row_number",
Rank() over (order by salary) as "rank",
dense_rank() over (order by salary) as "dense_rank",
percent_rank() over (order by salary) as " percent_rank"
from teacher order by id;

select min(salary)from teacher;










