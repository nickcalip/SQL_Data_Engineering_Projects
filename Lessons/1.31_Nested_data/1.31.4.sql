WITH job_skill_counts AS (
SELECT
    j.job_id,
    j.job_title_short,
    ARRAY_LENGTH(ARRAY_AGG(skill_id)) AS skill_count,
FROM
    job_postings_fact AS j
    INNER JOIN skills_job_dim AS s
    ON j.job_id = s.job_id
WHERE j.job_title_short IN ('Data Engineer','Data Analyst')
GROUP BY j.job_id, j.job_title_short
)
SELECT
    job_title_short,
    AVG(skill_count) AS avg_skills_required
FROM job_skill_counts
GROUP BY job_title_short;