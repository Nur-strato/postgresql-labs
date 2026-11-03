-- Lab 06: Tables, Data Types, and Constraints
DROP TABLE IF EXISTS course_items CASCADE;
CREATE TABLE course_items (
    item_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    price NUMERIC(10, 2) CHECK (price >= 0),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_item_name UNIQUE (item_name)
);
ALTER TABLE course_items ADD COLUMN description TEXT;
ALTER TABLE course_items ALTER COLUMN description SET DEFAULT 'N/A';
