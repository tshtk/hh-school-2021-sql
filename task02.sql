WITH test_data( id,
                title) AS (
    SELECT
           generate_series(1, 50) AS id,
           md5(random()::text) AS title
)
INSERT INTO specialization(specialization_id, specialization_title)
SELECT id, title
FROM test_data;


WITH test_data( vacancy_id,
                created,
                employer_id,
                vacancy_title,
                area_id,
                specialization_id,
                industry_id,
                vacancy_description,
                compensation_from,
                compensation_interval,
                compensation_gross) AS (
    SELECT generate_series(1, 10000)                                AS vacancy_id,
           now() - ('1 day'::interval * (random()*180::integer))    AS created,
           random() * 500::integer                                  AS employer_id,
           md5(random()::text)                                      AS vacancy_title,
           1 + random() * 84::integer                               AS area_id,
           1 + random() * 49::integer                               AS specialization_id,
           1 + random() * 99::integer                               AS industry_id,
           md5(random()::text)                                      AS vacancy_description,
           round((random() * (80000 - 15000) + 15000)::integer, -3) AS compensation_from,
           round((random() * (20000 - 5000) + 5000)::integer, -3)   AS compensation_interval,
           false
)
INSERT INTO vacancy(vacancy_id, created, employer_id, vacancy_title, area_id, specialization_id, industry_id, vacancy_description, compensation_from, compensation_to, compensation_gross)
SELECT vacancy_id,
       created,
       employer_id,
       vacancy_title,
       area_id,
       specialization_id,
       industry_id,
       vacancy_description,
       compensation_from,
       compensation_from + compensation_interval,
       compensation_gross
FROM test_data;

WITH test_data( resume_id,
                created,
                applicant_id,
                area_id,
                work_experience,
                specialization_id,
                position_name,
                compensation,
                education_id) AS (
    SELECT generate_series(1, 100000)                                   AS resume_id,
           now() - ('1 day'::interval * (random()*180::integer))         AS created,
           random() * 50000::integer                                    AS applicant_id,
           1 + random() * 84::integer                                   AS area_id,
           random() > 0.2                                               AS work_experience,
           1 + random() * 49::integer                                   AS specialization_id,
           md5(random()::text)                                          AS position_name,
           round((random() * (80000 - 15000) + 15000)::integer, -3)    AS compensation,
           1 + random() * 8::integer                                    AS education_id
)
INSERT INTO resume (resume_id, created, applicant_id, area_id, work_experience, specialization_id, position_name, compensation, education_id)
SELECT  resume_id,
        created,
        applicant_id,
        area_id,
        work_experience,
        specialization_id,
        position_name,
        compensation,
        education_id
FROM test_data;


WITH test_data( vacancy_id,
                resume_id,
                created
                ) AS (
SELECT v.vacancy_id,
       resume_id,
       CASE WHEN (r.created > v.created) THEN r.created::date + (random()*(now()::date - r.created))::integer
       ELSE v.created::date + (random()*(now()::date - v.created))::integer
       END AS created
FROM vacancy v
JOIN resume r ON (  v.area_id = r.area_id
                AND v.specialization_id = r.specialization_id
                AND r.compensation > v.compensation_from
                AND r.compensation < v.compensation_to))
INSERT INTO response(created, resume_id, vacancy_id)
SELECT created, resume_id, vacancy_id
FROM test_data;