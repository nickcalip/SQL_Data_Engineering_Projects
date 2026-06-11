SELECT
    j.job_id,
    j.job_title_short,
    ARRAY_LENGTH(ARRAY_AGG(skill_id)) AS skill_count
FROM job_postings_fact AS j
INNER JOIN skills_job_dim AS s
ON j.job_id = s.job_id
GROUP BY 
    j.job_id, j.job_title_short
HAVING skill_count > 12;
