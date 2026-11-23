--sql1211 the count function only don't count null value, the 1 or 0 are both counted

--soluton:
select query_name, 
round(avg(rating / position), 2) as quality,
round(avg(rating < 3) * 100, 2)  as poor_query_percentage
from queries 
group by query_name;
