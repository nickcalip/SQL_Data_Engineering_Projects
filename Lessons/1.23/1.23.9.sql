SELECT 
    skills
FROM
    skills_dim as s
WHERE NOT EXISTS (
    SELECT 1
    FROM skills_job_dim AS sjd
    INNER JOIN job_postings_fact AS j
    ON sjd.job_id = j.job_id
    WHERE j.job_title_short = 'Senior Data Engineer' AND
    s.skill_id = sjd.skill_id
);