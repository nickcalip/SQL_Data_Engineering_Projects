SELECT
    job_id,
    job_title,
    job_location
FROM job_postings_fact
WHERE NULLIF(job_title,job_location) IS NULL;