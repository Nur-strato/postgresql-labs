-- Lab 08: Foreign Keys and Referential Integrity (CASCADE)
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS publishers CASCADE;

CREATE TABLE publishers (
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    publisher_id INT REFERENCES publishers(publisher_id) ON DELETE CASCADE,
    published_year INT CHECK (published_year > 1900)
);

INSERT INTO publishers (name) VALUES ('Tech Press');
INSERT INTO books (title, publisher_id, published_year) VALUES ('PostgreSQL Essentials', 1, 2024);
SELECT b.title, p.name AS publisher FROM books b JOIN publishers p ON b.publisher_id = p.publisher_id;
