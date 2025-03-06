with daily_sales as (
select dayname(str_to_date(`date`,'%d-%m-%Y')) as day_of_week,
sum(total) as total_sales
from walmartsales group by day_of_week)
select day_of_week, total_sales from daily_sales
order by total_sales desc;