CASE
    WHEN condition_1 THEN result_1
    [ELSE result_default]
END
FROM
    table_name;


SELECT
 CASE
    WHEN salary_hour_avg > 40
        THEN 'high_salary'
    ELSE 'low_salary'
 END AS salary_category
 FROM data_jobs.job_postings_fact;

 /*

CASE: Engineering Use cases

Bucketing Data: CASE WHEN salary < 25 - Group values into ranges

HANDLING NULL Data: CASE WHENM salary IS NULL - Handle NULLs explicitly

Categorizing Value: CASE WHEN job_title LIKE '%Analyst%' THEN 'Data Analyst - Normalize inconsistent text

Conditional aggregation: COUNT(CASE WHEN salary IS NOT NULL THEN 1 END) - Aggregate subsets in one query


 */

 -- Bucket Salaries


 -- < 25 'low



 -- 25-50 'medium'


 -- > 50 = 'high'

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'-- Already check if the value is less than 25
        ELSE 'High'
    END as salary_category
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
LIMIT 10;


-- Handling missing data (NULLS)
-- Filter NULL salary values

SELECT
    job_title_short,
    salary_hour_avg,
    CASE
        WHEN salary_hour_avg IS NULL THEN 'Missing'
        WHEN salary_hour_avg < 25 THEN 'Low'
        WHEN salary_hour_avg < 50 THEN 'Medium'-- Already check if the value is less than 25
        ELSE 'High'
    END as salary_category
FROM
    job_postings_fact
LIMIT 10;


-- Categorizing Categorical Values
-- Classify the job_title columns values as:
    -- 'Data Analyst'
    -- 'Data Engineer'
    -- 'Data Scientist'

SELECT
    job_title,
    CASE
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Analyst%' THEN 'Data Analyst'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Engineer%' THEN 'Data Analyst'
        WHEN job_title LIKE '%Data%' AND job_title LIKE '%Scientis%' THEN 'Data Analyst'
        ELSE 'Other'
    END as job_title_category,
    job_title_short
FROM
    job_postings_fact
ORDER BY RANDOM()
LIMIT 20;


-- Conditional Aggregation
-- Caclulate Median salaries for different buckets

-- < 100k
-- >= 100k

SELECT
    job_title_short,
    COUNT(*) AS total_postings,
    MEDIAN(
        CASE
            WHEN salary_year_avg < 100_000 THEN salary_year_avg
        END
    ) AS median_low_sal,
    MEDIAN(
        CASE
            WHEN salary_year_avg >= 100_000 THEN salary_year_avg
        END
    ) AS median_high_sal
FROM job_postings_fact
WHERE salary_year_avg IS NOT NULL
GROUP BY job_title_short;


-- Final Example: Conditional Calculations
-- Compute a standardized_salary using yearly salary and adjusted hourly salary(e.g 2080 hours/year)
-- Categorize salaries into teirs of 

-- < 75k = 'Low'
-- 75k -150k 'Medium
-- >= 150k 'High

WITH salaries AS (
    SELECT
        job_title_short,
        salary_hour_avg,
        salary_year_avg,
        CASE
            WHEN salary_year_avg IS NOT NULL THEN salary_year_avg
            WHEN salary_hour_avg IS NOT NULL THEN salary_hour_avg * 2080
        END AS standardized_salary
    FROM job_postings_fact
)
SELECT
    *,
    CASE
        WHEN standardized_salary IS NULL THEN 'Missing'
        WHEN standardized_salary < 75_000 THEN 'Low'
        WHEN standardized_salary < 150_000 THEN 'Medium'
        ELSE 'High'
    END AS salary_bucket
FROM salaries
LIMIT 10;
