USE company_jobs;

CREATE OR REPLACE TABLE dev.company_salary_stats AS
SELECT 
    company_id,
    AVG(salary_year_avg) AS avg_yearly_salary,
    COUNT(job_id) AS job_count
FROM data_jobs.job_postings_fact AS jpf
WHERE jpf.salary_year_avg IS NOT NULL
GROUP BY company_id;

SELECT * 
FROM dev.company_salary_stats;