-- duckdb dw_marts.duckdb -c ".read build_dw_marts.sql"

-- Step 1: Create star schema tables
.read 01_create_tables_dw.sql

-- Step 2: DW - Load data from CSV files into tables

.read 02_load_schema_dw.sql

-- Step 3: Mart - Create flat mart

.read 03_create_flat_mart.sql

-- Step 4: Skill Demand Mart build
.read 04_create_skills_mart.sql

-- Step 5: Priority Roles Mart build

.read 05_create_priority_mart.sql

-- Step 6: Update Priority Mart

.read 06_update_priority_mart.sql