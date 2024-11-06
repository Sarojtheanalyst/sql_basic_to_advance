create table movies123(id int not null primary key, movie_name varchar(40),
					   imdb numeric , c_id numeric);
					   
create table cate(mid int , category_name varchar(40))


copy movies123(id,movie_name,imdb,c_id)
from 'E:\NEW DATABASES\moviesverse.csv'
delimiter ','
csv header;


copy cate (mid, category_name)
from 'E:\NEW DATABASES\movies_c.csv'
delimiter ','
csv header;

select * from movies123;   --- mid   cate    c_id    movies123
select * from cate;

select m.id, m.movie_name, m.imdb ,c.category_name
from movies123 m join cate c on c.mid=m.c_id order by movie_name;


select count(*) from movies123;


select m.id, m.movie_name, m.imdb ,c.category_name
from movies123 m left  join cate c on c.mid=m.c_id order by id;



select m.id, m.movie_name, m.imdb ,c.category_name
from movies123 m right  join cate c on c.mid=m.c_id order by id










