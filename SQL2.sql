-- fetch all the records from the table
select * from employee
-- fetch some columns 
select staff_id,full_name,age from employee; -- staff_id , full_name and age is fetch

select * from employee where staff_type <> 'NON-TEACHING';-- REST OF NON TEACHING ARE SHOWN

SELECT staff_id,staff_type from employee where staff_type <> 'TEACHING'

select gender from employee;-- this will show all the datas
select distinct gender from employee; -- this will show only the unique datas 

-- top n datas are showen in the limit functikon 
select * from employee limit 3;

select * from employee order by full_name ASC;  -- THOS WILL SORT DATDA IN ATO Z
select * from employee order by full_name DESC LIMIT 3; -- SORT + LIMIT THE COUNT 

SELECT * FROM employee where full_name like '%A%'  -- which contatin the name A 
SELECT * FROM employee where full_name like '_A%';-- start with a character and a 

-- boolean logics
select * from employee where age='56' OR gender='M' -- NOT



