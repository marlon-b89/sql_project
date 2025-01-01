/* Question: What are the top-paying data analyst jobs?
    - Identify the Top 10 highest paying roles and companies
    - Filter for remote and/or in NYC area
    - Focus on postings with specified salaries (remove null)
Highlight the top-paying opportunities and requiried skillsets, offering insights into employment opportunities.
*/

-- Identifying the top-paying jobs in NYC
SELECT
    job_id,
    job_title_short,
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
LIMIT 10;
