CREATE TABLE IF NOT EXISTS job_skill_priorities (
    job_id INT,
    skill_id INT,
    skill_name VARCHAR,
    priority_lvl INT,
    status VARCHAR
);
INSERT INTO job_skill_priorities(job_id, skill_id, status)
SELECT
    sjd.job_id,
    sjd.skill_id,
    'ACTIVE' AS status
FROM data_jobs.skills_job_dim AS sjd
INNER JOIN staging.priority_skills AS ps
ON sjd.skill_id = ps.skill_id;



SELECT *
from job_skill_priorities;