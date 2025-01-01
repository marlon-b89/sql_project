# INTRODUCTION
📊I participated in Luke Barousse's course **SQL for Data Analytics** on his YouTube page. As part of the capstone project, we analyzed the job market for data analyst jobs. This project explores top-paying jobs, in-demand skills, and where high demand meets high salary for data analyst roles in the NYC area🗽. Want to see all the SQL queries utilized for this project? Check them out here: [Project Queries](/data_analyst_jobs_project/query_folder/)

# BACKGROUND
🕵️This course was the perfect introduction to the power of SQL in my journey to learn a new skill. 

You can access [Barousse's course](https://www.lukebarousse.com/sql) on his website and I highly recommend subscribing to his [YouTube Page](https://www.youtube.com/@LukeBarousse) for more great content.

### Questions for Analysis
1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are the most in-demand for data analysts?
4. Which skills are associated with the highest salaries?
5. What are the most optimal skills to learn?

# TOOLS I USED
🛠️As part of the course and this project, I used several key tools:

- **SQL:** The backbone of my analysis that allowed me to query the database.
- **PostgreSQL:** THe database management system, ideal for handling the multiple different datasets.
- **Visual Studio Code:** My go-to for database management and execution of SQL queries.
- **ChatGPT:** Utilized to extract trends and insights, as well as create the visualizations incorporated here.

# THE ANALYSIS
📚Each query for this project aimed at investigating specific aspects of the data analyst job market. 
### 1. What are the top-paying data analyst jobs?
Highlight the top-paying opportunities and the company name, offering insights into the highest paying employment opportunities from 2023.

![Top Paying Roles](/data_analyst_jobs_project/assets/01_Highest_Salary.png)
*ChatGPT generated this graph from my SQL query results.*
```sql
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
```

### 2. What skills are required for these top-paying jobs?
Provides deeper insight to aide job seekers understand the skills they need to develop that align with the top salaries.

![Top Skillsets](/data_analyst_jobs_project/assets/02_Skillsets_Count.png)
*ChatGPT generated this graph from my SQL query results.*
```sql
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
```

### 3. What skills are the most in-demand for data analysts?
Reviewed a comparative view of how frequently each skill is required, emphasizing the key areas of focus for those looking to enhance their expertise in the data analytics field.
```sql
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
```

### 4. Which skills are associated with the highest salaries?
The variety of skills and their corresponding salaries demonstrate a dynamic and diverse technology landscape where data analysis, machine learning, programming, and infrastructure management are highly valued. 

![Skills associated with High Salary](/data_analyst_jobs_project/assets/04_Skills_Job_Table.png)
```sql
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
```

### 5. What are the most optimal skills to learn?
The scatter plot above represents the demand and average salary for various top skills. Each point on the graph corresponds to a specific skill, with its position determined by the demand count (horizontal axis) and average salary (vertical axis). The size of each point indicates the demand count, providing a visual representation of both the popularity and the value of each skill in the job market. Here are some key observations:
- SQL remains a highly demanded skill with a relatively high average salary, positioned significantly on the graph.
- Express has the highest average salary among the skills plotted, despite a lower demand, indicating its niche but lucrative nature.
- Python, Tableau, and Excel show strong demand with high average salaries, underscoring their importance in data-related professions.
![Optimal Skillsets](/data_analyst_jobs_project/assets/05_Optimal_Skills.png)
*ChatGPT generated this graph from my SQL query results.*
```sql
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
```

# WHAT I LEARNED 
💡This project afforded me the invaluable opportunity to enhance my SQL capabilities, which are essential for data analysis. Engaging extensively with SQL not only solidified my foundational understanding but also allowed me to tackle increasingly complex problems. This experience expanded my analytical abilities and equipped me with the skills necessary to delve deeper into data-driven decision-making processes. The practical application of SQL through varied and challenging scenarios has significantly improved my proficiency and confidence in handling real-world data tasks. 

# CONCLUSIONS
🙏Foundational skills like SQL and Excel remain indispensable, while expertise in modern programming languages, cloud services, and big data technologies offers lucrative opportunities. Visualization tools continue to be essential, reflecting the ongoing need for data professionals who can translate complex data into actionable insights. These insights could guide professionals in prioritizing skill development based on market demand and potential salary benefits.

The analysis highlights a strong market demand for SQL and Python skills, with an evident premium on expertise in advanced data processing and analysis tools. The investment in learning and mastering these skills clearly aligns with higher earning potential in the data analysis and finance sectors. Furthermore, specialists in niche technologies or emerging tools can command premium salaries, and continuous learning in these areas seems to be highly advantageous for career progression.