-- Lab 05: Creating and Dropping Databases
DROP DATABASE IF EXISTS lab5_test_db;
CREATE DATABASE lab5_test_db WITH ENCODING = 'UTF8';
COMMENT ON DATABASE lab5_test_db IS 'Temporary test database for Lab 05';
SELECT datname, pg_size_pretty(pg_database_size(datname)) AS db_size 
FROM pg_database 
WHERE datname = 'lab5_test_db';
