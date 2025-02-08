-- Retrieve the average processing time per machine by calculating the time difference between activity types for the same process. The query works as follows:
-- 1.	CTE (ind_process)
-- •	Joins the activity table to calculate the time taken for each process (process_id) by subtracting timestamps (a2.timestamp - a1.timestamp) for the same machine (machine_id).
-- •	Ensures that a1.activity_type > a2.activity_type to capture the correct sequence of activities.
-- 2.	Main Query
-- •	Computes the average processing time per machine by summing ind_process_time and dividing by the number of processes.
-- •	Uses ROUND() to format the result to three decimal places.
-- •	Handles division by zero using NULLIF(COUNT(process_id), 0).
-- The final output provides the machine ID and its corresponding average processing time across all processes.


with ind_process as (select a1.machine_id,a1.process_id,(a2.timestamp - a1.timestamp) as ind_process_time from activity as a1 join activity as a2 on a1.machine_id= a2.machine_id and a1.activity_type>a2.activity_type and a1.process_id = a2.process_id)
SELECT machine_id, 
       ROUND(SUM(ind_process_time) / NULLIF(COUNT(process_id), 0), 3) AS processing_time
FROM ind_process 
GROUP BY machine_id;
