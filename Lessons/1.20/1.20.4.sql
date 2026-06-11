SELECT
    jpf.job_posted_date,
    jpf.company_id,
    jpf.job_title_short,
    jpf.job_posted_date::DATE AS dt,
    company_id::STRING || '-' || jpf.job_posted_date::DATE AS compound_key
FROM
    job_postings_fact AS jpf
LIMIT 10;
