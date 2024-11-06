create table dateandtime(id int,product varchar(30),
					datea DATE, timea TIME);
					
show timezone
select now()
-- 'hr:mm:ss' or 'hhmmss' or now() , current_time

insert into dateandtime values(11,'mechanical_keyboard', now(),'181005');
-- date can be inserted in 'yyy/mm/dd' or 'yyyy-mm-dd' or 'yyyy.mm.dd' or yyyymmdd -current_date
-- now()
select * from dateandtime order by timea asc;

select current_date;
select now()

-- bogus code

insert into dateandtime values(200,'laptop',now(),now())

select * , extract(hour from timea) from dateandtime ;

select *,(extract(hour from timea)%12) as hour from dateandtime where id=11;



