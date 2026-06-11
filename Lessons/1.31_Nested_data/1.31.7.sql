WITH count_jobs AS (
    SELECT
        company_id,
        ARRAY_LENGTH(ARRAY_AGG(DISTINCT skill_id)) AS skill_count
    FROM job_postings_fact AS j INNER JOIN skills_job_dim AS s ON j.job_id = s.job_id
    GROUP BY company_id
), ranked_companies AS (
    SELECT
        c.name,
        s.skill_count,
        DENSE_RANK() OVER(
            ORDER BY skill_count DESC
        ) AS diversity_rank
    FROM company_dim AS c INNER JOIN count_jobs AS s ON c.company_id = s.company_id
)
SELECT
    *
FROM ranked_companies
WHERE diversity_rank <= 10;

