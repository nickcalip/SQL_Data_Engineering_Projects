WITH core_skills AS (
    SELECT
        skill_id,
        type AS skill_type
    FROM skills_dim
    WHERE type IN ('programming', 'databases')
)
SELECT 
    c.skill_type,
     COUNT(DISTINCT job_id) AS distinct_job_count,
FROM skills_job_dim AS s
INNER JOIN core_skills AS c
ON s.skill_id = c.skill_id
GROUP BY c.skill_type
ORDER BY distinct_job_count DESC;