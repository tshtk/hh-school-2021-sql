WITH test_data( created,
                resume_id
                ) AS (
SELECT date_trunc('month', created),
       resume_id
FROM resume)
SELECT count(resume_id), Extract(MONTH from created::date ) AS mm, Extract(YEAR from created::date ) AS yyyy
FROM test_data
GROUP BY created
ORDER BY count(*) DESC
LIMIT 1;

WITH test_data( created,
                vacancy_id
                ) AS (
SELECT date_trunc('month', created),
       vacancy_id
FROM vacancy)
SELECT count(vacancy_id), Extract(MONTH from created::date ) AS mm, Extract(YEAR from created::date ) AS yyyy
FROM test_data
GROUP BY created
ORDER BY count(*) DESC
LIMIT 1;