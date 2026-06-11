SELECT 
    job_id,
    job_title_short
FROM job_postings_fact AS j
WHERE j.job_title_short = 'Data Engineer' 
AND EXISTS(
    SELECT 1
    FROM skills_job_dim as sjd INNER JOIN skills_dim AS s
    ON sjd.skill_id = s.skill_id
    WHERE s.skills IN ('python')
    AND j.job_id = sjd.job_id
);