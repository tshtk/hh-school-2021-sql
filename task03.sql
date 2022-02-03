-- Получение средних значений по регионам (area_id) следующих величин:
-- compensation_from, compensation_to, среднее_арифметическое_from_и_to,
-- округление до второго знака, сортировка по полю area_id

WITH compensation_net_with_area(area_id, compensation_from, compensation_to) AS (
  SELECT area_id,
         CASE WHEN (v.compensation_gross = TRUE)
              THEN compensation_from * 0.87
              ELSE compensation_from
         END AS compensation_from,
         CASE WHEN (v.compensation_gross = TRUE)
              THEN compensation_to * 0.87
              ELSE compensation_to
         END AS compensation_to
  FROM vacancy v
    )
SELECT area_id,
       ROUND(AVG(compensation_from),2) AS avg_compensation_from,
       ROUND(AVG(compensation_to),2) AS avg_compensation_to,
       ROUND(AVG((compensation_to + compensation_from)/2),2) AS avg_compensation
FROM compensation_net_with_area
GROUP BY area_id
ORDER BY area_id;
