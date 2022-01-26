CREATE TABLE specialization (
    specialization_id       serial primary key,
    specialization_title    text
);

CREATE TABLE vacancy (
    vacancy_id          serial primary key,
    created             date,
    employer_id         integer not null,
    position_name       text not null,
    area_id             integer,
    specialization_id   integer references specialization(specialization_id),
    industry_id         integer,
    vacancy_description text,
    compensation_from   integer,
    compensation_to     integer,
    compensation_gross  boolean
);

CREATE TABLE resume (
    resume_id           serial primary key,
    created             date,
    applicant_id        integer not null,
    area_id             integer,
    work_experience     boolean,
    specialization_id   integer references specialization(specialization_id),
    position_name       text not null,
    compensation        integer,
    education_id        integer
);

CREATE TABLE response (
    response_id    serial primary key,
    created     date,
    resume_id   integer references resume(resume_id),
    vacancy_id  integer references vacancy(vacancy_id)
)