--sql 610
--solution:
select x, y, z, if(x+y+z > 2*greatest(x,y,z), 'Yes', 'No') as triangle
from triangle;
--or:
select x, y, z, case when x + y + z > 2*greatest(x,y,z) --CASE WHEN for a value
then 'Yes'
else 'No' as triangle
from triangle;


--sql180 consecutive nums
--solution:
select distinct num as ConsecutiveNums
from (select num,
lead(num, 1) over(order by id) as next_1, --window function Lead and Lag
lead(num, 2) over(order by id) as next_2
from logs) a
where num = next_1 
and num = next_2;


--sql1164 important 
--solution
select a.product_id, ifnull(b.new_price, 10) as price
from (
    select distinct product_id
    from products
) a
left join(
    select product_id, new_price
    from products
    where (product_id, change_date) in(      --this is () must be added
        select product_id, max(change_date)
        from products
        where change_date <= '2019-08-16'
        group by product_id
    )
 ) b
on a.product_id = b.product_id


--sql1978 
--solution:first find the deleted manager, then find the poor that get low salary.
select a.employee_id
from(
    select a.employee_id, a.salary
    from employees a
    left join employees b
    on a.manager_id = b.employee_id
    where a.manager_id is not null 
    and b.employee_id is null
) a
where a. salary < 30000
order by a.employee_id asc;

--simple:
select manager_id not in (select emmployee_id from employees)


--sql626
--solution:just change the id
select case when id % 2 = 1 and (select count(*) from seat) = id then id
when id % 2 = 1 then id + 1
else id - 1
end as id,
student
from seat
order by id 

--solution2: lead defaultly use the last line's value, or you can set like lead(line, num) num is the line that you want. so do lag
select id,
case when id % 2 = 1 then ifnull(lead(student) over(order by id), student) -- you can also use coalesce.
else lag(student) over (order by id) 
end as student
from seat
order by id
