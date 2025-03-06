-- firstly Count Transactions by Payment type and City
with payment_counts as (
select city, payment, COUNT(*) as transaction_count from walmartsales group by city, payment),
-- now Determine the Most Popular Payment Method per City
most_popular_payment as (
select city, payment, transaction_count, row_number() over (partition by city order by transaction_count desc) as rn 
from payment_counts)
-- now Display results for the Most Popular Payment Method in Each City
select city, payment, max(transaction_count) as max from most_popular_payment where rn = 1 
group by city, payment
order by city;
