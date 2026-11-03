-- Lab 15: Advanced Querying
DROP TABLE IF EXISTS employees, orders, warehouse_1, warehouse_2, sales CASCADE;
CREATE TABLE employees (employee_id SERIAL PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), department VARCHAR(50), salary NUMERIC(10,2), tenure INT, manager_id INTEGER REFERENCES employees(employee_id));
CREATE TABLE orders (order_id SERIAL PRIMARY KEY, region_id INT, product_name VARCHAR(100), amount NUMERIC(12,2), status VARCHAR(50));
CREATE TABLE warehouse_1 (product_id INT, product_name VARCHAR(100), quantity INT);
CREATE TABLE warehouse_2 (product_id INT, product_name VARCHAR(100), quantity INT);
CREATE TABLE sales (product_name VARCHAR(100), year INT, sales_amount NUMERIC(10,2));

INSERT INTO employees (first_name, last_name, department, salary, tenure, manager_id) VALUES
('Elena', 'Vasilieva', 'Executive', 150000.00, 10, NULL), ('John', 'Smith', 'IT', 95000.00, 6, 1),
('Alice', 'Johnson', 'IT', 85000.00, 3, 2), ('Bob', 'Marley', 'IT', 85000.00, 2, 2),
('Diana', 'Prince', 'Sales', 65000.00, 7, 1), ('Evan', 'Wright', 'Sales', 50000.00, 1, 5);

INSERT INTO orders (region_id, product_name, amount, status) VALUES
(1, 'Server Rack', 1200000.00, 'High Priority'), (1, 'Switches', 250000.00, 'Medium Priority'),
(2, 'Laptops', 400000.00, 'Low Priority'), (3, 'Monitors', 90000.00, 'Other');

INSERT INTO warehouse_1 VALUES (101, 'Mouse', 15), (102, 'Keyboard', 0), (103, 'Monitor', 8);
INSERT INTO warehouse_2 VALUES (102, 'Keyboard', 0), (103, 'Monitor', 12), (104, 'Webcam', 5);

WITH RECURSIVE org_chart AS (
    SELECT employee_id, first_name, last_name, manager_id, 1 AS level FROM employees WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.first_name, e.last_name, e.manager_id, oc.level + 1 FROM employees e INNER JOIN org_chart oc ON e.manager_id = oc.employee_id
)
SELECT * FROM org_chart ORDER BY level, employee_id;

SELECT product_name FROM warehouse_1 UNION SELECT product_name FROM warehouse_2;
SELECT product_id FROM warehouse_1 WHERE quantity = 0 INTERSECT SELECT product_id FROM warehouse_2 WHERE quantity = 0;
SELECT product_name FROM warehouse_1 EXCEPT SELECT product_name FROM warehouse_2;
SELECT first_name, last_name, department, salary, RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank FROM employees;
EXPLAIN ANALYZE SELECT first_name, last_name, salary FROM employees WHERE salary > 80000;
