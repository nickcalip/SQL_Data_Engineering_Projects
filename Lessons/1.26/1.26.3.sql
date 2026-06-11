SELECT
    cd.name as company_name,
    COUNT(job_id) AS job_count,
    CASE
        WHEN job_count > 100 THEN '100+ WFH DE Jobs'
        WHEN job_count > 50 THEN '50-100 WFH DE Jobs'
        WHEN job_count > 25 THEN '25-49 WFH DE Jobs'
        WHEN job_count < 25 THEN 'Less than 25 WFH DE Jobs'
    END AS WFH_DE_Job_category
FROM job_postings_fact AS jpf
INNER JOIN company_dim AS cd
ON jpf.company_id = cd.company_id
WHERE jpf.job_work_from_home = TRUE AND jpf.job_title_short = 'Data Engineer'
GROUP BY company_name
ORDER BY job_count DESC;
