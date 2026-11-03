# Patient No-Shows: Which Appointments Get Missed?

This project analyzes 110,521 medical appointments to find which ones are most likely to be missed and what a clinic can do about it. The main finding: the longer the wait between booking and appointment, the higher the no-show rate, from 4.6% for same-day appointments to 33.0% at 31+ days.

**[View the interactive dashboard](https://public.tableau.com/app/profile/savanna.ware/viz/PatientNo-Shows/No-ShowDashboard)**

![No-show dashboard](images/No-Show%20Dashboard.png)

## The question
Which appointments are most likely to end in a no-show, and how can a clinic reduce them? A missed appointment wastes clinician time and leaves another patient waiting longer for care.

## Data
- **Source:** [Medical Appointment No Shows](https://www.kaggle.com/datasets/joniarroba/noshowappointments) on Kaggle
- **Coverage:** public clinics in Vitória, Brazil, with appointments from 29 April to 8 June 2016
- **Rows:** 110,527 raw appointments, 110,521 after cleaning
- **Excluded:** 1 record with a negative age and 5 appointments dated before they were booked

## Approach
1. **Load:** read the raw CSV into DuckDB
2. **Profile:** check rows, ranges and data quirks
3. **Clean:** build one analysis-ready table
4. **Analyze:** answer 8 questions in SQL, using CTEs and window functions
5. **Visualize:** build an interactive dashboard in Tableau Public
6. **Recommend:** write a one-page memo for a clinic operations lead

**Tools:** DuckDB SQL, Tableau Public, Git and GitHub

## Key findings
1. **Longer lead times are linked with more no-shows:** 4.6% for same-day appointments vs 33.0% at 31+ days.
2. **SMS is linked with fewer no-shows, mainly when booked further ahead:** about equal at 1–7 days (23.8% with SMS vs 24.4% without), but 30.2% vs 37.5% at 31+ days.
3. **No-shows are concentrated among repeat patients:** the 5.2% of patients with 2 or more no-shows account for 35.3% of all no-shows.

Overall, SMS patients appeared to miss more appointments (27.6% vs 16.7%). That reversed within lead-time groups, because same-day appointments are rarely missed and none received an SMS.

## How to run it
1. Install [DuckDB](https://duckdb.org/).
2. Download the Kaggle CSV and save it as `data/raw/KaggleV2-May-2016.csv`. The raw data is not stored in this repo.
3. From the project folder, run `duckdb noshows.duckdb -ui`.
4. Run the files in `sql/` in order, from `01_load.sql` to `04_analysis.sql`.

## Limitations
- The data covers only 6 weeks in 2016 and one city in Brazil, so results may not apply elsewhere.
- These are correlations, not proof of cause. SMS reminders were not assigned at random.

## More detail
- [Business brief](docs/brief.md)
- [Data dictionary](docs/data_dictionary.md)
- [Recommendations memo](docs/memo.md)
