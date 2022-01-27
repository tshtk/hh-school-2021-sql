--Получение id и title вакансий, которые собрали больше 5 откликов в первую неделю после публикации
--Также выполняется сортировка вакансий по количеству откликов в порядку убывания и выводится количество откликов

WITH first_weekly_responses (vacancy_id, vacancy_title, response_created, vacancy_created) AS (
  SELECT r.vacancy_id, v.vacancy_title, r.created, v.created
  FROM response AS r
  INNER JOIN vacancy AS v ON v.vacancy_id = r.vacancy_id
  WHERE r.created - v.created <= 7)
SELECT vacancy_id, vacancy_title, COUNT(vacancy_id) AS responses
FROM first_weekly_responses
GROUP BY vacancy_id, vacancy_title
HAVING COUNT(vacancy_id)>5
ORDER BY COUNT(*) DESC;