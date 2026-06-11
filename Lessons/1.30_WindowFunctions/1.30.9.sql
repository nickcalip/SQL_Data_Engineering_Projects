WITH consec_postings AS (
    SELECT
        company_id,
        job_posted_date,
        LAG(job_posted_date) OVER (
            PARTITION BY company_id
            ORDER BY job_posted_date DESC
            ) AS prev_date
    FROM job_postings_fact
) 
SELECT 
    *,
    prev_date - job_posted_date AS days_between_postings
FROM consec_postings
WHERE prev_date IS NOT NULL AND company_id = 1346636;