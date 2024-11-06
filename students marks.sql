--select * from marks;
  /* insert into marks values(6,56,85,90,56);
select * from marks;

create table smarks(id int , name varchar(30)); */

insert into smarks values(6,'varun');
select * from smarks;

-- creating function to calculate rthe average of the martks 
create function gettotal(roll int)
returns int
as $$
begin
declare total int;
select total=(physics)/2 from marks where id=roll
return total
end;
$$ language plpgsql


