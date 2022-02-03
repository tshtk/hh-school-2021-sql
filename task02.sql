-- Заполнение 4 таблиц базы данных тестовыми данными

WITH specialization_test_data(id, title) AS (
  SELECT  generate_series(1, 50) AS id,
          md5(random()::text) AS title
)
INSERT INTO specialization(id, title)
SELECT id, title
FROM specialization_test_data;


WITH vacancy_test_data(id,
                created,
                employer_id,
                title,
                area_id,
                specialization_id,
                industry_id,
                description,
                compensation_from,
                compensation_interval,
                compensation_gross) AS (
  SELECT generate_series(1, 10000)                                AS id,
         now() - ('1 day'::interval * (random()*180::integer))    AS created,
         random() * 500::integer                                  AS employer_id,
         md5(random()::text)                                      AS title,
         1 + random() * 84::integer                               AS area_id,
         1 + random() * 49::integer                               AS specialization_id,
         1 + random() * 99::integer                               AS industry_id,
         md5(random()::text)                                      AS description,
         round((random() * (80000 - 15000) + 15000)::integer, -3) AS compensation_from,
         round((random() * (20000 - 5000) + 5000)::integer, -3)   AS compensation_interval,
         false
)
INSERT INTO vacancy(id, created, employer_id, title, area_id, specialization_id, industry_id,
                    description, compensation_from, compensation_to, compensation_gross)
SELECT id,
       created,
       employer_id,
       title,
       area_id,
       specialization_id,
       industry_id,
       description,
       compensation_from,
       compensation_from + compensation_interval,
       compensation_gross
FROM vacancy_test_data;

WITH resume_test_data(id,
                created,
                applicant_id,
                area_id,
                work_experience,
                specialization_id,
                desired_position,
                compensation,
                education_id) AS (
  SELECT generate_series(1, 100000)                              AS id,
         now() - ('1 day'::interval * (random()*180::integer))    AS created,
         random() * 50000::integer                                AS applicant_id,
         1 + random() * 84::integer                               AS area_id,
         random() > 0.2                                           AS work_experience,
         1 + random() * 49::integer                               AS specialization_id,
         md5(random()::text)                                      AS desired_position,
         round((random() * (80000 - 15000) + 15000)::integer, -3) AS compensation,
         1 + random() * 8::integer                                AS education_id
)
INSERT INTO resume (id, created, applicant_id, area_id, work_experience, specialization_id, desired_position,
                    compensation, education_id)
SELECT  id,
        created,
        applicant_id,
        area_id,
        work_experience,
        specialization_id,
        desired_position,
        compensation,
        education_id
FROM resume_test_data;

WITH response_test_data( vacancy_id, resume_id, created) AS (
  SELECT v.id,
         r.id,
         CASE WHEN (r.created > v.created)
              THEN r.created::date + (random()*(now()::date - r.created))::integer
              ELSE v.created::date + (random()*(now()::date - v.created))::integer
         END AS created
FROM vacancy v
INNER JOIN resume r ON (v.area_id = r.area_id
                        AND v.specialization_id = r.specialization_id
                        AND r.compensation > v.compensation_from
                        AND r.compensation < v.compensation_to))
INSERT INTO response(created, resume_id, vacancy_id)
SELECT created, resume_id, vacancy_id
FROM response_test_data;
