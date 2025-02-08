-- Retrieve a count of visits without transactions for each customer. The query:
-- 1.	Identifies customers who made visits but did not complete any transactions by performing a LEFT JOIN between the visits table and the transactions table, filtering for NULL transaction IDs.
-- 2.	Counts the number of such visits per customer using GROUP BY customer_id.
-- 3.	Returns each customer's ID along with their count of non-transaction visits.
-- The final result provides insights into customer behavior, specifically identifying customers who visited but did not make any purchases# #

-- with cust_no_transaction_visits as 
-- (select customer_id from visits as v left join transactions as t on v.visit_id = t.visit_id where transaction_id is null)
-- select customer_id, count(customer_id) as count_no_trans from cust_no_transaction_visits group by customer_id

-- #Retrieve the IDs of weather records where the temperature on a given day is higher than the temperature of the previous day. The query works as follows:
-- 1.	Subquery (prev_temp_weather)
-- •	Selects id and temperature from the weather table.
-- •	Uses a correlated subquery to find the temperature from the previous day (recordDate - 1 DAY).
-- 2.	Main Query
-- •	Filters the results to only include records where the current day's temperature is higher than the previous day's temperature.
-- •	Ensures that prev_temp is not NULL (to exclude cases where there is no prior day's data).
-- This query helps identify days with a temperature increase compared to the previous day.


with prev_temp_weather as (SELECT 
    id, 
    temperature, 
     (SELECT temperature 
     FROM weather w 
     WHERE w.recordDate = DATE_SUB(weather.recordDate, INTERVAL 1 DAY)
    ) AS prev_temp 
FROM 
    weather)
select id from prev_temp_weather where temperature > prev_temp and prev_temp is not null 
