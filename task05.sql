--Получение id и title вакансий, которые собрали больше 5 откликов в первую неделю после публикации
--Также выполняется сортировка вакансий по количеству откликов в порядку убывания и выводится количество откликов

SELECT v.id, v.title, COUNT(r.vacancy_id) AS responses
FROM response AS r
INNER JOIN vacancy AS v ON v.id = r.vacancy_id
WHERE r.created - v.created <= 7
GROUP BY v.id, v.title
HAVING COUNT(*)>5
ORDER BY COUNT(*) DESC;
