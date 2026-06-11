SELECT *
FROM
    job_postings_fact
WHERE NULLIF(job_title,'') IS NOT NULL AND NULLIF(UPPER(TRIM(job_location)),'N/A') IS NOT NULL;