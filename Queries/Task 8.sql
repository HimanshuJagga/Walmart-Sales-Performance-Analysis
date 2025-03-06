with parsed_data as (
select `customer id`, str_to_date(`date`,'%d-%m-%Y') as 
purchase_date from walmartsales ),
ranked_data as (
select `customer id`, purchase_date,
lead(purchase_date) over (partition by `customer id` order by purchase_date) 
as next_purchase_date
from parsed_data ),
repeat_customers as (
select `customer id`, purchase_date, next_purchase_date,
 datediff(next_purchase_date,purchase_date) as days_between
from ranked_data where datediff(next_purchase_date,purchase_date) <=30 )
select distinct `customer id` from repeat_customers order by `customer id`;