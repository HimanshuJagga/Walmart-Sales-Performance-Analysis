with monthly_sales as (
select date_format(str_to_date(`date`,'%d-%m-%Y'),'%m-%Y') as month, gender, sum(total) as total_sales from walmartsales
group by gender, month)
select gender, month, total_sales from monthly_sales
order by gender, month;