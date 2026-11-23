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


--sql 1174 immediate food delivery II
--wrong: the left join will keep the lines from the left table. so if the right table and find a line that matchs the criteria of the "on ...", it will be all null,
--and mysql will choose the first line from the group of the line. finally it fails. 
select a.*
from delivery a
left join delivery b
on a.customer_id = b.customer_id
and datediff(a.order_date, b.order_date) < 0
group by a.customer_id  ;

--solution: this solution is based from the wrong version. it finds the null lines from table, you can check the criteria.
select round(avg(order_date=customer_pref_delivery_date) * 100, 2) as immediate_percentage
from(
select a.*
from delivery a
left join delivery b
on a.customer_id = b.customer_id
and a.order_date > b.order_date 
where b.order_date is null) c;

--sql 2356 
--remeber to use DISTINCT 

--sql 1114
--solution: between can't be used in select syntex, it is only be used in where as a critira.  and remeber the between contains both begin value and end value.
select activity_date  as day, count(distinct user_id) as active_users
from activity
where activity_date between date_sub('2019-07-27', interval 29 day) and '2019-07-27' --notice the function date_sub
group by activity_date;