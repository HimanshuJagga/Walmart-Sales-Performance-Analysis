-- firstly Calculate Total Spending and Average Spending for Each Customer
with customer_spending as (
select `invoice id`, sum(total) as total_spent, avg(total) as avg_spent from walmartsales
group by `invoice id`),
-- now Determine Spending Tiers based on Total Spending
total_spending_tiers as (
select `invoice id`, total_spent, case
when total_spent >= (select max(total_spent) * 0.75 from customer_spending) then 'High'
when total_spent >= (select max(total_spent) * 0.50 from customer_spending) then 'Medium'
else 'Low'
end as total_spending_tier from customer_spending),
-- now Determine Spending Tiers based on Average Spending
average_spending_tiers as (
select `invoice id`, avg_spent, case
when avg_spent >= (select max(avg_spent) * 0.75 from customer_spending) then 'High'
when avg_spent >= (select max(avg_spent) * 0.50 from customer_spending) then 'Medium'
else 'Low'
end as average_spending_tier from customer_spending)
-- lastly display results
select `invoice id`, total_spent, total_spending_tier, avg_spent, average_spending_tier
from total_spending_tiers join average_spending_tiers using (`invoice id`) order by total_spent desc, avg_spent desc;