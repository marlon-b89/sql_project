/* Question: What are the most in-demand skills for all data analyst jobs?
    - Join job postings to inner join table
    - Identify the top 5 in-demand skills for D.A
    - Focus on all job_postings
Provides deeper insight into the most valuable skills for job seekers
*/

--List the top demanded skills for data analysts for all job_postings

SELECT
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE  
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%New York%'
GROUP BY
    skills
ORDER BY 
    demand_count DESC
LIMIT 10;