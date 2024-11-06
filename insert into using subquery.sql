select * from dept;  -- did , dept_name
select * from employe;--emp_id, emp_name, salary,dept_id, address
truncate table employe;

select * from dept;-- 1 it,2 eng,3 bca,4 bba ,
insert into dept values(6,'bsw')

insert into employe values(1,'aayush',90000,1,'gulmi');


-- fetch all the detail 
select e.emp_id,e.emp_name,e.salary,e.address,d.dept_name as department from employe e
 right join dept d on d.did=e.dept_id;
 
-- delete the employee who do not have any employeee ---bca and bba do not have any employee
-- this is the main query 
delete from dept where dept_name in(
select dept_name from dept d where  not exists(select 3 from employe e
											   where e.dept_id=d.did))
-- end of main query 

select * from dept;

-- find the department where the employees does not belongs 
select dept_name from dept where dept_name in(
 select dept_name from dept d where not exists(select 1 from employe e where e.dept_id=d.did)
)

-- find the department where the employees  belongs 
select dept_name from dept where dept_name in(
 select dept_name from dept d where  exists(select 1 from employe e where e.dept_id=d.did)
)


--update statement in the subquery
-- update 10 % increment to all employees who earn the max salary

select * from employe;

update employe e set salary=(salary+(salary*0.10))  where salary=
(select max(salary) from employe )



select * from employe;


truncate table employeb;


select * from employeb;

-- find the department name with their workers
select dept_name, count(*) from employeb group by dept_name;


-- find the detaiol of the employe who earns max salary from each departmengt

select * from employeb where (dept_name,salary)in  (
	select dept_name,max(salary) as mxsal from employeb group by dept_name )
	
	
--update the salary increase by 10% from the employee who earns max salary from each department
update employeb e set salary=(salary+(salary*0.1))  where (dept_name ,salary) in(
select dept_name,max(salary) as mxsal from employeb group by dept_name )	














