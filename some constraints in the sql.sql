-- we are going to perform the alter operations

-- create the table
--create table customer(id int, name varchar(200),price int ,arrival_time time);
 
-- insert into table there is no any primary key in the product table
--insert into customer values(7,'milan',80000,now());

-- we insert more than 8 data in the table 
select * from customer;



add primary key in the table 

-- there is 1 id is same it will throw an error while adding constarints
--this line willl thorw an error there is already an duplicatre key 7
alter table customer add constraint p_pk primary key(id); 
-- we delete the id 7 from the table

delete from customer where name='milan';
-- now adding the constraiint in the table 
alter table customer add constraint p_pk primary key(id);  -- this will add

-- if we want to add the same primary key this will throw an error
insert into customer values(7,'milan',20000,now())
-- we have to identified with the unique id n
insert into customer values(8,'milan',20000,now()) -- this will insert the data 

-- drop the primary key 
alter table customer drop constraint p_pk;  -- thisn will drop the constraints

-- againn we want to add the duplicate id it will work
insert into customer values(8,'naship',80000,now());
-- agin thuis will addd the data value in the table 


-- add the unique constarint in the table 
alter table customer add constraint unique_name 
unique(name);

-- drop the unique constraint in the table 
alter table customer drop constraint unique_name;
insert into customer values(9,'naship',90000,now());

--add check constraints
insert into customer values(9,'naship',1000,now());
-- due to 1000 the we cannot add the cponstraints
alter table customer add constraint price_constraint
 check(price>1000 and price<250000)

delete from customer where price=1000;

-- now again we add the constraint in the table
alter table customer add constraint price_constraint
 check(price>1000 and price<250000)
 
--n iof we insert the less value it will violet the constraints
insert into customer values(9,'naship',1000,now());
-- now we drop the constraints 
alter table customer drop constraint price_constraint;

-- we drop check constraints sucessfully
-- this data will insert sucessfully in the table 
insert into customer values(9,'naship',1000,now());


-- not null constraints
insert into customer values(10,'hira',1000);
select * from customer where id=11;
insert into customer values(11,'durga',2000,null);elect * from customer where id=11;
insert into customer values(11,'durga',2000,null);
-- we add the constraint in the table 

delete from customer where name='durga'

--alter table users alter column email set not null;

-- we can add the constraints in thge multiple columns also
alter table customer alter column arrival_time set not null;

-- drop the not null constraints 
alter table customer  alter column arrival_time drop not null;


-- add the constraint in the multiple column
alter table customer add constraint unique_sal_date unique(price,arrival_time);

-- delete the constraints 
alter table customer drop constraint unique_sal_date;

















