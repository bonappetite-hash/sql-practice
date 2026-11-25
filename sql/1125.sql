--sql 1907 count salary
--wrong:
select case when income < 20000 then 'Low Salary'
when income >= 20000 and income <= 50000 then 'Average Salary'
else 'High Salary' end as category,
count(category) as accounts_count   -- notice the "category" is named in select, so it can't be used in select again   -- notice the "category" is named in select, so it can't be used in select again
from accounts 
group by category;

--solution: union will delect the repeat line, union all won't. 
select 'Low Salary' as category, count(*) as accounts_count
from accounts
where income < 20000
union all 

select 'Average Salary' as category, count(*) as accounts_coun
from accounts
where income >= 20000 and income <= 50000
union all

select 'High Salary' as category, count(*) as accounts_coun
from accounts
where income > 50000;


--sql 1024 the last person fit in bus
--solution: ! notice: lead as a window function can't be used in a where term. 
select a.person_name
from (
select person_name, sum(weight) over (order by turn) as total
from queue
order by total desc) a
where a.total <= 1000
limit 1


--sql1341 movie
--solution:
(select u.name as results
from users u 
left join movierating m
on u.user_id = m.user_id
group by u.user_id
order by count(m.movie_id) desc , name --for order by it has sequence, fist sort with the count, second with name.
limit 1)                         -- the connect the condition of order use the comma.
union all -- for union / union all the "order by" or "limit" should be breaketed or it will report error,
            --cause union consider it as the golbal value. 
(select m.title
from movies m
left join movierating r
on m.movie_id = r.movie_id 
where r.created_at < '2020-03-01' and r.created_at >= '2020-02-01' 
group by m.movie_id 
order by avg(r.rating) desc,
m.title asc
limit 1)


--sql1321 restaurant growth
--solution:
select visited_on, a.total as amount, round(total/7, 2) as average_amount
from (select visited_on, 
sum(sum(amount)) over (order by visited_on         --this two line are the main dish for this probelm.
rows between 6 preceding and current row) as total, 
row_number() over (order by visited_on) as rn      --the function row_number()
from customer
group by visited_on) a
where a.rn >= 7;


--sql602 friends requests
--solution:
select id, sum(num) as num  --remeber the sum
from ((select requester_id as id, count(requester_id) as num
from requestaccepted
group by requester_id 
)

union all
(select accepter_id, count(accepter_id) as num
from requestaccepted
group by accepter_id)) a
group by id
order by num desc
limit 1


--sql585 investment in 2016
--solution; use of "IN"  this is importent!
select round(sum(tiv_2016), 2) as tiv_2016
from insurance
where tiv_2015 in (select tiv_2015 
        from insurance
        group by tiv_2015
        having count(tiv_2015) > 1)
and (lat, lon) in (select lat, lon
        from insurance
        group by lat, lon  -- this group by two column is simounteanse without ordering.
        having count(*) = 1)


--sql185
--solution:so fucking important! go back to web and do it again.
select b.name as Department, a.name as Employee, a.Salary
from employee a
join department b on a.departmentid=b.id
where (select count(distinct c.salary)
        from employee c
        where a.departmentid = c.departmentid
        and c.salary > a.salary) < 3 ;

