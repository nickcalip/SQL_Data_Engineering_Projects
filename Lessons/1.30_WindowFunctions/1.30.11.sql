WITH salary_share AS (
    SELECT
        company_id,
        job_id,
        salary_year_avg,
        SUM(salary_year_avg) OVER(
            PARTITION BY company_id
        ) AS total_spend
    FROM
        job_postings_fact
    WHERE salary_year_avg IS NOT NULL
)

SELECT
    *,
    (salary_year_avg / total_spend) * 100 AS percent_of_total_spend
FROM salary_share;
