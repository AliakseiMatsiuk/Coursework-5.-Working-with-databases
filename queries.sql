-- создание базы данных
CREATE DATABASE course_work;

-- создание таблицы company
CREATE TABLE company
(
    company_id             INTEGER,
    company_name           VARCHAR(255) NOT NULL,
    company_open_vacansies INTEGER
);

-- создание таблицы vacancy
CREATE TABLE vacancy
(
    company_id  INTEGER,
    vacancies   VARCHAR(255) NOT NULL,
    salary      INTEGER,
    url_vacancy TEXT
);

-- заполнение таблицы колонками
INSERT INTO company(company_id, company_name, company_open_vacansies)
VALUES (%s, %s, %s);

-- заполнение таблицы колонками
INSERT INTO vacancy(company_id, vacancies, salary, url_vacancy)
VALUES (%s, %s, %s, %s);

--Получает список всех компаний и количество вакансий у каждой компании.
SELECT company_name, company_open_vacansies FROM company;

--Получает список всех вакансий с указанием названия компании, названия вакансии и зарплаты и ссылки на вакансию
SELECT vacancies, company_name, salary, url_vacancy
FROM vacancy
JOIN company USING(company_id);

--Получает среднюю зарплату по вакансиям.
SELECT ROUND(AVG(salary), 2) FROM vacancy
WHERE salary NOT IN ('0');

--Получает список всех вакансий, у которых зарплата выше средней по всем вакансиям.
SELECT company_name, vacancies, salary, url_vacancy
FROM vacancy
JOIN company USING(company_id)
WHERE salary > (SELECT AVG(salary) FROM vacancy WHERE salary != 0);

--Получает список всех вакансий, в названии которых содержатся переданные в метод слова
SELECT company_name, vacancies, salary, url_vacancy
FROM vacancy
JOIN company USING(company_id)
WHERE vacancies LIKE '%{word.capitalize()}%'