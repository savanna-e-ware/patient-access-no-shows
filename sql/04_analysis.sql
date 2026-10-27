-- Which appointments are most likely to be missed?

--A1 What is the overall no-show rate?

SELECT COUNT(*) AS appointments,
ROUND(AVG(is_no_show) *100,1) AS no_show_rate_pct
FROM stg_appointments
;

-- Result: 110,521 appointments; overall no-show rate is 20.2%.
-- Meaning: about 1 in 5 appointments is missed.


--A2 How does the no-show rate change with booking lead time?

SELECT 
lead_time_bucket,
COUNT(*) AS appointments,
ROUND(AVG(is_no_show) * 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY lead_time_bucket
ORDER BY MIN(lead_time_days)
;

-- Result: no-show rate is lowest for same day appointments (4.6%) and highest for 31+ days (33%).
-- Meaning: the longer the wait between booking and appointment, the more likely a no-show.

--A3 Which weekdays and age groups have the highest no-show rates?

SELECT 
age_group,
COUNT(*) AS appointments,
ROUND(AVG(is_no_show) * 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY age_group
ORDER BY age_group
;

-- Result: highest no-show rate is age 18-34 (24%), lowest is age 65+ (15.5%).
-- Meaning: Young adult patients miss appointments most often.

SELECT
appointment_weekday,
COUNT(*) AS appointments,
ROUND(AVG(is_no_show)* 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY appointment_weekday
ORDER BY no_show_rate_pct
;

-- Result: highest is Fridays (21.2%), lowest is Thursdays (19.3%).
-- Saturday left out: only 39 appointments.
-- Meaning: weekday makes a small difference compared with lead time.

--A4 Is the no-show rate lower with an SMS reminder?

SELECT 
sms_received, 
COUNT(*) AS appointments,
ROUND(AVG(is_no_show) * 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY sms_received 
;

-- Result: with SMS 27.6%, without SMS 16.7%.
-- Meaning: patients who got an SMS missed more often. Surprising? Yes.

 --A5 Does the SMS effect hold within each lead-time bucket?
SELECT
lead_time_bucket,
sms_received,                                  
COUNT(*) AS appointments,
ROUND(AVG(is_no_show) * 100, 1) AS no_show_rate_pct
FROM stg_appointments
GROUP BY lead_time_bucket, sms_received                        
ORDER BY MIN(lead_time_days), sms_received
;

-- Result: Same day has no appointments with SMS, so SMS can't be compared there.
--         In 4 of the 4 other buckets the SMS no-show rate is lower.
--         Short lead times (1-7 days): 23.8% with SMS vs 24.4% without (little or no difference).
--         Longer lead times (31+ days): 30.2% with SMS vs 37.5% without.
-- Meaning: A4 looked backwards because same-day appointments have a 4.6% no-show rate
--          and none get an SMS. Comparing within each bucket is fairer: SMS is linked with
--          fewer no-shows mainly for appointments booked far ahead.
--          This is a correlation, not proof that SMS causes it.

  --A6 Does a patient's number of earlier no-shows predict the next one?
  WITH history AS (
      SELECT
          patient_id,
          appointment_date,
          is_no_show,
          COALESCE(
              SUM(is_no_show) OVER (
                  PARTITION BY patient_id
                  ORDER BY appointment_date, appointment_id
                  ROWS BETWEEN UNBOUNDED PRECEDING AND 1 PRECEDING
              ), 0) AS prior_no_shows
      FROM stg_appointments
  )
  SELECT
      CASE WHEN prior_no_shows = 0 THEN '0'
           WHEN prior_no_shows = 1 THEN '1'
           ELSE '2+' END AS prior_no_show_group,
      COUNT(*) AS appointments,
      ROUND(AVG(is_no_show) * 100, 1) AS no_show_rate_pct
  FROM history
  GROUP BY prior_no_show_group
  ORDER BY prior_no_show_group
  ;

  -- Result: no history (0 earlier no-shows): 18.7% no-show rate (94,551 appointments)
--         1 earlier no-show: 27.1% (11,898 appointments)
--         2+ earlier no-shows: 35.1% (4,072 appointments)
--         Check: the three appointment counts add up to 110,521.
-- Meaning: the no-show rate rises as earlier no-shows go up.
--          A patient with 2+ earlier no-shows is about 1.9x as likely to miss as one with none
--          (35.1% / 18.7%).
--          Clinics could prioritize contacting previous no shows for reminders first.
--          Caveat: the data covers only 6 weeks, so most patients have little history,
--          and this is a correlation, not proof of cause.


