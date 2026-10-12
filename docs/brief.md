## Business Brief: Reducing Missed Appointments

## Business problem
When a patient misses an appointment without warning, the slot is lost. The
clinician's time goes unused, and another patient who needed that slot waits
longer for care. This analysis looks at 110,527 appointments at public clinics
in Vitória, Brazil (April–June 2016) to find which appointments are most at risk
of being missed and what the clinic can do about it.

## Business question
**Which appointments are most likely to end in a no-show, and how can the clinic
reduce them?**

Sub-questions:
1. How does the no-show rate change with booking lead time (same day vs. weeks
   in advance)?
2. Which patients miss most often, by age group and by past no-show history?
3. Are some weekdays worse than others?
4. Are no-shows lower when patients receive an SMS reminder, even after
   accounting for booking lead time?

## KPIs
- **No-show rate:** missed appointments ÷ scheduled appointments
- **Booking lead time:** days between the booking date and the appointment date
  (reported as a median and in buckets: same day, 1–7, 8–14, 15–30, 31+ days)
- **SMS reminder coverage:** appointments where an SMS was sent ÷ all appointments
- **Repeat no-show rate:** patients with 2 or more missed appointments ÷ all
  patients

Excluded: records with impossible ages or with an appointment date before the
booking date.

## User stories
- As a **scheduling manager**, I want to see no-show rates by booking lead time
  so that I can decide when to send reminders.
- As a **front-desk coordinator**, I want to see which upcoming appointments
  belong to patients who have missed before, so that I can call them to confirm.
- As a **clinic operations lead**, I want to know whether SMS reminders reduce
  no-shows, so that I can decide whether to send them to more patients.

## Out of scope
Time of day and seasonality: the data has no appointment times and covers only
about 6 weeks.


