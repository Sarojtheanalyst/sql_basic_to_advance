 /* select * from employee1;
select * from department1;
select * from manager1;
select * from projects1; */
--select e.emp_name,d.dept_name from employee1 e join department1 d on e.dept_id=d.dept_id -- join 
--select e.emp_name,d.dept_name from employee1 e left join department1 d on e.dept_id=d.dept_id -- left join
--select e.emp_name,d.dept_name from employee1 e right join department1 d on e.dept_id=d.dept_id
 /*select e.emp_name,d.dept_name, m.manager_name, p.project_name from employee1 e left join department1 d on e.dept_id=d.dept_id
inner join manager1 m on m.manager_id=e.manager_id left join projects1 p on p.team_member_id_id=e.emp_id; */

