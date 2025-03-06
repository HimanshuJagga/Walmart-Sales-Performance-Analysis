-- firstly Calculate Average Sales per Product Line
with average_sales as (
select `product line`, avg(total) as avg_sales from walmartsales group by `product line`),
-- now detect anomalies
anomalies as (
select `invoice id`, `product line`, total, avg_sales, case
when total > (avg_sales * 1.5) then 'High Anomaly'
when total < (avg_sales * 0.5) then 'Low Anomaly'
else 'Normal' 
end as anomaly_type from walmartsales join average_sales using (`product line`))
select `invoice id`, `product line`, total, avg_sales, anomaly_type from anomalies
order by anomaly_type desc;