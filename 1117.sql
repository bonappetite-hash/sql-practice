--1193 monthly transactions

--wrong: can't use a select term in COUNT founction. this problem shoult be used SUM
select date_format(trans_date, '%Y-%m') as month, 
country,
count(country) as trans_count, 
count(select state from transactions where state = 'approved') as approved_count,
count(amount) as trans_total_amount,
acount(select amount from transactions where state = 'approved') as pproved_total_amount
from transactions t
group by month

--solution: 1. remeber how to transfor the date formate, 2. remeber to use sum 3. the 'case when' syntex
select date_format(trans_date, '%Y-%m') as month, 
country,
count(ifnull(country, 1)) as trans_count, 
sum(state = 'approved') as approved_count,
sum(amount) as trans_total_amount,
sum(case when state='approved' then amount else 0 end) as approved_total_amount
from transactions 
group by month, country;