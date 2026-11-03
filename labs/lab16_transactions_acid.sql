-- Lab 16: Transactions and ACID Properties
DROP TABLE IF EXISTS accounts, products, logs CASCADE;
CREATE TABLE accounts (account_id SERIAL PRIMARY KEY, owner_name VARCHAR(100) NOT NULL, balance DECIMAL(12, 2) NOT NULL CHECK (balance >= 0));
CREATE TABLE products (product_id SERIAL PRIMARY KEY, name VARCHAR(100), price DECIMAL(10, 2));
CREATE TABLE logs (log_id SERIAL PRIMARY KEY, message TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
INSERT INTO accounts (owner_name, balance) VALUES ('Account A', 1000.00), ('Account B', 500.00);

BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
COMMIT;

BEGIN;
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
ROLLBACK;

BEGIN;
INSERT INTO products (name, price) VALUES ('Laptop', 999.99);
SAVEPOINT sp1;
INSERT INTO products (name, price) VALUES ('Mouse', 25.99);
SAVEPOINT sp2;
INSERT INTO products (name, price) VALUES ('Invalid Product', -50.00);
ROLLBACK TO SAVEPOINT sp2;
INSERT INTO products (name, price) VALUES ('Keyboard', 79.99);
COMMIT;
