with customer_sales  as (
select `customer id`, sum(total) as total_revenue from walmartsales group by `customer id`),
ranked_customers as (
select `customer id`, total_revenue,
rank() over (order by total_revenue desc) as rnk
from customer_sales )
select `customer id`, total_revenue from ranked_customers
where rnk<=5
order by total_revenue desc;