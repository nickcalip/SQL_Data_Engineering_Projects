SELECT
    sd.skills,
    sd.skill_id,
    COUNT(jpf.job_id) AS job_count
FROM skills_dim AS sd
    RIGHT JOIN skills_job_dim AS sjd
    ON sd.skill_id = sjd.skill_id
    RIGHT JOIN job_postings_fact as jpf
    ON sjd.job_id = jpf.job_id
WHERE
    jpf.job_title_short LIKE '%Data%'
GROUP BY
    sd.skills,
    sd.skill_id
ORDER BY
    job_count DESC;

DESCRIBE skills_job_dim;