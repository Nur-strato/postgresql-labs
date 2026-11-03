-- Lab 16: Transactions and ACID Properties
-- Reference: Lab 16 Guide (BEGIN, COMMIT, ROLLBACK, Savepoints, Isolation Levels)

DROP TABLE IF EXISTS accounts, products, logs CASCADE;

CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    owner_name VARCHAR(100) NOT NULL,
    balance DECIMAL(12, 2) NOT NULL CHECK (balance >= 0)
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2)
);

CREATE TABLE logs (
    log_id SERIAL PRIMARY KEY,
    message TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO accounts (owner_name, balance) VALUES 
('Account A', 1000.00), 
('Account B', 500.00);

-- 1. Basic Transaction Control: Successful Transfer (COMMIT)
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 100 WHERE account_id = 2;
COMMIT;

-- 2. Failed Transaction with Complete Rollback (ROLLBACK)
BEGIN;
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;
ROLLBACK;

-- 3. Savepoints: Rollback to Intermediate State
BEGIN;
INSERT INTO products (name, price) VALUES ('Laptop', 999.99);
SAVEPOINT sp1;
INSERT INTO products (name, price) VALUES ('Mouse', 25.99);
SAVEPOINT sp2;
INSERT INTO products (name, price) VALUES ('Invalid Product', -50.00);
ROLLBACK TO SAVEPOINT sp2;
INSERT INTO products (name, price) VALUES ('Keyboard', 79.99);
COMMIT;

-- 4. Releasing Savepoints (from Lab 16 Guide)
BEGIN;
INSERT INTO logs (message) VALUES ('Starting process');
SAVEPOINT process_start;
INSERT INTO logs (message) VALUES ('Process completed');
RELEASE SAVEPOINT process_start;
COMMIT;

-- 5. Transaction Isolation Levels (READ COMMITTED, REPEATABLE READ, SERIALIZABLE)
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT * FROM accounts WHERE balance > 500;
COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SELECT * FROM accounts;
UPDATE accounts SET balance = balance * 1.05;
COMMIT;

-- Verification Queries
SELECT * FROM accounts;
SELECT * FROM products;
SELECT * FROM logs;
