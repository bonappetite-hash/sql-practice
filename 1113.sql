--sql1280 students and examinations, need to be done again.
--must understand the join in mysql is the same as corss join. and group by can group two columns or more.


--sql570
--my solution:
# Write your MySQL query statement below
select I.name 
from (select A.name, count(B.managerID) as times
from employee A
join employee B
where B.managerID = A.id
group by B.managerID) I
where times >= 5 ;

-- fixed version after asking AI
# Write your MySQL query statement below
select A.name
from employee A
join employee B
where B.managerID = A.id
group by B.managerID
having count(B.managerId) >= 5 


--sql 1934 confirmation rate
--wrong verson:
select s.user_id, round(count(c.action = "confirmed")/count(s.user_id), 2) as confirmation_rate
from signups as s
left join confirmations as c
on s.user_id = c.user_id
group by s.user_id
-- for count founction just count the "null" result others all be counted as 1. so in this wrong example, the "confirmed" or "timeout" all be count as 1, only the null will 
-- be counted as 0

--fixed version1:
use isnull(sum(), 0) --to fix the null can't be count

--fixed version2:
select s.user_id, round(ifnull(avg(c.action = "confirmed"), 0), 2) as confirmation_rate
from signups as s
left join confirmations as c
on s.user_id = c.user_id
group by s.user_id

--sql 1251 average price

--fixed version
select p.product_id, round(ifnull(sum(p.price * u.units)/sum(u.units), 0), 2) as average_price
from prices p
left join unitssold u
on u.purchase_date between p.start_date and p.end_date
and p.product_id = u.product_id
group by p.product_id 

