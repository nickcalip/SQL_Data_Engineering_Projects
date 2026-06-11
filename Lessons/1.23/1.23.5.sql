SELECT
    job_id,
    job_title_short,
    job_location,
FROM data_jobs.job_postings_fact AS j
WHERE j.job_country IN (
    SELECT job_country
    FROM data_jobs.job_postings_fact
    GROUP BY job_country
    HAVING
        COUNT(job_id) > (
            SELECT AVG(country_count)
            FROM (
                SELECT COUNT(job_id) AS country_count
                FROM job_postings_fact
                GROUP BY job_country
            ) AS country_counts
        )
)
ORDER BY j.job_country, j.job_id;
