

DESCRIBE raw_appointments;
SELECT * FROM raw_appointments LIMIT 10;

-- How many rows, unique patients, and unique appointments? 
SELECT COUNT (*) AS total_rows, 
COUNT (DISTINCT patientID) AS unique_patients, 
COUNT (DISTINCT AppointmentID) AS unique_appointments
FROM raw_appointments;

--The youngest and oldest age? 
SELECT MIN(age), MAX(age)
FROM raw_appointments;

--How many rows have an age below 0? 
SELECT COUNT(*)
FROM raw_appointments
WHERE age < 0;

--What values do No-show, SMS_received, and Handcap take? And how many rows each? 
SELECT SMS_received, COUNT(*) AS SMS_total
FROM raw_appointments
GROUP BY SMS_received
ORDER BY COUNT(*) DESC;

--What values do No-show, SMS_received, and Handcap take? And how many rows each? 


SELECT Handcap, COUNT(*) AS handcap_total
FROM raw_appointments
GROUP BY Handcap
ORDER BY COUNT(*) DESC;

--What values do No-show, SMS_received, and Handcap take? And how many rows each? 

SELECT "No-show", COUNT(*) AS no_show_total
FROM raw_appointments
GROUP BY "No-show"
ORDER BY COUNT(*) DESC;

