/*

Length and Count

Case conversion

Substring/extraction

Concatenation

Trimming

Replacement


*/



-- Length and Count

-- LENGTH

-- CHAR_LENGTH


SELECT CHAR_LENGTH('SQL');


SELECT LOWER('SQL');

SELECT UPPER('sql');

-- Substring/Extraction

SELECT LEFT('SQL', 2);

SELECT RIGHT('SQL', 2);

SELECT SUBSTRING('SQL',1, 1);

-- Concatenation

SELECT CONCAT('SQL', '-','Functions');

SELECT 'SQL' || '-' || 'Functions';

-- Trimming

SELECT TRIM(' SQL ');

SELECT LTRIM(' SQL ');

SELECT RTRIM(' SQL ');


-- Replacement

-- REPLACE or REGEX_REPLACE

SELECT REPLACE('SQL', 'Q', '_');


SELECT REGEXP_REPLACE('data.nerd@gmail.com', '^.*(@)', '\1');



-- Final Example
WITH title_lower AS(
    SELECT
        job_title,
        LOWER(TRIM(job_title)) AS job_title_clean
    FROM job_postings_fact
)
SELECT
    job_title,
    CASE
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%analyst%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%engineer%' THEN 'Data Analyst'
        WHEN job_title_clean LIKE '%data%' AND job_title_clean LIKE '%scientis%' THEN 'Data Analyst'
        ELSE 'Other'
    END as job_title_category
FROM
    title_lower
ORDER BY RANDOM()
LIMIT 20;


SELECT NULLIF(10,20);


SELECT
    NULLIF(salary_year_avg, 0)
    NULLIF(salary_hour_avg, 0)
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;


SELECT COALESCE(NULL,NULL,2);


SELECT
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080)
FROM job_postings_fact
WHERE salary_hour_avg IS NOT NULL OR salary_year_avg IS NOT NULL
LIMIT 10;


SELECT
    job_title_short,
    salary_year_avg,
    salary_hour_avg,
    COALESCE(salary_year_avg, salary_hour_avg * 2080) AS standardized_salary,
    CASE
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) IS NULL THEN 'Missing'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 75_000 THEN 'Low'
        WHEN COALESCE(salary_year_avg, salary_hour_avg * 2080) < 150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM job_postings_fact
ORDER BY standardized_salary DESC
LIMIT 10;
