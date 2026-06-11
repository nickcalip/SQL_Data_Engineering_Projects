SELECT
    jpf.job_id,
    jpf.job_title,
    cd.name AS company_name,
    jpf.salary_year_avg,
    CASE
        WHEN salary_year_avg >= 100_000 THEN 'High salary'
        WHEN salary_year_avg >= 60_000 THEN 'Standard Salary'
        WHEN salary_year_avg < 60_000 THEN 'Low Salary'
    END AS salary_category
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_title_short = 'Data Engineer' AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

