WITH ranked_salaries AS (
            SELECT
            job_id,
            job_title_short,
            salary_year_avg,
            RANK() OVER (
                PARTITION BY job_title_short
                ORDER BY salary_year_avg DESC
            ) AS ranked_salaries
        FROM
            job_postings_fact
        WHERE salary_year_avg IS NOT NULL
)
SELECT *
FROM ranked_salaries
WHERE ranked_salaries <= 3;
