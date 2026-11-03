-- Lab 17: Data Import/Export and Backup
COPY employees TO '/tmp/employees.csv' WITH CSV HEADER;
COPY employees TO '/tmp/employees.txt' WITH DELIMITER '|' NULL 'N/A' CSV HEADER;
COPY (SELECT * FROM employees WHERE department = 'IT') TO '/tmp/it_employees.csv' WITH CSV HEADER;

DROP TABLE IF EXISTS employees_import CASCADE;
CREATE TABLE employees_import (
    employee_id INT, first_name VARCHAR(50), last_name VARCHAR(50),
    department VARCHAR(50), salary NUMERIC(10,2), tenure INT, manager_id INT
);
COPY employees_import FROM '/tmp/it_employees.csv' WITH CSV HEADER;
SELECT * FROM employees_import;
