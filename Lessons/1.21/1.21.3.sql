USE company_jobs;

CREATE SCHEMA IF NOT EXISTS staging;

DROP SCHEMA staging;

CREATE SCHEMA IF NOT EXISTS dev;

SELECT *
FROM information_schema.schemata
WHERE catalog_name = 'company_jobs';