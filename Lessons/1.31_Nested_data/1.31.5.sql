SELECT
    c.name,
    ARRAY_LENGTH(ARRAY_AGG(DISTINCT job_location)) AS location_diversity_count,
FROM 
    job_postings_fact AS j INNER JOIN company_dim AS c ON j.company_id = c.company_id
GROUP BY
    c.name
HAVING location_diversity_count > 5
ORDER BY location_diversity_count DESC;