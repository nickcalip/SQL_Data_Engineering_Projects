/*

Question: What are the most in-demand skills for Data Engineers, Analysts, and Scientists
in the United States?
- Identify the top 10 in-demand skills for data engineers
- Focus on remote job postings in the US
- Why? Retrieves the topo 10 skills with the highest demand in the 
remote job marker, providing insights into the most valuable skills for 
data engineers seeking remote work

*/

-- Start of analysis for Data Engineers

SELECT
    sd.skills,
    COUNT(jpf.*) AS demand_count
FROM
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_work_from_home = True 
    AND jpf.job_title_short = 'Data Engineer'
GROUP BY
    sd.skills
ORDER BY 
    demand_count DESC
LIMIT 10;


/*
Here's a breakdown of the most demanded skills for Data Engineer Remote
positions. By in demand, we mean how many job postings there were with 
these skills were mentioned in the description. 

SQL and Python were by a considerable margin the most in-demand skills
for these positions with around 29,000 job-postings - almost double the 
next time skill of AWS.

Cloud platforms follow these up with AWS leading the pack with ~18,000
postings, followed by Azure at ~14000. 

Apache Spark completes the top 5 with nearly 13,000 postings, highlighting
the importance of big data processing skills.

Key Takeways:

- SQL and Python remain the foundational skill for Data Engineers
- Cloud platforms (AWS, Azure) are critical for modern data engineering
- Big Data tools like Spark continue to be highly valued
- Data pipeline tools (Airflow, Snowflake, Databricks) show growing demand
- Java and GCP finish out the top 10 most requested skills

┌────────────┬──────────────┐
│   skills   │ demand_count │
│  varchar   │    int64     │
├────────────┼──────────────┤
│ sql        │        29221 │
│ python     │        28776 │
│ aws        │        17823 │
│ azure      │        14143 │
│ spark      │        12799 │
│ airflow    │         9996 │
│ snowflake  │         8639 │
│ databricks │         8183 │
│ java       │         7267 │
│ gcp        │         6446 │
└────────────┴──────────────┘

*/