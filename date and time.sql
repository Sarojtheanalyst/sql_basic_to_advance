--select current_time;
select * from messanger;
--insert into messanger values (1,'kathmandu',current_time);

select *,extract(hour from timing) as hour, extract(minute from timing)as minute,
round(extract (second from timing),0) as second from messanger;