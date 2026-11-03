-- Lab 07: Primary Keys (SERIAL and IDENTITY)
DROP TABLE IF EXISTS authors CASCADE;
CREATE TABLE authors (
    author_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);
INSERT INTO authors (first_name, last_name, email) VALUES 
('Nurmukhamed', 'Abdumomun', 'nur@example.com'),
('Alex', 'Rivers', 'alex.rivers@example.com');
SELECT * FROM authors;
