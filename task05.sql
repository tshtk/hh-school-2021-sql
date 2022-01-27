WITH first_weekly_responses(vacancy_id, vacancy_title, response_created, vacancy_created) AS (

SELECT r.vacancy_id, v.vacancy_title, r.created AS response_created, v.created AS vacancy_created
FROM response AS r
JOIN vacancy AS v ON v.vacancy_id = r.vacancy_id
WHERE r.created - v.created <= 7)
SELECT vacancy_id, vacancy_title, count(vacancy_id) AS responses
FROM first_weekly_responses
GROUP BY vacancy_id, vacancy_title
HAVING count(vacancy_id)>5
ORDER BY count(*) DESC;