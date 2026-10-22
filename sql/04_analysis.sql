-- Which appointments are most likely to be missed?

--A1 What is the overall no-show rate?

SELECT COUNT(*) AS appointments,
ROUND(AVG(is_no_show) *100,1) AS no_show_rate_pct
FROM stg_appointments

--A2 How does the no-show rate change with booking lead time?

SELECT 
lead_time_bucket,
COUNT(*) AS appointments,
ROUND(AVG(is_no_show) * 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY lead_time_bucket
ORDER BY MIN(lead_time_days)
;

--A3 Which weekdays and age groups have the highest no-show rates?

SELECT 
age_group,
COUNT(*) AS appointments,
ROUND(AVG(is_no_show) * 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY age_group
ORDER BY age_group
;

SELECT
appointment_weekday,
COUNT(*) AS appointments,
ROUND(AVG(is_no_show)* 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY appointment_weekday
ORDER BY no_show_rate_pct
;


--A4 Is the no-show rate lower with an SMS reminder?

SELECT 
sms_received, 
COUNT(*) AS appointments,
ROUND(AVG(is_no_show) * 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY sms_received 
;
