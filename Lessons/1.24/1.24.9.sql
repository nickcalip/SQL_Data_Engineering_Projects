DELETE FROM staging.priority_skills
WHERE skill_id = 1; -- Deleting all rows from priority_skills where the skill_id = 1

-- We will then delete the records that don't match in the priority skills table in the job_skills_priorities

SELECT *
FROM staging.priority_skills;

-- Check that the skill_id's of 1 are deleted within priority skills

-- Creating a MERGE INTO that updates, inserts and deletes record that match, dont match and are only in the source table not the target

MERGE INTO job_skill_priorities AS tgt
USING (
    SELECT 
        sjd.job_id, 
        ps.skill_id, 
        ps.skill_name, 
        ps.priority_lvl
    FROM data_jobs.skills_job_dim AS sjd
    INNER JOIN staging.priority_skills AS ps ON sjd.skill_id = ps.skill_id;
) AS src -- This creates the source table with only jobs available in the priority_skills table that match records in sjd
ON tgt.job_id = src.job_id 
   AND tgt.skill_id = src.skill_id

WHEN MATCHED THEN -- Row exists in both source and target
    UPDATE SET 
        priority_lvl = src.priority_lvl,
        skill_name = src.skill_name

WHEN NOT MATCHED THEN -- row exists in source but not target
    INSERT (job_id, skill_id, skill_name, priority_lvl, status)
    VALUES (src.job_id, src.skill_id, src.skill_name, src.priority_lvl, 'NEW_SKILL')

WHEN NOT MATCHED BY SOURCE THEN -- when row exists in target but not source
    DELETE;

SELECT * FROM job_skill_priorities; WHERE skill_id = 1;