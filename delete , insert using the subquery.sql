create table employe(id int primary key, name varchar(30), dept_id int , address varchar(30));

create table dept(did int, dept_name varchar(20));

create table employe_history(emp_id int primary key, emp_name varchar(30),
							 dept_name varchar(30),address varchar(30));							 
select * from dept;
insert into dept values(19,'hacker');

insert into employe values(113,'suman',20,'kathmandu');

-- all the detail information of the students 
select * from employe e join dept d on e.dept_id=d.did;  -- emp_id, emp_name, dept_name,address

-- this will works smoothly 
insert into employe_history 
select e.id,e.name,d.dept_name,e.address
from employe e  join  dept d on e.dept_id=d.did
where not exists( select 1 from employe_history eh where eh.emp_id=e.id)

-- the code ends here 
select * from employe_history;

delete from employe where name='durga';
delete from employe_history where emp_name='hira';

select * from employe;  --id, name, dept_id, address 
select * from dept;  -- did ,  dept_name

-- find the deppartment which do not have any employees 
-- formula dept_id=dept_name 
select  distinct(dept_name) from dept where did not in( select distinct dept_id from employe);


-- find the department which have the employees 
select  distinct(dept_name) from dept where did in( select distinct dept_id from employe)
order by dept_name;


-- delete the department which do not have any employee
delete from dept where did
in(select  distinct(did) from dept where did not in( select distinct dept_id from employe))




-- find the did which do not have any employee 
select  distinct(did) from dept where did not in( select distinct dept_id from employe);


-- query which the department donot have any employees
select  distinct(dept_name) from dept where did not in( select distinct dept_id from employe);

