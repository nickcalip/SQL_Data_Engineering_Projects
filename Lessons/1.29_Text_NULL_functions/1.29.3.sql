SELECT
    job_id,
    NULLIF(job_via, 'Unknown') AS job_sourced_clean
FROM job_postings_fact;

