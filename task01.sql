-- Создание таблиц вакансии(vacancy), резюме(resume), отклики(response), специализации(specialization).
-- Подразумевается, что эти 4 создаваемые таблицы будут связаны с таблицами работодатели(employer), соискатели(applicant),
-- регион(area), отрасль(industry), образование(education), которые в этом примере для простоты не создаются.


CREATE TABLE specialization (
  specialization_id       SERIAL PRIMARY KEY,
  specialization_title    TEXT
);

CREATE TABLE vacancy (
  vacancy_id          SERIAL PRIMARY KEY,
  created             DATE NOT NULL,
  employer_id         INTEGER NOT NULL,
  vacancy_title       TEXT NOT NULL,
  area_id             INTEGER NOT NULL,
  specialization_id   INTEGER REFERENCES specialization(specialization_id),
  industry_id         INTEGER,
  vacancy_description TEXT,
  compensation_from   INTEGER,
  compensation_to     INTEGER,
  compensation_gross  BOOLEAN
);

CREATE TABLE resume (
  resume_id         SERIAL PRIMARY KEY,
  created           DATE NOT NULL,
  applicant_id      INTEGER NOT NULL,
  area_id           INTEGER NOT NULL,
  work_experience   BOOLEAN,
  specialization_id INTEGER REFERENCES specialization(specialization_id),
  desired_position  TEXT NOT NULL,
  compensation      INTEGER,
  education_id      INTEGER
);

CREATE TABLE response (
  response_id SERIAL PRIMARY KEY,
  created     DATE,
  resume_id   INTEGER REFERENCES resume(resume_id),
  vacancy_id  INTEGER REFERENCES vacancy(vacancy_id)
)
