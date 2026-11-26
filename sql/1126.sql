--fix name
--solution: in this probelm concat, upper, left, substring should be known.
select user_id, concat(upper(left(name, 1)), lower(substring(name, 2))) as name
from users
order by user_id


--sql1527
--solution: you can use like to match the string. and this is a kind of wildcard match, but not like in bash. the '%' expresses any characters,
          --and '_' means the only one character. while in bash they are '*' and '?'
          --also you can use regex to match. and the snytax will be like 'conditons regexp '(^| )diab1''
          --notice that regex matches is the patterns found anywhere inside the string.
select * 
from patients
where conditions like 'diab1%'
or conditions like '% diab1%';


--sql196
--solution: join and cross join and inner join in mysql are same.
delete a 
from person a
join person b
on a.email = b.email
and a.id > b.id


--sql176
--solution: offset
select (select distinct salary from employee
            order by salary desc
            limit 1 offset 1 )as secondhighestsalary

--solution 2:
select max(salary) as .... 
from employee
where salary < max(select max(salary) from employee);


--sql1484
--solution:group_concat is a aggregate function
select sell_date, count(distinct product) as num_sold,
group_concat(distinct product order by product separator ',') as products
from activities
group by sell_date
order by sell_date;


--sql1327
--wrong:
select product_name, sum(o.unit) as unit
from products p
left join orders o
on p.product_id = o.product_id
group by p.product_id
having o.order_date between '2020-02-01' and '2020-03-01' --this o.order_date is a bare column can't be used in having
and unit >= 100

--solution:
select product_name, sum(o.unit) as unit
from products p
left join orders o
on p.product_id = o.product_id
where o.order_date >= '2020-02-01'
and o.order_date < '2020-03-01'
group by p.product_id
having unit >= 100


--sql 50 last one
--solution:
select * from users
where mail regexp '^[a-zA-Z][a-zA-Z0-9-._]*@leetcode\\.com$'
and mail like binary '%@leetcode.com'; --use binary to distinct the upper and lower case

