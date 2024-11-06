create table movies(
 SN int not null primary key,
 movie_name varchar(30) unique,
 rating float
)

create table genre(
	gid int not null primary key,
	genre varchar(30) unique,
	gsn int,
	foreign key(gsn) references movies(SN)

)

create table release_year(
      rid int not null primary key,
	release_year int unique,
	rsn int,
	foreign key(rsn) references movies(SN)
)