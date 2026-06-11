CREATE SCHEMA IF NOT EXISTS staging; 
DROP schema staging;
DROP TABLE staging.priority_skills;
DROP TABLE main.job_skill_priorities;

CREATE TABLE IF NOT EXISTS staging.priority_skills (
    skill_id INTEGER PRIMARY KEY,
    skill_name VARCHAR,
    priority_lvl INTEGER
);
-- Inserting these values with the given column names into the newly made table
INSERT INTO staging.priority_skills (skill_id, skill_name, priority_lvl)
VALUES
    (1, 'python', 1),
    (0, 'sql', 1),
    (183, 'tableau', 2);

-- Double checking that the schema was made
SELECT *
FROM information_schema.schemata;

-- Double checking that our columns and values are available
SELECT *
FROM staging.priority_skills;