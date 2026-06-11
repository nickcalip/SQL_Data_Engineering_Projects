USE company_jobs;

WITH company_averages AS (
    SELECT
        company_id,
        AVG(salary_year_avg) AS avg_company_salary
    FROM 
        data_jobs.job_postings_fact
    GROUP BY company_id
)
SELECT
    job_id,
    job_title_short,
    j.company_id,
    salary_year_avg,
    avg_company_salary
FROM data_jobs.job_postings_fact AS j
INNER JOIN company_averages AS c
ON j.company_id = c.company_id
WHERE salary_year_avg > avg_company_salary;
