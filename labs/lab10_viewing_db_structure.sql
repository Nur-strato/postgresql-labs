-- Lab 10: Information Schema and Metadata Queries
SELECT table_name, table_type 
FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

SELECT column_name, data_type, is_nullable, column_default 
FROM information_schema.columns 
WHERE table_name = 'coffee_products';

SELECT tc.constraint_name, tc.constraint_type, kcu.column_name 
FROM information_schema.table_constraints tc 
JOIN information_schema.key_column_usage kcu 
  ON tc.constraint_name = kcu.constraint_name 
WHERE tc.table_name = 'coffee_products';
