
/*


Union - returns all rows from A and B. Duplicates removed

Union All - Duplicates preserved

Intersect - Returns rows common to A and B. Duplicates removed

Intersect All - Duplicates preserved

Except - Returns rows in A but not B duplicates removed

Except All - returns rwos in A minus rows in B. Duplicates removed one-for-one

*/



SELECT UNNEST([1,1,1,2])
UNION ALL
SELECT UNNEST([1,1, 3]);


SELECT UNNEST([1,1,1,2])
INTERSECT ALL
SELECT UNNEST([1,1, 3]);


SELECT UNNEST([1,1,1,2])
EXCEPT -- IN A NOT IN B
SELECT UNNEST([1,1, 3]);

SELECT UNNEST([1,1,1,2])
EXCEPT ALL
SELECT UNNEST([1,1, 3]);


CREATE TEMP TABLE jobs_2023 AS
SELECT * EXCLUDE(job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date ) = 2023;

CREATE TEMP TABLE jobs_2024 AS
SELECT * EXCLUDE(job_id, job_posted_date)
FROM job_postings_fact
WHERE EXTRACT(YEAR FROM job_posted_date ) = 2024;

SELECT * 
FROM jobs_2024;

-- What unique job postings appeared in either 2023 or 2024?

SELECT
    'jobs_2023' AS table_name,
    COUNT(*) AS record_count
FROM 
    jobs_2023
UNION
SELECT
    'jobs_2024' AS table_name,
    COUNT(*) AS record_count
FROM 
    jobs_2024;


SELECT *
FROM jobs_2023
UNION
SELECT *
FROM jobs_2024;

-- Which job postings appeared across both years, counting duplicates?


SELECT *
FROM jobs_2023
UNION ALL
SELECT *
FROM jobs_2024;


-- Which job postings appeared in 2023 but not 2024?


SELECT *
FROM jobs_2023
EXCEPT
SELECT *
FROM jobs_2024;


-- Which job postings from 2023 remain after subtracting matching 2024 postings, one-for-one?


SELECT *
FROM jobs_2023
EXCEPT ALL
SELECT *
FROM jobs_2024;


-- Which job postings appeared in both 2023 and 2024?


SELECT *
FROM jobs_2023
INTERSECT
SELECT *
FROM jobs_2024;

-- Which job postings appeared in both years, preserving duplicate counts?

SELECT *
FROM jobs_2023
INTERSECT ALL
SELECT *
FROM jobs_2024;
