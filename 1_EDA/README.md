# Exploratory Data Analysis w/ SQL: Job Market Analysis


![Project 1 Overview](../Images/ProjectImage.png)

A SQL project analyzing the data engineer job market using real world
job posting data. It demonstrates my ability to **write production-quality
analytical SQL, design efficient queries, and turn business questions into
data-driven insights**.

## Executive Summary

- ✅ Project scope: Built 3 analytical queries that answer key questions about the data engineer job market
- ✅ Data modeling: Used multi-table joins across fact and dimension tables to extract insights
- ✅ Analytics: Applied aggregations, filtering, and sorting to find top skills by demand, salary, and overall value
- ✅ Outcomes: Delivered actionable insights on SQL/Python dominance, cloud trends, and salary patterns 

If you only have a minute, review these:    

[01_top_demanded_skills.sql](01_top_demanded_skills.sql) – demand analysis with multi-table joins    
[02_top_paying_skills.sql](02_top_paying_skills.sql) – salary analysis with aggregations     
[03_optimal_skills.sql](03_optimal_skills.sql) – combined demand/salary optimization query
## Problem & Context

Job market analysts need to answer questions like:

- 💻 *What skills are most in-demand for data engineers?*

- 💰 W*hat skills a have the highest paying salaries?*

- ⚖️ *What is the optimal skill set balancing demand and compensation?*

This project analyzes a **data warehouse** built using the star schema
design. The warehouse structure consists of:

![Star Schema Design](../Images/1_2_Data_Warehouse.png)

- **Fact Table**: `job_postings_fact` - Central table containing job posting details (job_titles, locations, salaries, dates, etc)
- **Dimension Tables**:
    - `company_dim` - Company information linked to job postings
    - `skills_dim` - Skills catalog with skills names and types
- **Bridge Table**: skills_job_dim - Resolves the many-to-many relationship between job postings and skills

By building queries across these tables I was able to derive insights about skill deamnd, salary, the most optimal skills combinations to be successful in finding your desired role as a data engineer.

## Tech Stack

- 🐤 **Query Engine:** DuckDB for fast OLAP-style analytical queries
- 🧮 **Language:** SQL (ANSI-style with analytical functions)
- 📊 **Data Model:** Star Schema with fact + dimension + bridge tables
- 🧰 **Developmment:** VS Code for SQL editing + Terminal for DuckDB CLI
- 📦**Version Control:** Git/Github for versioned SQL scripts

## Analysis Overview

### Query Structure

1. **[Top Demanded Skills](./01_top_demanded_skills.sql)** - Identifies the top 10 most in-demand skills for remote Data Engineer positions

2. **[Top Paying Skills](./02_top_paying_skills.sql)** - Analyzes the top 25 highest-paying skills and demand metrics

3. **[Optimal Skills](./03_most_optimal_skills.sql)** - Calculates an optimal score using natural log of demand combined with median salary to identify the most valubale skills to learn

### Key Insights

- 🧠 Core Languages: SQL and Python each appear in ~29,000 job postings, making them the most demanded skills
- ☁️ Cloud Platforms: AWS and Azure are critical for modern data engineering roles
- 🧱 Infra & tools: Kubernetes, Docker, and Terraform are associated with premium salaries
- 🔥 Big Data tools: Apache Spark shows strong demand with competitive compensation

## SQL Skills Demonstrated

### Query Design & Optimization

- **Complext Joins**: Multi-table `INNER-JOIN` operations across `job_postings_fact`, `skills_job_dim`, and `skills_dim`
- **Aggregation**: `COUNT()`, `MEDIAN()`, `ROUND()` for statistical analysis
- **Filtering**: Boolean logic with `WHERE` clauses and multiple conditions (`job_title_short`, `job_work_from_home`, `salary_year_avg IS NOT NULL`)
- **Sorting & Limiting**: `ORDER BY` with `DESC` and `LIMIT` for top-N analysis

### Data Analysis Techniques

- **Grouping**: `GROUP BY` for categorical analysis by skill
- **Conditional Logic**: `CASE WHEN` statements for derived metrics
- **Mathematical Functions**: `LN()` for natural logarithm transformation to normalize demand metrics
- **Calculated Metrics**: Derived optimal score combining log-transformed demand with median salary
- **HAVING Clause**: Filtering aggregated results (skills with >= 100 postings)
- **NULL Handling**: Proper filtering of incomplete records (`salary_year_avg IS NOT NULL`)