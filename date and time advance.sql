--create table datetime(dob date, time1 time, time2 time);
-- insert some data in  the tables 

insert into datetime values('20040506',now(),now());

select * from datetime;-- now() gives us the current date and time

select now()::date as date, now()::time as time;-- extract the current date and time

-- interval function in postgrel

select now()::time + interval '1 hour'; -- this will add the 1 hour in the future

select now()::time as currenr_time,now()::time+interval ' 1 hour 4 minute' as one_hr_after;

-- back to the 4 hour 3 minute 5 second
select now()::time as curent_time ,now()::time -interval ' 4 hour 3 minute 5 second 100 millisecond'
as four_hr_3minute5second;

SELECT TO_DATE('20170103','YYYYMMDD');

SELECT TO_DATE('20170103','YYYYMMDD')-interval ' 1 year 2 month' as one_year_back

SELECT TO_DATE('20170103','YYYYMMDD')-interval ' 1 hour' as one_year_back

SELECT TO_TIME('100503','HHMMSS')-interval ' 1 HOUR 2 MINUTE' as one_HR_two_minute_back

--SELECT TO_DATE('2017 Feb 20','YYYY Mon DD');

--SELECT TO_TIMESTAMP('2018/08/27/15:23:45', 'YYYY/MM/DD/HH24:MI:ss')
       --   AS  new_timestamptz;


select EXTRACT(HOUR FROM TO_TIMESTAMP('15:23:45','HH24:MI:SS'));

SELECT NOW()::time AS CURREN_time, TO_TIMESTAMP('10:05:02','HH24:MI:SS')::TIME-INTERVAL'2 HOUR 2 MINUTE' AS GAP;

-- go back to the 1 hour 3 minute 5 second from currebnt time
select now()::time as current_time, now()::time-interval'1 hour 3 minute 5 second 4 millisecond ' as one_hr_back;

-- go forward 1 hour 3 minute 5 secomnd from te current time 
-- go back to the 1 hour 24 minute 5 second from currebnt time
select now()::time as current_time, now()::time+interval'1 hour 3 minute 5 second 4 millisecond ' as one_hr_forward;

-- go backward 1 hr 3 minute  from the 11:24:23 
select to_timestamp('11:24:23','HH24:MI:SS')::time as initial_time,
  to_timestamp('11:24:23','HH24:MI:SS')::time-interval'1 hour 3 minute 5 second'
  as time_after_1_hr_3_minute;


-- go forward  1 hr 3 minute  from the 11:24:23 
select to_timestamp('11:24:23','HH24:MI:SS')::time as initial_time,
  to_timestamp('11:24:23','HH24:MI:SS')::time+interval'1 hour 3 minute 5 second'
  as time_after_1_hr_3_minute;
  
 -- extract the hr minute and second from tyhe different fields
 select to_timestamp('11:24:23','HH24:MI:SS')::time as curr_time,
 extract(hour from to_timestamp('11:24:23','HH24:MI:SS')::time)as hr,
 extract(minute from  to_timestamp('11:24:23','HH24:MI:SS')::time) as minut,
 (extract(second  from  to_timestamp('11:24:23','HH24:MI:SS')::time)) as sec;

-- extract the current time , hr and minute and second from system date 

 select now()::time as curr_time,
 extract(hour from  now()::time)as hr,
 extract(minute from  now()::time) as minut,
  round(extract(second  from  now()::time)::numeric,1) as sec,
 extract(millisecond  from  now()::time) as milsec;


-- extract the date from the default date
SELECT TO_DATE('20170103','YYYYMMDD') as current_date1,
extract (year from  TO_DATE('20170103','YYYYMMDD')) as yearss,
extract (month from  TO_DATE('20170103','YYYYMMDD')) as months,
extract (day from  TO_DATE('20170103','YYYYMMDD')) as days,

-- extract the year month day from the current date
select now()::date as current_date1,
extract(year from now()::date) as curr_year,
extract(month from now()::date) as curr_month,
extract(day from now()::date) as curr_day,
extract(dow from now()::date) as day_of_week -- 0 means sunday 


select * from datetime;
select *,extract(year from age(now(),dob)) as age from datetime;


--arrival - departure AS difference  this is also a valid 
select  *,time1-to_timestamp('11:24:23','HH12:MI:SS')::time  as difference from datetime


-- ninsert the current date current time and 10 minute later
insert into datetime values('20040506',now()::time,now()::time+interval'   120 minutes 12 second');


-- calculate trhe difference betweens the two intervals of time and extract date day from table
select time1, time2 , time2-time1 as difference,
extract(hour from time2-time1) as hour1,
extract(minute from time2-time1) as minute,
extract(second from time2-time1) as  second1
from datetime;

-- create your own databses 
create database school;

-- drop the databse
drop database school;

drop function sum1;

-- creating a function

create function sum(var1 integer, var2 integer)
returns integer as $sum$
begin
return var1+var2;
end;
$sum$ language plpgsql;

--working meachnism of the function
select sum(200,0)as um_of_two;
-- drop the function 
drop function sum(integer,integer);












