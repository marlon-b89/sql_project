/* Question: What are the top-skills required for the top-paying data analyst jobs?
    - Use the previous query to focus on those postings
    - Add the specific skills required for each role
Provides deeper insight to aide job seekers understand the skills they need to develop that align with the top salaries.
*/

--Identifying the top-skills for those jobs

WITH top_paying_jobs AS 
(
    SELECT
        job_id,
        job_title,
        salary_year_avg,
        name as company_name
    FROM
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%New York%' AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
) 

SELECT
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY 
    salary_year_avg DESC;

/*
Frequency of Skill Requirements
SQL: Appears in 14 postings across different job titles.
Python: Appears in 13 postings.
Pandas: Appears in 3 postings.
R: Appears in 5 postings.
Express: Appears in 4 postings.
Tableau: Appears in 4 postings.
Power BI: Appears in 3 postings.
Elasticsearch, Neo4j, SQL Server, AWS, Oracle, Spark, Kafka: Each appears in multiple postings for the role of Data Analysis Manager.

Summary
The analysis highlights a strong market demand for SQL and Python skills, with an evident premium on expertise in advanced data processing and analysis tools. The investment in learning and mastering these skills clearly aligns with higher earning potential in the data analysis and finance sectors.
[
  {
    "job_id": 339646,
    "job_title": "Data Sector Analyst - Hedge Fund in Midtown",
    "salary_year_avg": "240000.0",
    "company_name": "Coda Search│Staffing",
    "skills": "sql"
  },
  {
    "job_id": 339646,
    "job_title": "Data Sector Analyst - Hedge Fund in Midtown",
    "salary_year_avg": "240000.0",
    "company_name": "Coda Search│Staffing",
    "skills": "python"
  },
  {
    "job_id": 339646,
    "job_title": "Data Sector Analyst - Hedge Fund in Midtown",
    "salary_year_avg": "240000.0",
    "company_name": "Coda Search│Staffing",
    "skills": "pandas"
  },
  {
    "job_id": 1713491,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "company_name": "TikTok",
    "skills": "sql"
  },
  {
    "job_id": 1713491,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "company_name": "TikTok",
    "skills": "python"
  },
  {
    "job_id": 1713491,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "company_name": "TikTok",
    "skills": "r"
  },
  {
    "job_id": 1713491,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "company_name": "TikTok",
    "skills": "express"
  },
  {
    "job_id": 841064,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "company_name": "TikTok",
    "skills": "sql"
  },
  {
    "job_id": 841064,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "company_name": "TikTok",
    "skills": "python"
  },
  {
    "job_id": 841064,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "company_name": "TikTok",
    "skills": "r"
  },
  {
    "job_id": 841064,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "239777.5",
    "company_name": "TikTok",
    "skills": "express"
  },
  {
    "job_id": 204500,
    "job_title": "Reference Data Analyst",
    "salary_year_avg": "225000.0",
    "company_name": "Selby Jennings",
    "skills": "sql"
  },
  {
    "job_id": 204500,
    "job_title": "Reference Data Analyst",
    "salary_year_avg": "225000.0",
    "company_name": "Selby Jennings",
    "skills": "python"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "company_name": "Pronix Inc",
    "skills": "sql"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "company_name": "Pronix Inc",
    "skills": "neo4j"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "company_name": "Pronix Inc",
    "skills": "elasticsearch"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "company_name": "Pronix Inc",
    "skills": "sql server"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "company_name": "Pronix Inc",
    "skills": "aws"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "company_name": "Pronix Inc",
    "skills": "oracle"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "company_name": "Pronix Inc",
    "skills": "spark"
  },
  {
    "job_id": 1563879,
    "job_title": "Data Analysis Manager",
    "salary_year_avg": "185000.0",
    "company_name": "Pronix Inc",
    "skills": "kafka"
  },
  {
    "job_id": 396924,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "company_name": "TikTok",
    "skills": "sql"
  },
  {
    "job_id": 396924,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "company_name": "TikTok",
    "skills": "python"
  },
  {
    "job_id": 396924,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "company_name": "TikTok",
    "skills": "r"
  },
  {
    "job_id": 396924,
    "job_title": "Investigations and Insights Lead Data Analyst - USDS",
    "salary_year_avg": "181177.5",
    "company_name": "TikTok",
    "skills": "express"
  },
  {
    "job_id": 386504,
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "company_name": "Brewer Morris",
    "skills": "python"
  },
  {
    "job_id": 386504,
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "company_name": "Brewer Morris",
    "skills": "excel"
  },
  {
    "job_id": 386504,
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "company_name": "Brewer Morris",
    "skills": "tableau"
  },
  {
    "job_id": 386504,
    "job_title": "Data Associate, Investor Relations",
    "salary_year_avg": "180000.0",
    "company_name": "Brewer Morris",
    "skills": "power bi"
  },
  {
    "job_id": 1468996,
    "job_title": "Data Analyst & Investor Relations",
    "salary_year_avg": "175000.0",
    "company_name": "Marlowe Partners LP",
    "skills": "excel"
  },
  {
    "job_id": 1468996,
    "job_title": "Data Analyst & Investor Relations",
    "salary_year_avg": "175000.0",
    "company_name": "Marlowe Partners LP",
    "skills": "powerpoint"
  },
  {
    "job_id": 405956,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "175000.0",
    "company_name": "Blink Health",
    "skills": "sql"
  },
  {
    "job_id": 405956,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "175000.0",
    "company_name": "Blink Health",
    "skills": "airflow"
  },
  {
    "job_id": 405956,
    "job_title": "Principal Data Analyst",
    "salary_year_avg": "175000.0",
    "company_name": "Blink Health",
    "skills": "tableau"
  }
]
*/
