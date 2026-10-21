-- Clean appointments table used by all analysis
CREATE OR REPLACE TABLE stg_appointments AS
SELECT
    PatientId      AS patient_id,
    AppointmentID  AS appointment_id,
    Gender         AS gender,
    Age            AS age,
    Neighbourhood  AS neighbourhood,
    Scholarship    AS scholarship,
    Hipertension   AS hypertension,
    Diabetes       AS diabetes,
    Alcoholism     AS alcoholism,
    Handcap        AS disability_count,
    SMS_received   AS sms_received,
    CASE "no-show"
    WHEN true THEN 1
    WHEN false THEN 0
    END AS is_no_show,
    CASE 
    WHEN "age" BETWEEN 0 AND 17 THEN '0-17'
    WHEN "age" BETWEEN 18 AND 34 THEN '18-34'
    WHEN "age" BETWEEN 35 AND 54 THEN '35-54'
    WHEN "age" BETWEEN 55 AND 64 THEN '55-64'
    WHEN "age" >= 65 THEN '65+'
    END AS age_group,
    CAST(ScheduledDay AS DATE)   AS scheduled_date,
    CAST(AppointmentDay AS DATE) AS appointment_date,
    DATE_DIFF('day', CAST(ScheduledDay AS DATE), CAST(AppointmentDay AS DATE)) 
    AS lead_time_days,
    CASE 
    WHEN DATE_DIFF('day', CAST(ScheduledDay AS DATE), CAST(AppointmentDay AS DATE)) = 0 THEN 'Same day'
    WHEN DATE_DIFF('day', CAST(ScheduledDay AS DATE), CAST(AppointmentDay AS DATE)) BETWEEN 1 AND 7 THEN '1-7 days'
    WHEN DATE_DIFF('day', CAST(ScheduledDay AS DATE), CAST(AppointmentDay AS DATE)) BETWEEN 8 AND 14 THEN '8-14 days'
    WHEN DATE_DIFF('day', CAST(ScheduledDay AS DATE), CAST(AppointmentDay AS DATE)) BETWEEN 15 AND 30 THEN '15-30 days'
    WHEN DATE_DIFF('day', CAST(ScheduledDay AS DATE), CAST(AppointmentDay AS DATE)) >= 31 THEN '31+ days'
    END AS lead_time_bucket,
    DAYNAME(CAST(AppointmentDay AS DATE)) as appointment_weekday
FROM raw_appointments
WHERE Age >= 0 AND CAST(AppointmentDay AS DATE) >= CAST(ScheduledDay AS DATE)
;