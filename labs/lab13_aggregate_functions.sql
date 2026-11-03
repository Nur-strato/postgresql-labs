-- Lab 13: Aggregate Functions
DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees (employee_id SERIAL PRIMARY KEY, first_name VARCHAR(50) NOT NULL, last_name VARCHAR(50) NOT NULL, department VARCHAR(50) NOT NULL, salary NUMERIC(10, 2) NOT NULL, bonus NUMERIC(10, 2), age INT, hire_date DATE, email VARCHAR(100));
INSERT INTO employees (first_name, last_name, department, salary, bonus, age, hire_date, email) VALUES
('Alice', 'Johnson', 'IT', 75000.00, 5000.00, 28, '2023-03-15', 'alice@company.com'),
('Bob', 'Smith', 'IT', 82000.00, 6000.00, 35, '2022-01-10', 'bob@company.com'),
('Charlie', 'Lee', 'IT', 90000.00, NULL, 42, '2021-06-01', NULL),
('Diana', 'Prince', 'HR', 52000.00, 2000.00, 29, '2023-08-20', 'diana@company.com'),
('Evan', 'Wright', 'HR', 48000.00, NULL, 24, '2024-02-01', NULL),
('Fiona', 'Gallagher', 'Sales', 61000.00, 4500.00, 31, '2022-11-15', 'fiona@company.com'),
('George', 'Clark', 'Sales', 58000.00, 3000.00, 45, '2020-04-12', 'george@company.com'),
('Hannah', 'Abbott', 'Sales', 64000.00, 5000.00, 26, '2023-05-18', 'hannah@company.com');

SELECT COUNT(*) AS total_employees, COUNT(email) AS employees_with_email, COUNT(DISTINCT department) AS unique_departments FROM employees;
SELECT department, COUNT(*) AS employee_count, ROUND(AVG(salary), 2) AS avg_salary FROM employees GROUP BY department ORDER BY avg_salary DESC;
SELECT department, COUNT(*) AS employee_count FROM employees GROUP BY department HAVING AVG(salary) > 60000;
SELECT department, STRING_AGG(first_name, ', ' ORDER BY first_name) AS employee_names, ARRAY_AGG(salary ORDER BY salary DESC) AS salaries_array FROM employees GROUP BY department;
SELECT employee_id, first_name, department, salary, ROUND(AVG(salary) OVER (PARTITION BY department), 2) AS dept_avg_salary FROM employees;
