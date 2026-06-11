-- Count rows - Aggregation only

SELECT 
    COUNT(*)
FROM job_postings_fact;




-- Count rows - Window function

SELECT
    job_id,
    COUNT(*) OVER ()
FROM 
    job_postings_fact;


-- Why are window functions important for Data Engineers?

-- They let you add context without destroying rows - which basically is the job
    -- Pipeline need row level data
    -- Aggregates collapse rows
    -- Window functions keep rows and add insight


-- Syntax

SELECT
    column_1,
    window_function () OVER (
        PARTITION BY <...>
        ORDER BY <...>
    ) AS window_column_alias
FROM 
    table_name;

-- Types of windows functions

-- Aggregate
    -- AVG()
    -- MAX()
    -- MIN()
    -- SUM()
    -- COUNT()

-- Row & Rank
    -- ROW_NUMBER
    -- RANK
    -- DENSE_RANK
    -- PERCENT_RANK
    -- NTILE()

-- Navigation
    -- LAG()
    -- LEAD
    -- FIRST_VALUE
    -- LAST_VALUE
    -- NTH_VALUE


SELECT
    job_id,
    job_title_short,
    company_id,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short, company_id
    ) AS avg_hourly_by_title
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY RANDOM()
LIMIT 10;

-- In this query it shows, the avg salary per hour that the company has and the avg hourly salary by title itself



-- ORDER BY

SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK () OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY salary_hour_avg DESC
LIMIT 10;

-- BOTH

SELECT
    job_posted_date,
    job_title_short,
    salary_hour_avg,
    AVG(salary_hour_avg) OVER (
        PARTITION BY job_title_short
        ORDER BY job_posted_date
    ) AS running_hourly_avg_by_title
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL AND job_title_short = 'Data Engineer'
ORDER BY job_title_short, job_posted_date
LIMIT 10;


SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK () OVER (
        PARTITION BY job_title_short
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY  salary_hour_avg DESC, job_title_short
LIMIT 10; --  This query partitions by job_title_short and gives a rank based on the hourly salary within that given title



-- Rank vs DENSE_RANK


SELECT
    job_id,
    job_title_short,
    salary_hour_avg,
    RANK () OVER (
        ORDER BY salary_hour_avg DESC
    ) AS rank_hourly_salary
FROM
    job_postings_fact
WHERE salary_hour_avg IS NOT NULL
ORDER BY salary_hour_avg DESC
LIMIT 140;


-- ROW_NUMBER() - Providing a new job_id

SELECT 
    *,
    ROW_NUMBER() OVER(
        ORDER BY job_posted_date
    )
FROM
    job_postings_fact
ORDER BY job_posted_date
LIMIT 20;


-- LAG() - Time based comparison of company yearly salary

SELECT
    job_id,
    company_id,
    job_title,
    job_title_short,
    job_posted_date,
    salary_year_avg,
    LEAD(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS next_posting_salary,
    salary_year_avg - LEAD(salary_year_avg) OVER (
        PARTITION BY company_id
        ORDER BY job_posted_date
    ) AS salary_change
FROM
    job_postings_fact
WHERE salary_year_avg IS NOT NULL
ORDER BY company_id, job_posted_date
LIMIT 60;