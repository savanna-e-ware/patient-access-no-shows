# Data Dictionary

Source: [Medical Appointment No Shows (Kaggle)](https://www.kaggle.com/datasets/joniarroba/noshowappointments)
One row = one appointment. 110,527 appointments, 62,299 unique patients.
Public clinics in Vitória, Brazil. Appointments from 29 April to 8 June 2016.
Column descriptions are checked against the data itself; where Kaggle's description differs, the notes say so.

| Column | Type | Meaning | Notes / quirks |
|---|---|---|---|
| PatientId | DOUBLE | Patient identifier | Many patients have several appointments. Stored as a decimal number; 5 IDs have decimals |
| AppointmentID | BIGINT | Appointment identifier | Unique per row |
| Gender | VARCHAR | Patient's sex, F or M | 71,840 F (65%), 38,687 M |
| ScheduledDay | TIMESTAMP | Date and time the appointment was booked | 10 Nov 2015 – 8 Jun 2016. Has a real time of day |
| AppointmentDay | TIMESTAMP | Date of the appointment | 29 Apr – 8 Jun 2016. Time is always midnight UTC (shows as 02:00 in Paris time), so there is no time of day |
| Age | BIGINT | Patient's age in years | -1 to 115. One impossible value (-1). 3,539 babies aged 0 (real) |
| Neighbourhood | VARCHAR | Neighbourhood where the clinic is located | 81 neighbourhoods |
| Scholarship | BIGINT | 1 = enrolled in Bolsa Família, Brazil's welfare program | 10,861 appointments (10%). Rough income indicator |
| Hipertension | BIGINT | 1 = patient has hypertension | Misspelled. 21,801 appointments (20%) |
| Diabetes | BIGINT | 1 = patient has diabetes | 7,943 appointments (7%) |
| Alcoholism | BIGINT | 1 = patient has alcoholism | 3,360 appointments (3%) |
| Handcap | BIGINT | Number of disabilities, 0 to 4 | Misspelled. A count, not yes/no (Kaggle's description says True/False, but the data has 0–4). Only 199 appointments have 2 or more |
| SMS_received | BIGINT | 1 = at least one SMS reminder was sent | 35,482 appointments (32%) |
| No-show | BOOLEAN | true = the patient did NOT come | Backwards from what the name suggests. 22,319 no-shows (20.2%). "Yes"/"No" in the CSV; DuckDB reads it as true/false |

## Known data issues
- 1 row with age -1: excluded in cleaning
- 38,568 appointments look like they happen before booking, but most are same-day bookings (the appointment is stored at midnight). Only 5 are real errors: excluded in cleaning
- Misspelled columns Hipertension and Handcap: renamed in cleaning
- No time of day for appointments, and only about 6 weeks of data: no analysis by hour or season
