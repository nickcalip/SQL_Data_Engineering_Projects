SELECT
    c.name AS company_name,
    ARRAY_AGG(DISTINCT job_location) AS hiring_locations
FROM job_postings_fact AS j
INNER JOIN company_dim AS c
ON j.company_id = c.company_id
GROUP BY c.name;

-- This query makes an array of all the job locations for each company and puts them into one column for you to see.



