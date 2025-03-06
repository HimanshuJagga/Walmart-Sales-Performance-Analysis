-- firstly Calculate Total Sales and COGS for Each Product Line in Each Branch
with product_line_sales as (
    select `product line`, branch, SUM(total) as total_sales, 
        SUM(cogs) as total_cogs
    from walmartsales
    group by branch, `product line` ),
-- now Calculate Profit for Each Product Line
profit_margin as (
    select branch, `product line`, (total_sales - total_cogs) AS profit
    from product_line_sales ),
-- now Assign Rank Based on Profit for Each Branch
ranked_product_lines as (
    select branch, `product line`, profit,
        row_number() over (partition by branch order by profit desc) as rankd
    from profit_margin )
-- now Select the Most Profitable Product Line for Each Branch
select branch, `product line`, profit as highest_profit
from ranked_product_lines
where rankd = 1
order by highest_profit desc;
