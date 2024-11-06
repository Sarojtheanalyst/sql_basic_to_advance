 /*select * from release_year; --ryear , release_year
select * from genre;  -- gid  genre  */

--insert into release_year values(30,2024);
							   
--select * from release_year limit 10;

--insert into genre values(8,'thriller'); -- adventure, comedy, drama, fantasy, horror, musicals, mystery, romance, science fiction, sports, thriller
--select * from genre;

 /*create table movie(Id int not null primary key,
				   movie_name varchar(30),
				   budget_in_$ int,
				   run_time_min int ,
				   ryear1 int ,
				   genren int,
				  
				  foreign key (ryear1)  references release_year(ryear),
				  foreign key (genren) references genre(gid));  */
				  
				  
--insert into movie values(10,'man of steel',291,143,19,7),(11,'i am legend',256,101,13,6)
--select * from movie;
select movie_name,budget_in_$,rellease_year,genre from movie join  release_year on movie.ryear1=release_year.ryear
join genre on movie.genren=genre.gid;

--alter table release_year rename column release_year to rellease_year;
 

-- in this way we can have the condition and filter thhe data                          
select movie_name,budget_in_$,rellease_year,genre from movie join  release_year on movie.ryear1=release_year.ryear
join genre on movie.genren=genre.gid where genre='action';

-- movies  which contain the a alphabet
select movie_name,budget_in_$,rellease_year,genre from movie join  release_year on movie.ryear1=release_year.ryear
join genre on movie.genren=genre.gid where movie_name like '%a%'

--movies name which has _ alphabet and 2nd a and any otherrs 
select movie_name,budget_in_$,rellease_year,genre from movie join  release_year on movie.ryear1=release_year.ryear
join genre on movie.genren=genre.gid where movie_name like '_a%';

-- list movies budget between 200 and 500
select movie_name,budget_in_$,rellease_year,genre from movie join  release_year on movie.ryear1=release_year.ryear
join genre on movie.genren=genre.gid where budget_in_$ between 200 and 500;

-- list of movies budget is less than 100$
select movie_name,budget_in_$,rellease_year,genre from movie join  release_year on movie.ryear1=release_year.ryear
join genre on movie.genren=genre.gid where budget_in_$ <100

-- count all the records in the tabloes 
select count(movie_name) from movie;

-- list of movies budget is more than 400
select movie_name,budget_in_$,rellease_year,genre from movie join  release_year on movie.ryear1=release_year.ryear
join genre on movie.genren=genre.gid where budget_in_$ >400


				  
				  
				  
				  