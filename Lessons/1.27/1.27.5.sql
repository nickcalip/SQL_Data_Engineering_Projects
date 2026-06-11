SELECT
    COUNT(job_id) AS job_count,
    DATE_TRUNC('quarter', job_posted_date)::DATE AS job_quarter
FROM
    job_postings_fact
WHERE DATE_TRUNC('year', job_posted_date) BETWEEN '2023-01-01' AND '2024-12-31'
GROUP BY job_quarter
ORDER BY job_quarter ASC;