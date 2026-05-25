/*

Question: What are the highest-paying skills for Data Engineer, Analysts, and Scientists?

- Caclulate the median salary for each skill required in data engineer positions
- Focus on remote positions with specified salaries
- Include skill frequency to identify both salary and demand

- Why?
    - Helps identify which skills command the highest compensation
    while also showing how common those skills are, providing a more cmoplete
    picture for skills development priorities
    - The median is used instaed of the average to reduce the impact of outlier salaries.

*/


SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) as median_salary,
    COUNT(jpf.*) AS demand_count
FROM 
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
    ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
    ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
GROUP BY 
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    median_salary DESC
LIMIT 25;

/*

Here’s a breakdown of the highest-paying skills based on median salary across job postings.

Rust ranked as the highest-paying skill with a median salary of approximately $210,000, though
demand was relatively niche with only 232 postings. Golang and Terraform followed closely with
median salaries around $184,000, showing that backend development and infrastructure automation
skills are highly valued in the current market.

Cloud and DevOps-related technologies appeared frequently among the top-paying skills. Kubernetes,
Airflow, Ansible, Terraform, and Redis all ranked highly, suggesting that companies are willing to
pay a premium for professionals who can build and maintain scalable data and infrastructure systems.

Modern backend and API technologies such as GraphQL, FastAPI, Django, and Node also appeared throughout
the list, reflecting continued demand for scalable web application and service development.

Interestingly, several highly paid skills such as Rust, Neo4j, and Crystal had relatively low demand counts,
indicating that specialized or niche expertise can command significantly higher salaries despite fewer openings.

Key Takeaways:
- Specialized programming languages like Rust and Golang command some of the highest salaries
- Cloud, DevOps, and infrastructure automation skills are consistently high-paying
- Kubernetes and Airflow combine both high salary potential and strong market demand
- Backend and API development frameworks remain highly valuable
- Niche technical expertise often leads to higher compensation despite lower job volume

┌────────────┬───────────────┬──────────────┐
│   skills   │ median_salary │ demand_count │
│  varchar   │    double     │    int64     │
├────────────┼───────────────┼──────────────┤
│ rust       │      210000.0 │          232 │
│ golang     │      184000.0 │          912 │
│ terraform  │      184000.0 │         3248 │
│ spring     │      175500.0 │          364 │
│ neo4j      │      170000.0 │          277 │
│ gdpr       │      169616.0 │          582 │
│ zoom       │      168438.0 │          127 │
│ graphql    │      167500.0 │          445 │
│ mongo      │      162250.0 │          265 │
│ fastapi    │      157500.0 │          204 │
│ bitbucket  │      155000.0 │          478 │
│ django     │      155000.0 │          265 │
│ crystal    │      154224.0 │          129 │
│ atlassian  │      151500.0 │          249 │
│ c          │      151500.0 │          444 │
│ typescript │      151000.0 │          388 │
│ kubernetes │      150500.0 │         4202 │
│ ruby       │      150000.0 │          736 │
│ node       │      150000.0 │          179 │
│ airflow    │      150000.0 │         9996 │
│ css        │      150000.0 │          262 │
│ redis      │      149000.0 │          605 │
│ vmware     │      148798.0 │          136 │
│ ansible    │      148798.0 │          475 │
│ jupyter    │      147500.0 │          400 │
└────────────┴───────────────┴──────────────┘
*/


