-- Lab 17: Data Import/Export and Backup
-- Reference: Lab 17 Guide (COPY command, CSV options, pg_dump & pg_restore)

-- ==========================================
-- 1. COPY Command (Export & Import)
-- ==========================================

-- Basic CSV export with headers
COPY employees TO '/tmp/employees.csv' WITH CSV HEADER;

-- Export with custom delimiter and NULL representation
COPY employees TO '/tmp/employees.txt' WITH DELIMITER '|' NULL 'N/A' CSV HEADER;

-- Export filtered query results
COPY (SELECT * FROM employees WHERE department = 'IT') TO '/tmp/it_employees.csv' WITH CSV HEADER;

-- CSV export with custom quote character and delimiter
COPY products TO '/tmp/products.csv' WITH CSV HEADER DELIMITER ';' QUOTE '"';

-- Import table setup & data restoration
DROP TABLE IF EXISTS employees_import CASCADE;
CREATE TABLE employees_import (
    employee_id INT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    department VARCHAR(50),
    salary NUMERIC(10, 2),
    tenure INT,
    manager_id INT
);

-- Basic CSV import
COPY employees_import FROM '/tmp/it_employees.csv' WITH CSV HEADER;

-- Import with error handling and encoding options
-- COPY products FROM '/tmp/products.csv' WITH CSV HEADER ON_ERROR IGNORE ENCODING 'UTF8';

SELECT * FROM employees_import;

-- ==========================================
-- 2. Backup & Restore CLI Commands (pg_dump / pg_restore)
-- Note: Terminal commands documented per syllabus requirements
-- ==========================================
-- # 1. Full cluster backup:
-- pg_dumpall -h localhost -U postgres > full_cluster_backup.sql
--
-- # 2. Database backup to SQL script:
-- pg_dump -h localhost -U postgres -d postgres > backups/backup.sql
--
-- # 3. Compressed custom format backup (-Fc):
-- pg_dump -h localhost -U postgres -d postgres -Fc > backups/backup.dump
--
-- # 4. Specific table backup:
-- pg_dump -h localhost -U postgres -d postgres -t employees -t products > backups/tables_backup.sql
--
-- # 5. Restore from custom format:
-- pg_restore -h localhost -U postgres -d target_database backups/backup.dump
--
-- # 6. Point-in-Time Recovery configuration:
-- restore_command = 'cp /backup/wal/%f %p'
