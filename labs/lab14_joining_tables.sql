-- Lab 14: Joining Tables
DROP TABLE IF EXISTS order_items, orders, products, customers, employees_hierarchy CASCADE;
CREATE TABLE customers (customer_id SERIAL PRIMARY KEY, name VARCHAR(100), email VARCHAR(100));
CREATE TABLE orders (order_id SERIAL PRIMARY KEY, customer_id INTEGER REFERENCES customers(customer_id), order_date DATE, total_amount DECIMAL(10,2));
CREATE TABLE products (product_id SERIAL PRIMARY KEY, product_name VARCHAR(100), price DECIMAL(10,2));
CREATE TABLE order_items (item_id SERIAL PRIMARY KEY, order_id INTEGER REFERENCES orders(order_id), product_id INTEGER REFERENCES products(product_id), quantity INTEGER);
CREATE TABLE employees_hierarchy (employee_id SERIAL PRIMARY KEY, name VARCHAR(100), manager_id INTEGER REFERENCES employees_hierarchy(employee_id));

INSERT INTO customers (name, email) VALUES ('Alice', 'alice@example.com'), ('Bob', 'bob@example.com'), ('Charlie', 'charlie@example.com'), ('David', 'david@example.com');
INSERT INTO orders (customer_id, order_date, total_amount) VALUES (1, '2024-01-15', 150.00), (1, '2024-02-10', 200.00), (2, '2024-02-14', 50.00), (NULL, '2024-03-01', 75.00);
INSERT INTO products (product_name, price) VALUES ('Laptop', 1200.00), ('Mouse', 25.00), ('Keyboard', 75.00);
INSERT INTO order_items (order_id, product_id, quantity) VALUES (1, 1, 1), (1, 2, 2), (2, 3, 1), (3, 2, 1);
INSERT INTO employees_hierarchy (employee_id, name, manager_id) VALUES (1, 'Big Boss', NULL), (2, 'Sarah Manager', 1), (3, 'John Developer', 2), (4, 'Jane QA', 2);

SELECT c.name, o.order_date, o.total_amount FROM customers c INNER JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.name, o.order_date, o.total_amount FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.name, o.order_date, o.total_amount FROM customers c RIGHT JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.name, o.order_date, o.total_amount FROM customers c FULL OUTER JOIN orders o ON c.customer_id = o.customer_id;
SELECT c.name, p.product_name FROM customers c CROSS JOIN products p;
SELECT c.name FROM customers c LEFT JOIN orders o ON c.customer_id = o.customer_id WHERE o.customer_id IS NULL;
SELECT e1.name AS employee, e2.name AS manager FROM employees_hierarchy e1 LEFT JOIN employees_hierarchy e2 ON e1.manager_id = e2.employee_id;
