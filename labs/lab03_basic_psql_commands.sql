-- Lab 03: Basic psql Meta-Commands and Inspection
-- Interactive psql commands:
-- \l       - List databases
-- \c       - Connect to a database
-- \dt      - List tables
-- \d table - Describe table schema
-- \q       - Quit psql
SELECT current_database() AS connected_database, current_user AS active_user;
