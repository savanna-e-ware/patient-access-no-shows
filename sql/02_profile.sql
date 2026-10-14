

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

--What values do  SMS_received take? And how many rows? 
SELECT SMS_received, COUNT(*) AS SMS_total
FROM raw_appointments
GROUP BY SMS_received
ORDER BY COUNT(*) DESC;

--What values do Handcap take? And how many rows? 


SELECT Handcap, COUNT(*) AS handcap_total
FROM raw_appointments
GROUP BY Handcap
ORDER BY COUNT(*) DESC;

--What values do No-show take? And how many rows ? 

SELECT "No-show", COUNT(*) AS no_show_total
FROM raw_appointments
GROUP BY "No-show"
ORDER BY COUNT(*) DESC;

--What date range does the data cover?
SELECT 
MIN(ScheduledDay) AS FirstBooking,
MAX(ScheduledDay) AS LastBooking, 
MIN(AppointmentDay) AS FirstAppointment,
MAX(AppointmentDay) AS LastAppointment
FROM raw_appointments;

--How many appts are dated before they were booked?
SELECT COUNT(*) AS appointment_before_booking
FROM raw_appointments
WHERE AppointmentDay < ScheduledDay;

--Look at examples: are they same day appts? 
SELECT CAST(ScheduledDay AS DATE), CAST(AppointmentDay AS DATE)
FROM raw_appointments
Where AppointmentDay < ScheduledDay
LIMIT 10;

--How many of these are actual errors in the data?
SELECT COUNT(*) AS real_errors
FROM raw_appointments
WHERE CAST(AppointmentDay AS DATE) < CAST(ScheduledDay AS DATE);

-- Note: 38,568 rows look like appointments before booking, but most are same-day bookings (appointment stored at midnight). Only 5 are real errors, to exclude in cleaning.