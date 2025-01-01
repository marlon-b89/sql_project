/* Question: What are the top skills based on salary?
    - Look at the avg salary associated with each skill for DA Jobs
    - Focus on roles with specified salaries, remove null
Provides deeper insight into how different skills impact salary levels
*/

--List the top paying skills for data analysts for all job_postings

SELECT
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE  
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    job_location LIKE '%New York%'
GROUP BY
    skills
ORDER BY 
    avg_salary DESC
LIMIT 25;

/*
Conclusion
The variety of skills and their corresponding salaries demonstrate a dynamic and diverse technology landscape where data analysis, machine learning, programming, and infrastructure management are highly valued. Specialists in niche technologies or emerging tools can command premium salaries, and continuous learning in these areas seems to be highly advantageous for career progression.
*/
