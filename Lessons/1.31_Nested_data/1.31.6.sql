WITH array_table AS (
    SELECT
        job_id,
        ARRAY_AGG(skill_id) AS skill_id_array
    FROM skills_job_dim
    GROUP BY job_id
), unnest_table  AS (
    SELECT
        job_id,
        UNNEST(skill_id_array) as skill_id
    FROM array_table
)
SELECT
    job_id,
    s.skills AS skill_name
FROM unnest_table AS u
INNER JOIN skills_dim AS s ON u.skill_id = s.skill_id;
