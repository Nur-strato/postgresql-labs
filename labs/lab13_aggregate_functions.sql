-- Lab 13: Aggregate Functions
-- Reference: Lab 13 Guide (COUNT, SUM, AVG, MIN/MAX, STRING_AGG, ARRAY_AGG, STDDEV, GROUP BY, HAVING, NULLs)

DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary NUMERIC(10, 2) NOT NULL,
    bonus NUMERIC(10, 2),
    age INT,
    hire_date DATE,
    email VARCHAR(100)
);

INSERT INTO employees (first_name, last_name, department, salary, bonus, age, hire_date, email) VALUES
('Alice', 'Johnson', 'IT', 75000.00, 5000.00, 28, '2023-03-15', 'alice@company.com'),
('Bob', 'Smith', 'IT', 82000.00, 6000.00, 35, '2022-01-10', 'bob@company.com'),
('Charlie', 'Lee', 'IT', 90000.00, NULL, 42, '2021-06-01', NULL),
('Diana', 'Prince', 'HR', 52000.00, 2000.00, 29, '2023-08-20', 'diana@company.com'),
('Evan', 'Wright', 'HR', 48000.00, NULL, 24, '2024-02-01', NULL),
('Fiona', 'Gallagher', 'Sales', 61000.00, 4500.00, 31, '2022-11-15', 'fiona@company.com'),
('George', 'Clark', 'Sales', 58000.00, 3000.00, 45, '2020-04-12', 'george@company.com'),
('Hannah', 'Abbott', 'Sales', 64000.00, 5000.00, 26, '2023-05-18', 'hannah@company.com');

-- 1. COUNT Variants
SELECT COUNT(*) AS total_employees,
       COUNT(email) AS employees_with_email,
       COUNT(DISTINCT department) AS unique_departments
FROM employees;

-- 2. SUM, AVG, MIN, MAX & Extremes
SELECT SUM(salary) AS total_salaries,
       ROUND(AVG(salary), 2) AS average_salary,
       MIN(salary) AS lowest_salary,
       MAX(salary) AS highest_salary
FROM employees;

SELECT department,
       MAX(hire_date) AS latest_hire,
       ROUND(AVG(age), 1) AS avg_age
FROM employees
GROUP BY department;

-- 3. Advanced Aggregates: STRING_AGG & ARRAY_AGG
SELECT department,
       STRING_AGG(first_name, ', ' ORDER BY first_name) AS employee_names,
       ARRAY_AGG(salary ORDER BY salary DESC) AS salaries_array
FROM employees
GROUP BY department;

-- 4. Statistical Aggregate Functions (STDDEV & VARIANCE)
SELECT department,
       ROUND(STDDEV(salary), 2) AS salary_std_dev,
       ROUND(VARIANCE(salary), 2) AS salary_variance
FROM employees
GROUP BY department;

-- 5. GROUP BY with Expressions (Age Groups)
SELECT 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END AS age_group,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END;

-- 6. HAVING Clause (Filtering Groups)
SELECT department, COUNT(*) AS employee_count, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;

-- 7. Handling NULL Values in Aggregations
SELECT COUNT(*) AS total_rows,


cd ~/Projects/postgresql-labs

cat << 'EOF' > labs/lab13_aggregate_functions.sql
-- Lab 13: Aggregate Functions
-- Reference: Lab 13 Guide (COUNT, SUM, AVG, MIN/MAX, STRING_AGG, ARRAY_AGG, STDDEV, GROUP BY, HAVING, NULLs)

DROP TABLE IF EXISTS employees CASCADE;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50) NOT NULL,
    salary NUMERIC(10, 2) NOT NULL,
    bonus NUMERIC(10, 2),
    age INT,
    hire_date DATE,
    email VARCHAR(100)
);

INSERT INTO employees (first_name, last_name, department, salary, bonus, age, hire_date, email) VALUES
('Alice', 'Johnson', 'IT', 75000.00, 5000.00, 28, '2023-03-15', 'alice@company.com'),
('Bob', 'Smith', 'IT', 82000.00, 6000.00, 35, '2022-01-10', 'bob@company.com'),
('Charlie', 'Lee', 'IT', 90000.00, NULL, 42, '2021-06-01', NULL),
('Diana', 'Prince', 'HR', 52000.00, 2000.00, 29, '2023-08-20', 'diana@company.com'),
('Evan', 'Wright', 'HR', 48000.00, NULL, 24, '2024-02-01', NULL),
('Fiona', 'Gallagher', 'Sales', 61000.00, 4500.00, 31, '2022-11-15', 'fiona@company.com'),
('George', 'Clark', 'Sales', 58000.00, 3000.00, 45, '2020-04-12', 'george@company.com'),
('Hannah', 'Abbott', 'Sales', 64000.00, 5000.00, 26, '2023-05-18', 'hannah@company.com');

-- 1. COUNT Variants
SELECT COUNT(*) AS total_employees,
       COUNT(email) AS employees_with_email,
       COUNT(DISTINCT department) AS unique_departments
FROM employees;

-- 2. SUM, AVG, MIN, MAX & Extremes
SELECT SUM(salary) AS total_salaries,
       ROUND(AVG(salary), 2) AS average_salary,
       MIN(salary) AS lowest_salary,
       MAX(salary) AS highest_salary
FROM employees;

SELECT department,
       MAX(hire_date) AS latest_hire,
       ROUND(AVG(age), 1) AS avg_age
FROM employees
GROUP BY department;

-- 3. Advanced Aggregates: STRING_AGG & ARRAY_AGG
SELECT department,
       STRING_AGG(first_name, ', ' ORDER BY first_name) AS employee_names,
       ARRAY_AGG(salary ORDER BY salary DESC) AS salaries_array
FROM employees
GROUP BY department;

-- 4. Statistical Aggregate Functions (STDDEV & VARIANCE)
SELECT department,
       ROUND(STDDEV(salary), 2) AS salary_std_dev,
       ROUND(VARIANCE(salary), 2) AS salary_variance
FROM employees
GROUP BY department;

-- 5. GROUP BY with Expressions (Age Groups)
SELECT 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END AS age_group,
    COUNT(*) AS employee_count,
    ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY 
    CASE 
        WHEN age < 30 THEN 'Under 30'
        WHEN age BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END;

-- 6. HAVING Clause (Filtering Groups)
SELECT department, COUNT(*) AS employee_count, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;

-- 7. Handling NULL Values in Aggregations
SELECT COUNT(*) AS total_rows,
       COUNT(email) AS non_null_emails,
       COUNT(*) - COUNT(email) AS null_emails,
       SUM(bonus) AS total_bonus,
       ROUND(AVG(bonus), 2) AS avg_bonus,
       COUNT(bonus) AS employees_with_bonus
FROM employees;

-- 8. Percentage Calculations & Conditional Aggregation
SELECT department,
       COUNT(*) AS dept_count,
       COUNT(CASE WHEN salary > 60000 THEN 1 END) AS high_earners,
       ROUND((COUNT(*)::FLOAT / (SELECT COUNT(*) FROM employees) * 100)::NUMERIC, 2) AS percentage_of_total
FROM employees
GROUP BY department
ORDER BY percentage_of_total DESC;

-- 9. Window vs Aggregate Comparison
SELECT employee_id, first_name, department, salary,
       ROUND(AVG(salary) OVER (PARTITION BY department), 2) AS dept_avg_salary
FROM employees;
