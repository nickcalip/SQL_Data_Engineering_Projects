/* 

DDL Data Definition Language

DML Data Manipulation Language

DQL Data Query Language

*/

-- .read Lessons/1.21/1.21_DDL_DML.sql

USE data_jobs;

DROP DATABASE IF EXISTS jobs_mart;

CREATE DATABASE IF NOT EXISTS jobs_mart;

SHOW DATABASES;

SELECT *
FROM information_schema.schemata;

USE jobs_mart;

CREATE SCHEMA IF NOT EXISTS staging;

-- DROP SCHEMA staging;

/*
CREATE TABLE [IF NOT EXISTS] table_name (
    id_column INTEGER PRIMARY KEY,
    column_name2 datatype,
    column_name3 datatype,
    foreign_key_column datatype,
    FOREIGN KEY (foreign_key_column) REFERENCES parent_table()
)
*/
CREATE TABLE IF NOT EXISTS staging.preferred_roles (
    role_id INTEGER PRIMARY KEY,
    role_name VARCHAR   
);

SELECT *
FROM information_schema.tables
WHERE table_catalog = 'jobs_mart';


/*

INSERT

    * Adds rows: New records only
    * Primary key: Duplicate keys fail
    * No updates: fails on duplicates
    * Best for: New data ingestion

Update
    * 

*/


INSERT INTO staging.preferred_roles(role_id, role_name)
VALUES
    (1, 'Data Engineer'),
    (2, 'Senior Data Engineer'),
    (3, 'Software Engineer');

SELECT *
FROM staging.preferred_roles;

ALTER TABLE staging.preferred_roles
ADD COLUMN preferred_role BOOLEAN;

UPDATE staging.preferred_roles
SET preferred_role = TRUE
WHERE role_id = 1 OR role_id = 2;

UPDATE staging.preferred_roles
SET preferred_role = FALSE
WHERE role_id = 3;

ALTER TABLE staging.preferred_roles
RENAME TO priority_roles;

SELECT *
FROM staging.priority_roles;

ALTER TABLE staging.priority_roles
RENAME COLUMN preferred_role TO priority_lvl;


ALTER TABLE staging.priority_roles
ALTER COLUMN priority_lvl TYPE INTEGER;

UPDATE staging.priority_roles
SET priority_lvl = 3
WHERE role_id = 3;

SELECT *
FROM staging.priority_roles;