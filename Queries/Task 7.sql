with product_line_sales as (
select `customer type`, `product line`, sum(total) as total_sales from walmartsales
group by `customer type`, `product line`),
ranked_product_lines as (
select `customer type`, `product line`, total_sales,
rank() over (partition by `customer type` order by total_sales desc) as rnk
from product_line_sales)
select `customer type`, `product line`, total_sales
from ranked_product_lines
where rnk = 1
order by `customer type`;
