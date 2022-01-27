-- Получение средних значений по регионам (area_id) следующих величин:
-- compensation_from, compensation_to, среднее_арифметическое_from_и_to,
-- округление до второго знака, сортировка по полю area_id

SELECT area_id,
       ROUND(AVG(compensation_from),2) AS avg_compensation_from,
       ROUND(AVG(compensation_to),2) AS avg_compensation_to,
       ROUND(AVG((compensation_to + compensation_from)/2),2) AS avg_compensation
FROM vacancy v
GROUP BY area_id
ORDER BY area_id;
