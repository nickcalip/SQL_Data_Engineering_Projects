SELECT 
    job_posted_date,
    job_posted_date::DATE AS date,
    job_posted_date::TIME AS time,
    job_posted_date::TIMESTAMP AS timestamp,
    job_posted_date::TIMESTAMPTZ AS timestampz
FROM job_postings_fact
LIMIT 10;


SELECT
    EXTRACT(part FROM column_name)
FROM table_name


SELECT
    EXTRACT(YEAR FROM job_posted_date) AS job_posted_year,
    EXTRACT(MONTH FROM job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer'
GROUP BY
    EXTRACT(YEAR FROM job_posted_date),
    EXTRACT(MONTH FROM job_posted_date)
ORDER BY job_posted_year, job_posted_month;

-- How to extract job postings by year and month using EXTRACT and an aggregation


DATE_TRUNC('precision', date_time)

-- truncates a date or timestamp to a specified level of precision (e.g, year, month, day, hour)

-- Returns a timestamp rounded down to the start of the specified time unit


SELECT
    job_posted_date,
    DATE_TRUNC('month', job_posted_date)::DATE AS job_posted_month
FROM job_postings_fact
ORDER BY RANDOM()
LIMIT 20;



SELECT
    DATE_TRUNC('month', job_posted_date) AS job_posted_month,
    COUNT(job_id) AS job_count
FROM job_postings_fact
WHERE job_title_short = 'Data Engineer' AND EXTRACT(YEAR FROM job_posted_date) = 2024
GROUP BY
    DATE_TRUNC('month', job_posted_date)
ORDER BY job_posted_month;


-- Timestamps with time zone:

-- AT TIME ZONE converts to the specific timezone

SELECT
    column_name AT TIME ZONE 'UTC'
FROM table_name;

SELECT
    '2026-01-01 00:00:00+00'::TIMESTAMPTZ AT TIME ZONE 'EST';

SELECT 
    job_posted_date
FROM job_postings_fact
LIMIT 10;

-- Timestamps without time zone(our situation):

-- Treated as local time in DuckDB
-- Using AT TIME ZONE assumes the amchines tme zone for conversion

SELECT
    column_name AT TIME ZONE 'UTC' AS TIME ZONE 'EST' 
    -- first occurence is telling the database what time the data is at and then what we want to convert it to
FROM
    table_name;

SELECT
    job_title_short,
    job_location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST'
FROM job_postings_fact
WHERE 
    job_location LIKE 'New York, NY';




SELECT
    column_name AT TIME ZONE 'UTC' AS TIME ZONE 'EST' 
    -- first occurence is telling the database what time the data is at and then what we want to convert it to
FROM
    table_name;

SELECT
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS job_posted_hour,
    COUNT(job_id)
FROM job_postings_fact
WHERE 
    job_location LIKE 'New York, NY'
GROUP BY
    EXTRACT(HOUR FROM job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST')
ORDER BY job_posted_hour;