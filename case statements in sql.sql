create table marks(id int, name varchar(30),marks int);

--insert the data in the table
copy marks(id,name,marks)
from 'E:\sample csv files\student_marks.csv'
delimiter ','
CSV HEADER;

-- select * from marks;
select *,
case 
    when marks<=40 then 'fail'
	when marks>40 and marks<=50 then 'D'
	when marks>50 and marks<=60 then 'c'
	when marks>60 and marks<= 70 then 'B'
	when marks>70 and marks<=80 then 'A'
	when marks>80 and marks<=90 then 'A+'
	when  marks>=90 then 'D'
else 
 ' wrong data'
 
 end as grade_sheet
 
 from marks;
 
 
-- case expression

select * ,
case marks
when 80 then 'A'
when 23 then 'fail'
else 'pass'
end as status_column
from marks;
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

	