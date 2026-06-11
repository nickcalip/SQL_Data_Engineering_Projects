WITH salary_outlier AS (
    SELECT
        company_id,
        AVG(salary_year_avg) AS avg_comp_sal,
        ARRAY_AGG(salary_year_avg) AS sal_list
    FROM job_postings_fact
    WHERE salary_year_avg IS NOT NULL
    GROUP BY company_id
), flat_outlier AS (
    SELECT
    company_id,
    avg_comp_sal,
    UNNEST(sal_list) AS salary_full
    FROM salary_outlier
)
SELECT
    company_id,
    salary_full AS specific_salary,
    avg_comp_sal
FROM
flat_outlier
WHERE salary_full > (avg_comp_sal * 1.5);