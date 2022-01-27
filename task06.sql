-- Создать необходимые индексы (обосновать выбор столбцов)
-- Для работодателей частым вариантом поиска резюме будет поиск
-- по региону и специализации
-- Соответствующий индекс для ускорения такого поиска
CREATE INDEX resume_area_specialization_index ON resume(area_id, specialization_id);

-- Для соискателей частым вариантом поиска вакансий будет поиск
-- по региону, специализации и зарплате
-- Соответствующий индекс для ускорения такого поиска
CREATE INDEX vacancy_area_specialization_compensation_index ON vacancy (area_id, specialization_id, compensation_from, compensation_to);

-- Для работодателей частым вариантом поиска резюме среди откликов на конкретную вакансию
-- Соответствующий индекс для ускорения такого поиска
CREATE INDEX response_vacancy_index ON response (vacancy_id);