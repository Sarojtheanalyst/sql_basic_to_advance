--id,first_name,last_name,email,gender,date_of_join,arrival_time 
create table dumbby1( id int,
					first_name varchar(50),
					last_name varchar(50),
					email varchar(100),
					gender varchar(10),
					date_of_join date,
					arrival_time time
)

copy dumbby1(id,first_name,last_name,email,gender,date_of_join,arrival_time)
from 'E:\MOCK_DATA.csv'
delimiter ','
csv header;
select * from dumbby1 limit 20;

select count(email) from dumbby1 where email = null;