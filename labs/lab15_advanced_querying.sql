-- Lab 15: Advanced Querying
-- Reference: Lab 15 Guide (Subqueries, Recursive CTE, Sets, Window Functions, Pivot, Filtering/Sorting, EXPLAIN)

DROP TABLE IF EXISTS employees, orders, warehouse_1, warehouse_2, sales CASCADE;

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC(10, 2),
    tenure INT,
    manager_id INTEGER REFERENCES employees(employee_id)
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    region_id INT,
    product_name VARCHAR(100),
    amount NUMERIC(12, 2),
    status VARCHAR(50)
);

CREATE TABLE warehouse_1 (
    product_id INT,
    product_name VARCHAR(100),
    quantity INT
);

CREATE TABLE warehouse_2 (
    product_id INT,
    product_name VARCHAR(100),
    quantity INT
);

CREATE TABLE sales (
    product_name VARCHAR(100),
    year INT,
    sales_amount NUMERIC(10, 2)
);

-- Seed Data
INSERT INTO employees (first_name, last_name, department, salary, tenure, manager_id) VALUES
('Elena', 'Vasilieva', 'Executive', 150000.00, 10, NULL),
('John', 'Smith', 'IT', 95000.00, 6, 1),
('Alice', 'Johnson', 'IT', 85000.00, 3, 2),
('Bob', 'Marley', 'IT', 85000.00, 2, 2),
('Diana', 'Prince', 'Sales', 65000.00, 7, 1),
('Evan', 'Wright', 'Sales', 50000.00, 1, 5);

INSERT INTO orders (region_id, product_name, amount, status) VALUES
(1, 'Server Rack', 1200000.00, 'High Priority'),
(1, 'Switches', 250000.00, 'Medium Priority'),
(2, 'Laptops', 400000.00, 'Low Priority'),
(3, 'Monitors', 90000.00, 'Other');

INSERT INTO warehouse_1 VALUES (101, 'Mouse', 15), (102, 'Keyboard', 0), (103, 'Monitor', 8);
INSERT INTO warehouse_2 VALUES (102, 'Keyboard', 0), (103, 'Monitor', 12), (104, 'Webcam', 5);

INSERT INTO sales VALUES 
('Laptop', 2022, 50000.00), ('Laptop', 2023, 75000.00), ('Laptop', 2024, 90000.00),
('Phone', 2022, 30000.00),  ('Phone', 2023, 40000.00),  ('Phone', 2024, 45000.00);

-- 1. Subquery: Employees with salary above company average
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- 2. CTE with aggregation
WITH regional_sales AS (
    SELECT region_id, SUM(amount) AS total_sales
    FROM orders
    GROUP BY region_id
)
SELECT region_id, total_sales
FROM regional_sales
WHERE total_sales > 1000000;

-- 3. Recursive CTE: Hierarchical Organization Chart
WITH RECURSIVE org_chart AS (
    SELECT employee_id, first_name, last_name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id, oc.level + 1
    FROM employees e
    INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT * FROM org_chart ORDER BY level, employee_id;

-- 4. Set Operations: UNION, INTERSECT, EXCEPT
SELECT product_name FROM warehouse_1 UNION SELECT product_name FROM warehouse_2;
SELECT product_id FROM warehouse_1 WHERE quantity = 0 INTERSECT SELECT product_id FROM warehouse_2 WHERE quantity = 0;
SELECT product_name FROM warehouse_1 EXCEPT SELECT product_name FROM warehouse_2;

-- 5. Window Functions & Partitioning
SELECT first_name, last_name, department, salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank
FROM employees;

-- 6. Pivoting with Conditional Aggregation
SELECT product_name,
       SUM(CASE WHEN year = 2022 THEN sales_amount ELSE 0 END) AS year_2022,
       SUM(CASE WHEN year = 2023 THEN sales_amount ELSE 0 END) AS year_2023,
       SUM(CASE WHEN year = 2024 THEN sales_amount ELSE 0 END) AS year_2024
FROM sales
GROUP BY product_name;

-- 7. FILTER Clause with Window Functions
SELECT employee_id,
       SUM(salary) OVER (PARTITION BY department) AS total_dept_salary,
       AVG(salary) FILTER (WHERE tenure > 5) OVER () AS avg_salary_senior
FROM employees;

-- 8. Custom Sorting with CASE
SELECT product_name, status
FROM orders
ORDER BY
    CASE status
        WHEN 'High Priority' THEN 1
        WHEN 'Medium Priority' THEN 2
        WHEN 'Low Priority' THEN 3
        ELSE 4
    END;

-- 9. Query Optimization (EXPLAIN ANALYZE)
EXPLAIN ANALYZE SELECT first_name, last_name, salary FROM employees WHERE salary > 80000;
