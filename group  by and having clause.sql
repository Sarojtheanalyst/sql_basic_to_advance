-- creating the table 
create table payment_mode(id int not null primary key, mode varchar(30),
						 amount int, pay_date DATE);

-- insert the data in the table with the help of the csv file 
copy payment_mode(id,mode,amount,pay_date)
from 'E:\sample csv files\payment_mode.csv'
delimiter ','
csv header ;

-- to check i will fetch the first 5 datas
select * from payment_mode limit 5;

-- how many different modes are there in our table
select distinct mode from payment_mode; -- there are two e sewa 

-- i am delete the one reow from the table there are two modes are there 
delete from payment_mode where mode='e sewa';

select count(*) from payment_mode;  -- there are 15 datas in our table 

--- we can group the data according to the modes

select mode, 
sum(amount) as total_amount, -- find the total amount in each moide
round(avg(amount)::numeric,2) as avg_amount, -- find average amound of mode
max(amount) as max_price, -- max amount from the mode
min(amount) as min_price, -- min amount from the mode
count(*) as no_of_payment -- total no of transaction based on the mode
from payment_mode
group by mode order by total_amount desc; -- data aranged based on the total amount 


-- select moode whose  no of transcation is less than 2 
-- e sewa is the only mode whose transaction is less than 2 
select mode, count(*) as no_of_payment
from payment_mode
group by mode
having 2>count(*) --  2>no_of_payment will lead to the error


-- fetch the mode whose no of  transcastion is between 2 and 5
select mode, count(*) as no_of_payment
from payment_mode
group by mode
having count(*)>=2 and count(*)<=5  --  2>no_of_payment will lead to the error



-- fetch the mode whose average is greater among other mode 
-- filtering the data from the tables according to max min 
select  max(max_price) as max_price ,
max(avg_amount) as max_avg,
max(min_price) as max_min_price,
max(no_of_payment) as maxi_no_of_payment,
max(total_amount) as max_total_amount,

min(max_price) as min_price ,
min(avg_amount) as min_avg,
min(min_price) as min_min_price,
min(no_of_payment) as min_no_of_payment,
min(total_amount) as min_total_amount 

from (
select mode, 
sum(amount) as total_amount, -- find the total amount in each moide
round(avg(amount)::numeric,2) as avg_amount, -- find average amound of mode
max(amount) as max_price, -- max amount from the mode
min(amount) as min_price, -- min amount from the mode
count(*) as no_of_payment -- total no of transaction based on the mode
from payment_mode
group by mode order by total_amount desc-- data aranged based on the total amount 
	
) as x;


-- fetch all the drtal information group by clause 
select mode, 
sum(amount) as total_amount, -- find the total amount in each moide
round(avg(amount)::numeric,2) as avg_amount, -- find average amound of mode
max(amount) as max_price, -- max amount from the mode
min(amount) as min_price, -- min amount from the mode
count(*) as no_of_payment -- total no of transaction based on the mode
from payment_mode
group by mode order by total_amount desc;
















