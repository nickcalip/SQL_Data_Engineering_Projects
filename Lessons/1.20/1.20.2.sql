SELECT
    jpf.job_title_short,
    jpf.job_no_degree_mention::INT AS job_no_degree_mention,
    COUNT(jpf.job_id) AS job_postings, 
FROM
    job_postings_fact AS jpf
WHERE 
    jpf.job_posted_date::DATE BETWEEN '2024-12-01' AND '2024-12-31'
GROUP BY
    jpf.job_title_short,
    jpf.job_no_degree_mention
ORDER BY 
    jpf.job_title_short,
    jpf.job_no_degree_mention;