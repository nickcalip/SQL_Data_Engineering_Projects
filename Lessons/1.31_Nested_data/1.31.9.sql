WITH unique_posting AS (
    SELECT
        j.job_id,
        j.company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT skill_id)) AS skill_count
    FROM
        job_postings_fact AS j INNER JOIN skills_job_dim AS s on j.job_id = s.job_id
    GROUP BY j.job_id ,j.company_id
), avg_skills_per_job AS (
    SELECT
    company_id,
    AVG(skill_count) AS avg_skill
    FROM unique_posting
    GROUP BY company_id
)
SELECT
    u.job_id,
    u.skill_count,
    s.avg_skill
FROM unique_posting AS u INNER JOIN avg_skills_per_job AS s ON u.company_id = s.company_id
WHERE u.skill_count > s.avg_skill
ORDER BY skill_count DESC
LIMIT 100;