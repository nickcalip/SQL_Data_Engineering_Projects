/*

Question: What are the optimal skills for data engineering-balancing both demand and salary?
- Create a ranking column that combines demand count and median salary to identify the most valuable skills.
- Focus only on remote Data Engineer positions specified annual salaries
- Why?
    - THis approach highlights skills that balance market demand and financial reward. It weighs core skills appropriately

*/


SELECT
    sd.skills,
    ROUND(MEDIAN(jpf.salary_year_avg),0) as median_salary,
    COUNT(jpf.*) as demand_count,
    ROUND(LN(COUNT(jpf.*)),1)as ln_demand_count,
    ROUND((MEDIAN(jpf.salary_year_avg) *  LN(COUNT(jpf.*))) / 1_000_000,2) AS optimal_score
FROM 
    job_postings_fact AS jpf
    INNER JOIN skills_job_dim AS sjd
        ON jpf.job_id = sjd.job_id
    INNER JOIN skills_dim AS sd
        ON sjd.skill_id = sd.skill_id
WHERE
    jpf.job_title_short = 'Data Engineer'
    AND jpf.job_work_from_home = True
    AND jpf.salary_year_avg IS NOT NULL
GROUP BY 
    sd.skills
HAVING
    COUNT(jpf.*) > 100
ORDER BY
    optimal_score DESC
LIMIT 25;

/*

We created an optimal score that balances both salary and job demand for remote Data Engineer skills. To reduce the 
effect of extremely high posting counts dominating the analysis, we applied the natural logarithm to the demand counts
before calculating the score. Without this transformation, skills with massive demand would heavily outweigh salary differences and skew the results.

After applying the log transformation, the distribution becomes more balanced and allows for a fairer comparison b
etween high-paying niche skills and highly demanded mainstream skills.

As seen previously, Python and SQL remain the most in-demand skills for remote Data Engineering roles based on total job postings. 
However, when combining normalized demand with median salary into our optimal score, Terraform ranks highest with a score of 0.97, 
followed closely by Python (0.95) and SQL (0.91).

This does not diminish the importance of Python or SQL. Instead, it highlights that Terraform offers a particularly strong combination 
of compensation and market demand relative to its posting frequency. In contrast, Python and SQL appear in such a large number of postings
that their raw demand alone no longer dominates the ranking after normalization.

Overall, the results suggest that while foundational skills like Python and SQL remain essential, specialized infrastructure and cloud-oriented
technologies such as Terraform, Airflow, Kafka, and Kubernetes may provide stronger value when considering both salary potential and relative
market competition.

Key Takeaways:

- Terraform leads the list with $184k median salary and 193 postings, resulting in the highest overall "optimal score".
- Python and SQL dominate demand (over 1100 postings each), with strong median salaries of $135k and $130k, respectively
- AWS (783 postings, $137k median), Spark (503 postings, $140k median), and Airflow(386 postings, $150k median) round off the top 6 for "optimal score".
- Kafka offers high compensation ($145k median) and solid demand (292 postings).
- Tools like Snowflake, Azure, and Databricks each have 250-475 postings and median salaries between $128-$137k.

┌────────────┬───────────────┬──────────────┬─────────────────┬───────────────┐
│   skills   │ median_salary │ demand_count │ ln_demand_count │ optimal_score │
│  varchar   │    double     │    int64     │     double      │    double     │
├────────────┼───────────────┼──────────────┼─────────────────┼───────────────┤
│ terraform  │      184000.0 │          193 │             5.3 │          0.97 │
│ python     │      135000.0 │         1133 │             7.0 │          0.95 │
│ sql        │      130000.0 │         1128 │             7.0 │          0.91 │
│ aws        │      137320.0 │          783 │             6.7 │          0.91 │
│ airflow    │      150000.0 │          386 │             6.0 │          0.89 │
│ spark      │      140000.0 │          503 │             6.2 │          0.87 │
│ kafka      │      145000.0 │          292 │             5.7 │          0.82 │
│ snowflake  │      135500.0 │          438 │             6.1 │          0.82 │
│ azure      │      128000.0 │          475 │             6.2 │          0.79 │
│ java       │      135000.0 │          303 │             5.7 │          0.77 │
│ scala      │      137290.0 │          247 │             5.5 │          0.76 │
│ kubernetes │      150500.0 │          147 │             5.0 │          0.75 │
│ git        │      140000.0 │          208 │             5.3 │          0.75 │
│ databricks │      132750.0 │          266 │             5.6 │          0.74 │
│ redshift   │      130000.0 │          274 │             5.6 │          0.73 │
│ gcp        │      136000.0 │          196 │             5.3 │          0.72 │
│ hadoop     │      135000.0 │          198 │             5.3 │          0.71 │
│ nosql      │      134415.0 │          193 │             5.3 │          0.71 │
│ pyspark    │      140000.0 │          152 │             5.0 │           0.7 │
│ mongodb    │      135750.0 │          136 │             4.9 │          0.67 │
│ docker     │      135000.0 │          144 │             5.0 │          0.67 │
│ go         │      140000.0 │          113 │             4.7 │          0.66 │
│ r          │      134775.0 │          133 │             4.9 │          0.66 │
│ bigquery   │      135000.0 │          123 │             4.8 │          0.65 │
│ github     │      135000.0 │          127 │             4.8 │          0.65 │
└────────────┴───────────────┴──────────────┴─────────────────┴───────────────┘

*/
