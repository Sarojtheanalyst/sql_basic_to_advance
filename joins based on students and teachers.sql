 /*create table movie1(id int not null primary key, series_name varchar(30),season_id numeric,
		category_id varchar(30));
alter table movie1 alter column category_id numeric;
		
select * from movie1;
create table season(seasonid int not null primary key, seasons numeric);
create table category(catid int not null primary key, cat_name varchar(40));   */

--insert into season values(11,11);
  /*insert  into category values (8,'action')
select * from season;
select * from category;   */

insert into movie1 values(13,'farzi',1,5)

select * from movie1;  -- n13 items of the data aere present in thr table

select m.series_name,s.seasons
from movie1 m inner join season s on m.season_id=s.seasonid


create table student (id int not null primary key , fname varchar(30), lname numeric, levels numeric);

select * from student;
create table lname(lid numeric , lname varchar(30));
create table levels(levelid int, level_name varchar(30));


insert into lname values(6,'lalana');
select * from levels;


insert into levels values(2,'engineering')
insert into student values (8,'govinda',1,1)

select * from student;  -- id fname lname levels

-- ibnner join 
select s.fname, l.lname,le.level_name
from student s join lname l on s.lname=l.lid
join levels le on s.levels=le.levelid

select count(*) from student;

--left join 
select s.fname, l.lname,le.level_name
from student s left  join lname l on s.lname=l.lid
 left join levels le on s.levels=le.levelid

-- right join 
-- there is no extra column in the right side 
select s.fname, l.lname,le.level_name
from student s right join lname l on s.lname=l.lid
right join levels le on s.levels=le.levelid

-- full outer join
select s.fname, l.lname,le.level_name
from student s full  join lname l on s.lname=l.lid
full join levels le on s.levels=le.levelid


select s.fname, l.lname,le.level_name
from student s natural  join lname l on s.lname=l.lid
natural join levels le on s.levels=le.levelid



