--Получение месяца с наибольшим количеством вакансий и месяца с наибольшим количеством резюме

WITH max_resume_created(month, count) AS (
  SELECT to_char(created, 'YYYY-MM'),
         COUNT(resume_id)
  FROM resume
  GROUP BY to_char(created, 'YYYY-MM')
  ORDER BY count(*) DESC
  LIMIT 1),
     max_vacancy_created(month, count) AS (
  SELECT to_char(created, 'YYYY-MM'),
         COUNT(vacancy_id)
  FROM vacancy
  GROUP BY to_char(created, 'YYYY-MM')
  ORDER BY count(*) DESC
  LIMIT 1)
SELECT *
FROM max_vacancy_created
JOIN max_resume_created ON TRUE;