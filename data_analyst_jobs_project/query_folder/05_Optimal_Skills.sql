/* Question: What are the most optimal skills to learn?
    - Identify skills in high demand and associated with high avg salaries for DA Jobs
    - Concentrate on NYC with specified salaries 
Target skills that offer job security (high demand) and financial benefits (high salary)
     - Offering strategic insights for career development in data analysis
*/



WITH skills_demand AS 
(
    SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE  
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%New York%' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), financial_benefit AS 
(
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 2) AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
    WHERE  
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%New York%' AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM skills_demand
INNER JOIN financial_benefit ON skills_demand.skill_id = financial_benefit.skill_id
WHERE demand_count > 10
ORDER BY 
    demand_count DESC,
    avg_salary DESC
LIMIT 30;
