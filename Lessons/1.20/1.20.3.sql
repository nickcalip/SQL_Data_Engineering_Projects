SELECT
    jpf.job_title_short,
    AVG(jpf.salary_hour_avg * 40 * 52)::DECIMAL(10,2) AS salary_hour_annual,
    AVG(jpf.salary_hour_avg * 40 * 52)::INT AS salary_hour_annual_zero_decimals
FROM
    job_postings_fact as jpf
WHERE 
    jpf.job_country = 'United States' AND jpf.salary_hour_avg IS NOT NULL
GROUP BY
    jpf.job_title_short
ORDER BY
    salary_hour_annual DESC;
