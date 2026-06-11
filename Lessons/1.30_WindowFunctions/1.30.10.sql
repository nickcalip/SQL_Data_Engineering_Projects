WITH trending_salary AS (
SELECT
    job_title_short,
    salary_year_avg,
    job_posted_date,
    LEAD(salary_year_avg) OVER(
        PARTITION BY job_title_short
    ) AS next_salary
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
)
SELECT
    *,
    CASE
        WHEN salary_year_avg < next_salary THEN 'Increasing'
        WHEN salary_year_avg > next_salary THEN 'Decreasing'
        WHEN salary_year_avg = next_salary THEN 'Stable'
    END as trend_direction
FROM trending_salary;