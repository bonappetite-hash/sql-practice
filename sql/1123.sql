--sql550 game playe analysis
--solution: need to redo!
select round(count(distinct b.player_id) / count(distinct a.player_id), 2) as fraction
from(
    select player_id, min(event_date) as first_date
    from activity 
    group by player_id
) a
left join activity b
on a.player_id = b.player_id
and datediff(a.first_date, b.event_date) = -1 --just like "where" add "and" to add another conditions


--sql1070 product sales analysis
--solution: should find the corresponding line of the first_year
select a.product_id, a.first_year, b.quantity, b.price
from (
    select product_id, min(year) as first_year
    from sales
    group by product_id) a
left join sales b
on a.product_id= b.product_id
and a.first_year = b.year


--sql1798 primary department
--wrong:having can't use the ungrouping column department_id
select employee_id, department_id
from employee
group by employee_id
having primary_flag = 'Y' --cause this is a nake column, you can you count or any other aggregate_functions
or count(department_id) = 1;

--solution:for COUNT it counts the numbers of lines in the group
select employee_id, department_id
from employee
where primary_flag = 'Y' 
or employee_id in (
    select employee_id
    from employee
    group by employee_id
    having(count(*)=1)
)


--sql1045 customer who bought all products
--solution: notice that count function can use in having so that the column is not been select can be used in having syntax.
select customer_id
from customer
group by customer_id
having count(distinct product_key) = (select count(*) from product);

this is a practice for sed
also for printf
i'm tired
I need to sleep
