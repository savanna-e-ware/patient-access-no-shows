-- Load the raw CSV into a table 
CREATE OR REPLACE TABLE raw_appointments AS 
SELECT * FROM read_csv('data/raw/KaggleV2-May-2016.csv', header = true);