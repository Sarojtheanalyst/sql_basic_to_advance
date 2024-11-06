--select current_time;
select * from messanger;
--insert into messanger values (1,'kathmandu',current_time);

select *,extract(hour from timing) as hour, extract(minute from timing)as minute,
round(extract (second from timing),0) as second from messanger;



--create tabkle and insert some values and add the time function 

create table details(timing1 TIME, Timing2 TIME)

The format of the time will be the 'HH:MM:SS'

INSERT INTO details values ('10:50:00','12:30:00');
INSERT INTO details values ('11:52:00','1:30:00');

