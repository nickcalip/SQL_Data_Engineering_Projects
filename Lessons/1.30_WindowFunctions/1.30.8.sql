WITH avg_deviation AS (
    SELECT
    job_id,
    job_title_short,
    salary_year_avg,
    AVG(salary_year_avg) OVER (
        PARTITION BY job_title_short
    ) AS avg_salary
    FROM 
        job_postings_fact
    WHERE salary_year_avg IS NOT NULL
)
SELECT 
    *,
    salary_year_avg - AVG(salary_year_avg) OVER (
        PARTITION BY job_title_short
    ) AS deviation
FROM avg_deviation;


-- SELECT 
--     job_id,
--     job_title_short,
--     salary_year_avg,
--     avg_salary,
--     salary_year_avg - avg_salary AS deviation
-- FROM (
--     SELECT 
--         job_id,
--         job_title_short,
--         salary_year_avg,
--         AVG(salary_year_avg) OVER(PARTITION BY job_title_short) AS avg_salary
--     FROM 
--         job_postings_fact
--     WHERE 
--         salary_year_avg IS NOT NULL
-- ) AS avg_data;