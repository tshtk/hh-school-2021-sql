-- Создание таблиц вакансии(vacancy), резюме(resume), отклики(response), специализации(specialization).
-- Подразумевается, что эти 4 создаваемые таблицы будут связаны с таблицами работодатели(employer), соискатели(applicant),
-- регион(area), отрасль(industry), образование(education), которые в этом примере для простоты не создаются.


CREATE TABLE specialization (
  id     SERIAL PRIMARY KEY,
  title  TEXT
);

CREATE TABLE vacancy (
  id                  SERIAL PRIMARY KEY,
  created             DATE NOT NULL,
  employer_id         INTEGER NOT NULL,
  title               VARCHAR NOT NULL,
  area_id             INTEGER NOT NULL,
  specialization_id   INTEGER REFERENCES specialization(id),
  industry_id         INTEGER,
  description         TEXT,
  compensation_from   INTEGER,
  compensation_to     INTEGER,
  compensation_gross  BOOLEAN
);

CREATE TABLE resume (
  id                SERIAL PRIMARY KEY,
  created           DATE NOT NULL,
  applicant_id      INTEGER NOT NULL,
  area_id           INTEGER NOT NULL,
  work_experience   BOOLEAN,
  specialization_id INTEGER REFERENCES specialization(id),
  desired_position  VARCHAR NOT NULL,
  compensation      INTEGER,
  education_id      INTEGER
);

CREATE TABLE response (
  id          SERIAL PRIMARY KEY,
  created     DATE,
  resume_id   INTEGER REFERENCES resume(id),
  vacancy_id  INTEGER REFERENCES vacancy(id)
)
