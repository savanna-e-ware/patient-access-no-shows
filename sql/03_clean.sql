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
    END AS age_group
FROM raw_appointments
WHERE Age >= 0;