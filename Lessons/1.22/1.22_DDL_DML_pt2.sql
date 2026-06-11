/*
RERUN path

.read Lessons/1.22/1.22_DDL_DML_pt2.sql
*/

CREATE OR REPLACE TABLE staging.job_postings_flat AS
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name
FROM
    data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd
        ON jpf.company_id = cd.company_id;

SELECT COUNT(*)
FROM staging.job_postings_flat
LIMIT 10;

/*
Building our view for the priority roles and job postings flat 
tables.
*/


CREATE OR REPLACE VIEW staging.priority_jobs_flat_view AS
SELECT 
    jpf.*
FROM staging.job_postings_flat AS jpf
JOIN staging.priority_roles AS r
    ON jpf.job_title_short = r.role_name
WHERE r.priority_lvl = 1;


SELECT 
    job_title_short,
    COUNT(*) as job_count
FROM staging.priority_jobs_flat_view
GROUP BY job_title_short
ORDER BY job_count DESC;

CREATE TEMPORARY TABLE senior_jobs_flat_temp AS
SELECT *
FROM staging.priority_jobs_flat_view
WHERE job_title_short = 'Senior Data Engineer';

 /*
DELETE FROM table_name
WHERE condition;

The business team came back and told us that they only want data
from 2024 and beyond included.


jobs_mart D SELECT COUNT(*) FROM staging.job_postings_flat;
┌────────────────┐
│  count_star()  │
│     int64      │
├────────────────┤
│    1615930     │
│ (1.62 million) │
└────────────────┘
jobs_mart D SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│       483252 │
└──────────────┘
jobs_mart D SELECT COUNT(*) FROM senior_jobs_flat_temp;
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│        91295 │
└──────────────┘

 */

-- Counting total rows before droping data before 2024

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;


DELETE FROM staging.job_postings_flat
WHERE job_posted_date < '2024-01-01';

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;

/*
jobs_mart D SELECT COUNT(*) FROM staging.job_postings_flat;
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│       828574 │
└──────────────┘
jobs_mart D SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│       251946 │
└──────────────┘
jobs_mart D SELECT COUNT(*) FROM senior_jobs_flat_temp;
┌──────────────┐
│ count_star() │
│    int64     │
├──────────────┤
│        91295 │
└──────────────┘

Post delete
*/


-- Business team is concerned the current data needed to be updated

TRUNCATE TABLE staging.job_postings_flat;

SELECT * FROM staging.job_postings_flat;

INSERT INTO staging.job_postings_flat
SELECT
    jpf.job_id,
    jpf.job_title_short,
    jpf.job_title,
    jpf.job_location,
    jpf.job_via,
    jpf.job_schedule_type,
    jpf.job_work_from_home,
    jpf.search_location,
    jpf.job_posted_date,
    jpf.job_no_degree_mention,
    jpf.job_health_insurance,
    jpf.job_country,
    jpf.salary_rate,
    jpf.salary_year_avg,
    jpf.salary_hour_avg,
    cd.name
FROM
    data_jobs.job_postings_fact AS jpf
    LEFT JOIN data_jobs.company_dim AS cd
        ON jpf.company_id = cd.company_id
WHERE job_posted_date >= '2024-01-01';

SELECT COUNT(*) FROM staging.job_postings_flat;
SELECT COUNT(*) FROM staging.priority_jobs_flat_view;
SELECT COUNT(*) FROM senior_jobs_flat_temp;