-- firstly calculate total monthly sales for each branch
with monthly_sales as (
select branch, date_format(str_to_date(`date`,'%d-%m-%Y'),'%m-%Y') as month,
sum(total) as total_sales
from walmartsales
group by branch,month),

-- now calculate monthly growth rate for each branch
growth_rate as (
select branch, month, total_sales,
lag(total_sales) over (partition by branch order by month) as prev_month_sales,
((total_sales-lag(total_sales) over (partition by branch order by month))/
lag(total_sales) over (partition by branch order by month))*100 as growth_rate from monthly_sales)

-- now to find the branch with the highest month-to-month growth rate
select branch, max(growth_rate) as max_growth_rate
from growth_rate
where growth_rate is not null
group by branch
order by max_growth_rate desc
limit 1;
