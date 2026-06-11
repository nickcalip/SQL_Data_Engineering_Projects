USE company_jobs;

ALTER TABLE dev.applications_fact
RENAME TO internal_applications_fact;

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_catalog = 'company_jobs'
AND table_schema = 'dev'
AND table_name = 'internal_applications_fact';