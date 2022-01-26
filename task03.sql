SELECT area_id,
       avg(compensation_from) AS compensation_from,
       avg(compensation_to) AS compensation_to,
       avg(compensation_to - compensation_from) AS compensation_avg
FROM vacancy v
GROUP BY area_id;