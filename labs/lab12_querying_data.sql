-- Lab 12: Querying Data
DROP TABLE IF EXISTS sales, employees, products, users CASCADE;
CREATE TABLE employees (id SERIAL PRIMARY KEY, name VARCHAR(100), department VARCHAR(50), department_id INT, salary NUMERIC(10, 2));
CREATE TABLE sales (sale_id SERIAL PRIMARY KEY, employee_id INT REFERENCES employees(id), amount NUMERIC(10, 2));
CREATE TABLE products (product_id SERIAL PRIMARY KEY, product_name VARCHAR(100), price NUMERIC(10, 2));
CREATE TABLE users (user_id SERIAL PRIMARY KEY, email VARCHAR(100));

INSERT INTO employees (name, department, department_id, salary) VALUES
('Brad Pitt', 'Sales', 3, 50000.00), ('Brandon Lee', 'Engineering', 5, 85000.00),
('Alice Cooper', 'Engineering', 5, 95000.00), ('Bob Marley', 'HR', 7, 45000.00),
('Charlie Chaplin', 'Engineering', 5, 60000.00);

INSERT INTO sales (employee_id, amount) VALUES (1, 1500.00), (2, 500.00), (3, 2000.00);
INSERT INTO products (product_name, price) VALUES ('Strawberry', 25.00), ('Blueberry', 45.00), ('Pineapple', 70.00);
INSERT INTO users (email) VALUES ('john.doe@gmail.com'), ('ALICE@GMAIL.COM'), ('invalid-email-address');

SELECT name, salary, salary * 0.10 AS potential_bonus FROM employees;
SELECT name FROM employees WHERE salary > 75000 AND department = 'Engineering';
SELECT product_name, price FROM products WHERE price BETWEEN 20 AND 50;
SELECT name FROM employees WHERE name LIKE 'Bra%';
SELECT email FROM users WHERE email ILIKE '%@gmail.com';
SELECT name FROM employees WHERE name ~ '^[AB]';
SELECT name, department FROM employees WHERE department_id IN (3, 5, 7);
SELECT name FROM employees e WHERE EXISTS (SELECT 1 FROM sales s WHERE s.employee_id = e.id AND s.amount > 1000);

WITH department_averages AS (
    SELECT department, AVG(salary) AS avg_salary FROM employees GROUP BY department
)
SELECT e.name, e.salary, e.department, ROUND(da.avg_salary, 2) AS avg_dept_salary
FROM employees e JOIN department_averages da ON e.department = da.department
WHERE e.salary > da.avg_salary;
