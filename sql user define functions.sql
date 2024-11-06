-- user defined functions in postgre sql

-- function to add two number of the digit
create function add1(val1 int, val2 int)
returns integer  as $adds$
declare total int;
begin
total:=val1+val2;
return val1+val2;
end;
$adds$ language plpgsql;

-- now call the function
select add1(10,20) as total_of_two -- total_of_two  30


-- function to calculate the square root of a number
create function sqr(val1 int)
returns integer as $sqrs$
declare sqre integer;
begin
sqre=val1*val1;
return sqre;
end;
$sqrs$ language plpgsql;

-- now calling the function
select sqr(6); -- output   36


-- function to print the hellow world
create function display()
returns varchar(30) as $hellow$
begin
return 'hellow world';
end;
$hellow$ language plpgsql;

-- function calling
select display(); -- output --> hellow world


-- function to display the first name and last name 
create function fullname(fname varchar(10), lname varchar(10))
returns varchar(40) as $person_name$
begin
return CONCAT (fname, '  ', lname) AS "Full name";
end;
$person_name$
language plpgsql;

-- drop function
drop function fullname(varchar,varchar); -- this will drop the function
	
-- function calling
select fullname('saroj','giri') ; 


































