WITH normalize_salaries AS (
    SELECT
        job_id,
        job_title_short,
        salary_year_avg,
        MIN(salary_year_avg) OVER (
            PARTITION BY job_title_short
        ) min_s,
        MAX(salary_year_avg) OVER (
            PARTITION BY job_title_short
        ) max_s
    FROM
        job_postings_fact
    WHERE
        salary_year_avg IS NOT NULL
)
SELECT
    *,
    (salary_year_avg - min_s) / NULLIF(max_s - min_s, 0) AS normalized_salary_score
FROM normalize_salaries;



-- NULLIF(max_s - min_s, 0) checks if that value is equal to 0 and returns null instead of zero so it doesnt cause a divide by 0 error.