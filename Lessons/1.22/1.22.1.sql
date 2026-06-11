USE company_jobs;

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'company_jobs';


CREATE OR REPLACE TABLE dev.uk_jobs_archive AS
SELECT *
FROM data_jobs.job_postings_fact AS jpf
WHERE jpf.job_country = 'United Kingdom';


SELECT *
FROM dev.uk_jobs_archive
LIMIT 10;