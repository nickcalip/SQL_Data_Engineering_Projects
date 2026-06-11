SELECT 
    name
FROM company_dim as c
WHERE EXISTS (
    SELECT 1
    FROM job_postings_fact as j
    WHERE j.company_id = c.company_id
);